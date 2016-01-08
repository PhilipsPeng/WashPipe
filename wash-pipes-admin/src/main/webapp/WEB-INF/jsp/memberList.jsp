<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<title>註冊會員列表</title>

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
			colNames : [ '會員ID', '姓名', '行動', 'Mail', '室內電話', '操作'],
			colModel : [ {
				name : 'id',
				index : 'id',
				width : 60,
				align : "center"
			}, {
				name : 'name',
				index : 'name',
				width : 50,
				align : "center"
			}, {
				name : 'mobile',
				index : 'mobile',
				width : 60,
				align : "center"
			}, {
				name : 'mail',
				index : 'mail',
				width : 90,
				align : "center"
			}, {
				name : 'phone',
				index : 'phone',
				width : 60,
				align : "center"
			} , {
				name : 'operation',
				index : 'operation',
				width : 80,
				align : "center"
			}],
			cmTemplate: { sortable: false },
			gridComplete : function() {
				var ids = jQuery("#list").jqGrid('getDataIDs');
				for ( var i = 0; i < ids.length; i++) {
					var cl = ids[i];
					var updateBtn = "<input  type='button' value='詳細資料' class='mybutton' onclick=\"memberDetail('"
						+ cl + "');\" />";
					var deleteBtn = "<input  type='button' value='刪除' class='mybutton' onclick=\"deleteMember('"
						+ cl + "');\" />";
					jQuery("#list").jqGrid('setRowData', ids[i], {
						operation : updateBtn + "&nbsp" + deleteBtn
					});
				}
			},
			caption : "註冊會員列表"
		}); 

	});
	
	function memberDetail(memberId) {
		$("#memberId").val(memberId);	
		$("#memberDetailForm").submit();			
	}
	
	function deleteMember(member) {
		//var memberIdListGrid = $('#list'),
		//selRows = memberIdListGrid.jqGrid('getGridParam','selarrrow');
		$("#deleteMemberId").val(member);
		$.prompt('確定刪除選擇的會員?',{
			buttons:[
				{title: '是',value:true},
				{title: '否',value:false}
				], 
			submit: function(e,v,m,f){ 
				if(v){
					 $("#memberDeleteForm").submit();
				}
			}
		});
	}
</script>

</head>
<body leftmargin="8" topmargin="8">
	<table width="98%"  align="center" border="0">
		<tr>
			
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
	
	<form id="memberDeleteForm" action="memberDelete.html" method="post">
		<input id="deleteMemberId" name="deleteMemberId" type="hidden" />
	</form>
	<form id="memberDetailForm" action="memberDetail.html" method="post">
		<input id="memberId" name="memberId" type="hidden" />
	</form>
</body>

</html>