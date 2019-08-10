/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.ws;

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
import rocks.imsofa.bp.kidscoding.editor.model.StoryBook;
import rocks.imsofa.bp.kidscoding.editor.service.StoryBookService;

/**
 *
 * @author lendle
 */
@Path("book")
public class StoryBookWS {
    @Autowired
    private StoryBookService storyBookService=null;

    public void setStoryBookService(StoryBookService storyBookService) {
        this.storyBookService = storyBookService;
    }
    
    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public StoryBook getStoryBook(@PathParam("id") String id){
        System.out.println("id="+id);
        return storyBookService.getStoryBook(id);
    }
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public StoryBook addStoryBook(StoryBook sb){
        return storyBookService.addStoryBook(sb);
    }
    
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public StoryBook updateStoryBook(StoryBook sb){
        return storyBookService.updateStoryBook(sb);
    }
    
    @DELETE
    @Path("{id}")
    public boolean deleteStoryBook(@PathParam("id") String id){
        return storyBookService.deleteStoryBook(id);
    }
}
