<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<title>忘記密碼</title>
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
			$("#forgetPwdForm").validate({
				errorClass : "errors",
				rules : {
					loginId : "required"
				},
				messages : {
					loginId : "請輸入登入id"
				}
			});
	});
	
</script>

</head>
<body>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
<form:form id="forgetPwdForm" commandName="member" action="forgetPwdSubmit.html" method="post">
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
												</td>
											</tr>
										
											<tr bgcolor="#FFFFFF">
												<td colspan="2" align="right">
													<form:button 
													style="border: 0px dotted #C0C0C0; background-color: #B7B76F; font-size: 10.5 pt; color: FFFFFF">
														送出
													</form:button>
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
</body>
</html>