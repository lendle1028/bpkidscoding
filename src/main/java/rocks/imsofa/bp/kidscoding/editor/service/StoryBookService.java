/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.service;

import rocks.imsofa.bp.kidscoding.editor.model.StoryBook;

/**
 *
 * @author lendle
 */
public interface StoryBookService {
    public StoryBook getStoryBook(String id);
    public StoryBook addStoryBook(StoryBook storyBook);
    public StoryBook updateStoryBook(StoryBook storyBook);
    public boolean deleteStoryBook(String id);
}
