<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>


<script id="clientEventHandlersJS" language="javascript" type="text/javascript">
    var arrCoupLoginErr = new Array();
    var arrCoupPINErr = new Array();
    var txtCoupTaxType = '';
    var bNtlOnly = 'FALSE';
    var EPaymt = 'FALSE';

    function DisplayCoupLogin(mode,data) {
        var txtCouponAcctID = document.getElementById('txtCouponAcctID');
        parent.sNew = false;
        bNtlOnly = 'FALSE';
        EPaymt = 'FALSE';
        debugger
        if (mode == 'NTL') {
            if (data == 'TRUE') {
                bNtlOnly = 'TRUE';
            }
            else
                bNtlOnly = 'FALSE';
        }
        else if (mode == 'EPayment') {
            if (data == 'TRUE') {
                EPaymt = 'TRUE';
            }
            else
                EPaymt = 'FALSE';
        }
        $('#divPayCoupon').css("display", "block");
        $('#LogCoupon').css("display", "block");
        $('#AppHeader').html('Print Payment Coupons');
        $('#lblMessage').html('All tax payments should be mailed with a proper scannable' +
                                ' payment document. Coupon books are mailed for these remittances. If you need a scannable' +
                                ' payment coupon for any tax type, enter the Social Security Number (SSN), Employer' +
                                ' Identification Number (EIN), Philadelphia Tax Account Number or Real Estate Tax Number (BRT)' +
                                ' below.  You will be presented with a list of the active tax types for that entity.' +
                                ' If you receive a message indicating "SSN/EIN with PIN required for requested account(s)",' +
                                ' the Tax Account ID you entered is inactive or has been rejected for security purposes. You may' +
                                ' start over with another Tax Account ID or you may click' +
                                ' <a id=lnkApply class="lblLink" onclick="LogApply()">here </a>to register for a Tax Account ID.');
        $('#lblMessage1').html('Please enter your Philadelphia Tax Account Number, Employer' +
                                 ' Identification Number (EIN), Social Security Number (SSN) or Real Estate Tax Number (BRT)' +
                                 ' as your Tax Account Id.');
        if (bNtlOnly == 'TRUE') {
            $('#AppHeader').html('File No Tax Liability Coupons')
            $('#lblMessage').html('Please enter your Philadelphia Tax Account Number, Employer' +
                                 ' Identification Number (EIN), Social Security Number (SSN) as your Tax Account ID.' +
                                 ' If you recieve a message indicating "SSN/EIN with PIN required for requested account(s)",' +
                                 ' the Tax Account ID you entered is inactive or has been rejected for security purposes. You may' +
                                 ' start over with another Tax Account ID or you may click' +
                                 ' <a id=lnkApply class="lblLink" onclick="LogApply()">here</a> to register for a Tax Account ID.');
            $('#lblMessage1').html('Please enter your Philadelphia Tax Account Number, Employer' +
                                    'Identification Number (EIN), Social Security Number (SSN) as your Tax Account Id.');
        } 	//if

        if (EPaymt == 'TRUE') {
            $('#AppHeader').html('Make an Electronic Payment')
            $('#lblMessage').html('');
            $('#lblMessage1').html('Please enter your Philadelphia Tax Account Number, Employer Identification Number (EIN)' +
                                    'or Social Security Number (SSN) as your Tax Account Id.');
        } 	//if

        if (EPaymt == 'TRUE') {
            $('#rowAcctid').css("display", "none");
            rowAcctid.style.visibility = 'hidden'
            $('#rowAcctidPIN').css("display", "block");
            rowAcctidPIN.style.visibility = 'visible'
            $('#rowAcctidType').css("display", "none");
            rowAcctidType.style.visibility = 'hidden'
        }
        else {
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
        }

       

    } 	//DisplayCoupLogin

    function LoadCoupLoginError() {
        var i = 0;
        var txtCouponAcctID = document.getElementById('txtCouponAcctID')
       
        arrCoupLoginErr[i++] = [txtCouponAcctID, '$(\'#txtCouponAcctID\').val() == ""', 'Enter Account number']
        arrCoupLoginErr[i++] = [txtCouponAcctID, '($(\'#txtCouponAcctID\').val().length > 12)', 'Invalid Account number']
       
    } 	//LoadCoupLoginError

    function LogApply() {

        $('#LogCoupon').css("display", "none");
        $('#divPayCoupon').css("display", "none");        
        ShowForm('LogApplyFirst');

    } 	//LogApply

    function ValidateCoupLogin() {

        $(AppError_Payment).text(ispSetInputErr(arrCoupLoginErr));
        if ($(AppError_Payment).text() != "") {
            resolvedIframeheight();
            parent.ScrollTop(1);
        }
    }



    var dobj = parent.$g.getXmlDocObj();
    var oCouponInfo = parent.$g.getXmlDocObj();
    var oAcctInfo = parent.$g.getXmlDocObj();

    function DoCoupLogin() {
        debugger;
        var i = 0;
        var el_payc_ind = 0;
        $(AppError_Payment).text('');
        var ddCoupTaxType = document.getElementById('ddCoupTaxType');
        var txtCoupPIN = document.getElementById('txtCoupPIN');

        $(parent.document).find('#mnuOnline').first().attr('online', 'yes');
        if (EPaymt == 'TRUE') {
            ValidateCoupPIN();
        }
        else {
            ValidateCoupLogin();
        }
        //

        if ($(AppError_Payment).text() == '') {

            if (EPaymt == 'TRUE') {
                el_payc_ind = 1;
                
                }
               
            else
            {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ERROR_INFO PROGRAM", '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ERROR_INFO ERROR", '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ERROR_INFO LINE", '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, " ", "ERROR_INFO MESSAGE", '', 0);
               
                el_payc_ind = 2;
             }
            //

           
             //changed the Function code to 'G' SUDIPTA ROY ::2016.11.18
        
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "G", "ENTITY_INFO ENT_TYPE", '', 0);
            if (EPaymt == 'TRUE') {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, $('#txtCouponAcctID2').val(), "ENTITY_INFO ENTITY_ID", '', 0);
                localStorage.setItem("AccountNumber", $('#txtCouponAcctID2').val());
                localStorage.setItem("Pin", $('#txtCoupPIN').val());
            }
            else {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, $('#txtCouponAcctID').val(), "ENTITY_INFO ENTITY_ID", '', 0);
            }
           
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

           
            ispCallXMLForm(parent.$g.xmlPayCoupon, oCouponInfo, "PayCoupon/PayCouponRecv", "");

          
            if (parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO MESSAGE', "", 0) == "") {
                parent.$g.xmlPayCoupon.loadXML(oCouponInfo.xml);
                if (EPaymt == 'TRUE') {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, EPaymt, "LOGIN_FROM NTL_ONLY", '', 0)
                }
                else {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, bNtlOnly, "LOGIN_FROM NTL_ONLY", '', 0)
                }
               
                var tempParameters = 'aaa=' + el_payc_ind + '&el_payc_ind=' + el_payc_ind;
                parent.setFrameUrl('PayCoupon/PayCoupon?y=' + tempParameters);

            } else {
                var err = parent.$x.ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO MESSAGE', "", 0)
                $(AppError_Payment).text(err);
                resolvedIframeheight();
                
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

            $(AppError_Payment).text('');
            $('#btnSubType').removeAttr("disabled");
            var txtCoupTaxType = document.getElementById('txtCoupTaxType');
            txtCoupTaxType = $(ddCoupTaxType.options[ddCoupTaxType.selectedIndex]).attr('CODE');
        } //if

    } //StoreTaxType

    function LoadCoupPINError() {
        debugger;
        //var i = 0;
        $(AppError_Payment).text("");
        var txtCoupPIN = document.getElementById('txtCoupPIN');

        if (document.getElementById("rowAcctidPIN").style.display != "none") {
            var txtCouponAcctID2 = document.getElementById('txtCouponAcctID2');
            if ($('#txtCouponAcctID2').val() == "") {
                $(AppError_Payment).text("Enter Tax account ID");
            }
            else if ($('#txtCoupPIN').val() == "") {
                $(AppError_Payment).text("Enter PIN Number");
            }
            else if (regInteger.exec($('#txtCoupPIN').val()) != $('#txtCoupPIN').val()) {
                $(AppError_Payment).text("PIN Number must be an Integer");
            }
            //arrCoupPINErr[i++] = [txtCouponAcctID2, '$(\'#txtCouponAcctID2\').val() == ""', 'Enter Tax account ID']
        }
        else if (document.getElementById("rowAcctidType").style.display != "none") {
            
            var txtCouponAcctID3 = document.getElementById('txtCouponAcctID3');
            if ($('#txtCouponAcctID3').val() == "") {
                $(AppError_Payment).text("Enter Tax account ID");
            }
        }
        else if (document.getElementById("rowAcctid").style.display != "none") {
            if ($('#txtCouponAcctID').val() == "") {
                $(AppError_Payment).text("Enter Tax account ID");
            }
        }
        
       // arrCoupPINErr[i++] = [txtCoupPIN, '$(\'#txtCoupPIN\').val() == ""', 'Enter PIN Number']
        //arrCoupPINErr[i++] = [txtCoupPIN, 'regInteger.exec($(\'#txtCoupPIN\').val()) != $(\'#txtCoupPIN\').val()', 'PIN Number must be an Integer']

    } 	//LoadCoupPINError

    function ValidateCoupPIN() {
        LoadCoupPINError();
        //var pinerror = ispSetInputErr(arrCoupPINErr);
        //$(AppError_Payment).text(pinerror);
        resolvedIframeheight();
        parent.ScrollTop(1);
    } 	//ValidateCoupPIN


    function DoCoupLoginPIN() {
        //
        debugger;
        $(AppError_Payment).text('');
        $(parent.document).find('#mnuOnline').first().attr('online', 'yes');
        ValidateCoupPIN()

        if ($(AppError_Payment).text() == '') {
           
          
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "I", "ENTITY_INFO FUNCTION_CODE", '', 0);
           
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtCouponAcctID2').val(), "ENTITY_INFO ENTITY_ID", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtCoupPIN').val(), "ENTITY_INFO PIN", '', 0);

            

            ispCallXMLForm(parent.$g.xmlAccount, oAcctInfo, "AccountInfo", "");
            if (parent.$x.ispXmlGetFieldVal(oAcctInfo, 'ERROR_INFO MESSAGE', "", 0) == "") {
                if (parent.$x.ispXmlGetFieldVal(oAcctInfo, 'ENTITY_INFO FORCEPINCHG', "", 0) == "Y") {
                    alert('Your PIN was generated by the Philadelphia Department of Revenue. For security purposes you must change your PIN.');
                    parent.$g.xmlAccount.loadXML(oAcctInfo.xml);
                    ShowForm('LogChangePin');
                } else {
                    parent.$g.xmlPayCoupon.loadXML(oCouponInfo.xml);
                  
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, bNtlOnly, "LOGIN_FROM NTL_ONLY", '', 0);
                    parent.DocWin.location.href = '../PayCoupon/PayCoupon';
                } 	//if
            } else {

                var errtext = parent.$x.ispXmlGetFieldVal(oAcctInfo, 'ERROR_INFO MESSAGE', "", 0);
                $(AppError_Payment).text(errtext);
                resolvedIframeheight();
                parent.ScrollTop(1);
               $('#txtCoupPIN').focus();
            } 	//if
        } else {

            $('#txtCoupPIN').focus();
        } 	//if
    } 	//DoCoupLoginPIN

    function resolvedIframeheight() {
        //iframe height issue resolved
        var iframe = window.parent.document.getElementById('ifrmDocwin');
        var container = $('#tab1').css("height");
        iframe.style.height = container;
    }

    $(function () {
        $('#txtCouponAcctID').keypress(function (evt) {
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                return false;
            }
        }
     );

    });
    $(function (e) {
        $('#txtCouponAcctID').keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                DoCoupLogin();
                $("#btnSubPrint").click();
            }

        });
      
    });
</script>

<div class="container-fluid no-padding">
    <div id="divPayCoupon" class="block3" style="display: none;">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3" name="LogCoupon" style="display: none;" id="LogCoupon">
                    <div class="blue_base_box">
                       
                         <h2>Online Services | <span id="AppHeader"></span>  </h2>
                        <div class="inner_white-panel">
                             <div class="row">
                                   <div class="col-lg-12 ">
                                 <div id="AppError_Payment" class="errormsg no-padding"  style="display:block;"></div>
                                       </div></div>
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
                                                    <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">TAX account ID<span class="lblTextRed">* </span>  : </label>
                                                    <div class="col-sm-9">
                                                        <input class='form-control input-sm' id="txtCouponAcctID" name="txtCouponAcctID" onchange="ValidateCoupLogin()"
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
                                                        <input class='form-control input-sm' id="txtCouponAcctID2" name="txtCouponAcctID2"
                                                            maxlength="12" size="14">
                                                    </div>
                                                </div>
                                                <div class="form-group text-left-custom">
                                                    <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">PIN  : </label>
                                                    <div class="col-sm-9">
                                                        <input class='form-control input-sm' id="txtCoupPIN" name="txtCoupPIN" type="password"
                                                             maxlength="13" size="15" tabindex="0">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-offset-4 col-sm-6">
                                                        <input class="submit_button" id="btnSubPrint" name="btnSubPrint" type="button" value="Submit"
                                                            onclick="DoCoupLogin()">
                                                      
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
                                                        <input class='form-control input-sm' id="txtCouponAcctID3" name="txtCouponAcctID3"
                                                            maxlength="12" size="14" disabled>
                                                        <div class="clear"></div>
                                                    </div>
                                                </div>
                                                <div class="form-group text-left-custom">
                                                    <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">Entity Type:*</label>
                                                    <div class="col-sm-9">
                                                        <select id="ddCoupTaxType" name="ddCoupCoupTaxType" class='form-control' style="width: 79px"
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

                                 
                                </div>

                            </div>

                        </div>

                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

