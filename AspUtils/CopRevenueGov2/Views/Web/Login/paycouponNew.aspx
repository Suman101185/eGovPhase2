<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>


<script id="clientEventHandlersJS" language="javascript" type="text/javascript">
    var arrCoupLoginErr = new Array();
    var arrCoupPINErr = new Array();
    var txtCoupTaxType = '';
    var bNtlOnly = 'FALSE';

    function DisplayCoupLogin() {
        var txtCouponAcctID = document.getElementById('txtCouponAcctID');
        parent.sNew = false;
        divPayCoupon

        $('#divPayCoupon').css("display", "block");
        $('#LogCoupon').css("display", "block");
        $('#AppHeader').html('<Span class=hdrLarge>Online Services</Span>' + '<Span class=hdrMedium>|Print Payment Coupons</Span>');
        $('#lblMessage').html('All tax payments should be mailed with a proper scannable' +
                                ' payment document. Coupon books are mailed for these remittances. If you need a scannable' +
                                ' payment coupon for any tax type, enter the Social Security Number (SSN), Employer' +
                                ' Identification Number (EIN), Philadelphia Tax Account Number or Real Estate Tax Number (BRT)' +
                                ' below.  You will be presented with a list of the active tax types for that entity.' +
                                ' If you receive a message indicating "SSN/EIN with PIN required for requested account(s)",' +
                                ' the Tax Account ID you entered is inactive or has been rejected for security purposes. You may' +
                                ' start over with another Tax Account ID or you may click' +
                                ' <a id=lnkApply class="lblLink" onclick="LogApply()">here</a>to register for a Tax Account ID.');
        $('#lblMessage1').html('Please enter your Philadelphia Tax Account Number, Employer' +
                                 ' Identification Number (EIN), Social Security Number (SSN) or Real Estate Tax Number (BRT)' +
                                 ' as your Tax Account Id.');
        if (bNtlOnly == 'TRUE') {
            $('#AppHeader').html('<Font class=hdrLarge>Online Services</Font>' +
                                   '<Font class=hdrMedium>|File No Tax Liability Coupons</Font>')
            $('#lblMessage').html('Please enter your Philadelphia Tax Account Number, Employer' +
                                 ' Identification Number (EIN), Social Security Number (SSN) as your Tax Account ID.' +
                                 ' If you recieve a message indicating "SSN/EIN with PIN required for requested account(s)",' +
                                 ' the Tax Account ID you entered is inactive or has been rejected for security purposes. You may' +
                                 ' start over with another Tax Account ID or you may click' +
                                 ' <a id=lnkApply class="lblLink" onclick="LogApply()">here</a> to register for a Tax Account ID.');
            $('#lblMessage1').html('Please enter your Philadelphia Tax Account Number, Employer' +
                                    'Identification Number (EIN), Social Security Number (SSN) as your Tax Account Id.');
        } 	//if



        $('#txtCouponAcctID').val('');
        $('#rowAcctid').css("display", "block");
        rowAcctid.style.visibility = 'visible'
        $('#rowAcctidPIN').css("display", "none");
        rowAcctidPIN.style.visibility = 'hidden'
        $('#rowForgotPIN').css("display", "none");
        rowForgotPIN.style.visibility = 'hidden'
        $('#rowAcctidType').css("display", "none");
        rowAcctidType.style.visibility = 'hidden'
        LoadCoupLoginError();
        txtCouponAcctID.focus();

    } 	//DisplayCoupLogin

    function LoadCoupLoginError() {
        var i = 0;
        var txtCouponAcctID = document.getElementById('txtCouponAcctID')
       
        arrCoupLoginErr[i++] = [txtCouponAcctID, '$(\'#txtCouponAcctID\').val() == ""', 'Enter ID Number']
        arrCoupLoginErr[i++] = [txtCouponAcctID, '($(\'#txtCouponAcctID\').val().length > 12)', 'Invalid Account Number']
    } 	//LoadCoupLoginError

    function LogApply() {

        $('#LogCoupon').css("display", "none");
        // parent.ispHighlightMenu(parent.mnuLogNewAcct);
        ShowForm('LogApplyFirst');

    } 	//LogApply

    function ValidateCoupLogin() {

        $(parent.AppError).text(ispSetInputErr(arrCoupLoginErr));


    }



    var dobj = parent.$g.getXmlDocObj();
    var oCouponInfo = parent.$g.getXmlDocObj();
    var oAcctInfo = parent.$g.getXmlDocObj();

    function DoCoupLogin() {
        var i = 0;
        $(parent.AppError).text('');
        var ddCoupTaxType = document.getElementById('ddCoupTaxType');
        var txtCoupPIN = document.getElementById('txtCoupPIN');

        $(parent.document).find('#mnuOnline').first().attr('online', 'yes');
        ValidateCoupLogin();

        if ($(parent.AppError).text() == '') {

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ERROR_INFO PROGRAM", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ERROR_INFO ERROR", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ERROR_INFO LINE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ERROR_INFO MESSAGE", '', 0);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "I", "ENTITY_INFO FUNCTION_CODE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, txtCoupTaxType, "ENTITY_INFO ENT_TYPE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, txtCouponAcctID.value, "ENTITY_INFO ENTITY_ID", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ENTITY_INFO ACCT_ID", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ENTITY_INFO NAME", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ENTITY_INFO ADDRESS1", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ENTITY_INFO ADDRESS2", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ENTITY_INFO ADDRESS3", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ENTITY_INFO CITY", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ENTITY_INFO STATE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ENTITY_INFO ZIP_CODE", '', 0);

            for (i = 0; i < 200; i++) {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "TAX_ACCT FUNC_CODE", '', i);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "0", "TAX_ACCT ACCOUNT", '', i);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "TAX_ACCT ACCOUNT_ID", '', i);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "TAX_ACCT START_DATE", '', i);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "TAX_ACCT END_DATE", '', i);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "TAX_ACCT FREQUENCY_CODE", '', i);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "TAX_ACCT BRT_ACCOUNT", '', i);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "TAX_ACCT BRT_ADDRESS1", '', i);
            }  //for

            // alert(parent.$g.xmlPayCoupon);
            ispCallXMLForm(parent.$g.xmlPayCoupon, oCouponInfo, "PayCoupon/PayCouponRecv", "");

            //alert("abcdd");
            if (parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO MESSAGE', "", 0) == "") {
                parent.$g.xmlPayCoupon.loadXML(oCouponInfo.xml);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, bNtlOnly, "LOGIN_FROM NTL_ONLY", '', 0)
                //parent.DocWin.location.href = '../PayCoupon/PayCoupon'
                parent.setFrameUrl('PayCoupon/PayCoupon');

            } else {
                var err = parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO MESSAGE', "", 0)
                $(parent.AppError).text(err);
                //alert((new XMLSerializer()).serializeToString(parent.$g.xmlPayCoupon));
                if (parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO ERROR', "", 0) == "2") {

                    $('#rowAcctid').css("display", "none");
                    $('#rowAcctid').css("visibility", "hidden");
                    $('#rowAcctidPIN').css("display", "none");
                    $('#rowAcctidPIN').css("visibility", "hidden");
                    $('#rowForgotPIN').css("display", "none");
                    $('#rowForgotPIN').css("visibility", "hidden");
                    $('#rowAcctidType').css("display", "block");
                    $('#rowAcctidType').css("visibility", "visible");
                    $('#txtCouponAcctID3').val($('#txtCouponAcctID').val());
                    LoadGenericDD(parent.xmlEntitytypeCoupon, ddCoupTaxType, "DDOWN", false);
                    $('#ddCoupTaxType').selectedIndex = 0;
                    $('#btnSubType').attr("disabled", "disabled");
                    ddCoupTaxType.focus();

                } else {

                    if (parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO ERROR', "", 0) == "3") {
                        $('#txtCouponAcctID2').val($('#txtCouponAcctID').val());
                        $('#txtCoupPIN').val('');
                        $('#rowAcctid').css("display", "none");
                        $('#rowAcctid').css("visibility", "hidden");
                        $('#rowAcctidPIN').css("display", "block");
                        $('#rowAcctidPIN').css("visibility", "visible");
                        $('#rowForgotPIN').css("display", "block");
                        $('#rowForgotPIN').css("visibility", "visible");
                        $('#rowAcctidType').css("display", "none");
                        $('#rowAcctidType').css("visibility", "hidden");
                        txtCoupPIN.focus();

                    } //if   
                } //if   
            } //if
        } //if
    } 	//DoCoupLogin

    function StoreTaxType() {
        if ($('#ddCoupTaxType').selectedIndex != 0) {

            $(parent.AppError).text('');
            $('#btnSubType').removeAttr("disabled");
            var txtCoupTaxType = document.getElementById('txtCoupTaxType');
            txtCoupTaxType = $(ddCoupTaxType.options[ddCoupTaxType.selectedIndex]).attr('CODE');
        } //if

    } //StoreTaxType

    function LoadCoupPINError() {

        var i = 0;
        var txtCoupPIN = document.getElementById('txtCoupPIN');

        arrCoupPINErr[i++] = [txtCoupPIN, '$(\'#txtCoupPIN\').val() == ""', 'Enter PIN Number']
        arrCoupPINErr[i++] = [txtCoupPIN, 'regInteger.exec($(\'#txtCoupPIN\').val()) != $(\'#txtCoupPIN\').val()', 'PIN Number must be an Integer']

    } 	//LoadCoupPINError

    function ValidateCoupPIN() {
        LoadCoupPINError();
        var pinerror = ispSetInputErr(arrCoupPINErr);
        $(parent.AppError).text(pinerror);

    } 	//ValidateCoupPIN


    function DoCoupLoginPIN() {

        var txtCouponAcctID2 = document.getElementById('txtCouponAcctID2');
        var txtCoupPIN = document.getElementById('txtCoupPIN');


        $(parent.AppError).text('');
        $(parent.document).find('#mnuOnline').first().attr('online', 'yes');
        ValidateCoupPIN()

        if ($(parent.AppError).text() == '') {


            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "I", "ENTITY_INFO FUNCTION_CODE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtCouponAcctID2.value, "ENTITY_INFO ENTITY_ID", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtCoupPIN.value, "ENTITY_INFO PIN", '', 0);

            ispCallXMLForm(parent.$g.xmlAccount, oAcctInfo, "AccountInfo", "");
            if (parent.$x.ispXmlGetFieldVal(oAcctInfo, 'ERROR_INFO MESSAGE', "", 0) == "") {
                if (parent.$x.ispXmlGetFieldVal(oAcctInfo, 'ENTITY_INFO FORCEPINCHG', "", 0) == "Y") {
                    alert('Your PIN was generated by the Philadelphia Department of Revenue. For security purposes you must change your PIN.');
                    parent.$g.xmlAccount.loadXML(oAcctInfo.xml);
                    ShowForm('LogChangePin');
                } else {
                    parent.$g.xmlPayCoupon.loadXML(oCouponInfo.xml);
                    //alert((new XMLSerializer()).serializeToString(oCouponInfo.xmlDoc));
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, bNtlOnly, "LOGIN_FROM NTL_ONLY", '', 0);
                    parent.DocWin.location.href = '../PayCoupon/PayCoupon';
                } 	//if
            } else {

                var errtext = parent.$x.ispXmlGetFieldVal(oAcctInfo, 'ERROR_INFO MESSAGE', "", 0);
                $(parent.AppError).text(errtext);
                txtCoupPIN.focus();
            } 	//if
        } else {

            txtCoupPIN.focus();
        } 	//if
    } 	//DoCoupLoginPIN



</script>

<div class="container-fluid no-padding">
    <div id="divPayCoupon" class="block3" style="display: none;">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3" name="LogCoupon" style="display: none;" id="LogCoupon">
                    <div class="blue_base_box">
                        <h2 id="AppHeader"></h2>

                        <div class="inner_white-panel">

                            <div class="contentsection">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h4 id="lblMessage"></h4>
                                        <h4 id="lblMessage1"></h4>
                                    </div>
                                </div>
                                <div class="clearfix"></div>

                                <div class="row">

                                    <div class="col-lg-12">

                                        <form class="form-horizontal login_form">

                                            <div class="row" id="rowAcctid">
                                                <div class="form-group text-left-custom">
                                                    <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">TAX account ID  : </label>
                                                    <div class="col-sm-9">
                                                        <input class="inpNormal" id="txtCouponAcctID" name="txtCouponAcctID" onchange="ValidateCoupLogin()"
                                                            maxlength="12" size="14">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-offset-4 col-sm-6">
                                                        <input class="submit_button" id="btnSubPrint" name="btnSubPrint" type="button" value="Submit"
                                                            onclick="DoCoupLogin()">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row" id="rowAcctidPIN">
                                                <div class="form-group text-left-custom">
                                                    <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">TAX account ID  : </label>
                                                    <div class="col-sm-9">
                                                        <input class="inpNormal" id="txtCouponAcctID2" name="txtCouponAcctID2"
                                                            maxlength="12" size="14" disabled>
                                                    </div>
                                                </div>
                                                <div class="form-group text-left-custom">
                                                    <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">PIN  : </label>
                                                    <div class="col-sm-9">
                                                        <input class="inpNormal" id="txtCoupPIN" name="txtCoupPIN" type="password"
                                                            onchange="ValidateCoupPIN()" maxlength="13" size="15" tabindex="0">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-offset-4 col-sm-6">
                                                        <input class="btnNormal" id="btnSubPIN" name="btnSubPIN" type="button" value="Submit"
                                                            onclick="DoCoupLoginPIN()" class="submit_button">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row" id="rowForgotPIN">
                                                <div class="form-group text-left-custom">
                                                    <p id="lnkForgotPin" class="lblLink" style="margin-bottom: 10px; margin-left: 10px"
                                                        onclick="ShowForm('divForgotPin')">
                                                        Forgot Pin
                                                    </p>

                                                    <div class="clear"></div>
                                                </div>
                                            </div>
                                            <div class="row" id="rowAcctidType">
                                                <div class="form-group text-left-custom">
                                                    <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">TAX account ID  : </label>
                                                    <div class="col-sm-9">
                                                        <input class="inpNormal" id="txtCouponAcctID3" name="txtCouponAcctID3"
                                                            maxlength="12" size="14" disabled>
                                                        <div class="clear"></div>
                                                    </div>
                                                </div>
                                                <div class="form-group text-left-custom">
                                                    <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">Entity Type:*</label>
                                                    <div class="col-sm-9">
                                                        <select id="ddCoupTaxType" name="ddCoupCoupTaxType" class="inpNormal" style="width: 79px"
                                                            onchange="StoreTaxType()">
                                                        </select>
                                                        <div class="clear"></div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-offset-4 col-sm-6">
                                                        <input class="btnNormal" id="Button1" name="btnSubPIN" type="button" value="Submit"
                                                            onclick="DoCoupLoginPIN()" class="submit_button">
                                                        <div class="clear"></div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-offset-4 col-sm-6">
                                                        <input class="btnNormal" id="btnSubType" name="btnSubType" type="button" value="Submit"
                                                            onclick="DoCoupLogin()">
                                                        <div class="clear"></div>
                                                    </div>
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

