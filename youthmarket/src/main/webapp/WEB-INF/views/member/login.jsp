<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result > 0}">
		<script type="text/javascript">
			alert("로그인 되었습니다")
			location.href="/youthmarket/sell/home.do"
		</script>
	</c:if>
	<c:if test="${result == 0}">
		<script type="text/javascript">
			alert("암호가 다릅니다")
			history.back()
		</script>
	</c:if>
	<c:if test="${result < 0}">
		<script type="text/javascript">
			alert("없는 아이디 입니다 ")
			history.back()
		</script>
	</c:if>
</body>
</html>