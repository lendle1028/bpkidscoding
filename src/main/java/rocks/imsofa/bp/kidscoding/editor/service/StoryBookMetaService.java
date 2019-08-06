/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.service;

import java.util.List;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBookMeta;

/**
 *
 * @author lendle
 */
public interface StoryBookMetaService {
    public List<StoryBookMeta> findAll();
    public List<StoryBookMeta> findAll(int pageSize, int pageIndex);
    public StoryBookMeta findById(String id);
    public List<StoryBookMeta> findByAuthor(String author);
    public List<StoryBookMeta> findByAuthor(String author, int pageSize, int pageIndex);
    public List<StoryBookMeta> findByKeywords(String keywords);
    public List<StoryBookMeta> findByKeywords(String keywords, int pageSize, int pageIndex);
}
