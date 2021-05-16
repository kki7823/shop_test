package com.gikim.mall;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Vector;

public class MemberMgr {

    private DBConnectionMgr pool;

    public MemberMgr() {
        pool = DBConnectionMgr.getInstance();
    }

    //ID 중복확인
    public boolean checkId(String id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        boolean flag = false;

        try {
            conn = pool.getConnection();
            sql = "select id from member_tbl where id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            flag = rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeClose(conn, pstmt, rs);
        }
        return flag;
    }

    //로그인
    public int loginMember(String id, String pwd) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        int mode = 0;
        // 0 : id-false, 1: id-true, 2 : id&pass-true
        try {
            if (!checkId(id)) {
                return mode;    //id-false -> 0
            }

            conn = pool.getConnection();
            sql = "select id,pwd from member_tbl where id = ? and pwd =? ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pwd);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                mode = 2;
            } else {
                mode = 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pool.freeClose(conn, pstmt, rs);
        }
        return mode;
    }

    //    우편번호 검색
    public Vector<ZipcodeBean> zipcodeRead(String road) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();

        try {
            con = pool.getConnection();
            sql = "select * from zipcode_tbl where road like ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "%" + road + "%");
            rs = pstmt.executeQuery();


            while (rs.next()) {
                ZipcodeBean bean = new ZipcodeBean();
                bean.setZipcode(rs.getString(1));
                bean.setCity(rs.getString(2));
                bean.setRegion(rs.getString(3));
                bean.setRoad(rs.getString(4));
                vlist.addElement(bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeClose(con, pstmt, rs);
        }
        return vlist;
    }

    public Boolean insertMember(MemberBean mBean) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        int result = 0;
        try {
            con = pool.getConnection();
            sql = "insert into member_tbl values (?,?,?,?,?,?,?,?,?,?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, mBean.getId());
            pstmt.setString(2, mBean.getPwd());
            pstmt.setString(3, mBean.getName());
            pstmt.setString(4, mBean.getGender());
            pstmt.setString(5, mBean.getBirthday());
            pstmt.setString(6, mBean.getEmail());
            pstmt.setString(7, mBean.getZipcode());
            pstmt.setString(8, mBean.getAddress());
            pstmt.setString(9, Arrays.stream(mBean.getHobby()).reduce((s1, s2) -> s1 + "," + s2).get());
            pstmt.setString(10, mBean.getJob());
            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (result > 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 회원정보 가져오기
     **/
    public MemberBean getMember(String id) {
        //hobby => 10101 => {"1","0","1","0","1"}
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        MemberBean bean = new MemberBean();
        try {
            con = pool.getConnection();
            sql = "select * from member_tbl where id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                bean.setId(rs.getString("id"));
                bean.setPwd(rs.getString("pwd"));
                bean.setName(rs.getString("name"));
                bean.setGender(rs.getString("gender"));
                bean.setBirthday(rs.getString("birthday"));
                bean.setEmail(rs.getString("email"));
                bean.setZipcode(rs.getString("zipcode"));
                bean.setAddress(rs.getString("address"));
                //hobby => 10101 => {"1","0","1","0","1"}
                //table에서 hobby을 가져옴.
                String hobby = rs.getString("hobby");
                //빈즈에 저장할 배열을 선언 ->
                String hobbys[] = new String[5];
                for (int i = 0; i < hobbys.length; i++) {
                    //hobbys[0]  =
                    hobbys[i] = hobby.substring(i, i + 1);
                }
                bean.setHobby(hobbys);
                bean.setJob(rs.getString("job"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeClose(con, pstmt, rs);
        }
        return bean;
    }

    /**
     * 회원정보 수정
     **/
    public boolean updateMember(MemberBean bean) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        boolean flag = false;
        try {
            con = pool.getConnection();
            sql = "update member_tbl set pwd=?, name=?, gender=?, birthday=?, email=?, zipcode=?, address=?, hobby=?, job=? where id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, bean.getPwd());
            pstmt.setString(2, bean.getName());
            pstmt.setString(3, bean.getGender());
            pstmt.setString(4, bean.getBirthday());
            pstmt.setString(5, bean.getEmail());
            pstmt.setString(6, bean.getZipcode());
            pstmt.setString(7, bean.getAddress());

            String hobby[] = bean.getHobby();
            char hb[] = {'0', '0', '0', '0', '0'};
            String lists[] = {"인터넷", "여행", "게임", "영화", "운동"};

            if (hobby != null) {
                for (int i = 0; i < hobby.length; i++) {
                    for (int j = 0; j < lists.length; j++) {
                        if (hobby[i].equals(lists[j])) {
                            hb[j] = '1';

                            break;
                        }//---if
                    }//---for2
                }//---for1
            }
            pstmt.setString(8, new String(hb));

            pstmt.setString(9, bean.getJob());
            pstmt.setString(10, bean.getId());
            if (pstmt.executeUpdate() == 1)
                flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeClose(con, pstmt);
        }
        return flag;
    }

    //Admin 관련 메소드
    public boolean adminCheck(String admin_id, String admin_pwd) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        boolean flag = false;

        try {
            con = pool.getConnection();
            sql = "select admin_id, admin_pwd from admin_tbl where admin_id = ? and admin_pwd = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, admin_id);
            pstmt.setString(2, admin_pwd);
            rs = pstmt.executeQuery();
            flag = rs.next();
        } catch (SQLException e) {
            System.out.println("adminCheck err : " + e.getMessage());
        } finally {
            pool.freeClose(con, pstmt, rs);
        }

        return flag;
    }

    public void sendAccount(String id) {
        MemberBean bean = getMember(id);
        String pwd = bean.getPwd();
        String title = "000.com에서 아이디와 비밀번호 전송합니다.";
        String content = "id : " + id + "/pwd : " + pwd;
        String toEmail = bean.getEmail();
        Gmail_Mail.send(title,content,toEmail);
    }

    public Vector<MemberBean> getMemberList(){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = null;
        Vector<MemberBean> vlist = new Vector<>();
        try{
            conn = pool.getConnection();
            sql = "select * from member_tbl";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()){
                MemberBean bean = new MemberBean();
                bean.setId(rs.getString("id"));
                bean.setPwd(rs.getString("pwd"));
                bean.setName(rs.getString("name"));
                bean.setGender(rs.getString("gender"));
                bean.setBirthday(rs.getString("birthday"));
                bean.setEmail(rs.getString("email"));
                vlist.addElement(bean);
            }
        }catch (SQLException e){
            System.out.println("getMemberList SQL err : "+e.getMessage());
        }finally {
            pool.freeClose(conn,pstmt,rs);
        }
        return vlist;
    }

}
