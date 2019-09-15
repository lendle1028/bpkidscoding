/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import rocks.imsofa.bp.kidscoding.editor.model.ReadableStoryBookMeta;
import rocks.imsofa.bp.kidscoding.editor.service.ReadableStoryBookMetaService;

/**
 *
 * @author lendle
 */
public class ReadableStoryBookMetaServiceImpl implements ReadableStoryBookMetaService{
    @Autowired
    private JdbcTemplate jdbcTemplate=null;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    
    @Override
    public ReadableStoryBookMeta findById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<ReadableStoryBookMeta> findByStoryBookId(String id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<ReadableStoryBookMeta> findByAuthorId(int authorId) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void addReadableStoryBookMeta(ReadableStoryBookMeta readableStoryBookMeta) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void updateReadableStoryBookMeta(ReadableStoryBookMeta readableStoryBookMeta) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void deleteReadableStoryBookMeta(String id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
