/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.ws;

import java.util.List;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import org.springframework.beans.factory.annotation.Autowired;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBookMeta;
import rocks.imsofa.bp.kidscoding.editor.service.StoryBookMetaService;

/**
 *
 * @author lendle
 */
@Path("meta")
public class StoryBookMetaWS {
    @Autowired
    private StoryBookMetaService storyBookMetaService;

    public void setStoryBookMetaService(StoryBookMetaService storyBookMetaService) {
        this.storyBookMetaService = storyBookMetaService;
    }
    
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<StoryBookMeta> findAll() {
        return storyBookMetaService.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public StoryBookMeta findById(@PathParam("id") String id) {
        return storyBookMetaService.findById(id);
    }

    @GET
    @Path("author/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<StoryBookMeta> findByAuthor(@PathParam("id") String author) {
        return storyBookMetaService.findByAuthor(author);
    }

    @GET
    @Path("keyword/{word}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<StoryBookMeta> findByKeywords(@PathParam("word") String keyword) {
        return storyBookMetaService.findByKeywords(keyword);
    } 
}
