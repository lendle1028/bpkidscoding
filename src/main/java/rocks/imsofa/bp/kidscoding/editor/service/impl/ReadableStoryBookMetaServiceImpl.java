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
import org.springframework.stereotype.Service;
import rocks.imsofa.bp.kidscoding.editor.model.ReadableStoryBookMeta;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBook;
import rocks.imsofa.bp.kidscoding.editor.service.ReadableStoryBookMetaService;
import rocks.imsofa.bp.kidscoding.editor.service.StoryBookService;

/**
 *
 * @author lendle
 */
@Service
public class ReadableStoryBookMetaServiceImpl implements ReadableStoryBookMetaService{
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
    public ReadableStoryBookMeta findById(String id) {
        return null;
    }

    @Override
    public List<ReadableStoryBookMeta> findByStoryBookId(String id) {
        StoryBook storyBook=this.storyBookService.getStoryBook(id);
        ReadableStoryBookMeta meta=FakeReadableStoryBookMetaFactory.generate(storyBook);
        List<ReadableStoryBookMeta> metas=new ArrayList<>();
        metas.add(meta);
        return metas;
    }

    @Override
    public List<ReadableStoryBookMeta> findByAuthorId(int authorId) {
        return null;
    }

    @Override
    public void addReadableStoryBookMeta(ReadableStoryBookMeta readableStoryBookMeta) {
    }

    @Override
    public void updateReadableStoryBookMeta(ReadableStoryBookMeta readableStoryBookMeta) {
    }

    @Override
    public void deleteReadableStoryBookMeta(String id) {
    }
    
}
