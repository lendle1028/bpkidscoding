<%@page contentType="text/html;charset=utf-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Start Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>
        <script type="text/javascript" src="/BPKidsCoding/js/StoryMetaJS.js"></script>
    </head>
    <body>
        <h1>歡迎光臨，<%=session.getAttribute("login")%></h1>
        <ul>
            <li>
                <a href="character-quote/index.html">Kids Coding 繪本故事編輯器</a>
            </li>
        </ul>
        <script>
            $(document).ready(function(){
                let url=window.location.href;
                let index=url.lastIndexOf("/");
                let ws=new StoryMetaJS(url.substring(0, index));
                ws.findAll().then((data)=>{
                    console.log(data);
                });
            });
        </script>
        <hr/>
        <a href="logout.jsp">登出</a>
    </body>
</html>
