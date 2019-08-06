<%@page contentType="text/html;charset=utf-8" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Start Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h1>歡迎光臨，<%=session.getAttribute("login")%></h1>
        <ul>
            <li>
                <a href="character-quote/index.html">Kids Coding 繪本故事編輯器</a>
            </li>
        </ul>
        <hr/>
        <a href="logout.jsp">登出</a>
    </body>
</html>
