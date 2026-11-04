<%@ page import="java.util.List" %>
<%@ page import="com.gym.model.Payment" %>
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

    List<Payment> payments =
        (List<Payment>) request.getAttribute("payments");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment History | IRON CLUB</title>

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

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 25px;
        }

        h2 span {
            color: #ff7518;
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
            min-width: 1000px;
        }

        th, td {
            padding: 15px;
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

        .status {
            color: #8be0a5;
            font-weight: bold;
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
            background: #183b26;
            color: #8be0a5;
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
    <div>Payment Management</div>
</header>

<div class="container">

    <div class="top-bar">
        <h2>Payment <span>History</span></h2>

        <a class="add-btn"
           href="${pageContext.request.contextPath}/PaymentServlet?action=add">
            + Record Payment
        </a>
    </div>

    <% if ("1".equals(request.getParameter("success"))) { %>
        <div class="message">
            Payment recorded successfully!
        </div>
    <% } %>

    <div class="table-container">

        <table>
            <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>Member</th>
                    <th>Plan</th>
                    <th>Amount</th>
                    <th>Payment Date</th>
                    <th>Start Date</th>
                    <th>Expiry Date</th>
                    <th>Status</th>
                </tr>
            </thead>

            <tbody>

            <% if (payments != null && !payments.isEmpty()) {
                for (Payment payment : payments) { %>

                <tr>
                    <td><%= payment.getPaymentId() %></td>

                    <td>
                        <%= escapeHtml(payment.getMemberName()) %>
                    </td>

                    <td>
                        <%= escapeHtml(payment.getPlanName()) %>
                    </td>

                    <td>
                        ₹<%= String.format("%.2f", payment.getAmount()) %>
                    </td>

                    <td><%= payment.getPaymentDate() %></td>

                    <td><%= payment.getStartDate() %></td>

                    <td><%= payment.getExpiryDate() %></td>

                    <td class="status">
                        <%= escapeHtml(payment.getPaymentStatus()) %>
                    </td>
                </tr>

            <%  }
               } else { %>

                <tr>
                    <td colspan="8" class="empty">
                        No payment records found.
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
