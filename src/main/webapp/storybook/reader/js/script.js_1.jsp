<%@page import="rocks.imsofa.bp.kidscoding.editor.model.StoryBook"%>
<%@page import="rocks.imsofa.bp.kidscoding.editor.service.StoryBookService"%>
<%@page contentType="text/javascript" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.servlet.support.*" %>
<%@page import="java.util.*, com.google.gson.*" %>
"use strict";
<%
    StoryBookService storyBookService=RequestContextUtils.findWebApplicationContext(request).getBean(StoryBookService.class);
    StoryBook storyBook=storyBookService.getStoryBook("1");
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
const characters = {
	"h": {
		"Name": "Hikaru",
		"Color": "#5bcaff",
		"Directory": "temp/12345",
		"Images":{ // Images Identifier for the "Show" statement.
            "Normal": "21-eevee-day-01.jpg"
		}
	},
	"test2": {
		"Name": "test2",
		"Color": "blue",
		"Directory": "temp/12345",
		"Images":{ // Images Identifier for the "Show" statement.
            "Normal": "98f1f86c-29f1-4a12-8ebc-5b13f2c51eb0_1.31d679aeaecb5d4115e447a470bb84e4.jpeg"
		}
	}
};

let script = {
	// The game starts here.
	"Start": [
		"scene url('https://dubaitravelblog.com/wp-content/uploads/2019/04/coca-cola-arena-citywalk-dubai.jpg')",
                <%
                    List<Map> pageContents=storyBook.getPageContents();
                    for(int i=0; i<pageContents.size(); i++){
                        Map pageContent=pageContents.get(i);
                        List blocks=gson.fromJson(""+pageContent.get("blocks"), List.class);
                        for(int j=0; j<blocks.size(); j++){
                            System.out.println(blocks.get(j));
                        }
                        System.out.println("=====================");
                    }
                %>
		"notify Welcome",
		"show h Normal center",
		{
			"Input": {
				"Text": "What is your name?",
				"Validation": function (input) {
					return input.trim().length > 0;
				},
				"Save": function (input) {
					storage.player.Name = input;
					return true;
				},
				"Warning": "You must enter a name!"
			}
		},
		"h Hi {{player.Name}} Welcome to Monogatari!",
		"show test2 Normal center",
		"test2 hello~",
		"show h Normal center",
		{
			"Choice": {
				"Dialog": "h Have you already read some documentation?",
				"Yes": {
					"Text": "Yes",
					"Do": "jump Yes"
				},
				"No": {
					"Text": "No",
					"Do": "jump No"
				}
			}
		}
	],

	"Yes": [

		"h That's awesome!",
		"h Then you are ready to go ahead and create an amazing Game!",
		"h I can't wait to see what story you'll tell!",
		"jump Scene2"
	],

	"No": [

		"h You can do it now.",

		"display message Help",

		"h Go ahead and create an amazing Game!",
		"h I can't wait to see what story you'll tell!",
		"end"
	],


	"Scene2": [
		"scene url('http://www.teachhub.com/sites/default/files/field/image/classroom-management-effective-learning-environment.jpg')",
		"show h Normal center",
		"h hello, this is scene2",
		"show b Normal center",
		"b what is this?",
		"end"
	]
};