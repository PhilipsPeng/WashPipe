	jQuery.validator.addMethod("memberIdIsExist", function(value, element, param) {
		var response='';
	    $.ajax({
	        type: "POST",
	        url: 'memberIdQuery.html',
	        data : {
	        	inputMemberId : value
			},
	        async:false,
	        success:function(data){
	            response = data;
	        }
	    });
	    if (response == 0) {
			return true;
		}else {
			return false;
		}
	}, "此會員ID已存在，請重新輸入");
	
	jQuery.validator.addMethod("memberIdCheck", function(value, element, param) {
		var response='';
	    $.ajax({
	        type: "POST",
	        url: 'memberIdQuery.html',
	        data : {
	        	inputMemberId : value
			},
	        async:false,
	        success:function(data){
	            response = data;
	        }
	    });
	    if (response > 0) {
			return true;
		}else {
			return false;
		}
	}, "請向你的上線索取你的會員ID");
	
	jQuery.validator.addMethod("memberCheck", function(value, element, param) {
		var response='';
	    $.ajax({
	        type: "POST",
	        url: 'memberQuery.html',
	        data : {
				inputMemberId : value
			},
	        async:false,
	        success:function(data){
	            response = data;
	        }
	    });
	    if (response > 0) {
			return false;
		}else {
			return true;
		}
	}, "此會員ID已註冊");
	
	jQuery.validator.addMethod("loginIdCheck", function(value, element, param) {
		var response='';
	    $.ajax({
	        type: "POST",
	        url: 'loginIdQuery.html',
	        data : {
	        	inputLoginId : value
			},
	        async:false,
	        success:function(data){
	            response = data;
	        }
	    });
	    if (response > 0) {
			return false;
		}else {
			return true;
		}
	}, "此登入ID已註冊");
	
	jQuery.validator.addMethod("TWIDCheck", function(value, element, param) {
		var a = new Array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K',
				'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'X', 'Y',
				'W', 'Z', 'I', 'O');
		var b = new Array(1, 9, 8, 7, 6, 5, 4, 3, 2, 1);
		var c = new Array(2);
		var d;
		var e;
		var f;
		var g = 0;
		var h = /^[a-z](1|2)\d{8}$/i;
		if (value.search(h) == -1) {
			return false;
		} else {
			d = value.charAt(0).toUpperCase();
			f = value.charAt(9);
		}
		for ( var i = 0; i < 26; i++) {
			if (d == a[i])//a==a
			{
				e = i + 10; //10
				c[0] = Math.floor(e / 10); //1
				c[1] = e - (c[0] * 10); //10-(1*10)
				break;
			}
		}
		for ( var i = 0; i < b.length; i++) {
			if (i < 2) {
				g += c[i] * b[i];
			} else {
				g += parseInt(value.charAt(i - 1)) * b[i];
			}
		}
		if ((g % 10) == f) {
			return true;
		}
		if ((10 - (g % 10)) != f) {
			return false;
		}
		return true; 
	}, "身份證格式不正確");
	
	jQuery.validator.addMethod("mailNumCheck", function(value, element, param) {
		if(value > 5)
			return false;
			
		return true;
		
	}, "最多為5封");
	
	$.validator.addMethod("selectProjectGroup", function(value, element, arg){
		  return arg != value;
	}, "請選擇文案群組");
	
	jQuery.validator.addMethod("projectGroupIsExist", function(value, element, param) {
		var response='';
	    $.ajax({
	        type: "POST",
	        url: 'projectGroupQuery.html',
	        data : {
	        	inputProjectGroupId : value
			},
	        async:false,
	        success:function(data){
	            response = data;
	        }
	    });
	    if (response > 0) {
			return false;
		}else {
			return true;
		}
	}, "此文案群組ID已存在");
