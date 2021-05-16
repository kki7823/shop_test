package com.gikim.mall;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class OrderMgr {

    private DBConnectionMgr pool;

    public OrderMgr() {
        pool = DBConnectionMgr.getInstance();
    }

    public void insertOrder(OrderBean order) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = null;

        try {
            conn = pool.getConnection();
            sql = "insert into order_tbl (no,id,productno, quantity,rdate,state) values (order_seq.nextval,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, order.getId());
            pstmt.setInt(2, order.getProductNo());
            pstmt.setInt(3, order.getQuantity());
            pstmt.setString(4, UtilMgr.getDay());
            pstmt.setString(5, "1");
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pool.freeClose(conn, pstmt);
        }
    }

    public Vector<OrderBean> getOrder(String id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        Vector<OrderBean> vlist = new Vector<>();

        try {
            conn = pool.getConnection();
            sql = "select * from order_tbl where id=? order by no desc";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs=pstmt.executeQuery();

            while (rs.next()){
                OrderBean order = new OrderBean();
                order.setNo(rs.getInt("no"));
                order.setId(rs.getString("id"));
                order.setProductNo(rs.getInt("productNo"));
                order.setQuantity(rs.getInt("quantity"));
                order.setRdate(rs.getString("rdate"));
                order.setState(rs.getString("state"));
                vlist.addElement(order);
            }

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            pool.freeClose(conn,pstmt,rs);
        }
        return vlist;
    }
}

