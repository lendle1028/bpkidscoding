/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.model;

/**
 *
 * @author lendle
 */
public class CharacterSpec {
    
    private String name = null; //for narrats, set this to null
    private boolean narrat = false;
    private int page = -1;
    private String imageURL = null;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isNarrat() {
        return narrat;
    }

    public void setNarrat(boolean narrat) {
        this.narrat = narrat;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
    
}
