<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache"> 
<meta http-equiv="Cache-Control" content="no-cache"> 
<meta http-equiv="Expires" content="0"> 
<title>template</title>
<base target="_self">
<link rel="stylesheet" type="text/css" href="skin/css/base.css" />
<link rel="stylesheet" type="text/css" href="skin/css/main.css" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.tools.min.js"></script>
</head>

<body leftmargin="8" topmargin='8'>
	<table width="98%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td><div style='float: left'>
					<img height="14" src="skin/images/frame/book1.gif" width="20" />&nbsp;歡迎使用水管達人管理系統。
				</div>
				<div style='float: right; padding-right: 8px;'>
					
				</div></td>
		</tr>
		<tr>
			<td height="1" 
				style='padding: 0px'></td>
		</tr>
	</table>
	
	<table width="98%" align="center" border="0" cellpadding="4"
		cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">
		<!--<tr>
			<td colspan="2" background="skin/images/frame/wbg.gif"
				bgcolor="#EEF4EA" class='title'>
				<div style='float: left'>
					<span>最新訊息</span>
				</div>
				<div style='float: right; padding-right: 10px;'></div>
			</td> 
		</tr>-->
		<tr bgcolor="#FFFFFF">
			<td height="30" colspan="2" align="center" valign="bottom">
				<table
					width="100%" border="0" cellspacing="1" cellpadding="1">
					<tr>
						<td width="15%" height="62" align="center"><img
							src="skin/images/frame/qc.gif" width="90" height="30" />
						</td>
						<td width="85%" valign="bottom">
							<span id="menu1"></span>
						</td>
					</tr>
				</table></td>
		</tr>
	</table>
	<table width="98%" align="center" border="0" cellpadding="4"
		cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom: 8px">
		<tr bgcolor="#EEF4EA">
			<td colspan="2" background="skin/images/frame/wbg.gif" class='title'><span>系統基本信息</span></td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="25%" bgcolor="#FFFFFF">
				您的權限：
			</td>
			<td width="75%" bgcolor="#FFFFFF">
				<span id="role">
					<c:if test="${loginMember.auth==1 }">
					一般使用者
					</c:if>
					<c:if test="${loginMember.auth==0 }">
					最大權限使用者
					</c:if>
				</span>
			</td>
		</tr>
	</table>
</body>
</html>