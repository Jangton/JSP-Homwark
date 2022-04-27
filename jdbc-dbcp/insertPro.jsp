<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
      import = "java.sql.*"    
%>
<%
	 //언어 설정
   request.setCharacterEncoding("utf-8");

   //클라이언트에서 전달된 데이터
   String id = request.getParameter("id");
   String name = request.getParameter("name");
   String pwd = request.getParameter("pwd");
   
   //DBCP로 변경
   Context initCtx = new InitialContext();
   Context envCtx = (Context)initCtx.lookup("java:comp/env");
   DataSource ds = (DataSource)envCtx.lookup("jdbc/jinu");
   Connection con = ds.getConnection();
   
   //3. SQL문 (insert로 상입하기)
   String sql = "insert into login(id, name, pwd) values(?, ?, ?)";
   
   //4. SQL 실행
   //Statement stmt = con.createStatement();
   PreparedStatement pstmt = con.prepareStatement(sql);
   //첫번째부터 id name pwd를 ?로 처리했기 때문에 순서대로 사용
   pstmt.setString(1, id);
   pstmt.setString(2, name);
   pstmt.setString(3, pwd);
   
   //변경하는 쿼리를 쓸때 executeUpdate();를 이용
   int i = pstmt.executeUpdate();
   //int i = stmt.executeUpdate(sql);
   
   //5.객체 해지
   pstmt.close();
   con.close();
   
   //page수행 후 list페이지를 이동하기위한 코드
   response.sendRedirect("list.jsp");
%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Insert title here</title>
</head>
<body>
   <%=i %>개의 데이터가 입력되었습니다!
</body>
</html>