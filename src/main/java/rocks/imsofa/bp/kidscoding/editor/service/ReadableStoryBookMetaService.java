/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.service;

import java.util.List;
import rocks.imsofa.bp.kidscoding.editor.model.ReadableStoryBookMeta;

/**
 *
 * @author lendle
 */
public interface ReadableStoryBookMetaService {
    public ReadableStoryBookMeta findById(String id);
    public List<ReadableStoryBookMeta> findByStoryBookId(String id);
    public List<ReadableStoryBookMeta> findByAuthorId(int authorId);
    public void addReadableStoryBookMeta(ReadableStoryBookMeta readableStoryBookMeta);
    public void updateReadableStoryBookMeta(ReadableStoryBookMeta readableStoryBookMeta);
    public void deleteReadableStoryBookMeta(String id);
}
