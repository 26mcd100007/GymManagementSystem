package com.gym.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import org.mindrot.jbcrypt.BCrypt;

public class AdminPasswordUpdater {

    public static void main(String[] args) {

        String username = "admin";
        String password = "admin123";

        // Generate BCrypt password hash
        String hashedPassword = BCrypt.hashpw(
                password,
                BCrypt.gensalt(12)
        );

        String sql = "UPDATE admin SET password = ? WHERE username = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, hashedPassword);
            ps.setString(2, username);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("Admin password updated successfully!");
            } else {
                System.out.println("Admin not found!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
