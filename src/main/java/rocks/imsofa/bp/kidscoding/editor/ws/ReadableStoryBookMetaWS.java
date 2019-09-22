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
import rocks.imsofa.bp.kidscoding.editor.model.PictureBookMeta;
import rocks.imsofa.bp.kidscoding.editor.service.PictureBookMetaService;

/**
 *
 * @author lendle
 */
@Path("readable")
public class ReadableStoryBookMetaWS {
    @Autowired
    private PictureBookMetaService readableStoryBookMetaService=null;

    public void setReadableStoryBookMetaService(PictureBookMetaService readableStoryBookMetaService) {
        this.readableStoryBookMetaService = readableStoryBookMetaService;
    }
    
    @GET
    @Path("/storybook/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PictureBookMeta> findByStoryBookId(@PathParam("id") String id){
        return this.readableStoryBookMetaService.findByStoryBookId(id);
    }
}
