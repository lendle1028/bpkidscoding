/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.service.impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Service;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBookMeta;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBookMetaRowMapper;
import rocks.imsofa.bp.kidscoding.editor.service.StoryBookMetaService;

/**
 *
 * @author lendle
 */
@Service
public class StoryBookMetaServiceImpl implements StoryBookMetaService{
    @Autowired
    private JdbcTemplate jdbcTemplate=null;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    @Override
    public List<StoryBookMeta> findAll() {
        return this.findAll(100, 0);
    }

    @Override
    public List<StoryBookMeta> findByAuthor(String author) {
        return this.findByAuthor(author, 100, 0);
    }

    @Override
    public List<StoryBookMeta> findByKeywords(String keywords) {
        return this.findByKeywords(keywords, 100, 0);
    }

    @Override
    public List<StoryBookMeta> findAll(int pageSize, int pageIndex) {
        return jdbcTemplate.query("select * from storymeta order by title limit ?, ?", new StoryBookMetaRowMapper(), pageSize*pageIndex, pageSize);
    }

    @Override
    public StoryBookMeta findById(String id) {
        return jdbcTemplate.queryForObject("select * from storymeta where id=?", new StoryBookMetaRowMapper(), id);
    }

    @Override
    public List<StoryBookMeta> findByAuthor(String author, int pageSize, int pageIndex) {
        SqlRowSet rs=jdbcTemplate.queryForRowSet("select * from users where user_id=?", author);
        if(rs.next()){
            return jdbcTemplate.query("select * from storymeta where author=? order by title limit ?, ?", new StoryBookMetaRowMapper(), rs.getInt("id"), pageSize*pageIndex, pageSize);
        }else{
            return new ArrayList<>();
        }
    }

    @Override
    public List<StoryBookMeta> findByKeywords(String keywords, int pageSize, int pageIndex) {
        return jdbcTemplate.query("select * from storymeta where title like ? or summary like ? or characters like ? order by title limit ?,?", new StoryBookMetaRowMapper(),
                "%"+keywords+"%", "%"+keywords+"%", "%"+keywords+"%", pageSize*pageIndex, pageSize);
    }

    @Override
    public int count() {
        return jdbcTemplate.queryForObject("select count(*) from storymeta", int.class);
    }
    
}
