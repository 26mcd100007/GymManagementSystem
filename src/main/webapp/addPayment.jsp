<%@ page import="java.util.List" %>
<%@ page import="com.gym.model.Member" %>
<%@ page import="com.gym.model.Plan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Member> members =
        (List<Member>) request.getAttribute("members");

    List<Plan> plans =
        (List<Plan>) request.getAttribute("plans");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Record Payment | IRON CLUB</title>

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
            margin: 20px 0 8px;
            color: #ddd;
        }

        select {
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

        .message {
            padding: 12px;
            margin-bottom: 18px;
            border-radius: 6px;
            background: #4a2020;
            color: #ffaaaa;
        }

        .note {
            color: #aaa;
            font-size: 13px;
            margin-top: 8px;
        }
    </style>
</head>

<body>

<header>IRON <span>CLUB</span></header>

<div class="container">

    <h2>Record <span>Payment</span></h2>

    <% if (request.getParameter("error") != null) { %>
        <div class="message">
            Unable to record payment. Please check the member,
            plan and database details.
        </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/PaymentServlet"
          method="post">

        <label>Select Member</label>

        <select name="memberId" required>
            <option value="">-- Choose Member --</option>

            <% if (members != null) {
                for (Member member : members) {
                    if ("ACTIVE".equalsIgnoreCase(member.getStatus())) {
            %>

                <option value="<%= member.getMemberId() %>">
                    <%= member.getName() %>
                    (ID: <%= member.getMemberId() %>)
                </option>

            <%      }
                }
            } %>
        </select>

        <label>Select Membership Plan</label>

        <select name="planId" required>
            <option value="">-- Choose Plan --</option>

            <% if (plans != null) {
                for (Plan plan : plans) {
            %>

                <option value="<%= plan.getPlanId() %>">
                    <%= plan.getPlanName() %> -
                    ₹<%= String.format("%.2f", plan.getPrice()) %>
                    (<%= plan.getDurationMonths() %> Months)
                </option>

            <%  }
            } %>
        </select>

        <p class="note">
            The payment amount and membership expiry date
            will be calculated automatically from the selected plan.
        </p>

        <button type="submit">Record Payment</button>

        <a class="back"
           href="${pageContext.request.contextPath}/PaymentServlet">
            Cancel
        </a>

    </form>

</div>

</body>
</html>
