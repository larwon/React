<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- UserDAO를 불러옴 -->
<%@ page import="user.UserDAO" %>
<!-- 자바스크립트를 사용할 수 있게 해주는 io -->
<%@ page import="java.io.PrintWriter" %>
<!-- 건너오는 모든 데이터를 utf-8로 받도록 하는 로직 -->
<% request.setCharacterEncoding("UTF-8"); %> 
<!-- User라는 VO를 bean을 현재 페이지에서만 사용함 -->
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 반응형 메타태그 -->
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		//세션유지 부분
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");			
		}
	
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if (result == 1) {
			/* 세션부여 부분 */
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
			
		}
		else if ( result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if ( result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다..')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if ( result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>