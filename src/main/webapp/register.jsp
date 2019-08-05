<%-- 
    Document   : register
    Created on : Aug 5, 2019, 3:53:08 PM
    Author     : lendle
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body>
        <h1>請輸入下列資料</h1>
        <form method="post" action="post_register">
            使用者名稱: <input type="text" name="userId" required="true"/><br/>
            Google 帳號: <input type="text" name="googleAccount" value="<%=session.getAttribute("register")%>" readonly="readonly"/><br/>
            Email: <input type="text" name="email" value="<%=session.getAttribute("register")%>" required="true"/><br/>
            <input type="submit"/>
        </form>
    </body>
</html>
