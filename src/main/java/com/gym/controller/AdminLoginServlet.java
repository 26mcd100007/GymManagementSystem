package com.gym.controller;

import com.gym.dao.AdminDAO;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO dao = new AdminDAO();

        boolean valid = dao.validateAdmin(username, password);

        if (valid) {

            HttpSession session = request.getSession();
            session.setAttribute("adminUsername", username);

            response.sendRedirect("dashboard.jsp");

        } else {

            response.sendRedirect("login.jsp?error=1");

        }
    }
}

