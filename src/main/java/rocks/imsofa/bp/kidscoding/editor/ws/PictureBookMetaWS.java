/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.ws;

import java.util.ArrayList;
import java.util.List;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import org.springframework.beans.factory.annotation.Autowired;
import rocks.imsofa.bp.kidscoding.editor.model.CharacterSpec;
import rocks.imsofa.bp.kidscoding.editor.model.PictureBookMeta;
import rocks.imsofa.bp.kidscoding.editor.model.SceneSpec;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBook;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBookMeta;
import rocks.imsofa.bp.kidscoding.editor.service.PictureBookMetaService;
import rocks.imsofa.bp.kidscoding.editor.service.StoryBookService;

/**
 *
 * @author lendle
 */
@Path("picturebook")
public class PictureBookMetaWS {

    @Autowired
    private PictureBookMetaService pictureBookMetaService = null;
    @Autowired
    private StoryBookService storyBookService = null;

    public void setPictureBookMetaService(PictureBookMetaService pictureBookMetaService) {
        this.pictureBookMetaService = pictureBookMetaService;
    }

    public void setStoryBookService(StoryBookService storyBookService) {
        this.storyBookService = storyBookService;
    }

    @GET
    @Path("/new/storybook/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public PictureBookMeta createFromStoryBook(@PathParam("id") String storyBookId) {
        StoryBook storyBook = storyBookService.getStoryBook(storyBookId);
        PictureBookMeta pictureBookMeta = new PictureBookMeta();
        pictureBookMeta.setOriginalStoryId(storyBookId);
        pictureBookMeta.setAuthor(storyBook.getMeta().getAuthor());
        pictureBookMeta.setTitle(storyBook.getMeta().getTitle());
        List<CharacterSpec> characterSpecs = new ArrayList<>();
        for (StoryBookMeta.CharacterBlock cb : storyBook.getMeta().getCharacters().getBlocks()) {
            for (int i = 0; i < storyBook.getPageContents().size(); i++) {
                CharacterSpec characterSpec = new CharacterSpec();
                characterSpec.setImageURL("");
                characterSpec.setName(cb.getData().get("character"));
                characterSpec.setPage(i);
                characterSpecs.add(characterSpec);
            }
        }
        pictureBookMeta.getCharacterSpecs().addAll(characterSpecs);

        List<SceneSpec> sceneSpecs = new ArrayList<>();
        for (int i = 0; i < storyBook.getPageContents().size(); i++) {
            SceneSpec sceneSpec=new SceneSpec();
            sceneSpec.setImageURL("");
            sceneSpec.setPage(i);
            sceneSpecs.add(sceneSpec);
        }
        pictureBookMeta.getSceneSpecs().addAll(sceneSpecs);
        return pictureBookMeta;
    }

    @GET
    @Path("/storybook/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PictureBookMeta> findByStoryBookId(@PathParam("id") String id) {
        return this.pictureBookMetaService.findByStoryBookId(id);
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public PictureBookMeta findById(@PathParam("id") String id) {
        return this.pictureBookMetaService.findById(id);
    }

    @GET
    @Path("/author/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PictureBookMeta> findByAuthorId(@PathParam("id") int id) {
        return this.pictureBookMetaService.findByAuthorId(id);
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void addPictureBookMeta(PictureBookMeta readableStoryBookMeta) {
        this.pictureBookMetaService.addPictureBookMeta(readableStoryBookMeta);
    }

    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public void updatePictureBookMeta(PictureBookMeta readableStoryBookMeta) {
        this.pictureBookMetaService.updatePictureBookMeta(readableStoryBookMeta);
    }

    @DELETE
    @Path("{id}")
    public void deletePictureBookMeta(@PathParam("id") String id) {
        this.pictureBookMetaService.deletePictureBookMeta(id);
    }
}
