/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.reader.utils;

import com.google.gson.Gson;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.security.GeneralSecurityException;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import org.apache.commons.io.IOUtils;
import rocks.imsofa.bp.kidscoding.editor.model.CharacterSpec;
import rocks.imsofa.bp.kidscoding.editor.model.ReadableStoryBookMeta;
import rocks.imsofa.bp.kidscoding.editor.model.SceneSpec;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBook;

/**
 *
 * @author lendle
 */
public class MonogatariSession {

    private String sessionId = null;
    private File sessionFolder = null;
    private Map<String, String> imageFileMap = new HashMap<>();//map url to internal file name
    private Map<String, MonogatariCharacterSpec> characterSpecs = new HashMap<>();//map character name to MonogatariCharacterSpec
    private ReadableStoryBookMeta meta = null;
    private String[] colors = new String[]{"#0000ff", "#cc66ff", "#ff0066", "#000066", "#009900", "#cc3300"};
    private List<String> commands = new ArrayList<>();
    private StoryBook storyBook = null;

    static {
        final TrustManager[] trustAllCertificates = new TrustManager[]{
            new X509TrustManager() {
                @Override
                public X509Certificate[] getAcceptedIssuers() {
                    return null; // Not relevant.
                }

                @Override
                public void checkClientTrusted(X509Certificate[] certs, String authType) {
                    // Do nothing. Just allow them all.
                }

                @Override
                public void checkServerTrusted(X509Certificate[] certs, String authType) {
                    // Do nothing. Just allow them all.
                }
            }
        };

        try {
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCertificates, new SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
        } catch (GeneralSecurityException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    public MonogatariSession(File monogatariRootDir, StoryBook storyBook, ReadableStoryBookMeta meta) {
        this.storyBook = storyBook;
        this.meta = meta;
        File tempFile = new File(monogatariRootDir, "temp");
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
        }
    }

    private void initCommands() {
        Gson gson = new Gson();
        List<Map> pageContents = storyBook.getPageContents();
        for (int i = 0; i < pageContents.size(); i++) {
            SceneSpec sceneSpec = this.meta.getSceneSpec(i);
            this.commands.add("\"scene url(\'" + sceneSpec.getImageURL() + "\')\"");
            Map pageContent = pageContents.get(i);
            List blocks = gson.fromJson("" + pageContent.get("blocks"), List.class);
            for (int j = 0; j < blocks.size(); j++) {
                Map pageJson = gson.fromJson("" + blocks.get(j), Map.class);
                Map data = (Map) pageJson.get("data");
                if ("characterQuote".equals(pageJson.get("type"))) {
                    //out.println("\"show "+data.get("character")+" "+data.get("message")+"\",");
                    String character = (String) data.get("character");
                    System.out.println("character=" + character);
                    CharacterSpec characterSpec = this.meta.getCharacterSpec(character, i);
                    String state = "Normal";
                    if (characterSpec.getPage() != -1) {
                        state = "Page" + i;
                    }
                    this.commands.add("\"show " + character + " " + state + " center\",");
                    this.commands.add("\"" + character + " " + data.get("message") + "\"");
                } else if ("os".equals(pageJson.get("type"))) {
                    this.commands.add("\"" + data.get("message") + "\"");
                }
            }
        }
    }

    private String cacheImageFile(String url) throws Exception {
        System.setProperty("http.agent", "Mozilla");
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
        return randomName;
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
