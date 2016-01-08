/* Copyright (C) 2011 Cloud.com, Inc.  All rights reserved. */
$(document).ready(function() {
	
  
  jQuery.validator.addMethod('prePaidAmount', 
		    function (value) {	  		
		        return Number(value) > 0;
		    }, i18n.errors.register.prePaidAmount); 

  var selectedMonth = $("#creditCardExpirationMonth option:selected").val();
  $("#creditCardExpirationMonth").change(function() {
	  selectedMonth=$("#creditCardExpirationMonth option:selected").val();
	  });
  jQuery.validator.addMethod("checkcardExp", function(value, element) {  
	  var month = "00";
		 if( selectedMonth !=''){
			 month = selectedMonth;
		 } 
		  var expDate =  month+ '/1/' + value;
		  var today =  new Date	();
		  return Date.parse(today) < Date.parse(expDate);	   
		
	}, i18n.errors.register.checkcardExp);
  
  jQuery.validator.addMethod("postalcode", function(postalcode, element, param) {
    if(param == 'US'){
      return this.optional(element) || postalcode.match(/(^\d{5}(-\d{4})?$)/);
    }  
    else if(param == 'CA'){
      return this.optional(element) || postalcode.match(/(^[ABCEGHJKLMNPRSTVXYabceghjklmnpstvxy]{1}\d{1}[A-Za-z]{1} ?\d{1}[A-Za-z]{1}\d{1})$/);
    }
    else {
     return this.optional(element) || postalcode.length > 0 &&  /^[a-zA-Z\d]+$/.test(postalcode);
    }  
  }, i18n.errors.register.postalcode);
  
  
  
  if($('#user\\.address\\.country').val()=='US' || $('#user\\.address\\.country').val() == 'CA' || 
		  $('#user\\.address\\.country').val() == 'AU'|| $('#user\\.address\\.country').val() == 'IN'|| $('#user\\.address\\.country').val() == 'JP'){
      $("#stateInput").hide();
      $("#user\\.address\\.country").defautlinkstates("#userAddressStateSelect"); 
      $("#userAddressStateSelect").val($('#user\\.address\\.state').val());
      if($('#user\\.address\\.country').val() == 'JP'){
    	  $("#otherstateDiv").hide();
    	  $("#JPstateDiv").show();
      }else{
        $("#otherstateDiv").show();
        $("#JPstateDiv").hide();
      }
      $("#stateSelect").show();
      
    }
    else { 
      $("#stateSelect").hide();
      $("#stateInput").show();
    }
  
  
  $("#user\\.address\\.country").change(function(){
	  	if($('#user\\.address\\.country').val()=='US' || $('#user\\.address\\.country').val() == 'CA' || 
	  			$('#user\\.address\\.country').val() == 'AU'|| $('#user\\.address\\.country').val() == 'IN' || $('#user\\.address\\.country').val() == 'JP'){
	      $("#stateInput").hide();
	      if($('#user\\.address\\.country').val() == 'JP'){
	    	  $("#otherstateDiv").hide();
	    	  $("#JPstateDiv").show();
	      }else{
	    	  $("#otherstateDiv").show();
	    	  $("#JPstateDiv").hide();
	      }
	      $("#stateSelect").show();
	      
	    }
	    else {
	      $("#stateSelect").hide();
	      $("#stateInput").show();
	    }
	    
  });
  
  $("#user\\.address\\.country").linkToStates("#userAddressStateSelect");
  
  $('#userAddressStateSelect').change(function(){
	    $('#user\\.address\\.state').val($('#userAddressStateSelect').val());
      $('#user\\.address\\.state').valid();
  }); 
  jQuery.validator.addMethod('validateState', 
		    function (value, element) {
	  		
	  		if(element.name == 'userAddressStateSelect'){
	  			var country =$('#user\\.address\\.country').val(); 
	  			 if  (country =='US' || country =='CA' || country =='AU' || country =='IN'|| country =='JP' ){
	  				 return value.length > 0;
	  			 } else {
	  				return true;
	  			 }

	  		} 
	  		return true;       	  
	    	
		    }, i18n.errors.register.validateState); 
  jQuery.validator.addMethod('validateUsername', 
      function (value, element) {
        return value.length > 0 &&  /^[a-zA-Z0-9_\.-]+$/.test(value);
  }, i18n.errors.register.user.validateUsername);
   
  var formValidator = $("#registrationForm").validate( {
    //debug : false,
    success : "valid",
    ignoreTitle : true,
    rules : {
      "user.firstName" : {
        required : true,
        flname:true
      },
      "user.lastName" : {
        required : true,
        flname:true
      },
      "user.email": {
    	  required : true,
    	  email : true
      } ,
      "confirmEmail": {
        required : true,
        email : true,
        equalTo : "#user\\.email"
      },      
      "user.username": {
    	  required : true,
    	  minlength : 5,
    	  validateUsername : true,
    	  remote : {
      	    url : '/portal/portal/validate_username'
          }
      },
      "trialCode": {
        required : true,
    	  remote : {
      	    url : '/portal/portal/validate_trialcode'
          }
      },
      "user.clearPassword": {
    	  required : true,
    	  password: true,
    	  notEqualTo : "#user\\.username"
      },
      "passwordconfirm" : {
        required: true,
        equalTo : "#user\\.clearPassword"
      },      
      "tenant.name" : {
        required: true
      },      
      "user.phone" : {
        required: true,
        phone: true
        },
      "countryCode" : {
        required: true,
        countryCode: true
        },        
      "userEnteredPhoneVerificationPin" : {
        required: true
        },        
      "acceptedTerms" : {
    	  required : true
      },
      
      "user.address.street1" : {
      	required: true
      },
      "user.address.city" : {
        	required: true
        },
      "user.address.state" : {
        	required: true
        },
      "user.address.postalCode" : {
        required: true,
        postalcode: function(){
          return $('#user\\.address\\.country').val();
        }
      },
      "user.address.country" : {
        required: true
      }, 
      "userAddressStateSelect" : {
    	  validateState:true
        
      }
    },
    messages: {
      "user.firstName": {
        required:i18n.errors.register.user.firstName,
        flname:i18n.errors.register.user.flnameValidationError
      },
      "user.lastName": {
        required:i18n.errors.register.user.lastName,
        flname:i18n.errors.register.user.flnameValidationError
      },
      "user.email": {
        required: i18n.errors.register.user.emailRequired,
        email: i18n.errors.register.user.email
      },
      "confirmEmail" : {
  	    required: i18n.errors.register.user.confirmEmail,
  	    email: i18n.errors.register.user.email,
	      equalTo: i18n.errors.register.user.confirmEmailEqualTo
      },
      "user.username": {
    	   required: i18n.errors.register.user.username,
         remote: i18n.errors.register.user.usernameRemote,
         minlength : i18n.errors.register.user.minLengthUsername,
         validateUsername : i18n.errors.register.user.validateUsername
      },
      "user.clearPassword" : {
        required: i18n.errors.register.user.clearPassword,
        password: i18n.errors.register.user.passwordValidationeError,
        notEqualTo: i18n.errors.register.user.passwordequsername
      },
      
      "passwordconfirm" : {
    	  required: i18n.errors.register.user.passwordConfirm,
    	  equalTo: i18n.errors.register.user.passwordConfirmEqualTo
      },
      "tenant.name" : {
          required: i18n.errors.register.tenant.name
      },
      "user.phone" : {
        required: i18n.errors.register.user.phone,
        phone: i18n.errors.register.user.phoneValidationError
      },
      "countryCode" : {
        required: i18n.errors.register.countryCode
      },      
      "userEnteredPhoneVerificationPin" : {
        required: i18n.errors.register.phonePin
      },      
      "trialCode": {
        remote: i18n.errors.register.trailCode
      },
      "acceptedTerms" : {
        required: i18n.errors.register.acceptedTerms
      },
      "user.address.street1" : {
          required:i18n.errors.register.user.address.street1
      }, 
      "user.address.city" : {
          required:i18n.errors.register.user.address.city
      },
      "user.address.state" : {
    	  required:i18n.errors.register.user.address.state
      },
      "user.address.postalCode" : {
        required: i18n.errors.register.user.address.postalCode,
        postalCode: i18n.errors.register.user.address.postalCode
      },
      "user.address.country" : {
        required:i18n.errors.register.user.address.country
      }
    },
    errorPlacement: function(error, element) { 
    	var name = element.attr('id');
    	name =ReplaceAll(name,".","\\.");  
    	if(error.html() !=""){
    		error.appendTo( "#"+name+"Error" );
    	}
    }
  });
  
  
  
  $(function() {
      $('#user\\.email, #confirmEmail, #user\\.clearPassword, #passwordconfirm').bind('cut copy paste', function(e) {
              e.preventDefault();              
          });
      });
  
  $("#backtouserinfo").click(function(event){
		  $("form").validate().cancelSubmit = true;
  });
	 
  $("#continuebutton").click(function(){
	  if($("#registrationForm").valid()){
		  $("#registrationForm").submit();
	  }
  });
  $("#registrationSubmit").click(function(){
    if(typeof(phoneVerificationEnabled) !="undefined" && phoneVerificationEnabled == true){
      var isPINVerified = verifyPIN();
      if(typeof(isPINVerified) =="undefined" || isPINVerified == false){
        return false;
      }
    }
	  if($("#registrationForm").valid()){
		  $("#registrationForm").submit();
	  }
  });

  $("#accountTypeSubmit").click(function(){
    $("#accountTypeForm").submit();
  });
  $(".accountype_selectbutton").click(function(){
    $("#account_type_select").val("");
    $("#account_type_select").val($(this).attr('id'));
    $("#accountTypeForm").submit();
  });
  
  
	var tncButtonCallBacks = {};
	tncButtonCallBacks[i18n.errors.register.tncDialog.buttons.ok] = function() {
            $(this).dialog('close');
          };
  $("#tncDialog").dialog( {          
    autoOpen : false,
    width : 400,
    modal : true,
    draggable: true,
    resizable: false,
    title : i18n.errors.register.tncDialog.title,
    open: function(event, ui) { $(".ui-dialog-titlebar-close").hide(); },
    buttons : tncButtonCallBacks
  });
  $("#tncLink a").click(function(){
    $("#tncDialog").dialog('open');
  });
  
  
  $("#phoneVerificationCall").click(function(){
    var phoneNumber = $("#user\\.phone").val();
    var countryCode = $("#countryCode").text();
    if (phoneNumber == "" || phoneNumber == null) {
      alert(i18n.errors.register.phoneDetails);
      return;
    }
    $("#phoneVerificationCall").html("<span class='call_icon'></span>"+i18n.labels.phoneVerificationCalling);

    var cntryCode = getOnlyNosFromThePhoneNoString(countryCode);
    var phoneNo = getOnlyNosFromThePhoneNoString(phoneNumber);
    $.ajax( {
      type : "GET",
      url : "/portal/portal/requestCall",
      data: {"phoneNumber":phoneNo,"countryCode":cntryCode},        
      dataType : "text/html",
      success : function(result) {
        if(result == "success"){
          alert(i18n.errors.register.callRequested);
        }else{
          alert(i18n.errors.register.callFailed);
        }
      },
      error : function (html) {
        alert(i18n.errors.register.callFailed);
      },
      complete: function(xhr,status){
        $("#phoneVerificationCall").html("<span class='call_icon'></span>"+i18n.labels.phoneVerificationCallMe);
      }
    });
  });
  
  $("#phoneVerificationSMS").click(function(){
    var phoneNumber = $("#user\\.phone").val();
    var countryCode = $("#countryCode").text();
    if (phoneNumber == "" || phoneNumber == null) {
      alert(i18n.errors.register.phoneDetails);
      return;
    }
    var cntryCode = getOnlyNosFromThePhoneNoString(countryCode);
    var phoneNo = getOnlyNosFromThePhoneNoString(phoneNumber);
    
    $("#phoneVerificationSMS").html("<span class='text_icon'></span>"+i18n.labels.phoneVerificationSending);
    $.ajax( {
      type : "GET",
      url : "/portal/portal/requestSMS",
      data: {"phoneNumber":phoneNo,"countryCode":cntryCode},        
      dataType : "text/html",
      success : function(result) {
        if(result == "success"){
          alert(i18n.errors.register.textMessageRequested);
        }else{
          alert(i18n.errors.register.textMessageFailed);
        }
      },
      error : function (html) {
        alert(i18n.errors.register.textMessageFailed);
      },
      complete: function(xhr,status){
        $("#phoneVerificationSMS").html("<span class='text_icon'></span>"+i18n.labels.phoneVerificationTextMe);
      }
    });
  });
  
  
 function verifyPIN(){
    $("#verificationStatusSuccess").hide();
    $("#verificationStatusFailed").hide();
    var phoneNumber = $("#user\\.phone").val();
    var userEnteredPIN = $("#userEnteredPhoneVerificationPin").val();
    if(typeof(phoneNumber) == "undefined" || phoneNumber == "" || typeof(userEnteredPIN) == "undefined" || userEnteredPIN == ""){
      $("#verificationStatusFailed").show();
      return false;
    }
    var nosInPhoneNoArray = phoneNumber.match(/\d+/g);
    var phoneNo = "";
    for ( var i=0; i<=nosInPhoneNoArray.length-1; i++ ){
      phoneNo += nosInPhoneNoArray[i];
    }
    var retVal = false;
    $.ajax( {
      type : "GET",
      url : "/portal/portal/phoneverification/verifyPIN",
      data: {"PIN":userEnteredPIN,"phoneNumber":phoneNo},        
      dataType : "text/html",
      async : false,
      success : function(result) {
        if(result == "success"){
          $("#verificationStatusSuccess").show();
          retVal =  true;
        }else{
          $("#verificationStatusFailed").show();
          retVal =  false;
        }
      },
      error : function (html) {
        $("#verificationStatusFailed").show();
        retVal =  false;
      }
    });
    return retVal;
  }  
});
