/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.service.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import rocks.imsofa.bp.kidscoding.editor.model.CharacterSpec;
import rocks.imsofa.bp.kidscoding.editor.model.PictureBookMeta;
import rocks.imsofa.bp.kidscoding.editor.model.SceneSpec;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBook;
import rocks.imsofa.bp.kidscoding.editor.service.StoryBookService;
import rocks.imsofa.bp.kidscoding.editor.service.PictureBookMetaService;

/**
 *
 * @author lendle
 */
@Service
public class PictureBookMetaServiceImpl implements PictureBookMetaService{
    @Autowired
    private JdbcTemplate jdbcTemplate=null;
    
    @Autowired
    private StoryBookService storyBookService=null;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void setStoryBookService(StoryBookService storyBookService) {
        this.storyBookService = storyBookService;
    }
    
    
    @Override
    public PictureBookMeta findById(String id) {
        PictureBookMeta meta=null;
        SqlRowSet rs=jdbcTemplate.queryForRowSet("select * from picturebook where id=?", id);
        if(rs.next()){
            meta=new PictureBookMeta();
            meta.setAuthor(rs.getInt("author"));
            meta.setId(id);
            meta.setOriginalStoryId(rs.getString("story"));
            meta.setTitle(rs.getString("title"));
            List<CharacterSpec> characterSpecs=jdbcTemplate.query("select * from picturebook_character where picturebookId=?", 
                    new Object[]{id},
                    new RowMapper<CharacterSpec>(){
                @Override
                public CharacterSpec mapRow(ResultSet rs, int i) throws SQLException {
                    CharacterSpec spec=new CharacterSpec();
                    spec.setImageURL(rs.getString("imageURL"));
                    spec.setName(rs.getString("name"));
                    spec.setNarrat(rs.getInt("narrat")==1);
                    spec.setPage(rs.getInt("page"));
                    return spec;
                }
            });
            meta.getCharacterSpecs().addAll(characterSpecs);
            
            List<SceneSpec> sceneSpecs=jdbcTemplate.query(
                    "select * from picturebook_scene where picturebookId=?", 
                    new Object[]{id}, 
                    new RowMapper<SceneSpec>(){
                @Override
                public SceneSpec mapRow(ResultSet rs, int i) throws SQLException {
                    SceneSpec spec=new SceneSpec();
                    spec.setImageURL(rs.getString("imageURL"));
                    spec.setPage(rs.getInt("page"));
                    return spec;
                }
            });
            meta.getSceneSpecs().addAll(sceneSpecs);
        }
        return meta;
    }

    @Override
    public List<PictureBookMeta> findByStoryBookId(String id) {
        List<PictureBookMeta> ret=new ArrayList<>();
        SqlRowSet rs=jdbcTemplate.queryForRowSet("select id from picturebook where story=?", id);
        while(rs.next()){
            PictureBookMeta meta=this.findById(rs.getString("id"));
            ret.add(meta);
        }
        return ret;
    }

    @Override
    public List<PictureBookMeta> findByAuthorId(int authorId) {
        List<PictureBookMeta> ret=new ArrayList<>();
        SqlRowSet rs=jdbcTemplate.queryForRowSet("select id from picturebook where author=?", authorId);
        while(rs.next()){
            PictureBookMeta meta=this.findById(rs.getString("id"));
            ret.add(meta);
        }
        return ret;
    }

    @Override
    @Transactional
    public PictureBookMeta addPictureBookMeta(PictureBookMeta meta) {
        String uuid=(meta.getId()==null)?UUID.randomUUID().toString():meta.getId();
        meta.setId(uuid);
        jdbcTemplate.update(
                "insert into picturebook (id, story, author, title) values (?,?,?,?)", 
                meta.getId(),
                meta.getOriginalStoryId(),
                meta.getAuthor(),
                meta.getTitle());
        for(CharacterSpec characterSpec : meta.getCharacterSpecs()){
            jdbcTemplate.update(
                "insert into picturebook_character (id, picturebookId,page,imageURL,name,narrat) values (?,?,?,?,?,?)", 
                UUID.randomUUID().toString(),
                meta.getId(),
                characterSpec.getPage(),
                characterSpec.getImageURL(),
                characterSpec.getName(),
                (characterSpec.isNarrat())?1:0);
        }
        for(SceneSpec sceneSpec : meta.getSceneSpecs()){
            jdbcTemplate.update(
                "insert into picturebook_scene (id, picturebookId,page,imageURL) values (?,?,?,?)", 
                UUID.randomUUID().toString(),
                meta.getId(),
                sceneSpec.getPage(),
                sceneSpec.getImageURL());
        }
        return meta;
    }

    @Override
    @Transactional
    public void updatePictureBookMeta(PictureBookMeta meta) {
        System.out.println("delete: "+meta.getId());
        this.deletePictureBookMeta(meta.getId());
        this.addPictureBookMeta(meta);
    }

    @Override
    @Transactional
    public void deletePictureBookMeta(String id) {
        jdbcTemplate.update("delete from picturebook_character where picturebookId=?", id);
        jdbcTemplate.update("delete from picturebook_scene where picturebookId=?", id);
        jdbcTemplate.update("delete from picturebook where id=?", id);
    }
    
}
