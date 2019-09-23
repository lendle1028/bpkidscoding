<%-- 
    Document   : listing
    Created on : Sep 23, 2019, 12:02:56 PM
    Author     : lendle
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
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
        <script src="../js/StoryMetaJS.js" type="text/javascript"></script>
        <script src="../js/StoryBookJS.js" type="text/javascript"></script>
    </head>
    <body>
        <script>
            $(document).ready(function () {
                $("#accordion").accordion();
                $("#tabs").tabs();
            });
        </script>
        <%
            StoryBookService storyBookService=RequestContextUtils.findWebApplicationContext(request).getBean(StoryBookService.class);
            StoryBook storyBook=storyBookService.getStoryBook(request.getParameter("storyBookId"));
        %>
        <div id="accordion">
            <h3>簡介</h3>
            <div>
                <p>
                    <button>編輯</button><br/>
                    作者：<%=storyBook.getMeta().getAuthor()%><br/>
                    <span id="summary"><%=storyBook.getMeta().getSummary()%></span>
                </p>
            </div>
            <h3>角色</h3>
            <div>
                <ul>
                    <%
                        for(Object data : (List)storyBook.getMeta().getCharacters().get("blocks")){
                            Map map=(Map)((Map)data).get("data");
                            String key=(String)map.get("character");
                            String value=(String)map.get("message");
                    %>
                    <li><%=key%>:<%=value%></li>
                    <%
                        }
                    %>
                </ul>
            </div>
            <h3>內容</h3>
            <div>
                <ul>
                    <%
                        for(Map data : storyBook.getPageContents()){
                            Map content=(Map)((Map)((List)data.get("blocks")).get(0)).get("data");
                            String value=(String)content.get("message");
                    %>
                    <li><%=value%></li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
        <div id="tabs">
            <ul>
                <li><a href="#tabs-1">繪本區</a></li>
                <li><a href="#tabs-2">程式素養區</a></li>
            </ul>
            <div id="tabs-1">
                <p>Proin elit arcu, rutrum commodo, vehicula tempus, commodo a, risus. Curabitur nec arcu. Donec sollicitudin mi sit amet mauris. Nam elementum quam ullamcorper ante. Etiam aliquet massa et lorem. Mauris dapibus lacus auctor risus. Aenean tempor ullamcorper leo. Vivamus sed magna quis ligula eleifend adipiscing. Duis orci. Aliquam sodales tortor vitae ipsum. Aliquam nulla. Duis aliquam molestie erat. Ut et mauris vel pede varius sollicitudin. Sed ut dolor nec orci tincidunt interdum. Phasellus ipsum. Nunc tristique tempus lectus.</p>
            </div>
            <div id="tabs-2">
                <p>Morbi tincidunt, dui sit amet facilisis feugiat, odio metus gravida ante, ut pharetra massa metus id nunc. Duis scelerisque molestie turpis. Sed fringilla, massa eget luctus malesuada, metus eros molestie lectus, ut tempus eros massa ut dolor. Aenean aliquet fringilla sem. Suspendisse sed ligula in ligula suscipit aliquam. Praesent in eros vestibulum mi adipiscing adipiscing. Morbi facilisis. Curabitur ornare consequat nunc. Aenean vel metus. Ut posuere viverra nulla. Aliquam erat volutpat. Pellentesque convallis. Maecenas feugiat, tellus pellentesque pretium posuere, felis lorem euismod felis, eu ornare leo nisi vel felis. Mauris consectetur tortor et purus.</p>
            </div>
        </div>
    </body>
</html>
