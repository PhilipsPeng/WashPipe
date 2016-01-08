<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title></title>
</head>
<body>
<c:redirect url="/welcome.html?id=${param.id}&projectGroup=${param.projectGroup}"/>
</body>
</html>