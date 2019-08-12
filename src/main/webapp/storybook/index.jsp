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
                    <h3><a v-bind:href="'../character-quote/index.old.jsp?id='+result.id">{{result.title}}</a></h3>
                    <div>
                        <p>{{result.summary}}</p>
                    </div>
                </div>
            </div>
        </div>
        <br/>
        <center>
            <div class="pagination" id="pagination">
                <a href="#">&laquo;</a>
                <span v-for="p in pagingData">
                    <span v-if="p.enabled==false">...</span>
                    <a v-if="p.enabled==true && p.current!=true" v-bind:href="'index.jsp?page='+p.index">{{p.index+1}}</a>
                    <span v-if="p.enabled==true && p.current==true">{{p.index+1}}</span>
                </span>
                <a href="#">&raquo;</a>
              </div>
        </center>
       
        <script>
            var vue=null;
            var vue_paging=null;
            var currentPage=<%=(request.getParameter("page")!=null)?(request.getParameter("page")):"0"%>;
            var currentSearch="findAll";

            $(document).ready(function(){
                let url=window.location.href;
                let index=url.lastIndexOf("/storybook");
                let ws=new StoryMetaJS(url.substring(0, index));
                ws.findAll(10, 0).then((data)=>{
                    vue = new Vue({
                        el: '#search-result-container',
                        data: {
                          "results": data
                        }
                      });
                });

                (async function(){
                    let cnt=await ws.count();
                    let pageCount=Math.ceil(cnt/10);
                    let remaining=cnt%10;
                    let pagingData=[];
                    
                    let startVisiblePageIndex=(currentPage>3)?(currentPage-3):0;
                    let lastVisiblePageIndex=((currentPage+3)<pageCount)?(currentPage+3):pageCount-1;
                    if(startVisiblePageIndex!=0){
                        //not start from 0
                        pagingData.push({
                            index: -1,
                            current: false,
                            enabled: false
                        });
                    }
                    for(let i=startVisiblePageIndex; i<=lastVisiblePageIndex; i++){
                        pagingData.push({
                            index: i,
                            current: (i==currentPage),
                            enabled: true
                        });
                    }
                    if(lastVisiblePageIndex!=pageCount-1){
                        //not end at the last page
                        pagingData.push({
                            index: -1,
                            current: false,
                            enabled: false
                        });
                    }
                    vue_paging=new Vue({
                        el: "#pagination",
                        data: {
                            "pagingData": pagingData
                        },
                        methods: {
                            "gotoPage": function(page){

                            }
                        }
                    });
                    console.log(vue_paging.pagingData);
                })();
            });
        </script>
    </body>
</html>
