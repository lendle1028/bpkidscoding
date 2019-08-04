/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.service.impl;

import java.util.Arrays;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.jdbc.support.rowset.SqlRowSetMetaData;
import org.springframework.stereotype.Service;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBook;
import rocks.imsofa.bp.kidscoding.editor.service.StoryBookService;

/**
 *
 * @author lendle
 */
@Service
public class StoryBookServiceImpl implements StoryBookService{
    @Autowired
    private JdbcTemplate jdbcTemplate=null;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    
    @Override
    public StoryBook getStoryBook(int id) {
        SqlRowSet rs=jdbcTemplate.queryForRowSet("select story.*, users.*,characters.content as cs, storycontent.* from story left join users on story.author=users.id left join characters on characters.story=story.id, storycontent where story.id=storycontent.story and story.id=? order by page", id);
        //SqlRowSet rs=jdbcTemplate.queryForRowSet("select story.*, users.*,characters.content as cs, storycontent.* from story left join users on story.author=users.id left join characters on characters.story=story.id, storycontent where story.id=storycontent.story and story.id=1 order by page");
        if(rs.next()){
            StoryBook storyBook=new StoryBook();
            storyBook.setId(rs.getInt("id"));
            storyBook.setAuthor(rs.getString("user_id"));
            storyBook.setCharacters(rs.getString("cs"));
            storyBook.setCreatedDate(rs.getString("CREATED_DATE"));//
            storyBook.setLastEditedDate(rs.getString("last_edited_date"));
            storyBook.setSummary(rs.getString("summary"));
            storyBook.setTitle(rs.getString("title"));
            storyBook.getPageContents().add(rs.getString("content"));
            while(rs.next()){
                storyBook.getPageContents().add(rs.getString("content"));
            }
            return storyBook;
        }
        return null;
    }
    
    @Override
    public boolean addStoryBook(StoryBook storyBook) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean updateStoryBook(StoryBook storyBook) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean deleteStoryBook(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
