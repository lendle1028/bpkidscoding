/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.service.impl;

import com.google.gson.Gson;
import java.util.Map;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBook;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBook.PageContent;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBookMeta;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBookMeta.Characters;
import rocks.imsofa.bp.kidscoding.editor.service.StoryBookService;

/**
 *
 * @author lendle
 */
@Service
public class StoryBookServiceImpl implements StoryBookService {

    @Autowired
    private JdbcTemplate jdbcTemplate = null;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public StoryBook getStoryBook(String id) {
        SqlRowSet rs = jdbcTemplate.queryForRowSet("select storymeta.*, users.*, storycontent.* from storymeta left join users on storymeta.author=users.id, storycontent where storymeta.id=storycontent.story and storymeta.id=? order by page", id);
        //SqlRowSet rs=jdbcTemplate.queryForRowSet("select story.*, users.*,characters.content as cs, storycontent.* from story left join users on story.author=users.id left join characters on characters.story=story.id, storycontent where story.id=storycontent.story and story.id=1 order by page");
        if (rs.next()) {
            StoryBook storyBook = new StoryBook();
            StoryBookMeta meta=new StoryBookMeta();
            storyBook.setId(rs.getString("id"));
            meta.setId(rs.getString("id"));
            meta.setAuthor(rs.getInt("author"));
            meta.setCharacters(new Gson().fromJson(rs.getString("characters"), Characters.class));
            meta.setCreatedDate(rs.getString("CREATED_DATE"));//
            meta.setLastEditedDate(rs.getString("last_edited_date"));
            meta.setSummary(rs.getString("summary"));
            meta.setTitle(rs.getString("title"));
            storyBook.setMeta(meta);
            Gson gson=new Gson();
            PageContent pageContent=gson.fromJson(rs.getString("content"), PageContent.class);
            storyBook.getPageContents().add(pageContent);
            //System.out.println("content="+rs.getString("content"));
            //System.out.println("\tblock="+new Gson().toJson(pageContent.get("blocks")));
            while (rs.next()) {
                storyBook.getPageContents().add(gson.fromJson(rs.getString("content"), PageContent.class));
            }
            return storyBook;
        }
        return null;
    }

    @Override
    @Transactional
    public StoryBook addStoryBook(StoryBook storyBook) {
        if (storyBook.getId() == null) {
            String bookId = UUID.randomUUID().toString();
            storyBook.setId(bookId);
            storyBook.getMeta().setId(bookId);
        }
        StoryBookMeta meta=storyBook.getMeta();
        jdbcTemplate.update("insert into story (id, author, created_date, last_edited_date, title, summary) values (?,?,?,?,?,?)",
                meta.getId(), meta.getAuthor(), meta.getCreatedDate(), meta.getLastEditedDate(),
                meta.getTitle(), meta.getSummary());
        jdbcTemplate.update("insert into characters (story, content) values (?, ?)",
                storyBook.getId(), new Gson().toJson(meta.getCharacters()));
        int pageNumber = 0;
        Gson gson=new Gson();
        for (PageContent content : storyBook.getPageContents()) {
            jdbcTemplate.update("insert into storycontent (story, page, content) values (?,?,?)",
                    storyBook.getId(), pageNumber++, gson.toJson(content));
        }
        return storyBook;
    }

    @Override
    @Transactional
    public StoryBook updateStoryBook(StoryBook storyBook) {
        deleteStoryBook(storyBook.getId());
        return this.addStoryBook(storyBook);
    }

    @Override
    @Transactional
    public boolean deleteStoryBook(String id) {
        jdbcTemplate.update("delete from storycontent where story=?", id);
        jdbcTemplate.update("delete from characters where story=?", id);
        jdbcTemplate.update("delete from story where id=?", id);
        return true;
    }

}
