package com.gym.dao;

import com.gym.model.Payment;
import com.gym.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    // Record a new payment
    public boolean addPayment(Payment payment) {

        String sql = "INSERT INTO payments "
                + "(member_id, plan_id, amount, payment_date, "
                + "start_date, expiry_date, payment_status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, payment.getMemberId());
            ps.setInt(2, payment.getPlanId());
            ps.setDouble(3, payment.getAmount());
            ps.setDate(4, payment.getPaymentDate());
            ps.setDate(5, payment.getStartDate());
            ps.setDate(6, payment.getExpiryDate());
            ps.setString(7, payment.getPaymentStatus());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Retrieve all payment records with member and plan names
    public List<Payment> getAllPayments() {

        List<Payment> payments = new ArrayList<>();

        String sql = "SELECT p.*, m.name AS member_name, "
                + "mp.plan_name FROM payments p "
                + "JOIN members m ON p.member_id = m.member_id "
                + "JOIN membership_plans mp ON p.plan_id = mp.plan_id "
                + "ORDER BY p.payment_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Payment payment = new Payment();

                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setMemberId(rs.getInt("member_id"));
                payment.setPlanId(rs.getInt("plan_id"));
                payment.setMemberName(rs.getString("member_name"));
                payment.setPlanName(rs.getString("plan_name"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentDate(rs.getDate("payment_date"));
                payment.setStartDate(rs.getDate("start_date"));
                payment.setExpiryDate(rs.getDate("expiry_date"));
                payment.setPaymentStatus(rs.getString("payment_status"));

                payments.add(payment);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payments;
    }

    // Retrieve payments belonging to one member
    public List<Payment> getPaymentsByMember(int memberId) {

        List<Payment> payments = new ArrayList<>();

        String sql = "SELECT p.*, m.name AS member_name, "
                + "mp.plan_name FROM payments p "
                + "JOIN members m ON p.member_id = m.member_id "
                + "JOIN membership_plans mp ON p.plan_id = mp.plan_id "
                + "WHERE p.member_id = ? ORDER BY p.payment_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, memberId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Payment payment = new Payment();

                    payment.setPaymentId(rs.getInt("payment_id"));
                    payment.setMemberId(rs.getInt("member_id"));
                    payment.setPlanId(rs.getInt("plan_id"));
                    payment.setMemberName(rs.getString("member_name"));
                    payment.setPlanName(rs.getString("plan_name"));
                    payment.setAmount(rs.getDouble("amount"));
                    payment.setPaymentDate(rs.getDate("payment_date"));
                    payment.setStartDate(rs.getDate("start_date"));
                    payment.setExpiryDate(rs.getDate("expiry_date"));
                    payment.setPaymentStatus(rs.getString("payment_status"));

                    payments.add(payment);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payments;
    }

    // Calculate total amount collected from successful payments
    public double getTotalRevenue() {

        String sql = "SELECT COALESCE(SUM(amount), 0) "
                   + "FROM payments WHERE payment_status = 'PAID'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0.0;
    }
}
