<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<title>陌生名單列表</title>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<link rel="stylesheet" type="text/css" media="screen"
	href="css/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" media="screen"
	href="css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="skin/css/base.css">
<link rel="stylesheet" type="text/css" href="css/prettyCheckboxes.css">
<link rel="stylesheet" type="text/css" href="css/examples.css">

<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/i18n/grid.locale-zh_TW.js"></script>
<script type="text/javascript" src="js/jquery-impromptu.4.0.min.js"></script>
<script type="text/javascript" src="js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="js/jquery.tablednd.js"></script>
<script type="text/javascript" src="js/jquery.contextmenu.js"></script>
<script type="text/javascript" src="js/jquery.json-2.2.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript" src="js/lin.validator.js"></script>

<script>
	var localData = ${localData};

	$(function() {
		jQuery("#list").jqGrid({
			datatype : "local",
			data : localData,
			height : 300,
			width : document.body.clientWidth - 46,
			colNames : [ '姓名', 'Mail', '建立時間', '信件寄送進度', '信件寄送狀態', 'id', '' ],
			colModel : [ {
				name : 'name',
				index : 'name',
				width : 60,
				align : "center"
			}, {
				name : 'email',
				index : 'email',
				width : 80,
				align : "center"
			}, {
				name : 'createTime',
				index : 'createTime',
				width : 60,
				align : "center"
			}, {
				name : 'sendMailProcess',
				index : 'sendMailProcess',
				width : 60,
				align : "center"
			}, {
				name : 'sendMailStatus',
				index : 'sendMailStatus',
				width : 60,
				align : "center"
			}, {
				name : 'id',
				index : 'id',
				width : 40,
				align : "center",
				hidden : true
			}, {
				name : 'deleteBtn',
				index : 'deleteBtn',
				width : 20,
				align : "center"
			} ],
			cmTemplate: { sortable: false },
			gridComplete : function() {
				var ids = jQuery("#list").jqGrid('getDataIDs');
				for ( var i = 0; i < ids.length; i++) {
					var cl = ids[i];
					var row = $("#list").jqGrid('getRowData', cl);
					var sendMailProcessText = '';
					var sendMailStatusText = '';
					if(row.sendMailProcess=='FIRST') {
						sendMailProcessText="第一封";
					}else if(row.sendMailProcess=='SECOND') {
						sendMailProcessText="第二封";
					}else if(row.sendMailProcess=='THIRD'){			
						sendMailProcessText="第三封";						
					}else if(row.sendMailProcess=='FOURTH'){			
						sendMailProcessText="第四封";						
					}else if(row.sendMailProcess=='FIFTH'){			
						sendMailProcessText="第五封";						
					}else {
						sendMailProcessText="最後一封";	
					}
					
					if(row.sendMailStatus=='SUCCESS') {
						sendMailStatusText="成功";
					}else if(row.sendMailStatus=='FAIL') {
						sendMailStatusText="失敗";
					}else if(row.sendMailStatus=='FINISH'){			
						sendMailStatusText="完成";						
					}
					ce1 = "<input  type='button' value='刪除' class='mybutton' onclick=\"deleteContactInfo('"
						+ cl + "');\" />";
					jQuery("#list").jqGrid('setRowData', ids[i], {
						sendMailProcess : sendMailProcessText,
						sendMailStatus : sendMailStatusText,
						deleteBtn : ce1
					});
				}
			},
			caption : "陌生名單"
		}); // jqGrid
		
		$("#id").change(function() {
			$("#contactInfoSelectForm").submit();
		});
	});
	
	function deleteContactInfo(oid) {
		//var unfamiliarListGrid = $('#list'),
		//selRows = unfamiliarListGrid.jqGrid('getGridParam','selarrrow');
		//alert(oid);
		$("#deleteContactInfoOid").val(oid);
		$.prompt('確定刪除選擇的陌生名單?',{
			buttons:[
				{title: '是',value:true},
				{title: '否',value:false}
				], 
			submit: function(e,v,m,f){ 
				if(v){
					 $("#contactInfoDeleteForm").submit();
				}
			}
		});
	}
	
	function downloadCsv() {
		$("#downloadCsvForm").submit();	
	}
</script>

</head>
<body leftmargin="8" topmargin="8">
	<form:form id="contactInfoSelectForm" commandName="projectGroup"
		action="contactInfoList.html" method="post">
		<table width="40%" align="center" border="0" cellpadding="3"
			cellspacing="1" bgcolor="#CBD8AC"
			style="margin-bottom: 8px; margin-top: 8px;">
			<tr bgcolor="#FFFFFF">
				<td width="30%" bgcolor="#FFFFFF"><font color="red">*</font>文案群組：
				</td>
				<td width="70%" bgcolor="#FFFFFF">
					<form:select path="id">
						<form:option value="NONE" label="--- Select ---"/>
						<form:options items="${projectGroupList}" 
							itemValue="id" itemLabel="name"/>
					</form:select>
				</td>
			</tr>
		</table>
	</form:form>
	<table width="98%"  align="center" border="0">
		<tr>
			<td align="right" class='title'>
				<input type="button" class='mybutton' id="dlrbtn" value="下載陌生名單"
					onclick="downloadCsv()">
			</td>
		</tr>
	</table>
	<table width="98%" id="viewtable" align="center" border="0"
		cellpadding="3" cellspacing="1" bgcolor="#CBD8AC"
		style="margin-bottom: 8px; margin-top: 8px">
		<tr bgcolor='#FFFFFF'>
			<td>
				<table id="list" width="98%">
					<tr>
						<td />
					</tr>
				</table>
				<div id="pager"></div>
			</td>
		</tr>
	</table>
	
	<form id="contactInfoDeleteForm" action="contactInfoDelete.html" method="post">
		<input id="deleteContactInfoOid" name="deleteContactInfoOid" type="hidden" />
	</form>
	<form id="downloadCsvForm" action="downloadCsv.html" method="post">
	</form>
</body>

</html>