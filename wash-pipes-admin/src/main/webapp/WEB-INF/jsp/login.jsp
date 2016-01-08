<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<title>水管達人管理系統</title>
	<style type="text/css">
	.style1 {
		font-family: Georgia, "Times New Roman", Times, serif;
		color: #FFFFFF;
		font-weight: bold;
	}
	</style>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript">
	  $(function(){
			$("#loginForm").validate({
				errorClass : "errors",
				rules : {
					loginId : "required",
					password : "required"
				},
				messages : {
					loginId : "請輸入登入id",
					password : "請輸入密碼"
				}
			});
	});
	
	function register() {
		$("#registerForm").submit();
	}  
	
	function forgetPwd() {
		$("#toForgetPwdForm").submit();
	}
</script>

</head>
<body>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
<form:form id="loginForm" commandName="member" action="login.html" method="post">
	<table cellpadding="0" cellspacing="0"
		style="border-collapse: collapse;" border="1" align="center"
		bordercolor="#CCCC99">
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0"
					style="border-collapse: collapse;" border="1" align="center"
					bordercolor="#CCCC99">
					<tr>
						<td>
							<table cellpadding="0" cellspacing="0"
								style="border-collapse: collapse;" border="1" align="center"
								bordercolor="#CCCC99">
								<tr>
									<td>
										<table width="350" cellpadding="0" cellspacing="0"
											style="border-collapse: collapse;" border="0" align="center">
											<tr bgcolor="#B7B76F" height="49">
												<td colspan="2" align="center"><FONT
													style="font-size: 21pt; font-family: Arial"
													color="#FFFFFF"><B>水管達人管理系統</B></FONT>&nbsp;&nbsp;<FONT
													style="font-size: 10.8pt; font-family: Arial"
													color="#FFFFFF"><I></I></FONT></td>
											</tr>
											<tr height="3" bgcolor="#FFFFFF">
												<td>&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
											<tr bgcolor="#FFFFFF">
												<td width="110" align="left">&nbsp;．<FONT
													style="font-size: 9pt; font-family: Arial" color="#828242">ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B>:</B></FONT></td>
												<td width="130">
													<form:input path="loginId" maxlength="20"
														size="15" tabindex="1" style="font-size: 9pt" />
													<form:errors path="loginId" cssClass="error" />
												</td>
											</tr>
											<tr bgcolor="#FFFFFF">
												<td align="left">&nbsp;．<FONT
													style="font-size: 9pt; font-family: Arial" color="#828242">Password&nbsp;&nbsp;&nbsp;<B>:</B></FONT></td>
												<td>
													<form:password path="password" redisplay="false"
														size="15" tabindex="1" style="font-size: 9pt" />
													<form:errors path="password" cssClass="error" />
												</td>
											</tr>
											<tr height="25" bgcolor="#FFFFFF">
												<td colspan="2">
													<font style="font-size: 10pt;" color="red">
														${loginError}
													</font>
												</td>
											</tr>
											<tr bgcolor="#FFFFFF">
												<td colspan="2" align="right">
													<form:button 
													style="border: 0px dotted #C0C0C0; background-color: #B7B76F; font-size: 10.5 pt; color: FFFFFF">
														登入
													</form:button>
													&nbsp;
													<input type="button" value="註冊" onclick="register()" 
													style="border: 0px dotted #C0C0C0; background-color: #B7B76F; font-size: 10.5 pt; color: FFFFFF"/>	
													<input type="button" value="忘記密碼" onclick="forgetPwd()" 
													style="border: 0px dotted #C0C0C0; background-color: #B7B76F; font-size: 10.5 pt; color: FFFFFF"/>							
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td><font color="red">${errorMessage}</font></td>
		</tr>
	</table>
</form:form>
<form:form id="registerForm" commandName="member" action="register.html" method="post">
</form:form>
<form:form id="toForgetPwdForm" commandName="member" action="forgetPwd.html" method="post">
</form:form>
</body>
</html>