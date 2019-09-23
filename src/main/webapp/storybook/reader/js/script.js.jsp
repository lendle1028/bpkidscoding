<%@page import="java.io.File"%>
<%@page import="rocks.imsofa.bp.kidscoding.reader.utils.MonogatariSession"%>
<%@page import="rocks.imsofa.bp.kidscoding.editor.model.PictureBookMeta"%>
<%@page import="rocks.imsofa.bp.kidscoding.editor.service.PictureBookMetaService"%>
<%@page import="rocks.imsofa.bp.kidscoding.editor.model.StoryBook"%>
<%@page import="rocks.imsofa.bp.kidscoding.editor.service.StoryBookService"%>
<%@page contentType="text/javascript" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.servlet.support.*" %>
<%@page import="java.util.*, com.google.gson.*" %>
"use strict";
<%
    PictureBookMetaService readableStoryBookMetaService=RequestContextUtils.findWebApplicationContext(request).getBean(PictureBookMetaService.class);
    StoryBookService storyBookService=RequestContextUtils.findWebApplicationContext(request).getBean(StoryBookService.class);
    StoryBook storyBook=storyBookService.getStoryBook("1");
    PictureBookMeta meta=readableStoryBookMetaService.findByStoryBookId(storyBook.getId()).get(0);
    MonogatariSession monogatariSession=new MonogatariSession(new File(application.getRealPath("/storybook/reader")), storyBook, meta);
    Gson gson=new Gson();
%>

/* exported messages */
/* exported notifications */
/* exported particles */
/* exported music */
/* exported voice */
/* exported sound */
/* exported videos */
/* exported images */
/* exported scenes */
/* exported characters */
/* exported script */

/* global storage */

// Define the messages used in the game.
let messages = {
	"Help": {
		"Title": "Help",
		"Subtitle": "Some useful Links",
		"Message": "<p><a href='https://monogatari.io/documentation/'>Documentation</a> - Everything you need to know.</p><p><a href='https://monogatari.io/demo/'>Demo</a> - A simple Demo.</p>"
	}
};

// Define the notifications used in the game
let notifications = {
	"Welcome": {
		title: "Welcome",
		body: "This is the Monogatari VN Engine",
		icon: ""
	}
};

// Define the Particles JS Configurations used in the game
let particles = {

};

// Define the music used in the game.
const music = {

};

// Define the voice files used in the game.
const voice = {

};

// Define the sounds used in the game.
const sound = {

};

// Define the videos used in the game.
const videos = {

};

// Define the images used in the game.
const images = {

};

// Define the backgrounds for each scene.
const scenes = {
};

// Define the Characters
const characters = <%=monogatariSession.getCharacterSpecs()%>;

<%
    String [] scenes=new String[]{
        "https://dubaitravelblog.com/wp-content/uploads/2019/04/coca-cola-arena-citywalk-dubai.jpg",
        "http://www.teachhub.com/sites/default/files/field/image/classroom-management-effective-learning-environment.jpg"
    };
%>

let script = {
	// The game starts here.
	"Start": [
            <%=monogatariSession.getCommands()%>
	]
};