<%-- 
    Document   : index
    Created on : Aug 9, 2019, 9:48:26 AM
    Author     : lendle
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
        crossorigin="anonymous"></script>
        <link href="index.css" rel="stylesheet" type="text/css"/>
        <script src="index.js" type="text/javascript"></script>
        <script src="https://cdn.jsdelivr.net/npm/vue"></script>
        <script src="../js/StoryMetaJS.js" type="text/javascript"></script>
    </head>
    <body>
        <form class="searchForm" method="get" action="">              
            <input class="searchTerm"  placeholder="Search…" autocomplete="off"/>
            <input type="submit" class="searchBtn" value="GO"/>
            <input type="submit" class="searchBtn" value="By Author"/>
        </form>
        <hr/>
        <div id="search-result-container">
            <div class="search-result" v-for="result in results">
                <div class="content">
                    <h3><a href="/viewjob/1234">{{result.title}}</a></h3>
                    <div>
                        <p>{{result.summary}}</p>
                    </div>
                </div>
            </div>
        </div>
       
        <script>
            var vue=null;
            $(document).ready(function(){
                let url=window.location.href;
                let index=url.lastIndexOf("/storybook");
                let ws=new StoryMetaJS(url.substring(0, index));
                ws.findAll(10, 0).then((data)=>{
                    var vue = new Vue({
                        el: '#search-result-container',
                        data: {
                          "results": data
                        }
                      });
                });
            });
        </script>
    </body>
</html>
