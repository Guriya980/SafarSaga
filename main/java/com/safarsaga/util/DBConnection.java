package com.safarsaga.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database connection utility.
 * Update URL, USER, PASSWORD below to match your MySQL configuration.
 * Default: host=localhost, port=3306, db=safarsaga_db, user=root, password=root
 */
public class DBConnection {
    // ─── CHANGE THESE TO MATCH YOUR MYSQL SETUP ───────────────────────────────
    private static final String URL  = "jdbc:mysql://localhost:3306/safarsaga_db"
            + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = "Omgorle@123";
    // ──────────────────────────────────────────────────────────────────────────

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("[SafarSaga] MySQL JDBC Driver not found: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try { conn.close(); } catch (SQLException ignored) {}
        }
    }
}
