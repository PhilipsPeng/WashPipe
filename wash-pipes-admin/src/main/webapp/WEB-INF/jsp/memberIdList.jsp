<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<title>會員ID列表</title>

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

<script>
	var localData = ${localData};

	$(document).ready(function() {
		jQuery("#list").jqGrid({
			datatype : "local",
			data : localData,
			height : 300,
			width : document.body.clientWidth - 46,
			colNames : [ '會員ID', '身份證', '姓名', '操作'],
			colModel : [ {
				name : 'id',
				index : 'id',
				width : 60,
				align : "center"
			}, {
				name : 'identificationId',
				index : 'identificationId',
				width : 90,
				align : "center"
			}, {
				name : 'name',
				index : 'name',
				width : 100,
				align : "center"
			}, {
				name : 'operation',
				index : 'operation',
				width : 40,
				align : "center"
			}],
			cmTemplate: { sortable: false },
			gridComplete : function() {
				var ids = jQuery("#list").jqGrid('getDataIDs');
				for ( var i = 0; i < ids.length; i++) {
					var cl = ids[i];
					//var row = $("#list").jqGrid('getRowData', cl);
					//var updateBtn = "<input  type='button' value='修改' class='mybutton' onclick=\"updateMemberId('"
						//+ cl + "');\" />&nbsp";
					var deleteBtn = "<input  type='button' value='刪除' class='mybutton' onclick=\"deleteMemberId('"
						+ cl + "');\" />";
					jQuery("#list").jqGrid('setRowData', ids[i], {
						operation : deleteBtn//updateBtn + deleteBtn
					});
				}
			},
			caption : "會員ID列表"
		}); 

	});
	
	function insertMemberId() {
		$("#memberIdInsertForm").submit();
	}
	
	function updateMemberId(memberId) {
		var memberIdListGrid = $('#list'),
		//selRows = memberIdListGrid.jqGrid('getGridParam','selarrrow'),
		//selRowId = memberIdListGrid.jqGrid ('getGridParam', 'selrow'),
	    celValue = memberIdListGrid.jqGrid ('getCell', memberId, 'id');
		
		//if(selRows.length > 1) {
		//	$.prompt('只能選擇一筆會員ID進行修改');
		//	return;
		//}
			
		$("#updateMemberId").val(celValue);
		celValue = memberIdListGrid.jqGrid ('getCell', memberId, 'identificationId');
		
		$("#updateIdentificationId").val(celValue);
		celValue = memberIdListGrid.jqGrid ('getCell', memberId, 'name');

		$("#updateName").val(celValue);
		$("#memberIdUpdateForm").submit();
	}
	
	function deleteMemberId(memberId) {
		//var memberIdListGrid = $('#list'),
		//selRows = memberIdListGrid.jqGrid('getGridParam','selarrrow');
		$("#deleteMemberId").val(memberId);
		$.prompt('刪除會員ID將一併刪除使用者，確定刪除?',{
			buttons:[
				{title: '是',value:true},
				{title: '否',value:false}
				], 
			submit: function(e,v,m,f){ 
				if(v){
					 $("#memberIdDeleteForm").submit();
				}
			}
		});
	}
	
	
</script>

</head>
<body leftmargin="8" topmargin="8">
	<table width="98%"  align="center" border="0">
		<tr>
			<td align="right" class='title'>
				<input type="button" class='mybutton' id="dlrbtn" value="新增"
					onclick="insertMemberId()">
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
	
	<form id="memberIdInsertForm" action="memberIdInsert.html" method="post">
	</form>
	
	<form id="memberIdUpdateForm" action="memberIdUpdate.html" method="post">
		<input id="updateMemberId" name="updateMemberId" type="hidden" />
		<input id="updateIdentificationId" name="updateIdentificationId" type="hidden" />
		<input id="updateName" name="updateName" type="hidden" />
	</form>
	
	<form id="memberIdDeleteForm" action="memberIdDelete.html" method="post">
		<input id="deleteMemberId" name="deleteMemberId" type="hidden" />
	</form>
</body>

</html>