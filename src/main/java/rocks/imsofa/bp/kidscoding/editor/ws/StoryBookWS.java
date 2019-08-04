/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.ws;

import javax.ws.rs.GET;
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
    public StoryBook getStoryBook(@PathParam("id") int id){
        return storyBookService.getStoryBook(id);
    }
}
