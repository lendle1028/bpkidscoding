<%-- 
    Document   : logout.jsp
    Created on : Aug 6, 2019, 10:53:51 AM
    Author     : lendle
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="google-signin-client_id" content="437674419610-28dg7fqqhh2p3nqh9l965gljc1fh3nek.apps.googleusercontent.com">
        <script src="https://apis.google.com/js/platform.js"></script>
        <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
        crossorigin="anonymous"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <%
            session.invalidate();
        %>
        <script>
            $(document).ready(function () {
                gapi.load('auth2', function () {
                    gapi.auth2.init();
                    var auth2 = gapi.auth2.getAuthInstance();
                    setTimeout(function () {
                        auth2.signOut().then(function () {
                            console.log('User signed out.');
                        });
                    }, 500);
                });
            });

        </script>
        <a href="index.jsp">回首頁</a>
    </body>
</html>
