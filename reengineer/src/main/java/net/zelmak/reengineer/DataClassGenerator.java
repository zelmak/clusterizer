/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.zelmak.reengineer;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

/**
 *
 * @author Brad
 */
public class DataClassGenerator {
    public static void main(String[] args) throws Exception {
        List<Double> inputData = new ArrayList<>();
        DataSource ds = DataSourceBuilder.dataSourceFrom(System.getProperty("user.home") + File.separator + "db.config");
        try (Connection conn = ds.getConnection()) {
            try (Statement st = conn.createStatement()) {
                try (ResultSet rs = st.executeQuery("select * from parm_input order by parm_value")) {
                    while(rs.next()) {
                        inputData.add(rs.getDouble(1));
                    }
                }
            }
        }
        
        String className = "Default";
        if (args.length>=1) {
            className = args[0];
        }
        String fileName = className + ".java";
        listDoubleTemplate(fileName, className, inputData);
    }

    private static void listDoubleTemplate(String fileName, String className, List<Double> inputData) throws IOException {
        try (PrintWriter pw = new PrintWriter(fileName)) {
            pw.println("import java.util.*;");
            pw.println();
            pw.println("public class " + className + " {");
            pw.println();
            pw.println("  public final List<Double> data;");
            pw.println();
            pw.println("  public " + className + "() {");
            pw.println("    List<Double> local = new ArrayList<>();");
            for (Double value : inputData) {
                pw.println("    local.add(" + value + ");");
            }
            pw.println();
            pw.println("   this.data = Collections.unmodifiableList(local);");
            pw.println();
            pw.println("  }");
            pw.println();
            pw.println("}");
        }
    }
}
