package com.gikim.mall;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class ProductMgr {
    private DBConnectionMgr pool;
    private static final String UPLOAD = "data";
    private static final String ENCRYPT = "UTF-8";
    private static final int MAXSIZE = 10 * 1024 * 1024;

    public ProductMgr() {
        pool = DBConnectionMgr.getInstance();
    }

    public Vector<ProductBean> getProductList() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        Vector<ProductBean> vlist = new Vector<>();
        try {
            conn = pool.getConnection();
            sql = "select no,name,price,rdate,stock from product_tbl order by no desc";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductBean bean = new ProductBean();
                bean.setNo(rs.getInt(1));
                bean.setName(rs.getString(2));
                bean.setPrice(rs.getInt(3));
                bean.setRdate(rs.getString(4));
                bean.setStock(rs.getInt(5));
                vlist.addElement(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pool.freeClose(conn, pstmt, rs);
        }

        return vlist;
    }

    public ProductBean getProduct(int no) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        ProductBean bean = new ProductBean();

        try {
            conn = pool.getConnection();
            sql = "select * from product_tbl where no = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, no);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                bean.setNo(rs.getInt("no"));
                bean.setName(rs.getString("name"));
                bean.setPrice(rs.getInt("price"));
                bean.setDetail(rs.getString("detail"));
                bean.setRdate(rs.getString("rdate"));
                bean.setStock(rs.getInt("stock"));
                bean.setImage(rs.getString("image"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pool.freeClose(conn, pstmt, rs);
        }
        return bean;
    }

    public void reduceProduct(OrderBean order) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = null;
        try {
            conn = pool.getConnection();
            sql = "update product_tbl set stock=stock-? where no=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, order.getQuantity());
            pstmt.setInt(2, order.getNo());
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pool.freeClose(conn, pstmt);
        }
    }

    public boolean insertProduct(HttpServletRequest req) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        boolean flag = false;
        try {
            MultipartRequest multi =
                    new MultipartRequest(req, UPLOAD, MAXSIZE, ENCRYPT, new DefaultFileRenamePolicy());
            con = pool.getConnection();
            sql = "insert into product_tbl (no,name,price,detail,rdate, stock,image)values(product_seq.nextval,?,?,?,?,?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, multi.getParameter("name"));
            pstmt.setInt(2, Integer.parseInt(multi.getParameter("price")));
            pstmt.setString(3, multi.getParameter("detail"));
            pstmt.setString(4, UtilMgr.getDay());
            pstmt.setInt(5, Integer.parseInt(multi.getParameter("stock")));
            if (multi.getFilesystemName("image") == null) {
                pstmt.setString(6, "ready.gif");    //기본이미지
            } else {
                pstmt.setString(6, multi.getFilesystemName("image"));
            }
            if (pstmt.executeUpdate() == 1) {
                flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeClose(con, pstmt);
        }
        return flag;
    }

    public boolean updateProduct(HttpServletRequest req) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = null;
        boolean flag = false;
        try {
            MultipartRequest multi = new MultipartRequest(req, UPLOAD, MAXSIZE, ENCRYPT, new DefaultFileRenamePolicy());
            conn = pool.getConnection();
            if (multi.getFilesystemName("image") == null) {
                sql = "update product_tbl set name=?, price=?, detail=?, stock=? where no=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, multi.getParameter("name"));
                pstmt.setInt(2, Integer.parseInt("price"));
                pstmt.setString(3, multi.getParameter("detail"));
                pstmt.setInt(4, Integer.parseInt(multi.getParameter("stock")));
                pstmt.setInt(5, Integer.parseInt(multi.getParameter("no")));
            } else {
                sql = "update product_tbl set name=?, price=?, detail=?, stock=?, image=? where no=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, multi.getParameter("name"));
                pstmt.setInt(2, Integer.parseInt("price"));
                pstmt.setString(3, multi.getParameter("detail"));
                pstmt.setInt(4, Integer.parseInt(multi.getParameter("stock")));
                pstmt.setInt(5, Integer.parseInt(multi.getParameter("no")));
            }
            if (pstmt.executeUpdate() == 1) {
                flag = true;
            }

        } catch (SQLException e) {
            System.out.println("updateProduct SQL ERR: " + e.getMessage());
        } catch (IOException e) {
            System.out.println("updateProduct IO ERR: " + e.getMessage());
        } finally {
            pool.freeClose(conn, pstmt);
        }

        return flag;
    }

    public boolean deleteProduct(int no) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        boolean flag = false;
        try {
            con = pool.getConnection();
            sql = "delete from product_tbl where no = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, no);
            if (pstmt.executeUpdate() == 1)
                flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeClose(con, pstmt);
        }
        return flag;
    }


}
