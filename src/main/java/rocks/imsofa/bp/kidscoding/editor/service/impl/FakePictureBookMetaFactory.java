/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.service.impl;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import rocks.imsofa.bp.kidscoding.editor.model.CharacterSpec;
import rocks.imsofa.bp.kidscoding.editor.model.PictureBookMeta;
import rocks.imsofa.bp.kidscoding.editor.model.SceneSpec;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBook;

/**
 *
 * @author lendle
 */
public class FakePictureBookMetaFactory {
    public static PictureBookMeta generate(StoryBook storyBook){
        PictureBookMeta meta=new PictureBookMeta();
        meta.setAuthor(0);
        meta.setId(UUID.randomUUID().toString());
        meta.setOriginalStoryId(storyBook.getId());
        String [] characterURLs=new String[]{
            "https://pokemon.gameinfo.io/images/pokemon-go/149-00.png",
            "https://tw.portal-pokemon.com/play/resources/pokedex/img/pm/0bca57b27bed8e50cf33ac9411a45482d61d807b.png",
            "https://vignette.wikia.nocookie.net/goanimate-2/images/2/29/Blastoise_by_xous54-d2xqh0g.png/revision/latest?cb=20160905153327",
            "https://img.4gamers.com.tw/ckfinder/images/TangBao/1811/21-eevee-day-01.jpg"
        };
        String [] sceneURLs=new String[]{
            "https://dubaitravelblog.com/wp-content/uploads/2019/04/coca-cola-arena-citywalk-dubai.jpg",
            "https://assets.pcmag.com/media/images/588342-classroom-teachers-student.jpg?thumb=y&width=810&height=456"
        };

        List<Map> characterList=(List) ((Map)storyBook.getMeta().getCharacters()).get("blocks");
        int index=0;
        for(Map entry : characterList){
            Map data=(Map) entry.get("data");
            CharacterSpec spec=new CharacterSpec();
            spec.setName(""+data.get("character"));
            //System.out.println("add character="+spec.getName());
            spec.setNarrat(false);
            spec.setImageURL(characterURLs[index%characterURLs.length]);
            spec.setPage(-1);
            meta.getCharacterSpecs().add(spec);
            index++;
        }
        
        for(int i=0; i<storyBook.getPageContents().size(); i++){
            SceneSpec spec=new SceneSpec();
            spec.setPage(i);
            spec.setImageURL(sceneURLs[i%sceneURLs.length]);
            meta.getSceneSpecs().add(spec);
        }
        return meta;
    }
}
