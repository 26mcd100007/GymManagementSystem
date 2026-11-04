package com.gym.controller;

import com.gym.dao.MemberDAO;
import com.gym.model.Member;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MemberServlet")
public class MemberServlet extends HttpServlet {

    private final MemberDAO memberDAO = new MemberDAO();

    // Handle GET requests
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin session
        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("adminUsername") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String action = request.getParameter("action");

        if ("edit".equals(action)) {

            try {
                int id = Integer.parseInt(
                    request.getParameter("id")
                );

                Member member = memberDAO.getMemberById(id);

                if (member == null) {
                    response.sendRedirect(
                        request.getContextPath()
                        + "/MemberServlet?action=list&error=notfound"
                    );
                    return;
                }

                request.setAttribute("member", member);

                request.getRequestDispatcher("editMember.jsp")
                       .forward(request, response);

            } catch (NumberFormatException e) {
                response.sendRedirect(
                    request.getContextPath()
                    + "/MemberServlet?action=list"
                );
            }

        } else {

            // Display all members
            List<Member> members = memberDAO.getAllMembers();

            request.setAttribute("members", members);

            request.getRequestDispatcher("members.jsp")
                   .forward(request, response);
        }
    }

    // Handle POST requests
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Check admin session
        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("adminUsername") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String action = request.getParameter("action");

        try {

            if ("add".equals(action)) {

                Member member = new Member();

                member.setName(request.getParameter("name"));
                member.setEmail(request.getParameter("email"));
                member.setPhone(request.getParameter("phone"));
                member.setPassword(request.getParameter("password"));

                member.setJoinDate(
                    Date.valueOf(
                        request.getParameter("joinDate")
                    )
                );

                boolean result = memberDAO.addMember(member);

                if (result) {
                    response.sendRedirect(
                        request.getContextPath()
                        + "/MemberServlet?action=list&success=added"
                    );
                } else {
                    response.sendRedirect(
                        request.getContextPath()
                        + "/addMember.jsp?error=1"
                    );
                }

            } else if ("update".equals(action)) {

                Member member = new Member();

                member.setMemberId(
                    Integer.parseInt(request.getParameter("memberId"))
                );

                member.setName(request.getParameter("name"));
                member.setEmail(request.getParameter("email"));
                member.setPhone(request.getParameter("phone"));
                member.setStatus(request.getParameter("status"));

                boolean result = memberDAO.updateMember(member);

                if (result) {
                    response.sendRedirect(
                        request.getContextPath()
                        + "/MemberServlet?action=list&success=updated"
                    );
                } else {
                    response.sendRedirect(
                        request.getContextPath()
                        + "/MemberServlet?action=list&error=update"
                    );
                }

            } else if ("delete".equals(action)) {

                int id = Integer.parseInt(
                    request.getParameter("memberId")
                );

                boolean result = memberDAO.deleteMember(id);

                if (result) {
                    response.sendRedirect(
                        request.getContextPath()
                        + "/MemberServlet?action=list&success=deleted"
                    );
                } else {
                    response.sendRedirect(
                        request.getContextPath()
                        + "/MemberServlet?action=list&error=delete"
                    );
                }

            } else {

                response.sendRedirect(
                    request.getContextPath()
                    + "/MemberServlet?action=list"
                );
            }

        } catch (IllegalArgumentException e) {

            response.sendRedirect(
                request.getContextPath()
                + "/MemberServlet?action=list&error=invalid"
            );
        }
    }
}
