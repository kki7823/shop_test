package com.gikim.mall;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Manages a java.sql.Connection pool.
 */
public class DBConnectionMgr {
    private String _driver = "oracle.jdbc.driver.OracleDriver";
    private String _url = "jdbc:oracle:thin:@13.124.230.151:1521:XE";
    private String _user = "shop_gikim", _password = "920829";

    private static DBConnectionMgr instance = null;

    private DBConnectionMgr() {
    }

    public static DBConnectionMgr getInstance() {
        if (instance == null) {
            instance = new DBConnectionMgr();
        }
        return instance;
    }

    public Connection getConnection() {
        Connection conn = null;

        try {
            Class.forName(_driver);
            conn = DriverManager.getConnection(_url, _user, _password);
        } catch (ClassNotFoundException e) {
            System.out.println("드라이버 로딩 실패 " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("오라클 접속 실패 " + e.getMessage());
        }
        return conn;
    }

    public void freeClose(Connection c, PreparedStatement p, ResultSet r) {
        try {
            if (r != null)
                r.close();
            if (p != null)
                p.close();
            freeClose(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeClose(Connection c, Statement s, ResultSet r) {
        try {
            if (r != null)
                r.close();
            if (s != null)
                s.close();
            freeClose(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeClose(Connection c, PreparedStatement p) {
        try {
            if (p != null)
                p.close();
            freeClose(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeClose(Connection c, Statement s) {
        try {
            if (s != null)
                s.close();
            freeClose(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeClose(Connection c) {
        try {
            if (c != null)
                c.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
