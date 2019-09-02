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
        <script src="js/StoryBookJS.js" type="text/javascript"></script>
    </head>
    <body>
        <h1>歡迎光臨，<%=session.getAttribute("login")%></h1>
        <ul>
            <li>
                <a href="storybook/index.jsp">Kids Coding 繪本故事編輯器</a>
            </li>
        </ul>
        <script>
            $(document).ready(function(){
                let url=window.location.href;
                let index=url.lastIndexOf("/");
                /*let ws=new StoryMetaJS(url.substring(0, index));
                ws.findAll().then((data)=>{
                    console.log(data);
                });*/
                
                let ws2=new StoryBookJS(url.substring(0, index));
                ws2.getStoryBook("0685455b-f62a-4367-8560-afaf47444dde").then((data)=>{
                    console.log(data);
                });
            });
        </script>
        <hr/>
        <a href="logout.jsp">登出</a>
    </body>
</html>
