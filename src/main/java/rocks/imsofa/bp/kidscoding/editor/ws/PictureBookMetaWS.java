/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.ws;

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
import rocks.imsofa.bp.kidscoding.editor.model.PictureBookMeta;
import rocks.imsofa.bp.kidscoding.editor.service.PictureBookMetaService;

/**
 *
 * @author lendle
 */
@Path("picturebook")
public class PictureBookMetaWS {
    @Autowired
    private PictureBookMetaService pictureBookMetaService=null;

    public void setPictureBookMetaService(PictureBookMetaService pictureBookMetaService) {
        this.pictureBookMetaService = pictureBookMetaService;
    }
    
    @GET
    @Path("/storybook/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PictureBookMeta> findByStoryBookId(@PathParam("id") String id){
        return this.pictureBookMetaService.findByStoryBookId(id);
    }
    
    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public PictureBookMeta findById(@PathParam("id") String id){
        return this.pictureBookMetaService.findById(id);
    }
    
    @GET
    @Path("/author/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PictureBookMeta> findByAuthorId(@PathParam("id") int id){
        return this.pictureBookMetaService.findByAuthorId(id);
    }
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void addPictureBookMeta(PictureBookMeta readableStoryBookMeta){
        this.pictureBookMetaService.addPictureBookMeta(readableStoryBookMeta);
    }
    
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public void updatePictureBookMeta(PictureBookMeta readableStoryBookMeta){
        this.pictureBookMetaService.updatePictureBookMeta(readableStoryBookMeta);
    }
    
    @DELETE
    @Path("{id}")
    public void deletePictureBookMeta(@PathParam("id") String id){
        this.pictureBookMetaService.deletePictureBookMeta(id);
    }
}
