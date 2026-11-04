<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gym.model.Member" %>

<%!
    private String escapeHtml(String value) {
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

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    List<Member> members =
        (List<Member>) request.getAttribute("members");
%>

<!DOCTYPE html>
<html>
<head>

    <title>Manage Members | IRON CLUB</title>

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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
        }

        .orange {
            color: #ff751a;
        }

        .container {
            padding: 35px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            gap: 15px;
        }

        h2 {
            margin: 0;
        }

        .add-btn {
            background: #ff751a;
            color: white;
            padding: 12px 18px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .table-container {
            background: #1c1c1c;
            padding: 20px;
            border-radius: 10px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 850px;
        }

        th {
            background: #292929;
            color: #ff751a;
            padding: 15px;
            text-align: left;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #333;
        }

        tr:hover {
            background: #252525;
        }

        .status {
            background: #174d2a;
            color: #8df0a8;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 12px;
        }

        .edit-btn {
            background: #2563eb;
            color: white;
            padding: 7px 12px;
            text-decoration: none;
            border-radius: 4px;
        }

        .delete-btn {
            background: #dc2626;
            color: white;
            padding: 7px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .message {
            padding: 12px;
            background: #174d2a;
            color: #8df0a8;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .error {
            background: #4a2020;
            color: #ff9999;
        }

        .empty {
            text-align: center;
            color: #aaa;
            padding: 35px;
        }

        .back {
            display: inline-block;
            margin-top: 25px;
            color: #ff751a;
            text-decoration: none;
        }

        @media(max-width: 700px) {
            .container {
                padding: 18px;
            }

            .header {
                align-items: flex-start;
                flex-direction: column;
            }
        }

    </style>

</head>

<body>

    <div class="navbar">

        <div class="logo">
            IRON <span class="orange">CLUB</span>
        </div>

        <a href="AdminLogoutServlet"
           style="color:#ff751a;text-decoration:none;">
            Logout
        </a>

    </div>

    <div class="container">

        <div class="header">

            <h2>Manage <span class="orange">Members</span></h2>

            <a href="addMember.jsp" class="add-btn">
                + Add New Member
            </a>

        </div>

        <% if ("added".equals(request.getParameter("success"))) { %>
            <div class="message">
                Member registered successfully!
            </div>
        <% } %>

        <% if ("updated".equals(request.getParameter("success"))) { %>
            <div class="message">
                Member updated successfully!
            </div>
        <% } %>

        <% if ("deleted".equals(request.getParameter("success"))) { %>
            <div class="message">
                Member deleted successfully!
            </div>
        <% } %>

        <% if (request.getParameter("error") != null) { %>
            <div class="message error">
                Operation failed. Please check the member details
                or existing payment records.
            </div>
        <% } %>

        <div class="table-container">

            <table>

                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Join Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>

                <% if (members != null && !members.isEmpty()) { %>

                    <% for (Member member : members) { %>

                        <tr>

                            <td><%= member.getMemberId() %></td>

                            <td><%= escapeHtml(member.getName()) %></td>

                            <td><%= escapeHtml(member.getEmail()) %></td>

                            <td><%= escapeHtml(member.getPhone()) %></td>

                            <td><%= member.getJoinDate() %></td>

                            <td>
                                <span class="status">
                                    <%= escapeHtml(member.getStatus()) %>
                                </span>
                            </td>

                            <td>

                                <a class="edit-btn"
                                   href="MemberServlet?action=edit&id=<%= member.getMemberId() %>">
                                    Edit
                                </a>

                                <form action="MemberServlet"
                                      method="POST"
                                      style="display:inline;"
                                      onsubmit="return confirm('Are you sure you want to delete this member?');">

                                    <input type="hidden"
                                           name="action"
                                           value="delete">

                                    <input type="hidden"
                                           name="memberId"
                                           value="<%= member.getMemberId() %>">

                                    <button type="submit"
                                            class="delete-btn">
                                        Delete
                                    </button>

                                </form>

                            </td>

                        </tr>

                    <% } %>

                <% } else { %>

                    <tr>
                        <td colspan="7" class="empty">
                            No members registered yet.
                        </td>
                    </tr>

                <% } %>

            </table>

        </div>

        <a href="dashboard.jsp" class="back">
            ← Back to Dashboard
        </a>

    </div>

</body>
</html>
