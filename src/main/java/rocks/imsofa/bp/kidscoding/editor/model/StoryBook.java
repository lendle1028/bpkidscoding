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
    private List<String> pageContents=new ArrayList<>();
    private String id;
    private StoryBookMeta meta=null;

    public List<String> getPageContents() {
        return pageContents;
    }

    public void setPageContents(List<String> pageContents) {
        this.pageContents = pageContents;
    }

    public StoryBookMeta getMeta() {
        return meta;
    }

    public void setMeta(StoryBookMeta meta) {
        this.meta = meta;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    
    
}
