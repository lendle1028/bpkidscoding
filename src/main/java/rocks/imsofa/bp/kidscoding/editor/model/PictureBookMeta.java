/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * the meta data of a readable storybook
 * a readable story book is a storybook bundled with the artworks
 * @author lendle
 */
public class PictureBookMeta {
    private String id=null;
    private String originalStoryId=null;
    private List<CharacterSpec> characterSpecs=new ArrayList<>();
    private List<SceneSpec> sceneSpecs=new ArrayList<>();
    private int author;
    private String title;

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
    
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOriginalStoryId() {
        return originalStoryId;
    }

    public void setOriginalStoryId(String originalStoryId) {
        this.originalStoryId = originalStoryId;
    }

    public List<CharacterSpec> getCharacterSpecs() {
        return characterSpecs;
    }

    public void setCharacterSpecs(List<CharacterSpec> characterSpecs) {
        this.characterSpecs = characterSpecs;
    }

    public List<SceneSpec> getSceneSpecs() {
        return sceneSpecs;
    }

    public void setSceneSpecs(List<SceneSpec> sceneSpecs) {
        this.sceneSpecs = sceneSpecs;
    }
    
    public SceneSpec getSceneSpec(final int page){
        List<SceneSpec> applicable=new ArrayList<>();
        for(SceneSpec spec : this.sceneSpecs){
            if(spec.getPage()!=-1 && spec.getPage()==page){
                if(applicable.isEmpty()){
                    applicable.add(spec);
                }else{
                    applicable.add(0, spec);
                }
            }else if(spec.getPage()==-1){
                applicable.add(spec);
            }
        }
        return applicable.isEmpty()?null:applicable.get(0);
    }
    
    public CharacterSpec getCharacterSpec(String name, final int page){
        List<CharacterSpec> applicable=new ArrayList<>();
        for(CharacterSpec spec : this.characterSpecs){
            if(name==null){
                //looking for narrats
                if(spec.isNarrat() && 
                   (spec.getPage()==-1 || spec.getPage()==page) ){
                    applicable.add(spec);
                }
            }else{
                //looking for characters
                if(name.equals(spec.getName()) && 
                   (spec.getPage()==-1 || spec.getPage()==page) ){
                    applicable.add(spec);
                }
            }
        }
        Collections.sort(applicable, new Comparator<CharacterSpec>() {
            @Override
            public int compare(CharacterSpec o1, CharacterSpec o2) {
                return calculateFitScore(o2, page)-calculateFitScore(o1, page);
            }
        });
        return applicable.isEmpty()?null:applicable.get(0);
    }
    
    private int calculateFitScore(CharacterSpec spec, int page){
        int score=0;
        if(spec.getPage()==page){
            score+=1;
        }
        
        return score;
    }
}
