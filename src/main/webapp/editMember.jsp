<%@ page import="com.gym.model.Member" %>
<%
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Member member = (Member) request.getAttribute("member");

    if (member == null) {
        response.sendRedirect("MemberServlet?action=list");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Member | IRON CLUB</title>
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
            background: #1c1c1c;
            padding: 30px;
            border-radius: 12px;
        }

        h2 {
            margin-top: 0;
        }

        h2 span {
            color: #ff7518;
        }

        label {
            display: block;
            margin: 18px 0 8px;
            color: #ddd;
        }

        input, select {
            width: 100%;
            padding: 13px;
            border: 1px solid #444;
            border-radius: 6px;
            background: #292929;
            color: white;
            font-size: 15px;
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

    <h2>Edit <span>Member</span></h2>

    <form action="${pageContext.request.contextPath}/MemberServlet"
          method="post">

        <input type="hidden" name="action" value="update">

        <input type="hidden" name="memberId"
               value="<%= member.getMemberId() %>">

        <label>Full Name</label>
        <input type="text" name="name"
               value="<%= member.getName() %>" required>

        <label>Email Address</label>
        <input type="email" name="email"
               value="<%= member.getEmail() %>" required>

        <label>Phone Number</label>
        <input type="text" name="phone"
               value="<%= member.getPhone() == null ? "" : member.getPhone() %>">

        <label>Membership Status</label>
        <select name="status">
            <option value="ACTIVE"
                <%= "ACTIVE".equals(member.getStatus()) ? "selected" : "" %>>
                ACTIVE
            </option>

            <option value="INACTIVE"
                <%= "INACTIVE".equals(member.getStatus()) ? "selected" : "" %>>
                INACTIVE
            </option>
        </select>

        <button type="submit">Update Member</button>

        <a class="back"
           href="${pageContext.request.contextPath}/MemberServlet?action=list">
           Cancel
        </a>

    </form>

</div>

</body>
</html>
