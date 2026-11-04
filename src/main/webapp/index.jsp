<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // If admin is already logged in, open dashboard
    if (session.getAttribute("adminUsername") != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>IRON CLUB | Gym Management</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #111;
            color: white;
            text-align: center;
        }

        .container {
            margin-top: 150px;
        }

        h1 {
            font-size: 48px;
            letter-spacing: 3px;
        }

        span {
            color: #ff751a;
        }

        p {
            color: #bbb;
            font-size: 18px;
        }

        .login-btn {
            display: inline-block;
            background: #ff751a;
            color: white;
            padding: 14px 32px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
        }

        .login-btn:hover {
            background: #e96510;
        }
    </style>
</head>

<body>

    <div class="container">

        <h1>IRON <span>CLUB</span></h1>

        <p>Welcome to Gym Membership Management System</p>

        <!-- Navigate to Admin Login -->

        <a href="${pageContext.request.contextPath}/login.jsp"
           class="login-btn">
            Get Started
        </a>

    </div>

</body>
</html>

