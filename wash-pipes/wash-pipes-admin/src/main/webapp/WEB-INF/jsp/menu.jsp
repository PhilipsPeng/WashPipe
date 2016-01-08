<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=5">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="0">
<title>menu</title>
<link rel="stylesheet" href="skin/css/base.css" type="text/css" />
<link rel="stylesheet" href="skin/css/menu.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript" src="skin/js/frame/menu.js"></script>
<base target="main" />
</head>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.tools.min.js"></script>

<body target="main">
	<table width='99%' height="100%" border='0' cellspacing='0'
		cellpadding='0'>
		<tr>
			<td style='padding-left: 3px; padding-top: 8px' valign="top">
				<dl class='bitem'>
					<dt onClick='showHide("items1_1")'>
						<b>常用操作</b>
					</dt>
					<dd style='display: block' class='sitem' id='items1_1'>
						<ul id="menu" class='sitemu'>
							<li><a href='contactInfoList.html' target='main'><font size="12px">陌生名單列表</font></a></li>
							<li><a href='customerList.html' target='main'><font size="12px">銷售列表</font></a></li>
							<c:if test="${loginMember.auth == 0 }">
								<li><a href='memberIdList.html' target='main'><font size="12px">註冊會員ID維護</font></a></li>
								<li><a href='memberList.html' target='main'><font size="12px">註冊會員列表</font></a></li>
							</c:if>
						</ul>
					</dd>
				</dl> 
				<c:if test="${loginMember.auth == 0}">
					<dl class='bitem'>
						<dt onClick='showHide("items2_3")'>
							<b>文案維護</b>
						</dt>
						<dd style='display: block' class='sitem' id='items2_3'>
							<ul class='sitemu'>
								<li><a href='projectGroupList.html' target='main'><font size="12px">文案群組維護</font></a></li>
								<li><a href='projectPageOne.html' target='main'><font size="12px">名單收集第一頁</font></a></li>
							</ul>
						</dd>
					</dl>
				
					<dl class='bitem'>
						<dt onClick='showHide("items2_2")'>
							<b>Send Mail設定</b>
						</dt>
						<dd style='display: block' class='sitem' id='items2_3'>
							<ul class='sitemu'>
								<li><a href='mailConfigList.html' target='main'><font size="12px">Mail內容維護</font></a></li>
							</ul>
						</dd>
					</dl>
				</c:if>
				<dl class='bitem'>
					<dt onClick='showHide("items2_3")'>
						<b>推廣功能</b>
					</dt>
					<dd style='display: block' class='sitem' id='items2_3'>
						<ul class='sitemu'>
							<li><a href='publicLink.html' target='main'><font size="12px">推廣連結</font></a></li>
						</ul>
					</dd>
				</dl>
			</td>
		</tr>
	</table>
</body>
</html>