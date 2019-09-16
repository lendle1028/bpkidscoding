/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.reader.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.io.IOUtils;
import rocks.imsofa.bp.kidscoding.editor.model.CharacterSpec;
import rocks.imsofa.bp.kidscoding.editor.model.ReadableStoryBookMeta;

/**
 *
 * @author lendle
 */
public class MonogatariSession {
    private String sessionId=null;
    private File sessionFolder=null;
    private Map<String, String> imageFileMap=new HashMap<>();//map url to internal file name
    public MonogatariSession(File monogatariRootDir, ReadableStoryBookMeta meta){
        File tempFile=new File(monogatariRootDir, "temp");
        if(!tempFile.exists()){
            tempFile.mkdir();
        }
        sessionId="session_"+System.currentTimeMillis();
        sessionFolder=new File(tempFile, sessionId);
        sessionFolder.mkdir();
        
        for(CharacterSpec spec : meta.getCharacterSpecs()){
            
        }
    }
    
    private String cacheImageFile(String url) throws Exception{
        URLConnection con=new URL(url).openConnection();
        String contentType=con.getContentType();
        int index=contentType.indexOf("/");
        String extension=contentType.substring(index+1);
        if("jpeg".equals(extension)){
            extension="jpg";
        }
        String randomName=""+System.currentTimeMillis()+"."+extension;
        try(InputStream input=new URL(url).openStream();OutputStream output=new FileOutputStream(new File(sessionFolder, randomName))){
            IOUtils.copy(input, output);
        }
        return randomName;
    }
}
