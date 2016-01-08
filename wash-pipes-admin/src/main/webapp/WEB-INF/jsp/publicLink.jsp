<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.List,org.wash.pipes.core.model.ProjectGroup" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>推廣連結</title>
<link rel="stylesheet" type="text/css" href="skin/css/base1.css">

<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="http://www.steamdev.com/zclip/js/jquery.zclip.min.js"></script>
<script>
	$(function(){
	<%
		List<ProjectGroup> projectGroupList = (List)request.getAttribute("projectGroupList");
		for(ProjectGroup pg:projectGroupList) {
			System.out.println(pg.getId());
		
	%>	
		
		
	<%
		}
	%>
	});
</script>
</head>
<body>
	<table width="80%" align="center" border="0" cellpadding="4"
		cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">
		<tr bgcolor="#EEF4EA">
			<td background="skin/images/frame/wbg.gif" class='title'><span>文案群組名稱</span></td>
			<td background="skin/images/frame/wbg.gif" class='title'><span>推廣網址</span></td>
			<td background="skin/images/frame/wbg.gif" class='title'></td> 
		</tr>
		<c:forEach items="${projectGroupList}" var="projectGroup">
			<tr bgcolor="#FFFFFF">
				<td bgcolor="#FFFFFF">
					${projectGroup.name}
				</td>
				<td bgcolor="#FFFFFF">
					<input type="text" id="${projectGroup.id}" style="width:600px; margin-left:15px;"
						value="http://www.washpipes.com?id=${loginMember.memberId.id}&projectGroup=${projectGroup.id}" />
					
				</td>
				<td bgcolor="#FFFFFF">
					<input type="button" class='mybutton' id="${projectGroup.id}_copy" value="複製" >
				</td>
			</tr>
		</c:forEach>
	</table>

</html>