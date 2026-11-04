<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.gym.dao.DashboardDAO" %>

<%
    // Check admin login session
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Prevent dashboard caching after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String adminName = (String) session.getAttribute("adminUsername");

    // Fetch live dashboard statistics from MySQL
    DashboardDAO dashboardDAO = new DashboardDAO();

    int totalMembers = dashboardDAO.getTotalMembers();
    int activeMembers = dashboardDAO.getActiveMembers();
    int expiredMemberships = dashboardDAO.getExpiredMemberships();
    double totalRevenue = dashboardDAO.getTotalRevenue();
%>

<!DOCTYPE html>
<html>
<head>

    <title>Admin Dashboard | IRON CLUB</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #111111;
            color: white;
        }

        /* Navigation Bar */

        .navbar {
            background: #1c1c1c;
            padding: 20px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #ff751a;
        }

        .logo {
            font-size: 26px;
            font-weight: bold;
            letter-spacing: 2px;
        }

        .orange {
            color: #ff751a;
        }

        .admin-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .admin-name {
            color: #cccccc;
        }

        .logout {
            background: #ff751a;
            color: white;
            padding: 10px 18px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }

        .logout:hover {
            background: #e96510;
        }

        /* Main Container */

        .container {
            padding: 40px;
        }

        .welcome {
            margin-bottom: 35px;
        }

        .welcome h2 {
            font-size: 30px;
            margin-bottom: 10px;
        }

        .welcome p {
            color: #aaaaaa;
        }

        /* Statistics Cards */

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
            gap: 22px;
            margin-bottom: 40px;
        }

        .card {
            background: #1c1c1c;
            padding: 25px;
            border-radius: 10px;
            border-left: 4px solid #ff751a;
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            background: #252525;
        }

        .card h3 {
            color: #aaaaaa;
            font-size: 15px;
            font-weight: normal;
        }

        .card p {
            font-size: 30px;
            font-weight: bold;
            color: #ff751a;
            margin-bottom: 0;
        }

        /* Management Section */

        .section {
            background: #1c1c1c;
            padding: 30px;
            border-radius: 10px;
        }

        .section h2 {
            margin-top: 0;
            margin-bottom: 10px;
        }

        .section p {
            color: #aaaaaa;
            line-height: 1.6;
        }

        /* Action Buttons */

        .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 25px;
        }

        .btn {
            display: inline-block;
            padding: 13px 22px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .primary-btn {
            background: #ff751a;
            color: white;
        }

        .primary-btn:hover {
            background: #e96510;
        }

        .secondary-btn {
            background: #292929;
            color: #ff751a;
            border: 1px solid #ff751a;
        }

        .secondary-btn:hover {
            background: #ff751a;
            color: white;
        }

        /* Footer */

        .footer {
            text-align: center;
            padding: 25px;
            color: #777777;
            margin-top: 30px;
            border-top: 1px solid #292929;
        }

        /* Responsive Design */

        @media(max-width: 600px) {

            .navbar {
                padding: 18px;
            }

            .container {
                padding: 20px;
            }

            .admin-name {
                display: none;
            }

            .welcome h2 {
                font-size: 24px;
            }

        }

    </style>

</head>

<body>

    <!-- Navigation Bar -->

    <div class="navbar">

        <div class="logo">
            IRON <span class="orange">CLUB</span>
        </div>

        <div class="admin-info">

            <span class="admin-name">
                Admin: <%= adminName %>
            </span>

            <a href="${pageContext.request.contextPath}/AdminLogoutServlet"
               class="logout">
                Logout
            </a>

        </div>

    </div>


    <!-- Main Dashboard -->

    <div class="container">

        <!-- Welcome Section -->

        <div class="welcome">

            <h2>
                Welcome Back, <span class="orange">Admin!</span>
            </h2>

            <p>
                Manage your gym members, memberships and payments
                from one place.
            </p>

        </div>


        <!-- Dashboard Statistics -->

        <div class="cards">

            <div class="card">

                <h3>Total Members</h3>

                <p><%= totalMembers %></p>

            </div>


            <div class="card">

                <h3>Active Members</h3>

                <p><%= activeMembers %></p>

            </div>


            <div class="card">

                <h3>Expired Memberships</h3>

                <p><%= expiredMemberships %></p>

            </div>


            <div class="card">

                <h3>Total Revenue</h3>

                <p>₹<%= String.format("%.2f", totalRevenue) %></p>

            </div>

        </div>


        <!-- Gym Management Section -->

        <div class="section">

            <h2>
                Gym <span class="orange">Management Panel</span>
            </h2>

            <p>
                Welcome to the IRON CLUB administration system.
                Use the options below to manage gym members,
                membership plans and payment records.
            </p>

            <div class="actions">

                <a href="${pageContext.request.contextPath}/MemberServlet?action=list"
                   class="btn primary-btn">
                    Manage Members
                </a>

                <a href="${pageContext.request.contextPath}/addMember.jsp"
                   class="btn secondary-btn">
                    + Add New Member
                </a>

                <a href="${pageContext.request.contextPath}/PlanServlet?action=list"
                   class="btn secondary-btn">
                    Manage Plans
                </a>

                <a href="${pageContext.request.contextPath}/addPlan.jsp"
                   class="btn secondary-btn">
                    + Add New Plan
                </a>

                <a href="${pageContext.request.contextPath}/PaymentServlet"
                   class="btn primary-btn">
                    Payment History
                </a>

                <a href="${pageContext.request.contextPath}/PaymentServlet?action=add"
                   class="btn secondary-btn">
                    + Record Payment
                </a>

            </div>

        </div>


        <!-- Footer -->

        <div class="footer">

            <p>
                IRON CLUB | Gym Membership Management System
            </p>

            <p>
                Admin Dashboard
            </p>

        </div>

    </div>

</body>
</html>
