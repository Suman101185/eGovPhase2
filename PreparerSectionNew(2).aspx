<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
      <script src="../../Content/Scripts/JqueryMin.js" type="text/javascript"></script>
    <!-- Bootstrap Core CSS -->
    <link href="../../Content/Styles/bootstrap.css" rel="stylesheet">
     <link href="../../Content/Styles/Font.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../Content/Styles/jPushMenu.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
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

            $('#txtPreparerName').attr("class", "inpNormal");
            $('#txtPrepAreaCode').attr("class", "inpNormal");
            $('#txtPrepPhone1').attr("class", "inpNormal");
            $('#txtPrepPhone2').attr("class", "inpNormal");
            $('#txtPrepPhoneExt').attr("class", "inpNormal");
            $('#txtPreparerEmail').attr("class", "inpNormal");
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
        }		//chkTaxpayer_onclick
        $(function () {

            $('#txtPreparerName').keyup(function () {
                var yourInput = $(this).val();
                re = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi;
                var isSplChar = re.test(yourInput);
                if (isSplChar) {
                    var no_spl_char = yourInput.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, '');
                    $(this).val(no_spl_char);
                }
            });

        });
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
            /*txtPreparerName.className = 'inpNormal'
            txtPrepAreaCode.className = 'inpNormal'	
            txtPrepPhone1.className = 'inpNormal'	
            txtPrepPhone2.className = 'inpNormal'	
            txtPrepPhoneExt.className = 'inpNormal'		
            txtPreparerEmail.className = 'inpNormal'
            chkTaxpayer.className = 'inpNormal'
            chkPreparer.className = 'inpNormal'*/

            $('#txtPreparerName').attr('class', 'form-control input-sm');
            $('#txtPrepAreaCode').attr('class', 'form-control input-sm');
            $('#txtPrepPhone1').attr('class', 'form-control input-sm');
            $('#txtPrepPhone2').attr('class', 'form-control input-sm');
            $('#txtPrepPhoneExt').attr('class', 'form-control input-sm');
            $('#txtPreparerEmail').attr('class', 'form-control input-sm');
            //$('#chkTaxpayer').attr('class', 'form-control input-sm');
            //$('#chkPreparer').attr('class', 'form-control input-sm');


            if ($('#chkTaxpayer').is(":checked") == false && $('#chkPreparer').is(":checked") == false) {

                //chkTaxpayer.className = 'inpError'
                //chkPreparer.className = 'inpError'
                $('#chkTaxpayer').attr("class", "inpError");
                $('#chkPreparer').attr("class", "inpError");

                return 'Filed By Must Be Checked.';
            }
            debugger;
            if ($('#txtPreparerName').val() == '' || $('#txtPreparerName').val().length < 2 ) {
               
                $('#txtPreparerName').attr("class", "inpError form-control input-sm");
                txtPreparerName.focus();
                txtPreparerName.select();
                return 'A Valid Filer Name Is Required.';
            }	//if
            //if (!$('#txtPreparerName').val().match("^[a-z0-9'.\s]{1,50}$")) {
            //    $('#txtPreparerName').attr("class", "inpError form-control input-sm");
            //    txtPreparerName.focus();
            //    txtPreparerName.select();
            //    return 'A Valid Filer Name Is Required.';
            //}	//if
            if ($('#txtPrepAreaCode').value == '' || txtPrepAreaCode.value.length != 3 || isNaN(txtPrepAreaCode.value) == true) {
                //  txtPrepAreaCode.className = 'inpError'
                $('#txtPrepAreaCode').attr("class", "inpError form-control input-sm");
                txtPrepAreaCode.focus();
                txtPrepAreaCode.select();
                return 'Area Code Is Required And Must Be Numeric.';
            }		//if
            if (txtPrepPhone1.value == '' || txtPrepPhone1.value.length != 3 || isNaN(txtPrepPhone1.value) == true) {
                // txtPrepPhone1.className = 'inpError'
                $('#txtPrepPhone1').attr("class", "inpError form-control input-sm");
                //txtPrepPhone1.focus();
                //txtPrepPhone1.select();
                return 'Phone Number Is Required And Must Be Numeric.';
            }		//if
            if (txtPrepPhone2.value == '' || txtPrepPhone2.value.length != 4 || isNaN(txtPrepPhone2.value) == true) {
                $('#txtPrepPhone2').attr("class", "inpError form-control input-sm");
                //txtPrepPhone2.className = 'inpError'
                txtPrepPhone2.focus();
                txtPrepPhone2.select();
                return 'Phone Number Is Required And Must Be Numeric.';
            }		//if
            if (txtPrepPhoneExt.value != '' && isNaN(txtPrepPhoneExt.value) == true) {
                // txtPrepPhoneExt.className = 'inpError';
                $('#txtPrepPhoneExt').attr("class", "inpError form-control input-sm");
                txtPrepPhoneExt.focus();
                txtPrepPhoneExt.select();
                return 'If Entered, Phone Extension Must Be Numeric.';
            }		//if
            if (txtPreparerEmail.value == "") {
                // txtPreparerEmail.className = 'inpError'
                $('#txtPreparerEmail').attr("class", "inpError form-control input-sm");
                txtPreparerEmail.focus();
                txtPreparerEmail.select();
                return 'Filer Email Address Required';
            }		//if
            if ((txtPreparerEmail.value.indexOf("@") == -1) || (txtPreparerEmail.value.indexOf(".") == -1) ||
                    (txtPreparerEmail.value.indexOf("@.") != -1) || (txtPreparerEmail.value.indexOf("@") == 0)) {
                // txtPreparerEmail.className = 'inpError'
                $('#txtPreparerEmail').attr("class", "inpError form-control input-sm");
                txtPreparerEmail.focus();
                txtPreparerEmail.select();
                return 'Filer Email Address Invalid Format';
            }		//if

            strEmail = txtPreparerEmail.value.toUpperCase();
            txtPreparerEmail.value = strEmail;
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
                // txtPreparerEmail.className = 'inpError'
                $('#txtPreparerEmail').attr("class", "inpError form-control input-sm");
                txtPreparerEmail.focus();
                txtPreparerEmail.select();
                return 'Filer Email Address Invalid Domain';
            }		//if
            if ($('#chkAgreement').is(":checked") == false) {
                return 'Signature Box is not checked';
            }		//if
            preparerErr = false;
            return ''
        }		//ValidatePreparer

     function PopulatePreparerXML(xmlStruct, xmlRegion) {
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
            if (txtPreparerName.value != '') {
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
    <%--<div class="school_page_form">
                           <div class="form_segment lessspac_element">

                                <label>Filled by *</label>
                                <div class="here_input" style="width:100px; margin:5px 15px;">
                                    <INPUT style="width:15px; margin-top:5px;" id=chkTaxpayer type=checkbox onclick="chkTaxpayer_onclick()" class="inpNormal">
                                    <span>Tax Payer</span>
                                </div>
                                <div class="here_input"  style="width:100px; margin:5px 15px;"">
                                 
		                         <INPUT id=chkPreparer class="inpNormal" style="width:15px; margin-top:5px;" type=checkbox onclick="chkTaxpayer_onclick()">
                                    <span>Prepayer</span>
                                </div>

                                <div class="clear"></div>

                            </div>

                            <div class="form_segment lessspac_element">

                                <div class="small_divs"><label>Filler Name *</label></div>
                                <div class="here_input_table">
                               <INPUT  id=txtPreparerName maxLength=40 size=48 name=txtPreparerName class="inpNormal" style="TEXT-ALIGN: left; WIDTH:200px">
                                    </div>
                                   <div class="clear"></div>
                              </div>
                              <div class="form_segment lessspac_element">

                                <div class="small_divs"><label>Filler Phone *</label></div>
                                <div class="here_input_table">
                             <INPUT class="input_size7 inpNormal"  id=txtPrepAreaCode name=txtPrepAreaCode maxlength=3 size=4 style="TEXT-ALIGN: left; WIDTH:30px">
			                 <INPUT class="input_size7 inpNormal"  id=txtPrepPhone1 name=txtPrepPhone1 maxlength=3 size=4 style="TEXT-ALIGN: left; WIDTH:30px">
			                 <INPUT class="input_size7 inpNormal"  id=txtPrepPhone2 name=txtPrepPhone2 maxlength=4 size=5 style="TEXT-ALIGN: left; WIDTH:40px">
                                   
                                    <span class="here_alert">Ext : </span> 
            <INPUT class="input_size7 inpNormal" id=txtPrepPhoneExt name=txtPrepPhoneExt maxlength=5 size=6 style="TEXT-ALIGN: left; WIDTH:50px; float:none;">
                                    </div>
                                   <div class="clear"></div>
                              </div>
                              

                            <div class="form_segment lessspac_element">

                                <label style="width:27%">Filer E-Mail Address: *</label>

                                <div class="here_input_table">
                                    <INPUT class="input_size9 inpNormal" id=txtPreparerEmail	maxLength=60 size=68 name=txtPreparerEmail style="TEXT-ALIGN: left">
                                   
                                </div>

                                <div class="clear"></div>
                            </div>


                            <div class="form_segment">



                                <div class="here_input_table">
                                  
                                     <INPUT id="chkAgreement" type="checkbox" style="WIDTH: 13px; float:left;" class="inpNormal">

                                     &nbsp;<p class="checkbox_p">Signature box: 
			Under penalties of perjury, as set forth in 18 Pa. C.S. &#167;&#167; 4903-4903 as amended, 
			I swear that I have reviewed this return and, to the best of my knowledge
			and belief, it is true and complete.</p>
                     <div class="clear"></div>
                                </div>
                               
                            </div>

    </div>--%>

    <form class="form-horizontal school_form">
      
        <div class="form-group">
            <div class="col-sm-2">
            <label class="control-label text-custom-left2" for="inputEmail3">Filled by<font style="color:red">*</font>: </label>

            </div>
            <div class="col-sm-2 ">
                    <label class="below_margin01">
                        <input style="width: 15px; margin-top: 5px;" id="chkTaxpayer" type="checkbox" onclick="chkTaxpayer_onclick()" class="inpNormal">
                        <span>Tax Payer</span>
                    </label>

            </div>
            <div class="col-sm-2">
                    <label class="below_margin01" ">
                        <input id="chkPreparer" class="inpNormal" style="width: 15px; margin-top: 5px;" type="checkbox" onclick="chkTaxpayer_onclick()">
                        <span>Prepayer</span>
                    </label>
          </div>
           
        </div>

        <div class="form-group">
            <div class="col-sm-2">
            <label class="control-label  text-custom-left2" for="inputEmail3">Filler Name<font style="color:red">*</font>:</label>

            </div>
            <div class="col-sm-3 below_margin01">
                <input id="txtPreparerName" name="txtPreparerName" onchange="ValidatePreparer()" class="form-control input-sm" type="text">
            </div>

        </div>

        <div class="form-group">
            <div class="col-sm-2">
            <label class="control-label  text-custom-left2" for="inputEmail3">Work Phone<font style="color:red">*</font>:</label></div>
            <div class="col-sm-2 below_margin01">
                <input id="txtPrepAreaCode" name="txtPrepAreaCode" class="form-control input-sm" onchange="ValidatePreparer()">
            </div>
            <div class="col-sm-2 below_margin01">
                <input id="txtPrepPhone1" name="txtPrepPhone1" class="form-control input-sm" onchange="ValidatePreparer()">
            </div>
            <div class="col-sm-2 below_margin01">
                <input id="txtPrepPhone2" name="txtPrepPhone2" class="form-control input-sm" onchange="ValidatePreparer()">
            </div>
            <div class="col-sm-3">
                <span class="small_span2">EXT - </span>
                <input id="txtPrepPhoneExt" name="txtPrepPhoneExt" class="form-control input-sm customwidth1" onchange="ValidatePreparer()">
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-2">
            <label class="control-label  text-custom-left2" for="inputEmail3">Filer E-Mail Address<font style="color:red">*</font>:</label>
            </div>
            <div class="col-sm-3 below_margin01">
                <input id="txtPreparerEmail" class="form-control input-sm" onchange="ValidatePreparer()">
            </div>

        </div>

             <div class="form-group">
           
<%--                <div class="radio">--%>
           <%--         <label class="radio">--%>
                         <div class="col-sm-2">
                         
                          </div>
                        <div class="col-sm-8 below_margin01">
                            <input id="chkAgreement" type="checkbox" id="optionsRadios1" value="option1" checked>  &nbsp;
                            <span><p>
                            Signature box: Under penalties of perjury, as set forth in 18 Pa. C.S. &#167;&#167; 4903-4903 as amended, I swear that I have reviewed this return and, to the best of my knowledge
			                and belief, it is true and complete.
			            </p></span></div>
			
                        
                <%--    </label>--%>
              <%--  </div>--%>
          


        </div>


        <%--<div class="form-group">
            <div class="col-sm-offset-3 col-sm-9  text-right">
                <button class="btn btn-default submit_button" type="submit">Print</button>
                <button class="btn btn-default submit_button" type="submit">Sign in</button>
            </div>
        </div>--%>

    </form>

</body>
</html>
