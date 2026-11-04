<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login | IRON CLUB</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #111111;
            color: white;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-box {
            width: 380px;
            padding: 40px;
            background: #1c1c1c;
            border-radius: 12px;
            box-shadow: 0 0 25px rgba(255,117,26,0.12);
        }

        h1 {
            text-align: center;
            font-size: 32px;
            margin-bottom: 8px;
        }

        .orange {
            color: #ff751a;
        }

        .subtitle {
            text-align: center;
            color: #aaa;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #ddd;
        }

        input {
            width: 100%;
            padding: 13px;
            margin-bottom: 20px;
            background: #292929;
            border: 1px solid #444;
            border-radius: 6px;
            color: white;
            font-size: 15px;
        }

        input:focus {
            outline: none;
            border-color: #ff751a;
        }

        button {
            width: 100%;
            padding: 13px;
            background: #ff751a;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #e96510;
        }

        .error {
            background: #4a2020;
            color: #ff9999;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            margin-bottom: 18px;
        }

        .footer {
            text-align: center;
            color: #777;
            font-size: 12px;
            margin-top: 25px;
        }
    </style>
</head>

<body>

<div class="login-box">

    <h1>IRON <span class="orange">CLUB</span></h1>

    <p class="subtitle">Admin Login Portal</p>

    <% if ("1".equals(request.getParameter("error"))) { %>
        <div class="error">
            Invalid username or password!
        </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/AdminLoginServlet"
          method="POST">

        <label>Username</label>

        <input type="text"
               name="username"
               placeholder="Enter admin username"
               required>

        <label>Password</label>

        <input type="password"
               name="password"
               placeholder="Enter password"
               required>

        <button type="submit">LOGIN</button>

    </form>

    <div class="footer">
        Gym Membership Management System
    </div>

</div>

</body>
</html>
