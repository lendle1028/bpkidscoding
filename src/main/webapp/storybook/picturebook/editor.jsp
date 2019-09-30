<%-- 
    Document   : editor
    Created on : Sep 25, 2019, 6:39:52 AM
    Author     : lendle
--%>

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
            $(document).ready(function () {
                $("#tabs").tabs();
                $("#charactersList").tabs().addClass("ui-tabs-vertical ui-helper-clearfix");
                $("#charactersList li").removeClass("ui-corner-top").addClass("ui-corner-left");
            });
        </script>
        <div id="tabs">
            <ul>
                <li><a href="#characters">角色</a></li>
                <li><a href="#scenes">場景</a></li>
            </ul>
            <div id="characters">
                <div id="charactersList">
                    <ul>
                        <li><a href="#a">皮卡丘</a></li>
                        <li><a href="#b">怪物</a></li>
                    </ul>
                    <div id="a">
                        <table style="width: 100%">
                            <tbody>
                                <tr>
                                    <td style="width: 20%">Page 0</td>
                                    <td style="width: 80%"><input type="text" style="width: 100%"/></td>
                                </tr>
                                <tr>
                                    <td>Page 1</td>
                                    <td><input type="text" style="width: 100%"/></td>
                                </tr>
                                <tr>
                                    <td>Page 2</td>
                                    <td><input type="text" style="width: 100%"/></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="b">
                        <table style="width: 100%">
                            <tbody>
                                <tr>
                                    <td style="width: 20%">Page 0</td>
                                    <td style="width: 80%"><input type="text" style="width: 100%"/></td>
                                </tr>
                                <tr>
                                    <td>Page 1</td>
                                    <td><input type="text" style="width: 100%"/></td>
                                </tr>
                                <tr>
                                    <td>Page 2</td>
                                    <td><input type="text" style="width: 100%"/></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div id="scenes">
                <table style="width: 100%">
                    <tbody>
                        <tr>
                            <td style="width: 20%">Page 0</td>
                            <td style="width: 80%"><input type="text" style="width: 100%"/></td>
                        </tr>
                        <tr>
                            <td>Page 1</td>
                            <td><input type="text" style="width: 100%"/></td>
                        </tr>
                        <tr>
                            <td>Page 2</td>
                            <td><input type="text" style="width: 100%"/></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
