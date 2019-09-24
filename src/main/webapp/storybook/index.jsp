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
    <script src="https://code.jquery.com/jquery-3.4.1.js"
        integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
    <link href="index.css" rel="stylesheet" type="text/css" />
    <script src="index.js" type="text/javascript"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue"></script>
    <script src="../js/StoryMetaJS.js" type="text/javascript"></script>
</head>

<body>
    <form class="searchForm" method="get" action="">
        <input class="searchTerm" placeholder="Search…" autocomplete="off" />
        <input type="button" class="searchBtn" value="GO" onclick="searchByKeyword();"/>
        <input type="button" class="searchBtn" value="By Author" onclick="searchByAuthor();"/>
    </form>
    <hr />
    <div id="search-result-container">
        <div class="search-result" v-for="result in results">
            <div class="content">
                <h3><a v-bind:href="'listing.jsp?storyBookId='+result.id">{{result.title}}</a></h3>
                <div>
                    <p>{{result.summary}}</p>
                </div>
            </div>
        </div>
    </div>
    <br />
    <center>
        <div class="pagination" id="pagination">
            <span v-if="currentPage == 0">
                &laquo;
            </span>
            <a v-else href="#" v-on:click="gotoPage(currentPage-1);">&laquo;</a>
            <span v-for="p in pagingData">
                <span v-if="p.enabled==false">...</span>
                <a v-if="p.enabled==true && p.current!=true" v-on:click="gotoPage(p.index);" href="#">{{p.index+1}}</a>
                <span v-if="p.enabled==true && p.current==true">{{p.index+1}}</span>
            </span>
            <span v-if="currentPage == pageCount-1">
                &raquo;
            </span>
            <a v-else href="#" v-on:click="gotoPage(currentPage+1);">&raquo;</a>
        </div>
    </center>

    <script>
        var vue = null;
        var vue_paging = null;
        var currentPage = 0;
        var currentSearchType = StoryMetaJS.ALL;
        var currentSearchArg = null;
        var count=-1;
        var pageCount=0;

        function searchByKeyword(){
            count=-1;
            doSearch(StoryMetaJS.BY_KEYWORD, $(".searchTerm").val(), 0);
        }

        function searchByAuthor(){
            count=-1;
            doSearch(StoryMetaJS.BY_AUTHOR, $(".searchTerm").val(), 0);
        }

        async function doSearch(searchType, arg, pageIndex) {
            if (searchType == null) {
                searchType = currentSearchType;
            } else {
                currentSearchType = searchType;
            }

            if (arg == null) {
                arg = currentSearchArg;
            } else {
                currentSearchArg = arg;
            }
            let url = window.location.href;
            let index = url.lastIndexOf("/storybook");
            let ws = new StoryMetaJS(url.substring(0, index));

            if(count==-1){
                //calculate the total number of instances with
                //the given search criteria
                let data=await ws.find(searchType, arg, 999999, 0);
                count=data.length;
                console.log("count="+count);
            }

            let data = await ws.find(searchType, arg, 10, pageIndex);
            if (vue == null) {
                vue = new Vue({
                    el: '#search-result-container',
                    data: {
                        "results": data
                    }
                });
            }else{
                vue.results=data;
            }

            currentPage = pageIndex;
            //console.log(currentPage);

            let cnt = count;
            pageCount = Math.ceil(cnt / 10);
            let remaining = cnt % 10;
            let pagingData = [];

            let startVisiblePageIndex = (currentPage > 3) ? (currentPage - 3) : 0;
            let lastVisiblePageIndex = ((currentPage + 3) < pageCount) ? (currentPage + 3) : pageCount - 1;
            if (startVisiblePageIndex != 0) {
                //not start from 0
                pagingData.push({
                    index: -1,
                    current: false,
                    enabled: false
                });
            }
            for (let i = startVisiblePageIndex; i <= lastVisiblePageIndex; i++) {
                pagingData.push({
                    index: i,
                    current: (i == currentPage),
                    enabled: true
                });
            }
            if (lastVisiblePageIndex != pageCount - 1) {
                //not end at the last page
                pagingData.push({
                    index: -1,
                    current: false,
                    enabled: false
                });
            }
            if (vue_paging == null) {
                vue_paging = new Vue({
                    el: "#pagination",
                    data: {
                        "pagingData": pagingData
                    },
                    methods: {
                        "gotoPage": function (page) {
                            console.log("gotoPage: " + page);
                            doSearch(null, null, page);
                        }
                    }
                });
            } else {
                vue_paging.pagingData = pagingData;
            }

            //console.log(vue_paging.pagingData);

        }

        $(document).ready(function () {
            doSearch(currentSearchType, null, 0);
        });
        // $(document).ready(function () {
        //     let url = window.location.href;
        //     let index = url.lastIndexOf("/storybook");
        //     let ws = new StoryMetaJS(url.substring(0, index));
        //     ws.findAll(10, 0).then((data) => {
        //         vue = new Vue({
        //             el: '#search-result-container',
        //             data: {
        //                 "results": data
        //             }
        //         });
        //     });

        //     (async function () {
        //         let cnt = await ws.count();
        //         let pageCount = Math.ceil(cnt / 10);
        //         let remaining = cnt % 10;
        //         let pagingData = [];

        //         let startVisiblePageIndex = (currentPage > 3) ? (currentPage - 3) : 0;
        //         let lastVisiblePageIndex = ((currentPage + 3) < pageCount) ? (currentPage + 3) : pageCount - 1;
        //         if (startVisiblePageIndex != 0) {
        //             //not start from 0
        //             pagingData.push({
        //                 index: -1,
        //                 current: false,
        //                 enabled: false
        //             });
        //         }
        //         for (let i = startVisiblePageIndex; i <= lastVisiblePageIndex; i++) {
        //             pagingData.push({
        //                 index: i,
        //                 current: (i == currentPage),
        //                 enabled: true
        //             });
        //         }
        //         if (lastVisiblePageIndex != pageCount - 1) {
        //             //not end at the last page
        //             pagingData.push({
        //                 index: -1,
        //                 current: false,
        //                 enabled: false
        //             });
        //         }
        //         vue_paging = new Vue({
        //             el: "#pagination",
        //             data: {
        //                 "pagingData": pagingData
        //             },
        //             methods: {
        //                 "gotoPage": function (page) {

        //                 }
        //             }
        //         });
        //         console.log(vue_paging.pagingData);
        //     })();
        // });
    </script>
</body>

</html>