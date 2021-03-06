/* Copyright (C) 2011 Cloud.com, Inc.  All rights reserved. */
var CODE_NOT_UNIQUE_ERROR_CODE = 601;
var AJAX_FORM_VALIDATION_FAILED_CODE = 420;
var PAGINATION_PAGE_SIZE = 12;
var PAGINATION_CURRENT_PAGE_NUMBER = 1;

if (typeof String.prototype.trim !== 'function') {
  String.prototype.trim = function () {
    return this.replace(/^\s+|\s+$/g, '');
  };
}

jQuery.fn.extend({
  inputAutoTitles: function (options) {
    // stick all the titles
    this.find('input[type=text]').each(function (i) {
      var title = $(this).attr('title');
      if ($(this).val() == '') {
        $(this).val(title).addClass('waiting').blur(function () {
          $(this).removeClass('active');
          if ($(this).val() == '' || $(this).val() == title) $(this).addClass('waiting').val(title);
        }).focus(function () {
          $(this).removeClass('waiting').addClass('active');
          if ($(this).val() == title) $(this).val('');
        });
        //
      } else {
        $(this).unbind('click');
      }
    });
    // clear the titles on submit
    $(this).submit(function () {
      $(this).find('[type=text]').each(function (i) {
        if ($(this).attr('title') == $(this).val()) $(this).val('');
      });
    });
  }
});

jQuery.validator.addMethod("password", function (value, element) {
  return this.optional(element) || value.length >= 8 && /\d/.test(value) && /[A-Z]/.test(value);
}, "8 characters, one number and one uppercase character required.");

jQuery.validator.addMethod("notEqualTo", function (value, element, param) {
  return (value != $(param).val());
}, "equal");

jQuery.validator.addMethod('noSpacesAllowed', function (value, element) {
  return value.length > 0 && /^[a-zA-Z0-9_:\[\]-]+$/.test(value);
}, "Only characters, digits and special symbols : - _ ] [ are allowed.");

$.validator.addMethod("xRemote", function (value, element) {
  var rule = this.settings.rules[element.name].xRemote;
  if (rule.condition && $.isFunction(rule.condition) && !rule.condition.call(this, element)) return "dependency-mismatch";
  return $.validator.methods.remote.apply(this, arguments);
}, "Code already in use");

jQuery.validator.addMethod("phone", function(value, element) {
	return this.optional(element) || value.length > 0 &&  /^[\d(][\d()\-\. ]*$/.test(value);
}, "Only numbers, parantheses, dots and dashes are allowed.");

jQuery.validator.addMethod("countryCode", function(value, element) {
	return this.optional(element) || value.length > 0 &&  /^[\d+][\d]*$/.test(value);
}, "A country code can start with a + or a number, followed by numbers only.");

jQuery.validator.addMethod("flname", function (value, element) {
  return this.optional(element) || value.length > 0 && /^[^\d\.,\/#$%\^&\*;:{}=_`~()!]+$/.test(value);
}, "Only characters and special symbols ' - are allowed.");

jQuery.validator.setDefaults({
  submitHandler: function (form) {
    var submit = $(form).find(".submitmsg");
    if ($(submit).attr("rel") != null && $(submit).attr("rel") != "") {
      $(submit).attr("value", $(submit).attr("rel"));
      $(submit).attr("disabled", true);
    }
    if ($(form).hasClass("ajaxform") == false) {
      form.submit();
    }
  }
});


$.ajaxSetup({
  contentType: "application/x-www-form-urlencoded;charset=utf8",
  complete: function (xhr, status) {
    if (xhr.status == 401) {
      window.location = "/portal/portal/login?timeout";
    }
  }
});



$(document).ready(function () {
  $(".welcomeuser_panel").hover(function () {
    $("#welcome_menu").parent().removeClass("welcomebox_sideicon");
    $("#welcome_menu").parent().addClass("welcomebox_dropdown_arrow");
    $("#welcome_menu").show();
  }, function () {
    $("#welcome_menu").parent().addClass("welcomebox_sideicon");
    $("#welcome_menu").parent().removeClass("welcomebox_dropdown_arrow");
    $("#welcome_menu").hide();
  });

  if ($('.grid_content').length > 0) {
    $(".smallrow_odd, .smallrow_even").hover(function () {
      $(this).find('.grid_links_container').show();
    }, function () {
      $(this).find('.grid_links_container').hide();
    });
  }

});

// Don't allow pages to be loaded in a frame.
if (top.location != location) {
  top.location.href = document.location.href;
}

function getCurrentPageData(current, currentPage, size, url) {

  var perPage = $("#perPage").val();
  var url = url + "currentPage=" + currentPage + "&perPage=" + perPage + "&size=" + size;
  $(current).attr("href", url);

  return true;


}

function ReplaceAll(Source, stringToFind, stringToReplace) {
  var tempArr = Source.split(stringToFind);
  var dest = "";
  for (var i = 0; i < tempArr.length; i++) {
    if (dest == "") {
      dest = tempArr[i];
    } else {
      dest = dest.concat(stringToReplace);
      dest = dest.concat(tempArr[i]);
    }
  }
  return dest;
}

//Prevent cross-site-script(XSS) attack. 


function sanitizeXSS(val) {
  if (val == null || typeof (val) != "string") return val;
  val = val.replace(/</g, "&lt;"); //replace < whose unicode is \u003c     
  val = val.replace(/>/g, "&gt;"); //replace > whose unicode is \u003e  
  return val;
}

function noNull(val) {
  if (val == null) return "";
  else return val;
}

function fromdb(val) {
  return sanitizeXSS(noNull(val));
}

function todb(val) {
  return encodeURIComponent(val);
}

function getVmName(p_vmName, p_vmDisplayname) {
  if (p_vmDisplayname == null) return fromdb(p_vmName);
  var vmName = null;

  if (p_vmDisplayname != p_vmName) {
    vmName = p_vmName + "(" + fromdb(p_vmDisplayname) + ")";
  } else {
    vmName = p_vmName;
  }

  return vmName;
}

function setBooleanReadField(value, $field) {
  if (value == "true" || value == true) $field.text(g_dictionary.yes).show();
  else if (value == "false" || value == false) $field.text(g_dictionary.no).show();
  else $field.hide();
}

function setBooleanEditField(value, $field) {
  if (value == true) $field.val("true"); //option value, not option displayText, so no localization
  else // value == false
  $field.val("false"); //option value, not option displayText, so no localization   
}

function convertBytes(bytes) {
  if (bytes < 1024 * 1024) {
    return (bytes / 1024).toFixed(2) + " KB";
  } else if (bytes < 1024 * 1024 * 1024) {
    return (bytes / 1024 / 1024).toFixed(2) + " MB";
  } else if (bytes < 1024 * 1024 * 1024 * 1024) {
    return (bytes / 1024 / 1024 / 1024).toFixed(2) + " GB";
  } else {
    return (bytes / 1024 / 1024 / 1024 / 1024).toFixed(2) + " TB";
  }
}

function convertHz(hz) {
  if (hz == null) return "";

  if (hz < 1000) {
    return hz + " MHZ";
  } else {
    return (hz / 1000).toFixed(2) + " GHZ";
  }
}



//Validation functions


function showError(isValid, field, errMsgField, errMsg) {
  if (isValid) {
    errMsgField.text("").hide();
    field.addClass("text").removeClass("error_text");
  } else {
    errMsgField.text(errMsg).show();
    field.removeClass("text").addClass("error_text");
  }
}

function showError2(isValid, field, errMsgField, errMsg, appendErrMsg) {
  if (isValid) {
    errMsgField.text("").hide();
    field.addClass("text2").removeClass("error_text2");
  } else {
    if (appendErrMsg) //append text
    errMsgField.text(errMsgField.text() + errMsg).show();
    else //reset text
    errMsgField.text(errMsg).show();
    field.removeClass("text2").addClass("error_text2");
  }
}

function showErrorInDropdown(isValid, field, errMsgField, errMsg, appendErrMsg) {
  if (isValid) {
    errMsgField.text("").hide();
    field.addClass("select").removeClass("error_select");
  } else {
    if (appendErrMsg) //append text
    errMsgField.text(errMsgField.text() + errMsg).show();
    else //reset text
    errMsgField.text(errMsg).show();
    field.removeClass("select").addClass("error_select");
  }
}

function validateDropDownBox(label, field, errMsgField, appendErrMsg) {
  var isValid = true;
  var errMsg = "";
  var value = field.val();
  if (value == null || value.length == 0) {
    errMsg = g_dictionary.required;
    isValid = false;
  }
  showErrorInDropdown(isValid, field, errMsgField, errMsg, appendErrMsg);
  return isValid;
}

function validateInteger(label, field, errMsgField, min, max, isOptional) {
  return validateNumber(label, field, errMsgField, min, max, isOptional, "integer");
}

function validateNumber(label, field, errMsgField, min, max, isOptional, type) {
  var isValid = true;
  var errMsg = "";
  var value = field.val();

  if (value != null && value.length != 0) {
    if (isNaN(value)) {
      errMsg = g_dictionary.invalidNumber;
      isValid = false;
    } else {
      if (type == "integer" && (value % 1) != 0) {
        errMsg = g_dictionary.invalidInteger;
        isValid = false;
      }

      if (min != null && value < min) {
        errMsg = g_dictionary.minimum + ": " + min;
        isValid = false;
      }
      if (max != null && value > max) {
        errMsg = g_dictionary.maximum + ": " + max;
        isValid = false;
      }
    }
  } else if (isOptional != true) { //required field
    errMsg = g_dictionary.required;
    isValid = false;
  }
  showError(isValid, field, errMsgField, errMsg);
  return isValid;
}

function validateString(label, field, errMsgField, isOptional, maxLength) {
  var isValid = true;
  var errMsg = "";
  var value = field.val();
  if (isOptional != true && (value == null || value.length == 0)) { //required field   
    errMsg = g_dictionary.required;
    isValid = false;
  } else if (value != null && value.length >= maxLength) {
    errMsg = g_dictionary.maximum + ": " + max + " character";
    isValid = false;
  } else if (value != null && value.indexOf('"') != -1) {
    errMsg = g_dictionary.doubleQuotesNotAllowed;
    isValid = false;
  }
  showError(isValid, field, errMsgField, errMsg);
  return isValid;
}

function validateEmail(label, field, errMsgField, isOptional) {
  if (validateString(label, field, errMsgField, isOptional) == false) return;
  var isValid = true;
  var errMsg = "";
  var value = field.val();
  if (value != null && value.length > 0) {
    myregexp = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    var isMatch = myregexp.test(value);
    if (!isMatch) {
      errMsg = g_dictionary.example + ": " + "xxxxxxx@hotmail.com";
      isValid = false;
    }
  }
  showError(isValid, field, errMsgField, errMsg);
  return isValid;
}

function validateNetmask(label, field, errMsgField, isOptional) {  
  if(validateString(label, field, errMsgField, isOptional) == false)
      return;
  var isValid = true;
  var errMsg = "";
  var value = field.val();            
  if(value!=null && value.length>0) {
      myregexp = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;     
      var isMatch = myregexp.test(value);
      if(!isMatch) {            
          errMsg = g_dictionary["label.example"] + ": 255.255.255.0";
        isValid = false;    
    }
  }   
  showError(isValid, field, errMsgField, errMsg); 
  return isValid;
}

function validateIp(label, field, errMsgField, isOptional) {
  if (validateString(label, field, errMsgField, isOptional) == false) return;
  var isValid = true;
  var errMsg = "";
  var value = field.val();
  if (value != null && value.length > 0) {
    myregexp = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
    var isMatch = myregexp.test(value);
    if (!isMatch) {
      errMsg = g_dictionary.example + ": " + "75.52.126.11";
      isValid = false;
    }
  }
  showError(isValid, field, errMsgField, errMsg);
  return isValid;
}

function validateCIDR(label, field, errMsgField, isOptional) {
  if (validateString(label, field, errMsgField, isOptional) == false) return;
  var isValid = true;
  var errMsg = "";
  var value = field.val();
  if (value != null && value.length > 0) {
    myregexp = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/\d{1,2}$/;
    var isMatch = myregexp.test(value);
    if (!isMatch) {
      isValid = false;
    }
  }
  showError(isValid, field, errMsgField, errMsg);
  return isValid;
}

function validateCIDRList(label, field, errMsgField, isOptional) {
  if (validateString(label, field, errMsgField, isOptional) == false) return;
  var isValid = true;
  var errMsg = "";
  var cidrList = field.val();

  var array1 = cidrList.split(",");
  for (var i = 0; i < array1.length; i++) {
    var value = array1[i];
    if (value != null && value.length > 0) {
      myregexp = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/\d{1,2}$/;
      var isMatch = myregexp.test(value);
      if (!isMatch) {
        isValid = false;
      }
    }
  }
  if (isValid == false) errMsg = g_dictionary.example + ": 10.1.1.1/24,10.1.1.2/24";

  showError(isValid, field, errMsgField, errMsg);
  return isValid;
}

function validateAlphanumeric(label, field, errMsgField, isOptional, allowedSplCharacters) {
  if (validateString(label, field, errMsgField, isOptional) == false) return;
  var isValid = true;
  var errMsg = "";
  var value = field.val();
  if (value != null && value.length > 0) {
    if (allowedSplCharacters != undefined && allowedSplCharacters.length > 0) { //Replacing Spl Characters with an Empty String as these spl characters like "-" etc are allowed along with Alphanumeric characters.
      value = value.replace(new RegExp("[" + allowedSplCharacters.join('') + "]", "g"), "");
    }
    if (alphanumericRegexp.test(value) == false) {
      errMsg = dictionary.onlyAlphanumericCharactersAreAllowed;
      isValid = false;
    }
  }
  showError(isValid, field, errMsgField, errMsg);
  return isValid;
}

function validatePath(label, field, errMsgField, isOptional) {
  if (validateString(label, field, errMsgField, isOptional) == false) return;
  var isValid = true;
  var errMsg = "";
  var value = field.val();
  if (value != null && value.length > 0) {
    myregexp = /^\//;
    var isMatch = myregexp.test(value);
    if (!isMatch) {
      errMsg = label + g_dictionary.example + ": " + "/aaa/bbb/ccc";
      isValid = false;
    }
  }
  showError(isValid, field, errMsgField, errMsg);
  return isValid;
}

function cleanErrMsg(field, errMsgField) {
  showError(true, field, errMsgField);
}


var keycode_Enter = 13;

var cloudStackLoginResponse, cloudStackSessionKey, cloudStackRole, cloudStackDomainid, cloudStackAccount, userTimeZoneOffset, cloudStackSupportELB, cloudStackFirewallRuleUiEnabled;

var cloudStackUserPublicTemplateEnabled = "true";

function getUserPublicTemplateEnabled() {
  return cloudStackUserPublicTemplateEnabled;
}

var cloudStackDirectAttachSecurityGroupsEnabled = "false";

function getDirectAttachSecurityGroupsEnabled() {
  return cloudStackDirectAttachSecurityGroupsEnabled;
}

function connectToCloudStack(tenantParam) {
  var returnVal = true;
  var url = "/portal/portal/dashboard/manageresource/getSSOCmdString";
  if (tenantParam != null && tenantParam != "") {
    url = url + "?tenant=" + tenantParam;
  }
  $.ajax({
    type: "GET",
    url: url,
    async: false,
    dataType: "text",
    success: function (ssoCmdString) {
      if (ssoCmdString.length > 0) {
        $.ajax({
          //type: "POST",
          type: "GET",
          url: "/portal/client/api",
          data: ssoCmdString,
          dataType: "json",
          async: false,
          success: function (json) {
            cloudStackLoginResponse = json.loginresponse;
            cloudStackSessionKey = encodeURIComponent(json.loginresponse.sessionkey);
            cloudStackRole = json.loginresponse.type;
            cloudStackDomainid = json.loginresponse.domainid;
            cloudStackAccount = json.loginresponse.account;
            if (tenantParam != null) {
              $.ajax({
                url: "/portal/portal/users/userTimezoneOffset?tenant=" + tenantParam,
                dataType: "text",
                async: false,
                success: function (response) {
                  userTimeZoneOffset = response;
                }
              });
            }

            $.ajax({
              url: cloudStackURL("command=listCapabilities"),
              dataType: "json",
              async: false,
              success: function (json) {
                if (json.listcapabilitiesresponse.capability.supportELB != null) {
                  cloudStackSupportELB = json.listcapabilitiesresponse.capability.supportELB.toString();
                }
                if (json.listcapabilitiesresponse.capability.firewallRuleUiEnabled != null) {
                  cloudStackFirewallRuleUiEnabled = json.listcapabilitiesresponse.capability.firewallRuleUiEnabled.toString();
                }
                if (json.listcapabilitiesresponse.capability.userpublictemplateenabled != null) {
                  cloudStackUserPublicTemplateEnabled = json.listcapabilitiesresponse.capability.userpublictemplateenabled.toString();
                }
                if (json.listcapabilitiesresponse.capability.securitygroupsenabled != null) {
                  cloudStackDirectAttachSecurityGroupsEnabled = json.listcapabilitiesresponse.capability.securitygroupsenabled.toString();
                }
              }
            });
          }
        });
      } else {
        returnVal = false;
      }
    }
  });
  return returnVal;
}

function getCloudAccount() {
  var b = false;
  $.ajax({
    type: "GET",
    url: "/portal/portal/dashboard/manageresource/getCloudAccount",
    async: false,
    dataType: "text",
    success: function (response) {
      b = true;
    }
  });
  return b;
}

function cloudStackURL(commandString) {
  return "/portal/client/api?" + commandString + "&response=json&tenant=" + effectiveTenantParam;
}

var $currentGridRow;

function clickAnotherGridRow($thisGridRow) {
  if ($currentGridRow != null && $currentGridRow != $thisGridRow) $currentGridRow.removeClass("selected active");
  if ($thisGridRow.hasClass("selected") == false) $thisGridRow.addClass("selected active");
  $currentGridRow = $thisGridRow;

  $("body").stopTime();

  //action links at bottom (begin)
  $("#top_actions").find("#spinning_wheel").hide();
  $("#action_result_panel").find("#msg").text("");
  $("#action_result_panel").removeClass("error").addClass("success").hide();
  cancelActionPanel(currentSelectedActionLink); //collapse expanded action panel
  //$("#cancel_link").click(); //cancel Edit mode
  //action links at bottom (end)
  //action buttons on top (begin)    
  var $spinningWheel = $("#top_actions").find("#spinning_wheel");
  $spinningWheel.find("#in_process_text").text("");
  $spinningWheel.hide();
  $("#top_message_panel").find("#msg").text("");
  $("#top_message_panel").removeClass("error").addClass("success").hide();
  
  //action buttons on top (end)
}

function clickTopActionLink() {
  if ($currentGridRow == null || ($currentGridRow.hasClass("selected") == true && $currentGridRow.hasClass("active") == true)) $currentGridRow.removeClass("selected active");
}

function cancelTopActionLink() {
  if ($currentGridRow != null && $currentGridRow.hasClass("selected") == false && $currentGridRow.hasClass("active") == false) $currentGridRow.addClass("selected active");
}

//action links at bottom (begin)


function initActionLinks(actionMap, refreshGridRowFn, refreshDetailsPanelFn) {
  for (var i = 0; i < actionMap.length; i++) {
    bindToActionLink(actionMap[i], refreshGridRowFn, refreshDetailsPanelFn);
  }
}

var currentSelectedActionLink = null;

function clickActionLink(elementIdPrefix, actionLinkOnClickFn) {
	if(actionLinkOnClickFn != null)
		actionLinkOnClickFn();		
	cancelActionPanel(currentSelectedActionLink);
	currentSelectedActionLink = elementIdPrefix;
	$("#"+elementIdPrefix+"_link").hide();
	$("#"+elementIdPrefix+"_text").show();
	$("#action_result_panel").hide();
	$("#top_message_panel").hide();
	$("#"+elementIdPrefix+"_panel").show();	
}

function cancelActionPanel(elementIdPrefix, actionLinkOnCancelFn) {
  if (elementIdPrefix == null) return;
  if (actionLinkOnCancelFn != null) actionLinkOnCancelFn();
  $("#" + elementIdPrefix + "_text").hide();
  $("." + elementIdPrefix + "_link").show();
  $("#" + elementIdPrefix + "_panel").hide();
  if (currentSelectedActionLink == elementIdPrefix) currentSelectedActionLink = null;
}

function bindToActionLink(mapObj, refreshGridRowFn, refreshDetailsPanelFn) {
  $("." + mapObj.elementIdPrefix + "_link").unbind("click").bind("click", function (event) {
    clickActionLink(mapObj.elementIdPrefix, mapObj.actionLinkOnClickFn);
    return false;
  });

  $("#" + mapObj.elementIdPrefix + "_panel").find("#cancel_button").unbind("click").bind("click", function (event) {
    $("#" + mapObj.elementIdPrefix + "_panel").find(".agree input[type=checkbox]#accept_checkbox").removeAttr("checked");
    cancelActionPanel(mapObj.elementIdPrefix, mapObj.actionLinkOnCancelFn);
    return false;
  });

  $("#" + mapObj.elementIdPrefix + "_panel").find("#confirm_button").unbind("click").bind("click", function (event) {
    if ($currentGridRow.data("jsonObj") == null) return false;

    var actionUrl1 = mapObj.getActionUrlFn();
    if (actionUrl1 == null) return false;

    $("#" + mapObj.elementIdPrefix + "_text").hide();
    $("." + mapObj.elementIdPrefix + "_link").show();
    $("#" + mapObj.elementIdPrefix + "_panel").hide();
    $("#action_link_container").find("#spinning_wheel").show();

    if (mapObj.isAsync == true) {
      $.ajax({
        type: "GET",
        url: actionUrl1,
        async: false,
        dataType: "json",
        success: function (obj) {
          var property;
          for (property in obj) {};
          var jobId = obj[property].jobid;
          if (jobId == null) return;
          var timerKey = "vmAction" + jobId;

          // Process the async job
          $("body").everyTime(
          5000, timerKey, function () {
            var actionUrl2 = cloudStackURL("command=queryAsyncJobResult&jobId=" + jobId);
            $.ajax({
              type: "GET",
              url: actionUrl2,
              dataType: "json",
              success: function (json) {
                var result = json.queryasyncjobresultresponse;
                if (result.jobstatus == 0) {
                  return; //Job has not completed
                } else {
                  $("body").stopTime(timerKey);
                  $("#action_link_container").find("#spinning_wheel").hide();
                  if (result.jobstatus == 1) {
                    // Succeeded  
                    var property;
                    for (property in result.jobresult) {}; //e.g. property == "virtualmachine", "volume", "success"   
                    var item4 = result.jobresult[property]; //item4 might be an object or true/"true" (if property is "success")                      
                    if (typeof (item4) != "object") {
                      if ((property == "success") && ((typeof (item4) == "string" && item4 == "true") || (typeof (item4) == "boolean" && item4 == true))) {
                        $currentGridRow.click();

                        var msg;
                        if (mapObj.afterActionSeccessFn != null) {
                          msg = mapObj.afterActionSeccessFn(item4); //item4 might be an object or true/"true". e.g. { "deletevolumeresponse" : { "success" : "true"}  }
                        }
                        if (msg == null) {
                          var actionlabel = $("." + mapObj.elementIdPrefix + "_link").find("a").text();
                          msg = actionlabel + " " + g_dictionary.succeeded;
                        }

                        $("#action_result_panel").find("#msg").html(msg);
                        $("#action_result_panel").find("#status_icon").removeClass("erroricon").addClass("successicon");
                        $("#action_result_panel").removeClass("error").addClass("success").show();
                      }
                      return;
                    }

                    if ($currentGridRow.data("jsonObj") == null) return;

                    var idPropertyName = null;
                    if (mapObj.returnedObjectId != null) {
                      if (mapObj.returnedObjectId != "NoReturnedObjectId") idPropertyName = mapObj.returnedObjectId;
                      else idPropertyName = null;
                    } else {
                      idPropertyName = "id";
                    }

                    if ((idPropertyName == null) || (item4[idPropertyName] == $currentGridRow.data("jsonObj").id)) {
                      var msg;
                      if (mapObj.afterActionSeccessFn != null) {
                        msg = mapObj.afterActionSeccessFn(item4); //item4 might be an object or true/"true". e.g. { "deletevolumeresponse" : { "success" : "true"}  }
                      }
                      if (msg == null) {
                        var actionlabel = $("." + mapObj.elementIdPrefix + "_link").find("a").text();
                        msg = actionlabel + " " + g_dictionary.succeeded;
                      }

                      $("#action_result_panel").find("#msg").html(msg);
                      $("#action_result_panel").find("#status_icon").removeClass("erroricon").addClass("successicon");
                      $("#action_result_panel").removeClass("error").addClass("success").show();

                      refreshGridRowFn(item4, $currentGridRow);

                      //$currentGridRow.click();  
                      refreshDetailsPanelFn($currentGridRow);
                    }
                  } else if (result.jobstatus == 2) {
                    // Failed 
                    var actionlabel = $("." + mapObj.elementIdPrefix + "_link").find("a").text();
                    var msg = actionlabel + " " + g_dictionary.actionFailed;
                    if (result.jobresult.errortext != null && result.jobresult.errortext.length > 0) msg += (" - " + fromdb(result.jobresult.errortext));
                    $("#action_result_panel").find("#msg").text(msg);
                    $("#action_result_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
                    $("#action_result_panel").removeClass("success").addClass("error").show();
                  }
                }
              },
              error: function (response) {
                $("body").stopTime(timerKey);
                $("#action_link_container").find("#spinning_wheel").hide();
                $("#action_result_panel").find("#msg").text(g_dictionary.errorFromAPICall + ": " + actionUrl2);
                $("#action_result_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
                $("#action_result_panel").removeClass("success").addClass("error").show();
              }
            });
          }, 0);
        },
        error: function (XMLHttpResponse) {
          $("#action_link_container").find("#spinning_wheel").hide();

          var errorMsg = "";
          if (XMLHttpResponse.responseText != null & XMLHttpResponse.responseText.length > 0) errorMsg = parseXMLHttpResponse(XMLHttpResponse);

          var actionlabel = $("." + mapObj.elementIdPrefix + "_link").find("a").text();
          var msg = actionlabel + " " + g_dictionary.actionFailed;
          if (errorMsg.length > 0) msg += (" " + errorMsg);
          else msg += (" " + g_dictionary.errorFromAPICall + ": " + actionUrl1);
          $("#action_result_panel").find("#msg").text(msg);
          $("#action_result_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
          $("#action_result_panel").removeClass("success").addClass("error").show();
        }
      });
    } else { // sync      
      $.ajax({
        type: "GET",
        url: actionUrl1,
        async: false,
        dataType: "json",
        success: function (obj1) {
          if (typeof (obj1) != "object") return;
          var propertyInObj1;
          for (propertyInObj1 in obj1) {}; //e.g. propertyInObj1 == "updatevirtualmachineresponse"
          var obj2 = obj1[propertyInObj1];
          if (typeof (obj2) != "object") return;
          var propertyInObj2;
          for (propertyInObj2 in obj2) {}; //e.g. propertyInObj2 == "virtualmachine"
          var item3 = obj2[propertyInObj2]; //item3 might be an object or a string "success". e.g. { "deletevolumeresponse" : { "success" : "true"}  }
          $("#action_link_container").find("#spinning_wheel").hide();

          var msg;
          if (mapObj.afterActionSeccessFn != null) {
            msg = mapObj.afterActionSeccessFn(item3); //item3 might be an object or a string "success". e.g. { "deletevolumeresponse" : { "success" : "true"}  }
          }
          if (msg == null) {
            var actionlabel = $("." + mapObj.elementIdPrefix + "_link").find("a").text();
            msg = actionlabel + " " + g_dictionary.succeeded;
          }

          $("#action_result_panel").find("#msg").text(msg);
          $("#action_result_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
          $("#action_result_panel").removeClass("error").addClass("success").show();

          if (typeof (item3) == "object") {
            refreshGridRowFn(item3, $currentGridRow);
            //$currentGridRow.click();  
            refreshDetailsPanelFn($currentGridRow);
          }

          if ((propertyInObj2 == "success") && ((typeof (item3) == "string" && item3 == "true") || (typeof (item3) == "boolean" && item3 == true))) {
            $currentGridRow.click(); //this will hide action_result_panel 
            $("#action_result_panel").find("#msg").text(msg);
            $("#action_result_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
            $("#action_result_panel").removeClass("error").addClass("success").show(); //so, show action_result_panel (again)           
          }
        },
        error: function (obj1) {
          $("#action_link_container").find("#spinning_wheel").hide();

          var actionlabel = $("." + mapObj.elementIdPrefix + "_link").find("a").text();
          var msg = actionlabel + " " + g_dictionary.actionFailed;
          $("#action_result_panel").find("#msg").text(msg);
          $("#action_result_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
          $("#action_result_panel").removeClass("success").addClass("error").show();
        }
      });
    }
    return false;
  });
}
//action links at bottom (end)

//top buttons (begin)


function doActionButton(actionMapItem, apiCommand) {
  var label = actionMapItem.label;
  var inProcessText = actionMapItem.inProcessText;

  var isAsyncJob = actionMapItem.isAsyncJob;
  var asyncJobResponse = actionMapItem.asyncJobResponse;
  var afterActionSeccessFn = actionMapItem.afterActionSeccessFn;

  var $spinningWheel = $("#top_actions").find("#spinning_wheel");
  $spinningWheel.find("#in_process_text").text(inProcessText);
  $spinningWheel.show();

  $("#top_message_panel").find("#msg").text("");
  $("#top_message_panel").hide();
  
  $("#action_result_panel").find("#msg").text("");
  $("#action_result_panel").hide();

  //Async job (begin) *****
  if (isAsyncJob == true) {
    $.ajax({
      cache:false,
      type: 'Get',
      url: apiCommand,
      dataType: "json",
      success: function (json) {
        var jobId = json[asyncJobResponse].jobid;
        var timerKey = "asyncJob_" + jobId;

        $("body").everyTime(
        10000, timerKey, function () {
          $.ajax({
            cache: false,
            url: cloudStackURL("command=queryAsyncJobResult&jobId=" + jobId),
            dataType: "json",
            success: function (json) {
              var result = json.queryasyncjobresultresponse;
              if (result.jobstatus == 0) {
                return; //Job has not completed
              } else {
                $("body").stopTime(timerKey);
                $spinningWheel.hide();

                if (result.jobstatus == 1) { // Succeeded     
                  var msg;
                  if (actionMapItem.afterActionSeccessFn != null) msg = actionMapItem.afterActionSeccessFn(json);
                  if (msg == null) msg = label + " " + g_dictionary.succeeded;
                  $("#top_message_panel").find("#msg").text(msg);
                  $("#top_message_panel").find("#status_icon").removeClass("erroricon").addClass("successicon");
                  $("#top_message_panel").removeClass("error").addClass("success").show();

                } else if (result.jobstatus == 2) { // Failed                                   
                  $("#top_message_panel").find("#msg").text(label + " " + g_dictionary.actionFailed + " - " + fromdb(result.jobresult.errortext));
                  $("#top_message_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
                  $("#top_message_panel").removeClass("success").addClass("error").show();
                }
              }
            },
            error: function (XMLHttpResponse) {
              $("body").stopTime(timerKey);
              $spinningWheel.hide();
              $("#top_message_panel").find("#msg").text(label + " " + g_dictionary.actionFailed);
              $("#top_message_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
              $("#top_message_panel").removeClass("success").addClass("error").show();
              if (actionMapItem.afterActionFailureFn != null) {
                actionMapItem.afterActionFailureFn(label + " " + g_dictionary.actionFailed);
              }
            }
          });
        }, 0);
      },
      error: function (XMLHttpResponse) {
        $spinningWheel.hide();
        $("#top_message_panel").find("#msg").text(label + " " + g_dictionary.actionFailed);
        $("#top_message_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
        $("#top_message_panel").removeClass("success").addClass("error").show();
        if (actionMapItem.afterActionFailureFn != null) {
          actionMapItem.afterActionFailureFn(label + " " + g_dictionary.actionFailed);
        }
      }
    });
  }
  //Async job (end) *****
  //Sync job (begin) *****
  else {
    $.ajax({
      type: 'Get',
      cache: false,
      url: apiCommand,
      dataType: "json",
      async: false,
      success: function (json) {
        var msg;
        if (actionMapItem.afterActionSeccessFn != null) msg = actionMapItem.afterActionSeccessFn(json);
        if (msg == null) msg = label + " " + g_dictionary.succeeded;
        $spinningWheel.hide();
        $("#top_message_panel").find("#msg").text(msg);
        $("#top_message_panel").find("#status_icon").removeClass("erroricon").addClass("successicon");
        $("#top_message_panel").removeClass("error").addClass("success").show();
      },
      error: function (XMLHttpResponse) {
        $spinningWheel.hide();
        $("#top_message_panel").find("#msg").text(label + " " + g_dictionary.actionFailed);
        $("#top_message_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
        $("#top_message_panel").removeClass("success").addClass("error").show();
        if (actionMapItem.afterActionFailureFn != null) {
          actionMapItem.afterActionFailureFn(label + " " + g_dictionary.actionFailed);
        }
      }
    });
  }
  //Sync job (end) *****
}

function bindActionMenuContainers() {
  $(".action_menu_container").each(function (i, ele) {
    var $ele = $(ele);

    $ele.bind("mouseover", function (event) {
      $(this).find("#action_menu").show();
      return false;
    });
    $ele.bind("mouseout", function (event) {
      var $thisElement = $(this)[0];
      var relatedTarget1 = event.relatedTarget;
      while (relatedTarget1 != null && relatedTarget1.nodeName != "BODY" && relatedTarget1 != $thisElement) {
        relatedTarget1 = relatedTarget1.parentNode;
      }
      if (relatedTarget1 == $thisElement) {
        return;
      }

      $(this).find("#action_menu").hide();
      return false;
    });
  });
}

//top buttons (end)

//XMLHttpResponse.status
var ERROR_ACCESS_DENIED_DUE_TO_UNAUTHORIZED = 401;
var ERROR_INTERNET_NAME_NOT_RESOLVED = 12007;
var ERROR_INTERNET_CANNOT_CONNECT = 12029;
var ERROR_VMOPS_ACCOUNT_ERROR = 531;

function handleError(XMLHttpResponse, handleErrorCallback) {
  // User Not authenticated
  if (XMLHttpResponse.status == ERROR_ACCESS_DENIED_DUE_TO_UNAUTHORIZED) {
    alert("CloudStack - Your session has expired.");
    //$("#dialog_session_expired").dialog("open");
  } else if (XMLHttpResponse.status == ERROR_INTERNET_NAME_NOT_RESOLVED) {
    alert("CloudStack - Your internet name cannot be resolved.");
    //$("#dialog_error_internet_not_resolved").dialog("open");
  } else if (XMLHttpResponse.status == ERROR_INTERNET_CANNOT_CONNECT) {
    alert("CloudStack - The Management Server is unaccessible.  Please try again later.");
    //$("#dialog_error_management_server_not_accessible").dialog("open");
  } else if (XMLHttpResponse.status == ERROR_VMOPS_ACCOUNT_ERROR && handleErrorCallback != undefined) {
    handleErrorCallback();
  } else if (handleErrorCallback != undefined) {
    handleErrorCallback();
  } else {
    var errorMsg = fromdb(parseXMLHttpResponse(XMLHttpResponse));
    alert(errorMsg);
  }
}

function parseXMLHttpResponse(XMLHttpResponse) {
  if (isBrowserIE7() == false)
  {
    if (isValidJsonString(XMLHttpResponse.responseText) == false) {
      return "";
    }
  }
  if (isBrowserIE7() == true) { // Workaround for IE7 as JSON is not available in IE7.
    try{
      var json = jQuery.parseJSON(XMLHttpResponse.responseText);
    } catch (e) {
      return "";
    }
  }
  else {
    var json = JSON.parse(XMLHttpResponse.responseText);
  }
  if (json != null) {
    var property;
    for (property in json) {}
    var errorObj = json[property];
    return fromdb(errorObj.errortext);
  } else {
    return "";
  }
}

function isValidJsonString(str) {
  try {
    JSON.parse(str);
  } catch (e) {
    return false;
  }
  return true;
}


var $readonlyFields, $editFields;

function cancelEditMode($tab) {
  if ($editFields != null) $editFields.hide();
  if ($readonlyFields != null) $readonlyFields.show();
  $tab.find("#save_button, #cancel_button").hide();
}

function switchBetweenDifferentTabs(tabArray, tabContentArray, afterSwitchFnArray) {
  for (var tabIndex = 0; tabIndex < tabArray.length; tabIndex++) {
    switchToTab(tabIndex, tabArray, tabContentArray, afterSwitchFnArray);
  }
}

function switchToTab(tabIndex, tabArray, tabContentArray, afterSwitchFnArray) {
  tabArray[tabIndex].bind("click", function (event) {
    tabArray[tabIndex].removeClass("off").addClass("on"); //current tab turns on
    for (var k = 0; k < tabArray.length; k++) {
      if (k != tabIndex) tabArray[k].removeClass("on").addClass("off"); //other tabs turns off
    }

    tabContentArray[tabIndex].show(); //current tab content shows             
    for (var k = 0; k < tabContentArray.length; k++) {
      if (k != tabIndex) tabContentArray[k].hide(); //other tab content hide
    }
    //if(tabIndex != 0)   //when switching to a tab that is not details tab
    //   cancelEditMode(tabContentArray[0]);  //cancel edit mode in details tab
    if (afterSwitchFnArray != null) {
      if (afterSwitchFnArray[tabIndex] != null) afterSwitchFnArray[tabIndex]();
    }
    return false;
  });
}

function switchBetweenDifferentTabsTwo(tabArray, tabContentArray, afterSwitchFnArray) {
  for (var tabIndex = 0; tabIndex < tabArray.length; tabIndex++) {
    switchToTabTwo(tabIndex, tabArray, tabContentArray, afterSwitchFnArray);
  }
}

function switchToTabTwo(tabIndex, tabArray, tabContentArray, afterSwitchFnArray) {
  tabArray[tabIndex].bind("click", function (event) {
    tabArray[tabIndex].removeClass("nonactive").addClass("active"); //current tab turns on
    for (var k = 0; k < tabArray.length; k++) {
      if (k != tabIndex) tabArray[k].removeClass("active").addClass("nonactive"); //other tabs turns off
    }

    tabContentArray[tabIndex].show(); //current tab content shows             
    for (var k = 0; k < tabContentArray.length; k++) {
      if (k != tabIndex) tabContentArray[k].hide(); //other tab content hide
    }
    //if(tabIndex != 0)   //when switching to a tab that is not details tab
    //   cancelEditMode(tabContentArray[0]);  //cancel edit mode in details tab
    if (afterSwitchFnArray != null) {
      if (afterSwitchFnArray[tabIndex] != null) afterSwitchFnArray[tabIndex]();
    }
    return false;
  });
}

//Role Functions


function isAdmin() {
  return (cloudStackRole == 1);
}

function isDomainAdmin() {
  return (cloudStackRole == 2);
}

function isUser() {
  return (cloudStackRole == 0);
}

//regular expression
var alphanumericRegexp = /^[a-zA-Z0-9_]*$/;

//dialogs


function initDialog(elementId, width1, addToActive) {
  if (width1 == null) {
    activateDialog($("#" + elementId).dialog({
      autoOpen: false,
      modal: true,
      zIndex: 2000
    }), addToActive);
  } else {
    activateDialog($("#" + elementId).dialog({
      width: width1,
      autoOpen: false,
      modal: true,
      zIndex: 2000
    }), addToActive);
  }
}

function initDialogWithOK(elementId, width1, addToActive) {
	var dialog;
  if (width1 == null) {
	  dialog = $("#" + elementId).dialog({
	      autoOpen: false,
	      modal: true,
	      zIndex: 2000,
	      buttons: {
	        "OK": function () {
	          $(this).dialog("close");
	        }
	      }
	    });
  } else {
	dialog =   $("#" + elementId).dialog({
	      width: width1,
	      height: 500,
	      autoOpen: false,
	      modal: true,
	      zIndex: 2000,
	      buttons: {
	        "OK": function () {
	          $(this).dialog("close");
	        }
	      }
	    });    
  }
  activateDialog(dialog, addToActive);
  return dialog;
}

function setTemplateStateInRightPanel(stateValue, $stateField) {
  $stateField.text(stateValue);

  if (stateValue == "Ready") $stateField.text(stateValue);
  else if (stateValue != null && stateValue.indexOf("%") != -1) $stateField.text(stateValue);
  else $stateField.text(stateValue);
}

//Adds a Dialog to the list of active Dialogs so that when you shift from one tab to another, we clean out the dialogs
var activeDialogs = new Array();

function activateDialog(dialog, addToActive) {
  if (addToActive == undefined || addToActive) {
    activeDialogs[activeDialogs.length] = dialog;
  }

  //bind Enter-Key-pressing event handler to the dialog   
  dialog.keypress(function (event) {
    if (event.keyCode == keycode_Enter) {
      $('[aria-labelledby$=' + dialog.attr("id") + ']').find(":button:first").click();
      return false; //event.preventDefault() + event.stopPropagation()
    }
  });
}

function removeDialogs() {
  for (var i = 0; i < activeDialogs.length; i++) {
    activeDialogs[i].remove();
  }
  activeDialogs = new Array();
}

function roundNumber(number, decimal) {
  var floatValue = parseFloat(number);
  // if number value is 12.6 and decimal is 0 we still need to show value
  // as 12.60 not as 13
  if ((floatValue + '').indexOf('.') != -1 && decimal == '0') {
    decimal = 2;
    var array1 = (floatValue + '').split('.');
    var decimalValue = array1[1];
    if (decimalValue.length == 1) {
      decimal = 1;
    }
  }
  return (Math.round(floatValue * Math.pow(10, decimal)) / Math.pow(10, decimal)).toFixed(decimal);
}

function setDateField(dateValue, dateField) {
    if (dateValue != null && dateValue.length > 0) {
	   var disconnected = new Date();
	   disconnected.setISO8601(dateValue); 
	   var showDate;
	   var milliseconds = disconnected.getTime(); 
	   if(userTimeZoneOffset != null)
	       disconnected  = new Date(milliseconds + (userTimeZoneOffset * 60 * 60 * 1000));
	   showDate = dateFormat(disconnected,g_dictionary.jsDateFormat,true);
	   dateField.text(showDate);
    }
}

function displayAjaxFormError(XMLHttpRequest, formId, fieldErrorClass) {
  var json = $.parseJSON(XMLHttpRequest.responseText);
  $("#" + formId + " ." + fieldErrorClass + " label").html("");
  for (var fieldError in json.Error) {
    var html = "<label class=\"error\" for=\"" + fieldError + "\" generated=\"true\">" + json.Error[fieldError].Message + "</label>";
    $("div[id='" + fieldError + "Error" + "']").html(html);
  }
}

function getOnlyNosFromThePhoneNoString(phoneNumber){
    var nosInPhoneNoArray = phoneNumber.match(/\d+/g);
    var phoneNo = "";
    for ( var i=0; i<=nosInPhoneNoArray.length-1; i++ ){
    	phoneNo += nosInPhoneNoArray[i];
    	}
    return phoneNo;
}


function initActionLinks2(actionMap, refreshGridRowFn, refreshDetailsPanelFn) {
  for (var i = 0; i < actionMap.length; i++) {
    bindToActionLink2(actionMap[i], refreshGridRowFn, refreshDetailsPanelFn);
  }
}

var currentSelectedActionLink = null;

function clickActionLink2(elementIdPrefix, actionLinkOnClickFn, refreshGridRowFn, refreshDetailsPanelFn, mapObj) {
  if (actionLinkOnClickFn != null) actionLinkOnClickFn();
  currentSelectedActionLink = elementIdPrefix;

  $("#action_result_panel").hide();
  $("#top_message_panel").hide();
  //initDialog(elementIdPrefix + "_panel", 675);
  
  var dialog = $("#" + elementIdPrefix + "_panel").dialog( {      
    width: 675,
    autoOpen: false,
    modal: true,
    zIndex: 2000,
    buttons : {
    "OK": function () {
      if ($currentGridRow.data("jsonObj") == null) return false;

      var actionUrl1 = mapObj.getActionUrlFn(this);
      if (actionUrl1 == null) return false;

      $(this).dialog("close");
      var $spinningWheel = $("#top_actions").find("#spinning_wheel");
      $spinningWheel.find("#in_process_text").text(mapObj.actionText);       
      $spinningWheel.show();


      if (mapObj.isAsync == true) {
        $.ajax({
          type: "GET",
          url: actionUrl1,
          async: false,
          cache:false,
          dataType: "json",
          success: function (obj) {
            var property;
            for (property in obj) {};
            var jobId = obj[property].jobid;
            if (jobId == null) return;
            var timerKey = "vmAction" + jobId;

            // Process the async job
            $("body").everyTime(
            5000, timerKey, function () {
              var actionUrl2 = cloudStackURL("command=queryAsyncJobResult&jobId=" + jobId);
              $.ajax({
                type: "GET",
                url: actionUrl2,
                dataType: "json",
                cache:false,
                success: function (json) {
                  var result = json.queryasyncjobresultresponse;
                  if (result.jobstatus == 0) {
                    return; //Job has not completed
                  } else {
                    $("body").stopTime(timerKey);
                    $("#top_actions").find("#spinning_wheel").hide();
                    if (result.jobstatus == 1) {
                      // Succeeded  
                      var property;
                      for (property in result.jobresult) {}; //e.g. property == "virtualmachine", "volume", "success"    
                      var item4 = result.jobresult[property]; //item4 might be an object or true/"true" (if property is "success")                     
                      if (typeof (item4) != "object") {
                        if ((property == "success") && ((typeof (item4) == "string" && item4 == "true") || (typeof (item4) == "boolean" && item4 == true))) {
                          $currentGridRow.click();

                          var msg;
                          if (mapObj.afterActionSeccessFn != null) {
                            msg = mapObj.afterActionSeccessFn(item4); //item4 might be an object or true/"true". e.g. { "deletevolumeresponse" : { "success" : "true"}  }
                          }
                          if (msg == null) {
                            var actionlabel = $("." + mapObj.elementIdPrefix + "_link").find("a").text();
                            msg = actionlabel + " " + g_dictionary.succeeded;
                          }

                          $("#action_result_panel").find("#msg").html(msg);
                          $("#action_result_panel").find("#status_icon").removeClass("erroricon").addClass("successicon");
                          $("#action_result_panel").removeClass("error").addClass("success").show();
                          
                        }
                        return;
                      }

                      if ($currentGridRow.data("jsonObj") == null) return;

                      var idPropertyName = null;
                      if (mapObj.returnedObjectId != null) {
                        if (mapObj.returnedObjectId != "NoReturnedObjectId") idPropertyName = mapObj.returnedObjectId;
                        else idPropertyName = null;
                      } else {
                        idPropertyName = "id";
                      }
                      if ((idPropertyName == null) || (item4[idPropertyName] == $currentGridRow.data("jsonObj").id) ) {
                        var msg;
                        if (mapObj.afterActionSeccessFn != null) {
                          msg = mapObj.afterActionSeccessFn(item4); //item4 might be an object or true/"true". e.g. { "deletevolumeresponse" : { "success" : "true"}  }
                        }
                        if (msg == null) {
                          var actionlabel = $("." + mapObj.elementIdPrefix + "_link").find("a").text();
                          msg = actionlabel + " " + g_dictionary.succeeded;
                        }
                        
                        $("#action_result_panel").find("#msg").html(msg);
                        $("#action_result_panel").find("#status_icon").removeClass("erroricon").addClass("successicon");
                        $("#action_result_panel").removeClass("error").addClass("success").show();
                        $("#" + mapObj.elementIdPrefix + "_panel").find(".agree input[type=checkbox]#accept_checkbox").removeAttr("checked");
                        
                        if(mapObj.detailsLevelAction!=true){
                        refreshGridRowFn(item4, $currentGridRow);
                        //$currentGridRow.click();  
                        refreshDetailsPanelFn($currentGridRow);
                        }
                      }
                    } else if (result.jobstatus == 2) {
                      // Failed 
                      var actionlabel = $("." + mapObj.elementIdPrefix + "_link").find("a").text();
                      var msg = actionlabel + " " + g_dictionary.actionFailed;
                      if (result.jobresult.errortext != null && result.jobresult.errortext.length > 0) msg += (" - " + fromdb(result.jobresult.errortext));
                      $("#action_result_panel").find("#msg").text(msg);
                      $("#action_result_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
                      $("#action_result_panel").removeClass("success").addClass("error").show();
                      $("#" + mapObj.elementIdPrefix + "_panel").find(".agree input[type=checkbox]#accept_checkbox").removeAttr("checked");
                    }
                  }
                },
                error: function (response) {
                  $("body").stopTime(timerKey);
                  $("#top_actions").find("#spinning_wheel").hide();
                  $("#action_result_panel").find("#msg").text(g_dictionary.errorFromAPICall + ": " + actionUrl2);
                  $("#action_result_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
                  $("#action_result_panel").removeClass("success").addClass("error").show();
                  $("#" + mapObj.elementIdPrefix + "_panel").find(".agree input[type=checkbox]#accept_checkbox").removeAttr("checked");
                }
              });
            }, 0);
          },
          error: function (XMLHttpResponse) {
            $("#top_actions").find("#spinning_wheel").hide();

            var errorMsg = "";
            if (XMLHttpResponse.responseText != null & XMLHttpResponse.responseText.length > 0) errorMsg = parseXMLHttpResponse(XMLHttpResponse);

            var actionlabel = $("." + mapObj.elementIdPrefix + "_link").find("a").text();
            var msg = actionlabel + " " + g_dictionary.actionFailed;
            if (errorMsg.length > 0) msg += (" " + errorMsg);
            else msg += (" " + g_dictionary.errorFromAPICall + ": " + actionUrl1);
            $("#action_result_panel").find("#msg").text(msg);
            $("#action_result_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
            $("#action_result_panel").removeClass("success").addClass("error").show();
            $("#" + mapObj.elementIdPrefix + "_panel").find(".agree input[type=checkbox]#accept_checkbox").removeAttr("checked");
          }
        });
      } else { // sync     
        $.ajax({
          type: "GET",
          url: actionUrl1,
          async: false,
          cache:false,
          dataType: "json",
          success: function (obj1) {
            if (typeof (obj1) != "object") return;
            var propertyInObj1;
            for (propertyInObj1 in obj1) {}; //e.g. propertyInObj1 == "updatevirtualmachineresponse"
            var obj2 = obj1[propertyInObj1];
            if (typeof (obj2) != "object") return;
            var propertyInObj2;
            for (propertyInObj2 in obj2) {}; //e.g. propertyInObj2 == "virtualmachine"
            var item3 = obj2[propertyInObj2]; //item3 might be an object or a string "success". e.g. { "deletevolumeresponse" : { "success" : "true"}  }
            $("#top_actions").find("#spinning_wheel").hide();

            var msg;
            if (mapObj.afterActionSeccessFn != null) {
              msg = mapObj.afterActionSeccessFn(item3); //item3 might be an object or a string "success". e.g. { "deletevolumeresponse" : { "success" : "true"}  }
            }
            if (msg == null) {
              var actionlabel = $("." + mapObj.elementIdPrefix + "_link").find("a").text();
              msg = actionlabel + " " + g_dictionary.succeeded;
            }

            $("#action_result_panel").find("#msg").text(msg);
            $("#action_result_panel").find("#status_icon").removeClass("erroricon").addClass("successicon");
            $("#action_result_panel").removeClass("error").addClass("success").show();

            if (typeof (item3) == "object") {
              refreshGridRowFn(item3, $currentGridRow);
              //$currentGridRow.click();  
              refreshDetailsPanelFn($currentGridRow);
            }

            if ((propertyInObj2 == "success") && ((typeof (item3) == "string" && item3 == "true") || (typeof (item3) == "boolean" && item3 == true))) {
              $currentGridRow.click(); //this will hide action_result_panel  
              $("#action_result_panel").find("#msg").text(msg);
              $("#action_result_panel").find("#status_icon").removeClass("erroricon").addClass("successicon");
              $("#action_result_panel").removeClass("error").addClass("success").show(); //so, show action_result_panel (again)           
            }
          },
          error: function (obj1) {
            $("#top_actions").find("#spinning_wheel").hide();

            var actionlabel = $("." + mapObj.elementIdPrefix + "_link").find("a").text();
            var msg = actionlabel + " " + g_dictionary.actionFailed;
            $("#action_result_panel").find("#msg").text(msg);
            $("#action_result_panel").find("#status_icon").removeClass("successicon").addClass("erroricon");
            $("#action_result_panel").removeClass("success").addClass("error").show();
            $("#" + mapObj.elementIdPrefix + "_panel").find(".agree input[type=checkbox]#accept_checkbox").removeAttr("checked");
          }
        });
      }


    },
    "Cancel": function () {
      $("#" + mapObj.elementIdPrefix + "_panel").find(".agree input[type=checkbox]#accept_checkbox").removeAttr("checked");
      if (currentSelectedActionLink == elementIdPrefix) currentSelectedActionLink = null;

      $(this).dialog("close");
    }

  }});
  
  activateDialog(dialog);
  dialog.dialog("open");

}

var $currentSelectedVolume=null;//Global variable for Volume ID for snapshot on Instances page.
var $currentSelectedSnapshot=null;//Global variable for Snapshot ID for snapshots on Volumes page.

function bindToActionLink2(mapObj, refreshGridRowFn, refreshDetailsPanelFn) {
  $("." + mapObj.elementIdPrefix + "_link").unbind("click").bind("click", function (event) {
    
    $currentSelectedVolume=$(this).attr('ref_volume');//Selected Volume ID for snapshot on Instances page.
    
    $currentSelectedSnapshot=$(this).parents('#action_menu').attr('ref_snapshot');
    
    clickActionLink2(mapObj.elementIdPrefix, mapObj.actionLinkOnClickFn, refreshGridRowFn, refreshDetailsPanelFn, mapObj);
    
  });

}

function activateThirdMenuItem(menuItem){
  $("#"+menuItem).removeClass("off").addClass("on");
}
var l3menuTenantParam=$("#l3_tenant_param").val();

$("#l3_instances_tab").bind("click", function (event) { 
  $(".thirdlevel_subtab").removeClass("on").addClass("off");
  $(this).removeClass("off").addClass("on");
  window.location = "/portal/portal/dashboard/manageresource?module=VirtualMachine&tenant="+l3menuTenantParam;
});

$("#l3_volumes_tab").bind("click", function (event) {
  $(".thirdlevel_subtab").removeClass("on").addClass("off");
  $(this).removeClass("off").addClass("on");
  window.location = "/portal/portal/dashboard/manageresource?module=Volume&tenant="+l3menuTenantParam;
});

$("#l3_snapshots_tab").bind("click", function (event) {
  $(".thirdlevel_subtab").removeClass("on").addClass("off");
  $(this).removeClass("off").addClass("on");
  window.location = "/portal/portal/dashboard/manageresource?module=Snapshot&tenant="+l3menuTenantParam;
});

$("#l3_ipaddress_tab").bind("click", function (event) {
  $(".thirdlevel_subtab").removeClass("on").addClass("off");
  $(this).removeClass("off").addClass("on");
  window.location = "/portal/portal/dashboard/manageresource?module=IPAddress&tenant="+l3menuTenantParam;
});

$("#l3_templates_tab").bind("click", function (event) {
  $(".thirdlevel_subtab").removeClass("on").addClass("off");
  $(this).removeClass("off").addClass("on");
  window.location = "/portal/portal/dashboard/manageresource?module=Template&tenant="+l3menuTenantParam;
});

$("#l3_iso_tab").bind("click", function (event) {
  $(".thirdlevel_subtab").removeClass("on").addClass("off");
  $(this).removeClass("off").addClass("on");
  window.location = "/portal/portal/dashboard/manageresource?module=ISO&tenant="+l3menuTenantParam;
});

$("#l3_network_tab").bind("click", function (event) {
  $(".thirdlevel_subtab").removeClass("on").addClass("off");
  $(this).removeClass("off").addClass("on");
  window.location = "/portal/portal/dashboard/manageresource?module=Network&tenant="+l3menuTenantParam;
});

function isBrowserIE7()
{
	if (navigator.appVersion.indexOf('MSIE 7.')==-1) return false;
	return true;
}
function viewUtilitRates(tenantParam,id){
	$.ajax({
	      type: "GET",
	      url: "/portal/portal/subscription/utilityrates_lightbox?tenant=" + tenantParam,
	      dataType: "text/html",
	      cache:false,
	      success: function (html) {
	        $("#"+id).find("#container").html(html);
	        var $dialogLightbox = initDialogWithOK(id,850,false);
	        $dialogLightbox.dialog("open");
	      }
    });
}
