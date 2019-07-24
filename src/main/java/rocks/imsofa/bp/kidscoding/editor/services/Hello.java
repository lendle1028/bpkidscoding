/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

/**
 *
 * @author lendle
 */
@Path("hello")
public class Hello {
    @GET
    public String sayHello(){
        return "hello";
    }
}
