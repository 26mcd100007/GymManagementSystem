<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Membership Plan | IRON CLUB</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #111;
            color: white;
            font-family: Arial, sans-serif;
        }

        header {
            background: #1c1c1c;
            padding: 22px 40px;
            border-bottom: 2px solid #ff7518;
            font-size: 28px;
            font-weight: bold;
        }

        header span {
            color: #ff7518;
        }

        .container {
            max-width: 650px;
            margin: 50px auto;
            padding: 30px;
            background: #1c1c1c;
            border-radius: 12px;
        }

        h2 span {
            color: #ff7518;
        }

        label {
            display: block;
            margin: 18px 0 8px;
            color: #ddd;
        }

        input, textarea {
            width: 100%;
            padding: 13px;
            border: 1px solid #444;
            border-radius: 6px;
            background: #292929;
            color: white;
            font-size: 15px;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        button {
            margin-top: 25px;
            padding: 13px 22px;
            background: #ff7518;
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #e66510;
        }

        .back {
            display: inline-block;
            margin-left: 12px;
            color: #ff7518;
            text-decoration: none;
        }
    </style>
</head>

<body>

<header>IRON <span>CLUB</span></header>

<div class="container">

    <h2>Add <span>Membership Plan</span></h2>

    <form action="${pageContext.request.contextPath}/PlanServlet"
          method="post">

        <input type="hidden" name="action" value="add">

        <label>Plan Name</label>
        <input type="text" name="planName"
               placeholder="Example: Monthly" required maxlength="50">

        <label>Duration (Months)</label>
        <input type="number" name="durationMonths"
               min="1" max="120" placeholder="Example: 1" required>

        <label>Price (₹)</label>
        <input type="number" name="price"
               min="0" step="0.01" placeholder="Example: 999" required>

        <label>Description</label>
        <textarea name="description"
                  placeholder="Enter plan details"></textarea>

        <button type="submit">Add Plan</button>

        <a class="back"
           href="${pageContext.request.contextPath}/PlanServlet?action=list">
           Cancel
        </a>

    </form>

</div>

</body>
</html>

