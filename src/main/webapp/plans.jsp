<%@ page import="java.util.List" %>
<%@ page import="com.gym.model.Plan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    public String escapeHtml(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
%>

<%
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Plan> plans = (List<Plan>) request.getAttribute("plans");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Membership Plans | IRON CLUB</title>

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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 27px;
            font-weight: bold;
        }

        .logo span {
            color: #ff7518;
        }

        .container {
            padding: 35px;
        }

        h2 span {
            color: #ff7518;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 25px;
        }

        .add-btn {
            background: #ff7518;
            color: white;
            padding: 12px 18px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
        }

        .table-container {
            overflow-x: auto;
            background: #1c1c1c;
            border-radius: 10px;
            padding: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 700px;
        }

        th, td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid #333;
        }

        th {
            color: #ff7518;
            background: #252525;
        }

        tr:hover {
            background: #292929;
        }

        .edit-btn {
            color: #ffae42;
            text-decoration: none;
            margin-right: 12px;
        }

        .delete-btn {
            background: #c0392b;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        .empty {
            text-align: center;
            padding: 35px;
            color: #aaa;
        }

        .message {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 6px;
        }

        .success {
            background: #183b26;
            color: #8be0a5;
        }

        .error {
            background: #4a2020;
            color: #ffaaaa;
        }

        .back {
            display: inline-block;
            margin-top: 25px;
            color: #ff7518;
            text-decoration: none;
        }
    </style>
</head>

<body>

<header>
    <div class="logo">IRON <span>CLUB</span></div>
    <div>Membership Management</div>
</header>

<div class="container">

    <div class="top-bar">
        <h2>Membership <span>Plans</span></h2>

        <a class="add-btn"
           href="${pageContext.request.contextPath}/addPlan.jsp">
            + Add New Plan
        </a>
    </div>

    <% if ("1".equals(request.getParameter("success"))) { %>
        <div class="message success">
            Operation completed successfully!
        </div>
    <% } %>

    <% if ("1".equals(request.getParameter("error"))) { %>
        <div class="message error">
            Operation failed. The plan may be linked to existing payments.
        </div>
    <% } %>

    <div class="table-container">

        <table>
            <thead>
                <tr>
                    <th>Plan ID</th>
                    <th>Plan Name</th>
                    <th>Duration</th>
                    <th>Price</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
            </thead>

            <tbody>

            <% if (plans != null && !plans.isEmpty()) {
                for (Plan plan : plans) { %>

                <tr>
                    <td><%= plan.getPlanId() %></td>

                    <td>
                        <%= escapeHtml(plan.getPlanName()) %>
                    </td>

                    <td>
                        <%= plan.getDurationMonths() %> Months
                    </td>

                    <td>
                        ₹<%= String.format("%.2f", plan.getPrice()) %>
                    </td>

                    <td>
                        <%= escapeHtml(plan.getDescription()) %>
                    </td>

                    <td>
                        <a class="edit-btn"
                           href="${pageContext.request.contextPath}/PlanServlet?action=edit&id=<%= plan.getPlanId() %>">
                            Edit
                        </a>

                        <form action="${pageContext.request.contextPath}/PlanServlet"
                              method="post"
                              style="display:inline;"
                              onsubmit="return confirm('Are you sure you want to delete this plan?');">

                            <input type="hidden" name="action" value="delete">

                            <input type="hidden" name="planId"
                                   value="<%= plan.getPlanId() %>">

                            <button type="submit" class="delete-btn">
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>

            <%  }
               } else { %>

                <tr>
                    <td colspan="6" class="empty">
                        No membership plans found.
                    </td>
                </tr>

            <% } %>

            </tbody>
        </table>

    </div>

    <a class="back"
       href="${pageContext.request.contextPath}/dashboard.jsp">
        ← Back to Dashboard
    </a>

</div>

</body>
</html>
