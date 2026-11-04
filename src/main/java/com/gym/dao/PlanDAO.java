
package com.gym.dao;

import com.gym.model.Plan;
import com.gym.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PlanDAO {

    // Add a new membership plan
    public boolean addPlan(Plan plan) {

        String sql = "INSERT INTO membership_plans "
                   + "(plan_name, duration_months, price, description) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, plan.getPlanName());
            ps.setInt(2, plan.getDurationMonths());
            ps.setDouble(3, plan.getPrice());
            ps.setString(4, plan.getDescription());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Retrieve all membership plans
    public List<Plan> getAllPlans() {

        List<Plan> plans = new ArrayList<>();

        String sql = "SELECT * FROM membership_plans ORDER BY plan_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Plan plan = new Plan();

                plan.setPlanId(rs.getInt("plan_id"));
                plan.setPlanName(rs.getString("plan_name"));
                plan.setDurationMonths(rs.getInt("duration_months"));
                plan.setPrice(rs.getDouble("price"));
                plan.setDescription(rs.getString("description"));

                plans.add(plan);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return plans;
    }

    // Retrieve a plan using its ID
    public Plan getPlanById(int planId) {

        String sql = "SELECT * FROM membership_plans WHERE plan_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, planId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Plan plan = new Plan();

                    plan.setPlanId(rs.getInt("plan_id"));
                    plan.setPlanName(rs.getString("plan_name"));
                    plan.setDurationMonths(rs.getInt("duration_months"));
                    plan.setPrice(rs.getDouble("price"));
                    plan.setDescription(rs.getString("description"));

                    return plan;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Update an existing membership plan
    public boolean updatePlan(Plan plan) {

        String sql = "UPDATE membership_plans SET "
                   + "plan_name = ?, duration_months = ?, "
                   + "price = ?, description = ? "
                   + "WHERE plan_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, plan.getPlanName());
            ps.setInt(2, plan.getDurationMonths());
            ps.setDouble(3, plan.getPrice());
            ps.setString(4, plan.getDescription());
            ps.setInt(5, plan.getPlanId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a membership plan
    public boolean deletePlan(int planId) {

        String sql = "DELETE FROM membership_plans WHERE plan_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, planId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Unable to delete plan. It may be linked to existing payments.");
            e.printStackTrace();
            return false;
        }
    }
}
