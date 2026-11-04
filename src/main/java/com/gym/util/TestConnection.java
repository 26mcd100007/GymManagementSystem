package com.gym.util;

import java.sql.Connection;

public class TestConnection {

    public static void main(String[] args) {

        Connection con = DBConnection.getConnection();

        if (con != null) {
            System.out.println("GYM DATABASE IS READY!");
        } else {
            System.out.println("CONNECTION FAILED!");
        }

    }
}
