package com.gikim.mall;

import java.sql.*;
import java.util.Properties;
import java.util.Vector;

public class DBConnectionPoolMgr {

    private Vector<ConnectionObject> connections = new Vector<ConnectionObject>(10); //Connection 객체와 상태값
    private String _driver = "oracle.jdbc.driver.OracleDriver";
    private String _url = "jdbc:oracle:thin:@13.124.230.151:1521:XE";
    private String _user = "shop_gikim";
    private String _password = "1234";

    private boolean _traceOn = false;   //사용가능 여부
    private boolean initialize = false; //초기화
    private int _openConnections = 50;   //최대 가능 갯수

    private static DBConnectionPoolMgr instance = null; // Singleton

    private DBConnectionPoolMgr() {
    }

    public static DBConnectionPoolMgr getInstance() {
        if (instance == null) {
            instance = new DBConnectionPoolMgr();
        }
        return instance;
    }

    //    열려있는 Connection 객체의 수 설정
    public void setOpenConnectionCount(int count) {
        _openConnections = count;
    }

    //    사용가능여부 설정
    public void setEnableTrace(boolean enable) {
        _traceOn = enable;
    }

    //    Vector<ConnectionObject> connections 를 반환
    public Vector<ConnectionObject> getConnectionList() {
        return connections;
    }

    //    현재 열려 있는 Connection객체의 수를 반환
    public int getConnectionCount() {
        return connections.size();
    }

    private Connection createConnection() {
        Connection conn = null;

        try {
            if (_user == null) {
                _user = "";
            }
            if (_password == null) {
                _password = "";
            }

            Properties props = new Properties();
            props.put("user", _user);
            props.put("password", _password);

            conn = DriverManager.getConnection(_url, props);

        } catch (SQLException e) {
            System.err.println("CONNECT ERR : " + e.getMessage());
        }
        return conn;
    }

    //    모든 연결을 해제하고, 연결 pool(Vector) 내의 모든 내용을 삭제
    public void finalize() {

        ConnectionObject conns = null;

        for (int i = 0; i < connections.size(); i++) {
            conns = (ConnectionObject) connections.elementAt(i);

            try {
                conns.connection.close();
            } catch (Exception e) {
                System.err.println("CONNECTION ALL CLOSE ERR : " + e.getMessage());
            }
            conns = null;
        }
        connections.removeAllElements();    //Vector 안의 모든 객체를 제거
    }


    //  현재 사용되지 않지만 연결되어 있는 Connection 자원 해재
    public void releaseFreeConnections() {
        ConnectionObject conns = null;

        for (int i = 0; i < connections.size(); i++) {
            conns = (ConnectionObject) connections.elementAt(i);
            if (!conns.inuse) {
                removeConnection(conns.connection);
            }
        }
    }

    //사용되지 않는 connection 객체 제거
    public void removeConnection(Connection c) {
        if (c == null) {
            return;
        }

        ConnectionObject conns = null;
        for (int i = 0; i < connections.size(); i++) {

            conns = (ConnectionObject) connections.elementAt(i);

            if (c == conns.connection) {
                try {
                    c.close();
                    connections.removeAllElements();
                } catch (SQLException e) {
                    System.err.println("CONNECTION REMOVE ERR : " + e.getMessage());
                }
                break;
            }
        }
    }

    //    PreparedStatement, Statement, ResultSet 디양한 자원 해제 메서드 (Overloading)
    public void freeConnection(PreparedStatement pstmt, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (SQLException e) {
            System.err.println("PreparedStatement, ResultSet CLOSE ERR : " + e.getMessage());
        }
    }

    public void freeConnection(Statement pstmt, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (SQLException e) {
            System.err.println("Statement, ResultSet CLOSE ERR : " + e.getMessage());
        }
    }

    public void freeConnection(Statement pstmt) {
        try {
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (SQLException e) {
            System.err.println("Statement, ResultSet CLOSE ERR : " + e.getMessage());
        }
    }

    public Connection getConnection() {

        Connection conn = null;
        ConnectionObject conns = null;

        if (!initialize) {
            try {
                Class.forName(_driver);
                conn = DriverManager.getConnection(_url, _user, _password);

            } catch (ClassNotFoundException e) {
                System.err.println("DRIVER ERR : " + e.getMessage());
            } catch (SQLException e) {
                System.err.println("CONNECTION ERR : " + e.getMessage());
            }
        }
        boolean badConnection = false;  //연결이 잘못되었을 경우 상태값 저장

        for(int i=0;i<connections.size();i++){
            conns=(ConnectionObject) connections.elementAt(i);

            //연결이 유효한지 테스트
            if(!conns.inuse){
                try{
                    badConnection=conns.connection.isClosed();  //기존 Connection 객체가 닫혀있는(true)지

                    if(!badConnection){
                        badConnection=(conns.connection.getWarnings()!=null);   //getWarnings(): 경고발생(true)
                    }

                }catch (SQLException e){
                    System.err.println("CONNECTION VALIDATE ERR : "+e.getMessage());
                }

                //잘못연결된 Connection 객체의 경우 pool(Vector)에서 제거
                if(badConnection){
                    connections.removeElementAt(i);
                    continue;
                }

                conn=conns.connection;
                conns.inuse=true;

                break;
            }//연결이 유효한지 테스트

            if(conn==null){
                conn=createConnection();
                conns=new ConnectionObject(conn, true);
                connections.addElement(conns);
            }
        }

        return conn;
    }

}//End of DBConnection

//   Connection 객체와 그 객체의 사용여부를 저장할 수 있는 클래스 선언 -> 서브클래스
class ConnectionObject {
    public Connection connection = null;
    public boolean inuse = false;

    public ConnectionObject(Connection c, boolean useFlag) {
        connection = c;
        inuse = useFlag;
    }

}
