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
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"
        integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css"
        integrity="sha256-46qynGAkLSFpVbEBog43gvNhfrOj+BmwXdxFgVK/Kvc=" crossorigin="anonymous" />
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script> -->
    <!--link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" /-->
</head>

<body>
    <div id="container" class="container-fluid">
        <div id="header">
            <h1 id="title" onclick="showEditBookNameDialog();">書名</h1>&nbsp;<h2 id="page">第一頁</h2>
        </div>
        <div id="content" style="width: 100%">
            <div class="row" style="width: 100%">
                <ul class="list-group col-2" style="width: 100%">
                    <li class="list-group-item list-group-item-warning" onclick="flipIntro();"
                        style="cursor: pointer; width: 100%">簡介</li>
                    <li class="list-group-item list-group-item-warning" onclick="flipCharacters();"
                        style="cursor: pointer; width: 100%">角色介紹</li>
                    <li class="list-group-item list-group-item-warning" v-for="(page, index) in book.data"
                         style="width: 100%">
                        <div class="row">
                            <div class="col-9" style="cursor: pointer; " v-on:click="flip2Page(index);">
                                第{{index+1}}頁
                            </div>
                            <div class="col-3 float-right" >
                                <span class="fa fa-trash-alt" style="cursor: pointer;"></span>
                            </div>
                        </div>
                    </li>
                    <li class="list-group-item list-group-item-warning" onclick="flipCharacters();"
                        style="cursor: pointer; width: 100%">
                        <button class="btn btn-primary float-center"><span class="fa fa-plus"></span></button>
                    </li>
                </ul>
                <div id="editorContainer" class="col-10">
                    <!--div id="editorjs"></div-->
                </div>
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
        var currentBook = null;
        let url = window.location.href;
        let index = url.lastIndexOf("/");
        let ws2 = new StoryBookJS(url.substring(0, index) + "/..");
        //let data=null;
        let vue = null;
        ws2.getStoryBook("<%=request.getParameter("id")%>").then((book) => {
            console.log(book);
            currentBook = book;
            vue = new Vue({
                el: "#container",
                data: {
                    book: book
                },
                methods: {
                    flip2Page: function (index) {
                        flip(index);
                    }
                }
            });
        });

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
            showEditorJSUI(currentBook.summary, TOOL_SET.INTRO);
        }

        function flipCharacters() {
            showEditorJSUI(currentBook.characters, TOOL_SET.CHARACTERS);
        }

        function flip(index) {
            currentPage = index;
            showEditorJSUI(currentBook.data[index], TOOL_SET.PAGE);
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