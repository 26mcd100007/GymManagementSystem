package com.gym.dao;

import com.gym.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DashboardDAO {

    // Count all registered members
    public int getTotalMembers() {

        String sql = "SELECT COUNT(*) FROM members";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // Count members whose account status is ACTIVE
    public int getActiveMembers() {

        String sql = "SELECT COUNT(*) FROM members "
                   + "WHERE status = 'ACTIVE'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // Count members whose latest paid membership has expired
    public int getExpiredMemberships() {

        String sql = "SELECT COUNT(*) FROM ("
                   + "SELECT member_id, MAX(expiry_date) AS last_expiry "
                   + "FROM payments "
                   + "WHERE payment_status = 'PAID' "
                   + "GROUP BY member_id"
                   + ") AS latest "
                   + "WHERE last_expiry < CURDATE()";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // Calculate total revenue from successful payments
    public double getTotalRevenue() {

        String sql = "SELECT COALESCE(SUM(amount), 0) "
                   + "FROM payments WHERE payment_status = 'PAID'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0.0;
    }
}
