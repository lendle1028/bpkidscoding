/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author lendle
 */
public class StoryBook {
    private String title;
    private int author;
    private String createdDate;
    private String lastEditedDate;
    private String summary;
    private String characters;
    private List<String> pageContents=new ArrayList<>();
    private String id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getAuthor() {
        return author;
    }

    public void setAuthor(int author) {
        this.author = author;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getLastEditedDate() {
        return lastEditedDate;
    }

    public void setLastEditedDate(String lastEditedDate) {
        this.lastEditedDate = lastEditedDate;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getCharacters() {
        return characters;
    }

    public void setCharacters(String characters) {
        this.characters = characters;
    }

    public List<String> getPageContents() {
        return pageContents;
    }

    public void setPageContents(List<String> pageContents) {
        this.pageContents = pageContents;
    }
    
    
}
