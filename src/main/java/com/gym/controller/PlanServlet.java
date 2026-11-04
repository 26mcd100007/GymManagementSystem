package com.gym.controller;

import com.gym.dao.PlanDAO;
import com.gym.model.Plan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/PlanServlet")
public class PlanServlet extends HttpServlet {

    private PlanDAO planDAO;

    @Override
    public void init() {
        planDAO = new PlanDAO();
    }

    private boolean isAdminLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null
                && session.getAttribute("adminUsername") != null;
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdminLoggedIn(request)) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {

                int planId = Integer.parseInt(
                    request.getParameter("id"));

                Plan plan = planDAO.getPlanById(planId);

                if (plan == null) {
                    response.sendRedirect(
                        request.getContextPath() + "/PlanServlet?action=list");
                    return;
                }

                request.setAttribute("plan", plan);

                request.getRequestDispatcher("/editPlan.jsp")
                       .forward(request, response);

            } else {

                List<Plan> plans = planDAO.getAllPlans();

                request.setAttribute("plans", plans);

                request.getRequestDispatcher("/plans.jsp")
                       .forward(request, response);
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() + "/PlanServlet?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdminLoggedIn(request)) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        boolean success = false;

        try {
            if ("add".equals(action) || "update".equals(action)) {

                String name = request.getParameter("planName").trim();
                int duration = Integer.parseInt(
                    request.getParameter("durationMonths"));
                double price = Double.parseDouble(
                    request.getParameter("price"));
                String description = request.getParameter("description");

                if (name.isEmpty() || duration <= 0
                        || !Double.isFinite(price) || price < 0) {
                    response.sendRedirect(
                        request.getContextPath() + "/plans.jsp?error=1");
                    return;
                }

                Plan plan = new Plan();

                plan.setPlanName(name);
                plan.setDurationMonths(duration);
                plan.setPrice(price);
                plan.setDescription(description);

                if ("add".equals(action)) {
                    success = planDAO.addPlan(plan);
                } else {
                    int planId = Integer.parseInt(
                        request.getParameter("planId"));
                    plan.setPlanId(planId);
                    success = planDAO.updatePlan(plan);
                }

            } else if ("delete".equals(action)) {

                int planId = Integer.parseInt(
                    request.getParameter("planId"));

                success = planDAO.deletePlan(planId);
            }

        } catch (NumberFormatException e) {
            success = false;
        }

        String result = success ? "success" : "error";

        response.sendRedirect(
            request.getContextPath()
            + "/PlanServlet?action=list&" + result + "=1");
    }
}
