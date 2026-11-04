<%@ page import="com.gym.model.Plan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Plan plan = (Plan) request.getAttribute("plan");

    if (plan == null) {
        response.sendRedirect("PlanServlet?action=list");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Plan | IRON CLUB</title>

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

    <h2>Edit <span>Membership Plan</span></h2>

    <form action="${pageContext.request.contextPath}/PlanServlet"
          method="post">

        <input type="hidden" name="action" value="update">

        <input type="hidden" name="planId"
               value="<%= plan.getPlanId() %>">

        <label>Plan Name</label>
        <input type="text" name="planName"
               value="<%= plan.getPlanName() %>"
               maxlength="50" required>

        <label>Duration (Months)</label>
        <input type="number" name="durationMonths"
               value="<%= plan.getDurationMonths() %>"
               min="1" max="120" required>

        <label>Price (₹)</label>
        <input type="number" name="price"
               value="<%= plan.getPrice() %>"
               min="0" step="0.01" required>

        <label>Description</label>
        <textarea name="description"><%= plan.getDescription() == null ? "" : plan.getDescription() %></textarea>

        <button type="submit">Update Plan</button>

        <a class="back"
           href="${pageContext.request.contextPath}/PlanServlet?action=list">
            Cancel
        </a>

    </form>

</div>

</body>
</html>
