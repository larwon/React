<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- UserDAO를 불러옴 -->
<%@ page import="bbs.BbsDAO" %>
<!-- 자바스크립트를 사용할 수 있게 해주는 io -->
<%@ page import="java.io.PrintWriter" %>
<!-- 건너오는 모든 데이터를 utf-8로 받도록 하는 로직 -->
<% request.setCharacterEncoding("UTF-8"); %> 
<!-- User라는 VO를 bean을 현재 페이지에서만 사용함 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<!-- 받아오는 name을 적어야함 -->
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
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
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");			
		} else {
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('입력이 안 된 사항이 있습니다.')");
						script.println("history.back()");
						script.println("</script>");
			} else {
						BbsDAO bbsDAO = new BbsDAO();
						int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
						if (result == -1) {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('글쓰기에 실패하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
							
						} else {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'bbs.jsp'");
							script.println("</script>");
						}
			}
		}
	
		
	
		
	%>
</body>
</html>