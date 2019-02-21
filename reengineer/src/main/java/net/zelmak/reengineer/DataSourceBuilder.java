/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.zelmak.reengineer;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import javax.sql.DataSource;
import org.apache.commons.dbcp.BasicDataSource;

/**
 *
 * @author Brad
 */
public class DataSourceBuilder {

    public static DataSource dataSourceFrom(String filename) throws IOException {
        return DataSourceBuilder.dataSourceFrom(new File(filename));
    }

    public static DataSource dataSourceFrom(File file) throws IOException {
        return DataSourceBuilder.dataSourceFrom(propertiesFrom(file));
    }

    public static DataSource dataSourceFrom(Properties p) throws IOException {
        return DataSourceBuilder.dataSourceFrom(databaseSettingsFrom(p));
    }

    public static DataSource dataSourceFrom(DatabaseSettings dbs) throws IOException {
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName(dbs.driverClassName);
        ds.setUrl(dbs.url);
        ds.setUsername(dbs.username);
        ds.setPassword(dbs.password);
        return ds;

    }

    public static Properties propertiesFrom(String filename) throws IOException {
        return propertiesFrom(new File(filename));
    }
    
    public static Properties propertiesFrom(File file) throws IOException {
        try (FileInputStream fis = new FileInputStream(file)) {
            Properties p = new Properties();
            p.load(fis);
            return p;
        }
    }

    public static DatabaseSettings databaseSettingsFrom(Properties p) {
        DatabaseSettings dbs = new DatabaseSettings();
        dbs.driverClassName = p.getProperty("db.driver");
        dbs.url = p.getProperty("db.url");
        dbs.username = p.getProperty("db.username");
        dbs.password = p.getProperty("db.password");
        return dbs;
    }

    public static class DatabaseSettings {

        public String driverClassName;
        public String url;
        public String username;
        public String password;
    }
}
