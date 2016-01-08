<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<title>個人資料</title>
<link rel="stylesheet" type="text/css" href="skin/css/base.css">
<link rel="stylesheet" type="text/css" href="css/examples.css">
<link href="css/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="js/jquery-impromptu.4.0.min.js"></script>

<script type="text/javascript">
	function backPage() {
		$("#backPageForm").submit();
	}
</script>
</head>
<body leftmargin="8" topmargin="8">
	<table width="40%"  align="center" border="0">
		<tr>
			<td align="right" class='title'>
				<input type="button" class='mybutton' id="dlrbtn" value="上一頁"
					onclick="backPage()">
			</td>
		</tr>
	</table>
	<table width="40%" align="center" border="0" cellpadding="3"
		cellspacing="1" bgcolor="#CBD8AC"
		style="margin-bottom: 8px; margin-top: 8px;">
		<tr>
			<td colspan="2" background="skin/images/frame/wbg.gif"
				bgcolor="#EEF4EA" class="title">會員資料</td>

		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				會員ID：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.id}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				登入ID：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.loginId}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				密碼：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.password}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				姓名：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.name}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				行動：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.mobile}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				Mail：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.mail}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				Facebook：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.fb}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				微博：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.weibo}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				Skype：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.skype}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				微信：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.wechat}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				Line：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.line}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				QQ：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.qq}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				室內電話：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.phone}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				省：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.province}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				縣市：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.county}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				鄉鎮市區：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.city}
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="30%" bgcolor="#FFFFFF">
				地址：
			</td>
			<td width="70%" bgcolor="#FFFFFF">
				${member.address}
			</td>
		</tr>
	</table>
	<form id="backPageForm" action="memberList.html" method="post">
	</form>
</body>
</html>