/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.reader.utils;

import com.github.kevinsawicki.http.HttpRequest;
import com.google.gson.Gson;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.io.FileUtils;
import rocks.imsofa.bp.kidscoding.editor.model.CharacterSpec;
import rocks.imsofa.bp.kidscoding.editor.model.PictureBookMeta;
import rocks.imsofa.bp.kidscoding.editor.model.SceneSpec;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBook;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBook.PageContent.PageContentBlock;

/**
 *
 * @author lendle
 */
public class MonogatariSession {

    private String sessionId = null;
    private File sessionFolder = null;
    private Map<String, String> imageFileMap = new HashMap<>();//map url to internal file name
    private Map<String, MonogatariCharacterSpec> characterSpecs = new HashMap<>();//map character name to MonogatariCharacterSpec
    private PictureBookMeta meta = null;
    private String[] colors = new String[]{"#0000ff", "#cc66ff", "#ff0066", "#000066", "#009900", "#cc3300"};
    private List<String> commands = new ArrayList<>();
    private StoryBook storyBook = null;

    public MonogatariSession(File monogatariRootDir, StoryBook storyBook, PictureBookMeta meta) {
        this.storyBook = storyBook;
        this.meta = meta;
        File imgFolder=new File(monogatariRootDir, "img");
        File charactersFolder=new File(imgFolder, "characters");
        File tempFile = new File(charactersFolder, "temp");
        if (!tempFile.exists()) {
            tempFile.mkdir();
        }
        sessionId = "session_" + System.currentTimeMillis();
        sessionFolder = new File(tempFile, sessionId);
        sessionFolder.mkdir();
        System.out.println("sessionFolder="+sessionFolder.getAbsolutePath());
        for (CharacterSpec spec : meta.getCharacterSpecs()) {
            String url = spec.getImageURL();
            if (!imageFileMap.containsKey(url)) {
                try {
                    //then create cache
                    String cachedFileName = this.cacheImageFile(url);
                    imageFileMap.put(url, cachedFileName);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
        initCharacterSpecs();
        initCommands();
    }

    public String getCharacterSpecs() {
        Map outputMap = new HashMap();
        for (MonogatariCharacterSpec spec : this.characterSpecs.values()) {
            Map content = new HashMap();
            outputMap.put(spec.name, content);
            content.put("Name", spec.name);
            content.put("Color", spec.color);
            content.put("Directory", spec.directory);
            content.put("Images", spec.stateImageMap);
        }
        return new Gson().toJson(outputMap);
    }

    public String getCommands() {
        return String.join(",\r\n", commands);
    }

    private void initCharacterSpecs() {
        int index = 0;
        for (CharacterSpec spec : meta.getCharacterSpecs()) {
            String name = spec.getName();
            MonogatariCharacterSpec monogatariCharacterSpec = null;
            if (this.characterSpecs.containsKey(name) == false) {
                monogatariCharacterSpec = new MonogatariCharacterSpec();
                this.characterSpecs.put(name, monogatariCharacterSpec);
                monogatariCharacterSpec.name = name;
                monogatariCharacterSpec.color = colors[index % colors.length];
                monogatariCharacterSpec.directory = "temp/" + sessionId;
            } else {
                monogatariCharacterSpec = this.characterSpecs.get(name);
            }
            if (spec.getPage() == -1) {
                monogatariCharacterSpec.stateImageMap.put("Normal", imageFileMap.get(spec.getImageURL()));
            } else {
                monogatariCharacterSpec.stateImageMap.put("Page" + spec.getPage(), imageFileMap.get(spec.getImageURL()));
            }
            index++;
        }
    }

    private void initCommands() {
        Gson gson = new Gson();
        List<StoryBook.PageContent> pageContents = storyBook.getPageContents();
        for (int i = 0; i < pageContents.size(); i++) {
            SceneSpec sceneSpec = this.meta.getSceneSpec(i);
            System.out.println("scene="+sceneSpec.getImageURL());
            this.commands.add("\"scene url(\'" + sceneSpec.getImageURL() + "\')\"");
            StoryBook.PageContent pageContent = pageContents.get(i);
            //System.out.println("block="+pageContent.get("blocks"));
            List<StoryBook.PageContent.PageContentBlock> blocks = (List) pageContent.getBlocks();
            for (int j = 0; j < blocks.size(); j++) {
                PageContentBlock pageJson = (PageContentBlock) blocks.get(j);
                Map data = (Map) pageJson.getData();
                if ("characterQuote".equals(pageJson.getType())) {
                    //out.println("\"show "+data.get("character")+" "+data.get("message")+"\",");
                    String character = (String) data.get("character");
                    //System.out.println("character=" + character);
                    CharacterSpec characterSpec = this.meta.getCharacterSpec(character, i);
                    String state = "Normal";
                    if (characterSpec.getPage() != -1) {
                        state = "Page" + i;
                    }
                    this.commands.add("\"show " + character + " " + state + " center\"");
                    this.commands.add("\"" + character + " " + data.get("message") + "\"");
                } else if ("os".equals(pageJson.getType())) {
                    this.commands.add("\"" + data.get("message") + "\"");
                }
            }
        }
    }

    private String cacheImageFile(String url) throws Exception {
        String contentType=HttpRequest.get(url).userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36").contentType();
        int index = contentType.indexOf("/");
        String extension = contentType.substring(index + 1);
        if ("jpeg".equals(extension)) {
            extension = "jpg";
        }
        File tempFile=File.createTempFile("tmp", "."+extension);
        HttpRequest.get(url).userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36").receive(tempFile);
        String randomName = "" + System.currentTimeMillis() + "." + extension;
        FileUtils.copyFile(tempFile, new File(sessionFolder, randomName));
        
        //System.out.println(tempFile.getAbsolutePath());
        tempFile.deleteOnExit();
        return randomName;
        /*System.setProperty("http.agent", "Mozilla");
        URLConnection con = new URL(url).openConnection();
        String contentType = con.getContentType();
        int index = contentType.indexOf("/");
        String extension = contentType.substring(index + 1);
        if ("jpeg".equals(extension)) {
            extension = "jpg";
        }
        System.out.println("extension="+extension);
        String randomName = "" + System.currentTimeMillis() + "." + extension;
        try (InputStream input = new URL(url).openStream(); OutputStream output = new FileOutputStream(new File(sessionFolder, randomName))) {
            IOUtils.copy(input, output);
        }
        return randomName;*/
    }

    class MonogatariCharacterSpec {

        String name, color, directory;
        /**
         * map state to image for now, images with no page limitation will be
         * associated with state "Normal" images that are bound to page will be
         * associated with state "Page"+pageIndex
         */
        Map<String, String> stateImageMap = new HashMap<>();
    }
}
