<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		//세션 정보 해지
		session.invalidate();
	%>
	<script>
		location.href = 'main.jsp';
	</script>
</body>
</html>