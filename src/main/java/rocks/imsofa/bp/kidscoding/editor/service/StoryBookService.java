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
    public StoryBook getStoryBook(int id);
    public boolean addStoryBook(StoryBook storyBook);
    public boolean updateStoryBook(StoryBook storyBook);
    public boolean deleteStoryBook(int id);
}
