package com.gym.dao;

import com.gym.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.BCrypt;

public class AdminDAO {

    public boolean validateAdmin(String username, String password) {

        String sql = "SELECT password FROM admin WHERE username = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    String hashedPassword = rs.getString("password");

                    return BCrypt.checkpw(password, hashedPassword);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
