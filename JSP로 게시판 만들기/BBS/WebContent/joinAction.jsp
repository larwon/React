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
<!-- 받아오는 name을 적어야함 -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
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
	//세션부분
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
	
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
		|| user.getUserGender() == null || user.getUserEmail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
				
			}
			else {
				/* 세션부여 부분 */
				session.setAttribute("userID", user.getUserID());

				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	
		
	%>
</body>
</html>