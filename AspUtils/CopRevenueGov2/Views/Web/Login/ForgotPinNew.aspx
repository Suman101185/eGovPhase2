<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>


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
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
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

        parent.sNew = false;
        
        $('#divForgotPinNew').css("display", "block");
        $('#divForgotPin').css("display", "block");
        $('#AppHeaderForgotPin').html(txtHeader + '<span>|Forgot PIN</span>');

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

        document.getElementById('txtFpAcctID').value = "";
        $('#txtFpAcctID').text('');

        document.getElementById('txtFpTaxID').value = "";
        //$('#txtFpTaxID').attr('class', 'inpNormal');

    } 	//ClearForgotPinScreen


    function LoadForgotPinError() {
        var i = 0;
        var txtFpAcctID = document.getElementById('txtFpAcctID');
        var txtFpTaxID = document.getElementById('txtFpTaxID');
        //Account Id	
        arrForgotPinErr[i++] = [txtFpAcctID, '$(\'#txtFpAcctID\').val()' == "", 'Enter SSN/EIN Number']
        arrForgotPinErr[i++] = [txtFpAcctID, 'isNaN($(\'#txtFpAcctID\').val())', 'SSN/EIN Not Numeric']
        arrForgotPinErr[i++] = [txtFpAcctID, '($(\'#txtFpAcctID\').val().length !== 9)', 'Invalid SSN/EIN Number']

        //Tax ID
        arrForgotPinErr[i++] = [txtFpTaxID, '$(\'#txtFpTaxID\').val() == ""', 'Enter Tax Account Number']
        arrForgotPinErr[i++] = [txtFpTaxID, 'isNaN($(\'#txtFpTaxID\').val())', 'Tax Account Number Not Numeric']
        arrForgotPinErr[i++] = [txtFpTaxID, '$(\'#txtFpTaxID\').val().length < 7', 'Invalid Tax Account Number']
    } 	//LoadForgotPinError


    function ValidateForgotPin() {
        var errforgot = ispSetInputErr(arrForgotPinErr);
        $(parent.AppError).text(errforgot);

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

    function SubmitForgotPin() {

        var txtFpAcctID = document.getElementById('txtFpAcctID');
        var txtFpTaxID = document.getElementById('txtFpTaxID');

        if (txtFpTaxID.value == '') {
            txtFpTaxID.value = txtFpAcctID.value;
        } 	//if

        loadXmlFiles();

        ValidateForgotPin();
        if ($(parent.AppError).text() == '') {

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "4", "ENTITY_INFO FUNCTION_CODE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtFpAcctID.value, "ENTITY_INFO ENTITY_ID", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtFpTaxID.value, "ENTITY_INFO ACCOUNT_ID", '', 0);

            ispCallXMLForm(parent.$g.xmlAccount, parent.$g.xmlAccount, "AccountInfo", "");


            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ERROR_INFO MESSAGE', "", 0) == "") {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO PIN', "", 0) == "0") {
                    var nopin = 'No PIN on file. Use \'PIN apply\' to get your PIN';
                    $(parent.AppError).text(nopin);
                    txtFpTaxID.value = '';

                    return;
                } 	//if
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS EMAIL', "", 0) == "") {
                    var noemail = 'No E-mail address on file. Use \'PIN apply\' to get your PIN';
                    $(parent.AppError).text(noemail);
                    txtFpTaxID.value = '';
                    return;
                } 	//if
                sTemp = CreateEmail();

                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'FORGOTPIN', 'FUNCTION', '', 0);

                sTemp = sTemp.replace('>', '&GT&');
                sTemp = sTemp.replace('<', '&LT&');
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, sTemp, 'DATA', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS EMAIL', "", 0), "ADDRESS", '', 0);

                ispCallXMLForm(parent.$g.xmlEmail, parent.$g.xmlEmail, "MailPIN", "");

                ShowForm('ApplyPinThankYou');
            } else {

                var err = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ERROR_INFO MESSAGE', "", 0);
                $(parent.AppError).text(err);
                txtFpAcctID.focus();
            } 	//if
        } else {
            txtFpAcctID.focus();
        } 	//if


    } 	//SubmitPinApply
</script>


<div class="container-fluid no-padding">
    <div id="divForgotPinNew" class="block3" style="display: none;">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3" name="divForgotPin" style="display: none;" id="divForgotPin">
                    <div class="blue_base_box">
                        <h2 id="AppHeaderForgotPin"></h2>

                        <div class="inner_white-panel">

                            <div class="contentsection">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h4>Please enter your Employee Identification Number (EIN) or Social Security Number
                                                (SSN).<br>
                                            <br>
                                            For Earnings Tax and School Income Tax filers, your Social Security number is your
                                                Philadelphia Tax Account number.<br>
                                            <br>
                                            <font class="lblTextRed">* </font>Required Field</h4>
                                    </div>
                                </div>
                                <div class="clearfix"></div>

                                <div class="row">

                                    <div class="col-lg-12">

                                        <form class="form-horizontal login_form">
                                            <div class="form-group text-left-custom">
                                                <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">SSN / EIN: *  : </label>
                                                <div class="col-sm-9">
                                                    <%-- <input type="email" class="form-control input-sm" id="inputEmail3" placeholder="Email">--%>
                                                    <input id="txtFpAcctID" name="txtFpAcctID" onchange="ValidateForgotPin()"
                                                        maxlength="9" size="17" class="form-control input-sm inpNormal">
                                                </div>
                                            </div>
                                            <div class="form-group text-left-custom">
                                                <label for="inputPassword3" class="col-sm-3 control-label text-left-custom">Phila. Tax Account No.: *</label>
                                                <div class="col-sm-9">
                                                    <%--<input type="password" class="form-control  input-sm" id="inputPassword3" placeholder="Password">--%>
                                                    <input id="txtFpTaxID" name="txtFpTaxID" onchange="ValidateForgotPin()"
                                                        maxlength="9" size="17" class="form-control input-sm inpNormal">
                                                </div>

                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-4 col-sm-6">
                                                    <%-- <button type="submit" class="btn btn-default submit_button" id="btnLogin" onclick="DoLogin()">Submit</button>--%>
                                                    <input class="submit_button" id="btnFpApply" name="btnFpApply" type="button" value="Apply"
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

