<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<title>註冊</title>
<link rel="stylesheet" type="text/css" href="skin/css/base.css">
<link rel="stylesheet" type="text/css" href="css/examples.css">
<link href="css/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="js/jquery-impromptu.4.0.min.js"></script>
<script type="text/javascript" src="js/lin.validator.js"></script>

<script type="text/javascript">
	$(function() {
		$("#registerForm").validate({
			errorClass : "errors",
			rules : {
				id: {
					required : true,
					memberIdCheck : true,
					memberCheck : true
				},
				loginId : {
					required : true,
					loginIdCheck : true
				},
				password : "required",
				name : "required",
				mobile : "required",
				mail : {
					required : true,
					email : true
				}
			},
			messages : {
				id : {
					required : "必填"
				},
				loginId : {
					required : "必填"
				},
				password : "必填",
				name : "必填",
				mobile : "必填",
				mail : {
					required : "必填",
					email : "mail格式不正確"
				}
			}
		});
	});
	
	function registerCancel() {
		$("#cancelForm").submit();
	}
</script>
</head>
<body leftmargin="8" topmargin="8">
	<form:form id="registerForm" commandName="member" 
		action="registerSubmit.html" method="post">
		<table width="40%" align="center" border="0" cellpadding="3"
			cellspacing="1" bgcolor="#CBD8AC"
			style="margin-bottom: 8px; margin-top: 8px;">
			<tr>
				<td colspan="2" background="skin/images/frame/wbg.gif"
					bgcolor="#EEF4EA" class="title">註冊</td>

			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF"><font color="red">*</font>會員ID：
				</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="id"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF"><font color="red">*</font>登入ID：
				</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="loginId"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF"><font color="red">*</font>密碼：
				</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="password"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF"><font color="red">*</font>姓名：
				</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="name"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF"><font color="red">*</font>行動：
				</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="mobile"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF"><font color="red">*</font>Mail：
				</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="mail"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF">Facebook：</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="fb"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF">微博：</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="weibo"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF">Skype：</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="skype"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF">微信：</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="wechat"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF">Line：</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="line"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF">QQ：</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="qq"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF">室內電話：
				</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="phone"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF">省：</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="province"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF">縣市：</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="county"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF">鄉鎮市區：</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="city"
						style="width: 200px;" /></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF">地址：</td>
				<td width="70%" bgcolor="#FFFFFF"><form:input path="address"
						style="width: 200px;" /></td>
			</tr>
		</table>
		<table width="40%" align="center" border="0" cellpadding="3"
			cellspacing="1" bgcolor="#CBD8AC"
			style="margin-bottom: 8px; margin-top: 8px;">
			<tr bgcolor="#FFFFFF">
				<td width="100%" bgcolor="#FFFFFF">
					<button class="mybutton" onclick="registerCancel()">
						取消
					</button>
					&nbsp;&nbsp;
					<form:button
						class="mybutton" id="registerSubmit">
						儲存
					</form:button>
			</tr>
		</table>
	</form:form>
	
	<form id="cancelForm" action="index.html" method="post">
	</form>
</body>
</html>