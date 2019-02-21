package net.zelmak;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author brad
 */
public class GaussianDataGenerator {

    private static final int ROUNDING_FACTOR = 100000;
    private static final Random RNG = new Random();

    public static void main(String[] args) throws SQLException {
        try (Connection conn = getConnection()) {
            try (Statement st = conn.createStatement()) {
                st.executeUpdate("truncate table parm_input");
            }
            try (PreparedStatement ps = conn.prepareStatement("insert into parm_input ( parm_seq, parm_value ) values (?, ?)")) {
                for (int i = 0; i < 500; i++) {
                    ps.setInt(1, i);
                    final double value = roundTo(RNG.nextGaussian() * 0.5 + 100, ROUNDING_FACTOR);
                    ps.setDouble(2, value);
                    ps.addBatch();
                }
                ps.executeBatch();
                for (int i = 500; i < 1000; i++) {
                    ps.setInt(1, i);
                    final double value = roundTo(RNG.nextGaussian() + 120, ROUNDING_FACTOR);
                    ps.setDouble(2, value);
                    ps.addBatch();
                }
                ps.executeBatch();
                for (int i = 1000; i < 1500; i++) {
                    ps.setInt(1, i);
                    final double value = roundTo(RNG.nextGaussian() * 2 + 140, ROUNDING_FACTOR);
                    ps.setDouble(2, value);
                    ps.addBatch();
                }
                ps.executeBatch();
            }
            conn.commit();
        }
    }

    private static Connection getConnection() throws SQLException {
        Connection conn = DriverManager.getConnection("<connection-url>", "<username>", "<password>");
        conn.setAutoCommit(false);
        return conn;
    }

    static double roundTo(double value, double rFactor) {
        return Math.round(value * rFactor) / rFactor;
    }
}
