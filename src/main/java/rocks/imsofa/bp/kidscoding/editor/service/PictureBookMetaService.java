/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.service;

import java.util.List;
import rocks.imsofa.bp.kidscoding.editor.model.PictureBookMeta;

/**
 *
 * @author lendle
 */
public interface PictureBookMetaService {
    public PictureBookMeta findById(String id);
    public List<PictureBookMeta> findByStoryBookId(String id);
    public List<PictureBookMeta> findByAuthorId(int authorId);
    public PictureBookMeta addPictureBookMeta(PictureBookMeta readableStoryBookMeta);
    public void updatePictureBookMeta(PictureBookMeta readableStoryBookMeta);
    public void deletePictureBookMeta(String id);
}
