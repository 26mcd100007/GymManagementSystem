package com.gym.controller;

import com.gym.dao.PaymentDAO;
import com.gym.dao.MemberDAO;
import com.gym.dao.PlanDAO;
import com.gym.model.Payment;
import com.gym.model.Member;
import com.gym.model.Plan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    private PaymentDAO paymentDAO;
    private MemberDAO memberDAO;
    private PlanDAO planDAO;

    @Override
    public void init() {
        paymentDAO = new PaymentDAO();
        memberDAO = new MemberDAO();
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

        if ("add".equals(action)) {

            List<Member> members = memberDAO.getAllMembers();
            List<Plan> plans = planDAO.getAllPlans();

            request.setAttribute("members", members);
            request.setAttribute("plans", plans);

            request.getRequestDispatcher("/addPayment.jsp")
                   .forward(request, response);

        } else {

            List<Payment> payments = paymentDAO.getAllPayments();

            request.setAttribute("payments", payments);

            request.getRequestDispatcher("/payments.jsp")
                   .forward(request, response);
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

        try {
            int memberId = Integer.parseInt(
                    request.getParameter("memberId"));

            int planId = Integer.parseInt(
                    request.getParameter("planId"));

            Member member = memberDAO.getMemberById(memberId);
            Plan plan = planDAO.getPlanById(planId);

            if (member == null || plan == null
                    || !"ACTIVE".equalsIgnoreCase(member.getStatus())) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/PaymentServlet?action=add&error=invalid");
                return;
            }

            LocalDate startDate = LocalDate.now();

            LocalDate expiryDate = startDate.plusMonths(
                    plan.getDurationMonths());

            Payment payment = new Payment();

            payment.setMemberId(memberId);
            payment.setPlanId(planId);
            payment.setAmount(plan.getPrice());
            payment.setPaymentDate(Date.valueOf(startDate));
            payment.setStartDate(Date.valueOf(startDate));
            payment.setExpiryDate(Date.valueOf(expiryDate));
            payment.setPaymentStatus("PAID");

            boolean success = paymentDAO.addPayment(payment);

            if (success) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/PaymentServlet?success=1");
            } else {
                response.sendRedirect(
                        request.getContextPath()
                        + "/PaymentServlet?action=add&error=save");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/PaymentServlet?action=add&error=invalid");

        }
    }
}

