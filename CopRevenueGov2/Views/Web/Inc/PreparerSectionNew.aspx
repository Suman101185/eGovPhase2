<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
      <script src="../../Content/Scripts/JqueryMin.js" type="text/javascript"></script>
        <script src="../Content/Scripts/bootstrap.min.js" type="text/javascript"></script>
    <!-- Bootstrap Core CSS -->
    <link href="../../Content/Styles/bootstrap.css" rel="stylesheet">
     <link href="../../Content/Styles/Font.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../Content/Styles/jPushMenu.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script id="clientEventHandlersJS" language="javascript" type="text/javascript">
        var preparerErr = false;

        function DisablePreparer(bDisabled) {
         
            //	ClearPreparer()
            /*  txtPreparerName.disabled = bDisabled
            txtPrepAreaCode.disabled = bDisabled
            txtPrepPhone1.disabled = bDisabled
            txtPrepPhone2.disabled = bDisabled
            txtPrepPhoneExt.disabled = bDisabled
            txtPreparerEmail.disabled = bDisabled
        
            chkTaxpayer.disabled = bDisabled
            chkPreparer.disabled = bDisabled
            chkAgreement.disabled = bDisabled
            */
            var txtPreparerName = document.getElementById('txtPreparerName');
            var txtPrepAreaCode = document.getElementById('txtPrepAreaCode');
            var txtPrepPhone1 = document.getElementById('txtPrepPhone1');
            var txtPrepPhone2 = document.getElementById('txtPrepPhone2');
            var txtPrepPhoneExt = document.getElementById('txtPrepPhoneExt');
            var txtPreparerEmail = document.getElementById('txtPreparerEmail');
            var chkTaxpayer = document.getElementById('chkTaxpayer');
            var chkPreparer = document.getElementById('chkPreparer');
            var chkAgreement = document.getElementById('chkAgreement');

            if (bDisabled == true) {
                $('#txtPreparerName').attr("disabled", "disabled");
                $('#txtPrepAreaCode').attr("disabled", "disabled");
                $('#txtPrepPhone1').attr("disabled", "disabled");
                $('#txtPrepPhone2').attr("disabled", "disabled");
                $('#txtPrepPhoneExt').attr("disabled", "disabled");
                $('#txtPreparerEmail').attr("disabled", "disabled");
                $('#chkTaxpayer').attr("disabled", "disabled");
                $('#chkPreparer').attr("disabled", "disabled");
                $('#chkAgreement').attr("disabled", "disabled");
            }
            else {
                $('#txtPreparerName').removeAttr("disabled");
                $('#txtPrepAreaCode').removeAttr("disabled");
                $('#txtPrepPhone1').removeAttr("disabled");
                $('#txtPrepPhone2').removeAttr("disabled");
                $('#txtPrepPhoneExt').removeAttr("disabled");
                $('#txtPreparerEmail').removeAttr("disabled");
                $('#chkTaxpayer').removeAttr("disabled");
                $('#chkPreparer').removeAttr("disabled");
                $('#chkAgreement').removeAttr("disabled");

            }


        }		//DisablePreparer

        function ClearPreparer() {
            var txtPreparerName = document.getElementById("txtPreparerName");
            var txtPrepAreaCode = document.getElementById("txtPrepAreaCode");
            var txtPrepPhone1 = document.getElementById("txtPrepPhone1");
            var txtPrepPhone2 = document.getElementById("txtPrepPhone2");
            var txtPrepPhoneExt = document.getElementById("txtPrepPhoneExt");
            var txtPreparerEmail = document.getElementById("txtPreparerEmail");
            var chkTaxpayer = document.getElementById('chkTaxpayer');
            var chkPreparer = document.getElementById('chkPreparer');
            var chkAgreement = document.getElementById('chkAgreement');

            txtPreparerName.value = "";
            txtPrepAreaCode.value = "";
            txtPrepPhone1.value = "";
            txtPrepPhone2.value = "";
            txtPrepPhoneExt.value = "";
            txtPreparerEmail.value = "";
            $('#chkTaxpayer').removeAttr("checked");
            $('#chkPreparer').removeAttr("checked");
            $('#chkAgreement').removeAttr("checked");
            // chkTaxpayer.checked = false;
            // chkPreparer.checked = false;

            /*txtPreparerName.className = 'inpNormal'
            txtPrepAreaCode.className = 'inpNormal'	
            txtPrepPhone1.className = 'inpNormal'	
            txtPrepPhone2.className = 'inpNormal'	
            txtPrepPhoneExt.className = 'inpNormal'		
            txtPreparerEmail.className = 'inpNormal'
            chkTaxpayer.className = 'inpNormal'
            chkPreparer.className = 'inpNormal'
            AppError.innerText = ''
            */

            $('#txtPreparerName').attr("class", "inpNormal form-control input-sm");
            $('#txtPrepAreaCode').attr("class", "inpNormal form-control input-sm");
            $('#txtPrepPhone1').attr("class", "inpNormal form-control input-sm");
            $('#txtPrepPhone2').attr("class", "inpNormal form-control input-sm");
            $('#txtPrepPhoneExt').attr("class", "inpNormal form-control input-sm");
            $('#txtPreparerEmail').attr("class", "inpNormal form-control input-sm");
            $('#chkTaxpayer').attr("class", "inpNormal");
            $('#chkPreparer').attr("class", "inpNormal");

        }		//ClearPreparer



        function chkTaxpayer_onclick() {
            var txtPreparerName = document.getElementById("txtPreparerName");
            var txtPrepAreaCode = document.getElementById("txtPrepAreaCode");
            var txtPrepPhone1 = document.getElementById("txtPrepPhone1");
            var txtPrepPhone2 = document.getElementById("txtPrepPhone2");
            var txtPrepPhoneExt = document.getElementById("txtPrepPhoneExt");
            var txtPreparerEmail = document.getElementById("txtPreparerEmail");
            var chkTaxpayer = document.getElementById("chkTaxpayer");
            var chkPreparer = document.getElementById("chkPreparer");
            var chkAgreement = document.getElementById("chkAgreement");
            var evt = window.event || arguments.callee.caller.arguments[0];
            var mnuElement = evt.srcElement || evt.target;
            var id = mnuElement.id;

            if (id == 'chkTaxpayer' && $('#chkTaxpayer').is(":checked") == true) {
                $('#chkPreparer').removeAttr("checked");
            } else {
                $('#chkTaxpayer').removeAttr("checked");
            }		//if
            txtPreparerName.focus()
        }		//chkTaxpayer_onclick  txtPrepPhone1
        $(function () {
            $('#txtPrepAreaCode').keypress(function (evt) {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                    return false;
                }
            }
         );
             
        });
        $(function () {
            $('#txtPrepPhone1').keypress(function (evt) {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                    return false;
                }
            }
         );

        });
        $(function () {
            $('#txtPrepPhone2').keypress(function (evt) {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                    return false;
                }
            }
         );

        });
        //modified by SumanG
        //$(function () {
        //    $('#txtPreparerName').keypress(function (evt) {
        //        if ((evt.charCode > 64 && evt.charCode < 91) || (evt.charCode > 96 && evt.charCode < 123))
        //            return true;
        //        else
        //            return false;
        //    }
        // );

        //});//by manoranjan
        function ValidatePreparer() {         
            var strEmail = "";
            preparerErr = true;
            var txtPreparerName = document.getElementById("txtPreparerName");
            var txtPrepAreaCode = document.getElementById("txtPrepAreaCode");
            var txtPrepPhone1 = document.getElementById("txtPrepPhone1");
            var txtPrepPhone2 = document.getElementById("txtPrepPhone2");
            var txtPrepPhoneExt = document.getElementById("txtPrepPhoneExt");
            var txtPreparerEmail = document.getElementById("txtPreparerEmail");
            var chkTaxpayer = document.getElementById("chkTaxpayer");
            var chkPreparer = document.getElementById("chkPreparer");
            var chkAgreement = document.getElementById("chkAgreement");
           
            $('#txtPreparerName').attr('class', 'form-control input-sm');
            $('#txtPrepAreaCode').attr('class', 'form-control input-sm');
            $('#txtPrepPhone1').attr('class', 'form-control input-sm');
            $('#txtPrepPhone2').attr('class', 'form-control input-sm');
            $('#txtPrepPhoneExt').attr('class', 'form-control input-sm');
            $('#txtPreparerEmail').attr('class', 'form-control input-sm');
           
            if ($('#chkTaxpayer').is(":checked") == false && $('#chkPreparer').is(":checked") == false) {              
                $('#chkTaxpayer').attr("class", "inpError");
                $('#chkPreparer').attr("class", "inpError");
                return 'Filed by must be checked.';
            }
            else {
                $('#chkTaxpayer').attr("class", "inpNormal");//by manoranjan
                $('#chkPreparer').attr("class", "inpNormal");
            }
          
            if ($('#txtPreparerName').val() == '' || $('#txtPreparerName').val().length < 2 ) {
               
                $('#txtPreparerName').attr("class", "inpError form-control input-sm");
                $('#txtPreparerName').focus();
                $('#txtPreparerName').select();
                return 'A valid filer name is required.';
            }	//if          
           
            if ($('#txtPrepAreaCode').val() == '' || txtPrepAreaCode.value.length != 3 || isNaN(txtPrepAreaCode.value) == true) {               
                $('#txtPrepAreaCode').attr("class", "inpError form-control input-sm");
                $('#txtPrepAreaCode').focus();
                $('#txtPrepAreaCode').select();
                return 'Area code is required and must be numeric.';
            }		//if
            if ($('#txtPrepPhone1').val() == '' || txtPrepPhone1.value.length != 3 || isNaN(txtPrepPhone1.value) == true) {             
                $('#txtPrepPhone1').attr("class", "inpError form-control input-sm");
                $('#txtPrepPhone1').focus();
                $('#txtPrepPhone1').select();
                return 'Phone number is required and must be numeric.';
            }		//if
            if ($('#txtPrepPhone2').val() == '' || txtPrepPhone2.value.length != 4 || isNaN(txtPrepPhone2.value) == true) {
                $('#txtPrepPhone2').attr("class", "inpError form-control input-sm");               
                $('#txtPrepPhone2').focus();
                $('#txtPrepPhone2').select();
                return 'Phone number is required and must be numeric.';
            }		//if
            if ($('#txtPrepPhoneExt').val() != '' && isNaN($('#txtPrepPhoneExt').val()) == true) {              
                $('#txtPrepPhoneExt').attr("class", "inpError form-control input-sm");
                $('#txtPrepPhoneExt').focus();
                $('#txtPrepPhoneExt').select();
                return 'Phone extension must be numeric.';
            }		//if
            if ($('#txtPreparerEmail').val() == "") {              
                $('#txtPreparerEmail').attr("class", "inpError form-control input-sm");
                $('#txtPreparerEmail').focus();
                $('#txtPreparerEmail').select();
                return 'Filer email address required';
            }		//if
            if ((txtPreparerEmail.value.indexOf("@") == -1) || (txtPreparerEmail.value.indexOf(".") == -1) ||
                    (txtPreparerEmail.value.indexOf("@.") != -1) || (txtPreparerEmail.value.indexOf("@") == 0)) {               
                $('#txtPreparerEmail').attr("class", "inpError form-control input-sm");
                txtPreparerEmail.focus();
                txtPreparerEmail.select();
                return 'Filer email address invalid format';
            }		//if

            strEmail = txtPreparerEmail.value.toUpperCase();
            $('#txtPreparerEmail').val(strEmail);
            if ((txtPreparerEmail.value.indexOf(".BIZ") == -1) && (txtPreparerEmail.value.indexOf(".COM") == -1) &&
                (txtPreparerEmail.value.indexOf(".INFO") == -1) && (txtPreparerEmail.value.indexOf(".NAME") == -1) &&
                (txtPreparerEmail.value.indexOf(".NET") == -1) && (txtPreparerEmail.value.indexOf(".ORG") == -1) &&
                (txtPreparerEmail.value.indexOf(".PRO") == -1) && (txtPreparerEmail.value.indexOf(".AERO") == -1) &&
                (txtPreparerEmail.value.indexOf(".CAT") == -1) && (txtPreparerEmail.value.indexOf(".EDU") == -1) &&
                (txtPreparerEmail.value.indexOf(".GOV") == -1) && (txtPreparerEmail.value.indexOf(".INT") == -1) &&
                (txtPreparerEmail.value.indexOf(".JOBS") == -1) && (txtPreparerEmail.value.indexOf(".MIL") == -1) &&
                (txtPreparerEmail.value.indexOf(".MOBI") == -1) && (txtPreparerEmail.value.indexOf(".MUSEUM") == -1) &&
                (txtPreparerEmail.value.indexOf(".TEL") == -1) && (txtPreparerEmail.value.indexOf(".TRAVEL") == -1) &&
                (txtPreparerEmail.value.indexOf(".US") == -1) && (txtPreparerEmail.value.indexOf(".ASIA") == -1)) {               
                $('#txtPreparerEmail').attr("class", "inpError form-control input-sm");
                $('#txtPreparerEmail').focus();
                $('#txtPreparerEmail').select();
                return 'Filer email address invalid domain';
            }		//if
            if ($('#chkAgreement').is(":checked") == false) {
                return 'Signature Box is not checked';
            }		//if
            preparerErr = false;
            return ''
        }		//ValidatePreparer

        function PopulatePreparerXML(xmlStruct, xmlRegion) {
            debugger;
            var txtPreparerName = document.getElementById("txtPreparerName");
            var txtPrepAreaCode = document.getElementById("txtPrepAreaCode");
            var txtPrepPhone1 = document.getElementById("txtPrepPhone1");
            var txtPrepPhone2 = document.getElementById("txtPrepPhone2");
            var txtPrepPhoneExt = document.getElementById("txtPrepPhoneExt");
            var txtPreparerEmail = document.getElementById("txtPreparerEmail");
            var chkTaxpayer = document.getElementById("chkTaxpayer");
            var chkPreparer = document.getElementById("chkPreparer");
            var chkAgreement = document.getElementById("chkAgreement");

            parent.$x.ispXmlSetFieldVal(xmlStruct, '<% Response.Write(CopMvcUtil.GetString(Request.ServerVariables["REMOTE_ADDR"])); %>', xmlRegion + " PREPARER_IP_ADDRESS", '', 0);
            parent.$x.ispXmlSetFieldVal(xmlStruct, txtPreparerName.value, xmlRegion + " PREPARER_NAME", '', 0);
            parent.$x.ispXmlSetFieldVal(xmlStruct, txtPrepAreaCode.value + txtPrepPhone1.value + txtPrepPhone2.value, xmlRegion + " PREPARER_PHONE", '', 0);
            parent.$x.ispXmlSetFieldVal(xmlStruct, txtPrepPhoneExt.value, xmlRegion + " PREPARER_PHONE_EXT", '', 0);
            parent.$x.ispXmlSetFieldVal(xmlStruct, txtPreparerEmail.value, xmlRegion + " PREPARER_EMAIL_ADDRESS", '', 0);
            if ($('#chkTaxpayer').is(":checked") == true) {
                parent.$x.ispXmlSetFieldVal(xmlStruct, "T", xmlRegion + " PREPARER_WHO", '', 0);
            }
            else if ($('#chkPreparer').is(":checked") == true) {
                parent.$x.ispXmlSetFieldVal(xmlStruct, "P", xmlRegion + " PREPARER_WHO", '', 0);
            }		//if

        }		//PopulatePrepareXML

        function PopulatePreparer(xmlStruct, xmlRegion) {
            var txtPreparerName = document.getElementById("txtPreparerName");
            var txtPrepAreaCode = document.getElementById("txtPrepAreaCode");
            var txtPrepPhone1 = document.getElementById("txtPrepPhone1");
            var txtPrepPhone2 = document.getElementById("txtPrepPhone2");
            var txtPrepPhoneExt = document.getElementById("txtPrepPhoneExt");
            var txtPreparerEmail = document.getElementById("txtPreparerEmail");
            var chkTaxpayer = document.getElementById("chkTaxpayer");
            var chkPreparer = document.getElementById("chkPreparer");
            var chkAgreement = document.getElementById("chkAgreement");

            txtPreparerName.value = parent.$x.ispXmlGetFieldVal(xmlStruct, xmlRegion + " PREPARER_NAME", '', 0);
            txtPrepAreaCode.value = splitField(parent.$x.ispXmlGetFieldVal(xmlStruct, xmlRegion + " PREPARER_PHONE", '', 0), 0, 3);
            txtPrepPhone1.value = splitField(parent.$x.ispXmlGetFieldVal(xmlStruct, xmlRegion + " PREPARER_PHONE", '', 0), 3, 3);
            txtPrepPhone2.value = splitField(parent.$x.ispXmlGetFieldVal(xmlStruct, xmlRegion + " PREPARER_PHONE", '', 0), 6, 4);
            txtPrepPhoneExt.value = parent.$x.ispXmlGetFieldVal(xmlStruct, xmlRegion + " PREPARER_PHONE_EXT", '', 0);
            txtPreparerEmail.value = parent.$x.ispXmlGetFieldVal(xmlStruct, xmlRegion + " PREPARER_EMAIL_ADDRESS", '', 0);
            if ($('#txtPreparerName').val() != '') {
                if (parent.$x.ispXmlGetFieldVal(xmlStruct, xmlRegion + " PREPARER_WHO", '', 0) == 'T') {
                    $('#chkTaxpayer').prop("checked", true);
                    //chkTaxpayer.checked = true
                    //chkPreparer.checked = false
                    $('#chkPreparer').prop("checked", false);
                } else {
                    //chkPreparer.checked = true
                    $('#chkPreparer').prop("checked", true);
                    //chkTaxpayer.checked = false
                    $('#chkTaxpayer').prop("checked", false);
                }		//if
            }		//if

        }		//PopulatePrepare

        function ClearPreparerXML(xmlStruct, xmlRegion) {
            parent.$x.ispXmlSetFieldVal(xmlStruct, "", xmlRegion + " PREPARER_IP_ADDRESS", '', 0);
            parent.$x.ispXmlSetFieldVal(xmlStruct, "", xmlRegion + " PREPARER_NAME", '', 0);
            parent.$x.ispXmlSetFieldVal(xmlStruct, "", xmlRegion + " PREPARER_PHONE", '', 0);
            parent.$x.ispXmlSetFieldVal(xmlStruct, "", xmlRegion + " PREPARER_PHONE_EXT", '', 0);
            parent.$x.ispXmlSetFieldVal(xmlStruct, "", xmlRegion + " PREPARER_EMAIL_ADDRESS", '', 0);
            parent.$x.ispXmlSetFieldVal(xmlStruct, "", xmlRegion + " PREPARER_WHO", '', 0);
        }		//ClearPreparerXML

        function splitField(value, start, end) {
            //EGOVWEB-74 Check for null coded added
            if (value) {		//Check for null
                if (value.length != 0) {
                    return value.substr(start, end);
                } else {
                    return ''
                } 	//if
            } else {
                return ''
            }		//if
        }		//splitField

        function NTLThankYou() {
            parent.DocWin.location.href = '../login/MainAsp';
        }		//NTLThankYou
    </script>
    <title></title>
</head>
<body>    

  <%--  <form class="form-horizontal school_form">
      
        <div class="form-group">
            <div class="col-sm-2">
            <label class="control-label text-custom-left2" for="inputEmail3">Filed by<span style="color:red">*</span>: </label>

            </div>
            <div class="col-sm-2 ">
                    <label class="below_margin01">
                        <input style="width: 15px; margin-top: 5px;" id="chkTaxpayer" type="checkbox" onclick="chkTaxpayer_onclick()" class="inpNormal">
                        <span>Taxpayer</span>
                    </label>

            </div>
            <div class="col-sm-2">
                    <label class="below_margin01" ">
                        <input id="chkPreparer" class="inpNormal" style="width: 15px; margin-top: 5px;" type="checkbox" onclick="chkTaxpayer_onclick()">
                        <span>Preparer</span>
                    </label>
          </div>
           
        </div>

        <div class="form-group">
            <div class="col-sm-2">
            <label class="control-label  text-custom-left2" for="inputEmail3">Filer Name<span style="color:red">*</span>:</label>

            </div>
            <div class="col-sm-5">
                <input id="txtPreparerName" name="txtPreparerName" onchange="ValidatePreparer()" class="form-control input-sm" maxlength="30" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-2">
            <label class="control-label  text-custom-left2" for="inputEmail3">Filer Phone<span style="color:red">*</span>:</label>

            </div>
            <div class="col-sm-1 col-xs-2" style="padding-right:0px;width:15%">
                <input id="txtPrepAreaCode" name="txtPrepAreaCode" class="form-control input-sm" onchange="ValidatePreparer()" maxlength="3" />
            </div>
            <div class="col-sm-1 col-xs-2" style="padding-right:0px;width:15%">
                <input id="txtPrepPhone1" name="txtPrepPhone1" class="form-control input-sm" onchange="ValidatePreparer()" maxlength="3" />
            </div>
            <div class="col-sm-1 col-xs-2" style="padding-right:0px;width:15%">
                <input id="txtPrepPhone2" name="txtPrepPhone2" class="form-control input-sm" onchange="ValidatePreparer()" maxlength="4" />
            </div>
            <div class="col-sm-3  col-xs-6 customwidth_input no-padding">
                <span class="small_span2">EXT -</span>               
                <input id="txtPrepPhoneExt" name="txtPrepPhoneExt" class="form-control input-sm customwidth1" onchange="ValidatePreparer()" maxlength="6" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-2">
            <label class="control-label  text-custom-left2" for="inputEmail3">Filer E-Mail Address<span style="color:red">*</span>:</label>
            </div>
            <div class="col-sm-5">
                <input id="txtPreparerEmail" class="form-control input-sm" onchange="ValidatePreparer()">
            </div>

        </div>

        <div class="form-group">
           

                         <div class="col-sm-2">
                         
                          </div>
                        <div class="col-sm-9 below_margin01">
                            <input id="chkAgreement" type="checkbox" value="option1" checked>  &nbsp;
                            <span>
                            Signature box: Under penalties of perjury, as set forth in 18 Pa. C.S. &#167;&#167; 4903-4903 as amended, I swear that I have reviewed this return and, to the best of my knowledge
			                and belief, it is true and complete.
			            </span></div>			
                        
              

        </div>     
    </form>--%>

      <form class="form-horizontal school_form print-prepare-form">
      
        <div class="form-group" style="margin-bottom:1px !important;">
            <div class="col-md-2 col-xs-3 col-sm-3">
            <label class="control-label text-custom-left2" for="inputEmail3" style="font-weight:normal;">Filed by<span style="color:red">*</span>: </label>

            </div>
            <div class="col-xs-3 col-sm-3 col-md-3">
                    <label class="below_margin01">
                        <input style="width: 15px; margin-top: 5px;" id="chkTaxpayer" type="checkbox" onclick="chkTaxpayer_onclick()" class="inpNormal">
                        <span>Taxpayer</span>
                    </label>

            </div>
            <div class="col-xs-3 col-sm-3 col-md-3">
                    <label class="below_margin01" ">
                        <input id="chkPreparer" class="inpNormal" style="width: 15px; margin-top: 5px;" type="checkbox" onclick="chkTaxpayer_onclick()">
                        <span>Preparer</span>
                    </label>
          </div>
           
        </div>

        <div class="form-group" style="margin-bottom:1px !important;">
            <div class="col-xs-3 col-sm-3 col-md-2">
            <label class="control-label  text-custom-left2" for="inputEmail3" style="font-weight:normal;">Filer Name<span style="color:red">*</span>:</label>

            </div>
            <div class="col-xs-5 col-sm-5 col-md-5">
                <input id="txtPreparerName" name="txtPreparerName" onchange="ValidatePreparer()" class="form-control input-sm" maxlength="30" style="height:17px !important; padding:0 !important; font-size:12px !important;" />
            </div>
        </div>

        <div class="form-group" style="margin-bottom:1px !important;">
            <div class="col-xs-3 col-sm-3 col-md-2">
            <label class="control-label  text-custom-left2" for="inputEmail3" style="font-weight:normal;">Filer Phone<span style="color:red">*</span>:</label>

            </div>
            <div class="col-sm-1 col-xs-1 col-md-1" style="padding-right:0px;width:15%">
                <input id="txtPrepAreaCode" name="txtPrepAreaCode" class="form-control input-sm" onchange="ValidatePreparer()" maxlength="3" style="height:17px !important; padding:0 !important; font-size:12px !important;" />
            </div>
            <div class="col-sm-1 col-xs-1 col-md-1" style="padding-right:0px;width:15%">
                <input id="txtPrepPhone1" name="txtPrepPhone1" class="form-control input-sm" onchange="ValidatePreparer()" maxlength="3" style="height:17px !important; padding:0 !important; font-size:12px !important;" />
            </div>
            <div class="col-sm-1 col-xs-1 col-md-1" style="padding-right:0px;width:15%">
                <input id="txtPrepPhone2" name="txtPrepPhone2" class="form-control input-sm" onchange="ValidatePreparer()" maxlength="4" style="height:17px !important; padding:0 !important; font-size:12px !important;" />
            </div>
            <div class="col-sm-4 col-xs-4 col-md-4  customwidth_input no-padding" style="padding-right:0px;width:25%;">
                <span class="small_span2">EXT -</span>               
                <input id="txtPrepPhoneExt" name="txtPrepPhoneExt" class="form-control input-sm customwidth1" onchange="ValidatePreparer()" maxlength="6" style="width:50%; height:19px !important; padding:0 !important; font-size:12px !important;"  />
            </div>
        </div>

        <div class="form-group" style="margin-bottom:1px !important;">
            <div class="col-xs-3 col-md-2 col-sm-3 school-filer-email-add">
            <label class="control-label text-custom-left2" for="inputEmail3" style="font-weight:normal;">Filer E-Mail Address<span style="color:red">*</span>:</label>
            </div>
            <div class="col-sm-5 col-md-5 col-xs-5">
                <input id="txtPreparerEmail" class="form-control input-sm email-input-sit" onchange="ValidatePreparer()" style="height:17px !important; padding:0 !important; font-size:12px !important;">
            </div>

        </div>
            <%-- <div class="form-group">
           <div class="col-sm-10 below_margin01">
                        <div class="radio">
                      <label class="col-sm-10  extraspacing">
                            <input id="chkAgreement" type="checkbox"  value="option1" checked>  &nbsp;
                            <span><p>
                            Signature box: Under penalties of perjury, as set forth in 18 Pa. C.S. &#167;&#167; 4903-4903 as amended, I swear that I have reviewed this return and, to the best of my knowledge
			                and belief, it is true and complete.
			            </p></span></label>			
               

            </div>
        </div>     
      </div>--%>
        <div class="form-group" style="margin-bottom:0px !important; margin-top:0 !important;">
           
<%--                <div class="radio">--%>
           <%--         <label class="radio">--%>
                        
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 below_margin01">
                            <input id="chkAgreement" type="checkbox" <%--id="optionsRadios1"--%> value="option1" checked>  &nbsp;
                            <span>
                            Signature box: Under penalties of perjury, as set forth in 18 Pa. C.S. &#167;&#167; 4903-4903 as amended,<br /> I swear that I have reviewed this return and, to the best of my knowledge and belief, it is true and complete.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div>	
           
                        
                <%--    </label>--%>
              <%--  </div>--%>        


        </div>     
    </form>

</body>
</html>
