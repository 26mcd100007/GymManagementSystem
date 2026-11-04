<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>

<!DOCTYPE html>
<html>
<head>

    <title>Add Member | IRON CLUB</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #111;
            color: white;
        }

        .navbar {
            background: #1c1c1c;
            padding: 20px 35px;
            border-bottom: 2px solid #ff751a;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
        }

        .orange {
            color: #ff751a;
        }

        .container {
            width: 90%;
            max-width: 650px;
            margin: 45px auto;
            background: #1c1c1c;
            padding: 35px;
            border-radius: 12px;
        }

        h2 {
            margin-top: 0;
            margin-bottom: 25px;
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

        input[type="date"] {
            color-scheme: dark;
        }

        button {
            background: #ff751a;
            color: white;
            border: none;
            padding: 13px 25px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            font-weight: bold;
        }

        button:hover {
            background: #e96510;
        }

        .back {
            display: inline-block;
            margin-left: 12px;
            color: #ff751a;
            text-decoration: none;
        }

        .error {
            background: #4a2020;
            color: #ff9999;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 5px;
        }

    </style>

</head>

<body>

    <div class="navbar">
        <div class="logo">
            IRON <span class="orange">CLUB</span>
        </div>
    </div>

    <div class="container">

        <h2>Add New <span class="orange">Member</span></h2>

        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="error">
                Unable to register member.
                Email may already exist.
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/MemberServlet"
              method="POST">

            <input type="hidden" name="action" value="add">

            <label>Full Name</label>
            <input type="text"
                   name="name"
                   placeholder="Enter member name"
                   maxlength="100"
                   required>

            <label>Email Address</label>
            <input type="email"
                   name="email"
                   placeholder="Enter email address"
                   maxlength="100"
                   required>

            <label>Phone Number</label>
            <input type="tel"
                   name="phone"
                   placeholder="Enter phone number"
                   maxlength="15"
                   required>

            <label>Password</label>
            <input type="password"
                   name="password"
                   placeholder="Create member password"
                   minlength="8"
                   required>

            <label>Joining Date</label>
            <input type="date"
                   name="joinDate"
                   required>

            <button type="submit">Register Member</button>

            <a href="${pageContext.request.contextPath}/MemberServlet?action=list"
               class="back">
                Back to Members
            </a>

        </form>

    </div>

</body>
</html>

