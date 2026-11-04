package com.gym.dao;

import com.gym.model.Member;
import com.gym.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

public class MemberDAO {

    // CREATE: Add a new member
    public boolean addMember(Member member) {

        String sql = "INSERT INTO members "
                + "(name, email, phone, password, join_date, status) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String hashedPassword = BCrypt.hashpw(
                    member.getPassword(),
                    BCrypt.gensalt(12)
            );

            ps.setString(1, member.getName());
            ps.setString(2, member.getEmail());
            ps.setString(3, member.getPhone());
            ps.setString(4, hashedPassword);
            ps.setDate(5, member.getJoinDate());
            ps.setString(6, "ACTIVE");

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // READ: Get all members
    public List<Member> getAllMembers() {

        List<Member> members = new ArrayList<>();

        String sql = "SELECT * FROM members ORDER BY member_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Member member = new Member();

                member.setMemberId(rs.getInt("member_id"));
                member.setName(rs.getString("name"));
                member.setEmail(rs.getString("email"));
                member.setPhone(rs.getString("phone"));
                member.setJoinDate(rs.getDate("join_date"));
                member.setStatus(rs.getString("status"));

                members.add(member);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return members;
    }

    // READ: Get member by ID
    public Member getMemberById(int memberId) {

        String sql = "SELECT * FROM members WHERE member_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, memberId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Member member = new Member();

                    member.setMemberId(rs.getInt("member_id"));
                    member.setName(rs.getString("name"));
                    member.setEmail(rs.getString("email"));
                    member.setPhone(rs.getString("phone"));
                    member.setJoinDate(rs.getDate("join_date"));
                    member.setStatus(rs.getString("status"));

                    return member;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // UPDATE: Modify member details
    public boolean updateMember(Member member) {

        String sql = "UPDATE members SET name = ?, "
                + "email = ?, phone = ?, status = ? "
                + "WHERE member_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, member.getName());
            ps.setString(2, member.getEmail());
            ps.setString(3, member.getPhone());
            ps.setString(4, member.getStatus());
            ps.setInt(5, member.getMemberId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // DELETE: Remove member
    public boolean deleteMember(int memberId) {

        String sql = "DELETE FROM members WHERE member_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, memberId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
