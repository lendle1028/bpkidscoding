<%-- 
    Document   : index.old
    Created on : Aug 9, 2019, 9:47:44 PM
    Author     : lendle
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>

<head>
    <meta charset="utf-8" />
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"
        integrity="sha256-eGE6blurk5sHj+rmkfsGYeKyZx3M4bG+ZlFyA7Kns7E=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/editorjs@latest"></script>
    <script src="quote.js"></script>
    <script src="separator.js"></script>
    <script src="os.js"></script>
    <script src="EditorDataProcessor.js"></script>
    <link href="quote.css" rel="stylesheet" />
    <link href="separator.css" rel="stylesheet" />
    <link href="os.css" rel="stylesheet" />
    <link href="main.css" rel="stylesheet" />
    <link href="https://code.jquery.com/ui/1.12.1/themes/le-frog/jquery-ui.css" rel="stylesheet" />
    <script src="../js/StoryMetaJS.js" type="text/javascript"></script>
    <script src="../js/StoryBookJS.js" type="text/javascript"></script>
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script> -->
    <!--link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" /-->
</head>

<body>111
    <div id="container">
        <div id="header">
            <h1 id="title" onclick="showEditBookNameDialog();">書名</h1>&nbsp;<h2 id="page">第一頁</h2>
        </div>
        <div id="content">
            <div id="tree">
                <table style="width: 100%;">
                    <tr>
                        <td onclick="flipIntro();">簡介</td>
                    </tr>
                    <tr>
                        <td onclick="flipCharacters();">角色介紹</td>
                    </tr>
                    <tr>
                        <td onclick="flip(0);">第一頁</td>
                    </tr>
                    <tr>
                        <td onclick="flip(1);">第二頁</td>
                    </tr>
                    <tr>
                        <td onclick="flip(2);">第三頁</td>
                    </tr>
                </table>
            </div>
            <div id="editorContainer">
                <!--div id="editorjs"></div-->
            </div>
        </div>

    </div>
    <div id="editBookNameDialog" style="display: none">
        書名：<input type="text" id="editBookNameDialog_name" />
    </div>
    <button onclick="save();">Save</button>

    <script>
        var currentData = null;
        var currentEditor = null;
        var TOOL_SET = {
            INTRO: {
                os: Os
            },
            CHARACTERS: {
                characterQuote: Quote
            },
            PAGE: {
                characterQuote: Quote,
                separator: Separator,
                os: Os
            }
        };
        var currentEditorType = null;
        var currentPage = -1;
        function showEditBookNameDialog() {
            $("#editBookNameDialog_name").val(data.title);
            $("#editBookNameDialog").dialog({
                modal: true,
                buttons: [{
                    text: "Ok",
                    icon: "ui-icon-check",
                    click: function () {
                        data.title = $("#editBookNameDialog_name").val();
                        $("#title").text(data.title);
                        $(this).dialog("close");
                    }
                },
                {
                    text: "Cancel",
                    icon: "ui-icon-close",
                    click: function () {
                        $(this).dialog("close");
                    }
                }]
            });
        }

        function flipIntro() {
            showEditorJSUI(data.summary, TOOL_SET.INTRO);
        }

        function flipCharacters() {
            showEditorJSUI(data.characters, TOOL_SET.CHARACTERS);
        }

        function flip(index) {
            currentPage = index;
            showEditorJSUI(data.data[index], TOOL_SET.PAGE);
        }

        function showEditorJSUI(data, toolset = TOOL_SET.PAGE) {
            //first, check if there is any modification
            if (currentEditor) {
                currentEditor.save().then(savedData => {
                    if (currentData != null) {
                        let modified = EditorDataProcessor.isModified(savedData, currentData);
                        if (modified) {
                            let save = window.confirm("是否儲存?");
                            //todo: 儲存
                            if (save) {
                                if (currentEditorType == "page") {
                                    data.data[currentPage] = savedData;
                                } else if (currentEditorType == "summary") {
                                    data.summary = savedData;
                                    console.log(data);
                                } else {
                                    data.characters = savedData;
                                }
                            }
                        }
                        //then, load the editor
                        _showEditorJSUI(data, toolset);
                    }
                });
            } else {
                _showEditorJSUI(data, toolset);
            }
        }
        /**
         * an internal function to load editorjs
         */
        function _showEditorJSUI(data, toolset) {
            if (toolset == TOOL_SET.PAGE) {
                currentEditorType = "page";
            } else if (toolset == TOOL_SET.CHARACTERS) {
                currentEditorType = "characters";
            } else {
                currentEditorType = "summary";
            }
            currentData = data;
            $("#editorContainer").empty();
            let editorUI = document.createElement("div");
            $(editorUI).attr("id", "editorjs");
            $("#editorContainer").append($(editorUI));
            currentEditor = new EditorJS({
                holder: 'editorjs',
                autofocus: true,
                tools: toolset,
                "data": data
            });
        }
        
        let url=window.location.href;
        let index=url.lastIndexOf("/");
        let ws2=new StoryBookJS(url.substring(0, index)+"/..");
        let data=null;
        ws2.getStoryBook("<%=request.getParameter("id")%>").then((book)=>{
            data = book;
        });
        
        /*let data = {
            title: "Book1",
            summary: { "time": 1563781369246, "blocks": [{ "type": "os", "data": { "message": "簡介" } }], "version": "2.15.0" },
            characters: { "time": 1563781369246, "blocks": [{ "type": "characterQuote", "data": { "character": "test2", "message": "111" } }], "version": "2.15.0" },
            data: [
                { "time": 1563781369246, "blocks": [{ "type": "characterQuote", "data": { "character": "test2", "message": "111" } }, { "type": "os", "data": { "message": "12121" } }, { "type": "separator", "data": {} }], "version": "2.15.0" },
                { "time": 1563781369246, "blocks": [{ "type": "characterQuote", "data": { "character": "test2", "message": "112" } }, { "type": "os", "data": { "message": "12121" } }, { "type": "separator", "data": {} }], "version": "2.15.0" },
                { "time": 1563781369246, "blocks": [{ "type": "characterQuote", "data": { "character": "test2", "message": "113" } }, { "type": "os", "data": { "message": "12121" } }, { "type": "separator", "data": {} }], "version": "2.15.0" }
            ]
        };*/

        function save() {
            editor.save().then(savedData => {
                console.log(JSON.stringify(savedData));
            });
        }

    </script>
</body>

</html>
