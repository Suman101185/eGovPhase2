<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<!DOCTYPE html>

<html>
<head>
    <title></title>

<script type="text/javascript" language="javascript" src="Content/Scripts/global.js"></script>
<script type="text/javascript" language="javascript" src="Content/Scripts/ispXmlProc.js"></script>
<!-- Bootstrap Core CSS -->
<link type="text/css" href="../Content/Styles/bootstrap.css" rel="stylesheet" />

<!-- Custom CSS -->
<link type="text/css" href="../Content/Styles/copegov.css" rel="stylesheet" />
<link type="text/css" href="../Content/Styles/style.css" rel="stylesheet" />
<link href="../Content/Styles/Font.css" rel="stylesheet" />
<link type="text/css" href="Content/Styles/jPushMenu.css" rel="stylesheet" />
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript" src="Content/js/jquery.js"></script>
<!-- Bootstrap Core JavaScript -->
<script type="text/javascript" src="Content/js/bootstrap.min.js"></script>
<script type="text/javascript" src="Content/js/jPushMenu.js"></script>
<script type="text/javascript" language="javascript">
    var arrForgotPinErr = new Array();
    var oEmail = parent.$g.getXmlDocObj();
    var oAcctInfo = parent.$g.getXmlDocObj();
    function DisplayForgotPin() {
        // $(AppError_Fp).text('');
        parent.sNew = false;
        
        $('#divForgotPinNew').css("display", "block");
        $('#divForgotPin').css("display", "block");
        $('#AppHeaderForgotPin').html(txtHeader + '<span> | Forgot PIN</span>');
        $('#divPayCoupon').css("display", "none");
        
        ClearForgotPinScreen();
        LoadForgotPinError();
        $('#txtFpAcctID').focus();
    } 	//DisplayForgotPin


    function ClearForgotPinScreen() {

        //Sanghamitra
        //for (i = 0; i < document.all.length; i++) {
        //    if (document.all.item(i).id.search(/txt/i) != -1) {
        //        document.all.item(i).value = '';
        //        document.all.item(i).className = 'inpNormal';
        //    } 	//if
        //} 	//for
        //sanghamitra
       //manoranjan
        $('#txtFpAcctID').val('');
        $('#txtFpTaxID').val('');
      
        //$('#txtFpTaxID').attr('class', 'inpNormal');

    } 	//ClearForgotPinScreen
   

    function LoadForgotPinError() {
        var i = 0;
        var txtFpAcctID = document.getElementById('txtFpAcctID');
        var txtFpTaxID = document.getElementById('txtFpTaxID');
        //Account Id	
        arrForgotPinErr[i++] = [txtFpAcctID, '$(\'#txtFpAcctID\').val()' == "", 'Enter SSN/EIN number']
        arrForgotPinErr[i++] = [txtFpAcctID, 'isNaN($(\'#txtFpAcctID\').val())', 'SSN/EIN not numeric']
        arrForgotPinErr[i++] = [txtFpAcctID, '($(\'#txtFpAcctID\').val().length != 9)', 'Invalid SSN/EIN number']

        //Tax ID
        arrForgotPinErr[i++] = [txtFpTaxID, '$(\'#txtFpTaxID\').val() == ""', 'Enter Tax Account number']
        arrForgotPinErr[i++] = [txtFpTaxID, 'isNaN($(\'#txtFpTaxID\').val())', 'Tax Account number not numeric']
        arrForgotPinErr[i++] = [txtFpTaxID, '$(\'#txtFpTaxID\').val().length < 7', 'Invalid Tax Account number']
    } 	//LoadForgotPinError

    $(function () {
        $('#txtFpAcctID').keypress(function (evt) {
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                return false;
            }
        });
    });

    $(function () {
        $('#txtFpTaxID').keypress(function (evt) {
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                return false;
            }
        });
    });
   
    function ValidateForgotPin() {
        $(AppError_Fp).text('');
        var errforgot = ispSetInputErr(arrForgotPinErr);
        $(AppError_Fp).text(errforgot);
        resolvedIframeheight();
    } 	//ValidateForgotPin


    function loadXmlFiles() {
        parent.$g.loadXmlSync('XML/AcctTemplate', parent.parseXml_xmlAccount);
        parent.$g.loadXmlSync('XML/email', parent.parseXml_xmlEmail);


    }

    function load_oEmail(xml) {
        oEmail.xml = xml;
    }

    var dobj = parent.$g.getXmlDocObj();

    var emailobj = parent.$g.getXmlDocObj();
    // var oAcctInfo = parent.$g.getXmlDocObj();
    $(function (e) {
        $('#txtFpAcctID').keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                SubmitForgotPin();
                $("#btnFpApply").click();
            }

        });
        $("#txtFpTaxID").keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                SubmitForgotPin();
                $("#btnFpApply").click();
            }

        });
        $("#btnFpApply").keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                SubmitForgotPin();
                $("#btnFpApply").click();
            }

        });

    });
    function SubmitForgotPin() {      
     
        //if (txtFpTaxID.value == '') {
        //    txtFpTaxID.value = txtFpAcctID.value;
        //} 	//if

        loadXmlFiles();

        ValidateForgotPin();
        if ($(AppError_Fp).text() == '') {

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "4", "ENTITY_INFO FUNCTION_CODE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtFpAcctID').val(), "ENTITY_INFO ENTITY_ID", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtFpTaxID').val(), "ENTITY_INFO ACCOUNT_ID", '', 0);

            ispCallXMLForm(parent.$g.xmlAccount, parent.$g.xmlAccount, "AccountInfo", "");


            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ERROR_INFO MESSAGE', "", 0) == "") {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO PIN', "", 0) == "0") {
                    var nopin = 'No PIN on file. Use \'PIN apply\' to get your PIN';
                    $(AppError_Fp).text(nopin);
                    $('#txtFpTaxID').val('');

                    return;
                } 	//if
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS EMAIL', "", 0) == "") {
                    var noemail = 'No E-mail address on file. Use \'PIN apply\' to get your PIN';
                    $(AppError_Fp).text(noemail);
                    $('#txtFpTaxID').val('');
                    return;
                } 	//if
                sTemp = CreateEmail();

                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'FORGOTPIN', 'FUNCTION', '', 0);

                sTemp = sTemp.replace('>', '&GT&');
                sTemp = sTemp.replace('<', '&LT&');
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, sTemp, 'DATA', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS EMAIL', "", 0), "ADDRESS", '', 0);

                ispCallXMLForm(parent.$g.xmlEmail, parent.$g.xmlEmail, "MailPIN", "");
                debugger;
                ShowForm('ApplyPinThankYou');
            } else {

                var err = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ERROR_INFO MESSAGE', "", 0);
                $(AppError_Fp).text(err);
                resolvedIframeheight();
                $('#txtFpAcctID').focus();
            } 	//if
        } else {
            $('#txtFpAcctID').focus();
        } 	//if


    } 	//SubmitPinApply
</script>

</head>
<body>
<div class="container-fluid no-padding">
    <div id="divForgotPinNew" class="block3" style="display: none;">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3" name="divForgotPin" style="display: none;" id="divForgotPin">
                    <div class="blue_base_box">
                        <h2 id="AppHeaderForgotPin"></h2>

                        <div class="inner_white-panel">
                             <div class="row">
                                   <div class="col-lg-12 col-lg-offset-0">
                                 <div id="AppError_Fp" class="errormsg no-padding" style="display:block;"></div>
                                       </div></div>
                            <div class="contentsection">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h4>Please enter your Employee Identification Number (EIN) or Social Security Number
                                                (SSN).<br>
                                            
                                            For Earnings Tax and School Income Tax filers, your Social Security number is your
                                                Philadelphia Tax Account number.<br>
                                            
                                            <span class="lblTextRed">* </span>Required Field</h4>
                                    </div>
                                </div>
                               
                                <div class="row">

                                    <div class="col-lg-12">

                                        <form class="form-horizontal login_form">
                                            <div class="form-group text-left-custom">
                                                <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">SSN / EIN<span class="lblTextRed">* </span>: </label>
                                                <div class="col-sm-9">
                                                    <%-- <input type="email" class="form-control input-sm" id="inputEmail3" placeholder="Email">--%>
                                                    <input id="txtFpAcctID" name="txtFpAcctID" onchange="ValidateForgotPin()"
                                                        maxlength="9" size="17" class="form-control input-sm inpNormal">
                                                </div>
                                            </div>
                                            <div class="form-group text-left-custom">
                                                <label for="inputPassword3" class="col-sm-3 control-label text-left-custom">Phila. Tax Account No.<span class="lblTextRed">* </span>: </label>
                                                <div class="col-sm-9">
                                                    <%--<input type="password" class="form-control  input-sm" id="inputPassword3" placeholder="Password">--%>
                                                    <input id="txtFpTaxID" name="txtFpTaxID" onchange="ValidateForgotPin()"
                                                        maxlength="9" size="17" class="form-control input-sm inpNormal">
                                                </div>

                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-4 col-sm-6">
                                                    <%-- <button type="submit" class="btn btn-default submit_button" id="btnLogin" onclick="DoLogin()">Submit</button>--%>
                                                    <input class="btn btn-default submit_button" id="btnFpApply" name="btnFpApply" type="button" value="Send"
                                                        onclick="return SubmitForgotPin()" size="48">
                                                </div>
                                            </div>


                                        </form>

                                    </div>

                                    <%-- <div class="clearfix"></div>--%>
                                </div>

                            </div>

                        </div>

                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>