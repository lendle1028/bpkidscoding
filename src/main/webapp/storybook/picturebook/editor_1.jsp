<%-- 
    Document   : editor
    Created on : Sep 25, 2019, 6:39:52 AM
    Author     : lendle
--%>

<%@page import="java.util.Map"%>
<%@page import="rocks.imsofa.bp.kidscoding.editor.model.StoryBookMeta.CharacterBlock"%>
<%@page import="rocks.imsofa.bp.kidscoding.editor.model.StoryBookMeta.Characters"%>
<%@page import="rocks.imsofa.bp.kidscoding.editor.model.StoryBookMeta"%>
<%@page import="rocks.imsofa.bp.kidscoding.editor.service.PictureBookMetaService"%>
<%@page import="rocks.imsofa.bp.kidscoding.editor.model.StoryBook"%>
<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@page import="rocks.imsofa.bp.kidscoding.editor.service.StoryBookService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://code.jquery.com/jquery-3.4.1.js"
        integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
        <script
            src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
            integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
        crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/south-street/jquery-ui.css"/>
        <script src="https://cdn.jsdelivr.net/npm/vue"></script>
        <script src="../../js/StoryMetaJS.js" type="text/javascript"></script>
        <script src="../../js/StoryBookJS.js" type="text/javascript"></script>
        <script src="../../js/PictureBookMetaJS.js" type="text/javascript"></script>
        <style>
            .ui-tabs-vertical { width: 55em; }
            .ui-tabs-vertical .ui-tabs-nav { padding: .2em .1em .2em .2em; float: left; width: 12em; }
            .ui-tabs-vertical .ui-tabs-nav li { clear: left; width: 100%; border-bottom-width: 1px !important; border-right-width: 0 !important; margin: 0 -1px .2em 0; }
            .ui-tabs-vertical .ui-tabs-nav li a { display:block; }
            .ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active { padding-bottom: 0; padding-right: .1em; border-right-width: 1px; }
            .ui-tabs-vertical .ui-tabs-panel { padding: 1em; float: right; width: 40em;}
        </style>
    </head>
    <body>
        <script>
            let url = window.location.href;
            let index = url.lastIndexOf("/storybook");
            let storyMetaWS = new StoryMetaJS(url.substring(0, index));
            let storyBookWS = new StoryBookJS(url.substring(0, index));
            let pictureBookWS=new PictureBookMetaJS(url.substring(0, index));
            let storyBook=null;
            let pictureBook=null;
            let characterSpecsMap={};
            let vue=null;
            
            async function run(){
                storyBook=await storyBookWS.getStoryBook("<%=request.getParameter("storyBookId")%>");
                pictureBook=await pictureBookWS.createFromStoryBook("<%=request.getParameter("storyBookId")%>");
                pictureBook.characterSpecs.sort((a,b)=>{
                    return a.page-b.page;
                });
                //collect characterspecs and put them into map with character names as the key
                for(let c of pictureBook.characterSpecs){
                    if(!characterSpecsMap[c.name]){
                        characterSpecsMap[c.name]=[];
                    }
                    characterSpecsMap[c.name].push(c);
                }
                vue=new Vue({
                    el: "#tabs",
                    data:{
                        "pictureBook": pictureBook,
                        "characterSpecsMap": characterSpecsMap
                    }
                });
            }
            
            $(document).ready(function () {
                $("#tabs").tabs();
                $("#charactersList").tabs().addClass("ui-tabs-vertical ui-helper-clearfix");
                $("#charactersList li").removeClass("ui-corner-top").addClass("ui-corner-left");
                run();
            });
        </script>
        <%
            String storyBookId=request.getParameter("storyBookId");
            StoryBookService storyBookService=RequestContextUtils.findWebApplicationContext(request).getBean(StoryBookService.class);
            StoryBook storyBook=storyBookService.getStoryBook(request.getParameter("storyBookId"));
            StoryBookMeta meta=storyBook.getMeta();
            //PictureBookMetaService pictureBookMetaService=RequestContextUtils.findWebApplicationContext(request).getBean(PictureBookMetaService.class);
            int pageCount=storyBook.getPageContents().size();
            Characters characters=meta.getCharacters();
        %>
        <form action="editor_save.jsp">
            <div id="tabs">
                <ul>
                    <li><a href="#characters">角色</a></li>
                    <li><a href="#scenes">場景</a></li>
                </ul>
                <div id="characters">
                    <div id="charactersList">
                        <ul>
                            <%
                                for(CharacterBlock block : characters.getBlocks()){
                                    Map<String, String>data=block.getData();
                            %>
                            <li><a href="#<%=data.get("character")%>"><%=data.get("character")%></a></li>
                            <%
                                }
                            %>
                            <!--li><a href="#a">皮卡丘</a></li>
                            <li><a href="#b">怪物</a></li-->
                        </ul>
                            <%
                                for (CharacterBlock block : characters.getBlocks()) {
                                    Map<String, String> data = block.getData();
                            %>
                            <div id="<%=data.get("character")%>">
                                <table style="width: 100%">
                                    <tbody>
                                        <%
                                            for(int i=0; i<pageCount; i++){
                                        %>
                                        <tr>
                                            <td style="width: 20%">Page <%=i%></td>
                                            <td style="width: 80%"><input type="text" style="width: 100%" id="<%="character_"+data.get("character")+"_"+i%>"/></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <%
                                }
                            %>
                    </div>
                </div>
                <div id="scenes">
                    <table style="width: 100%">
                        <tbody>
                            <%
                                for (int i = 0; i < pageCount; i++) {
                            %>
                            <tr>
                                <td style="width: 20%">Page <%=i%></td>
                                <td style="width: 80%"><input type="text" style="width: 100%" id="<%="scene_" + i%>"/></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </form>
    </body>
</html>
