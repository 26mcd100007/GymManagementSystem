
package com.gym.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/gym_management";

    private static final String USER = "root";

    private static final String PASSWORD = "Password";

    public static Connection getConnection() {

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    URL, USER, PASSWORD
            );

            System.out.println("Database connected successfully!");

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Database connection failed!");
            e.printStackTrace();
        }

        return con;
    }
}
