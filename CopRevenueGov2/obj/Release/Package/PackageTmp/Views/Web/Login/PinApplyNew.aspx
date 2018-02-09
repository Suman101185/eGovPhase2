<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>


<script type="text/javascript" language="javascript">
    var arrPinApplyErr = new Array();
    var oEmail = parent.$g.getXmlDocObj();

    function DisplayPinApply() {

        parent.sNew = false;
        $('#divPinApply').css("display", "block");
        $('#LogPinApply').css("display", "block");
       
        AppHeaderPinApply.innerHTML = txtHeader + '<Span class=hdrMedium> | PIN apply</Span>';
        //added by ajoy
        loadXmlFiles();
        ClearPinApplyScreen();
        LoadPinApplyError();
        $('#txtPaAcctID').val('');
        $('#txtPaTaxID').val('');
        $('#txtPaEmail').val('');
        $('#txtPaAcctID').focus();
    }		//DisplayPinApply


    function loadXmlFiles() {
       
        parent.$g.loadXmlSync('XML/email', parent.load_oEmail);
    }



    function load_oEmail(xml) {
        oEmail.xml = xml;
    }

    function ClearPinApplyScreen() {

       
    }		//ClearPinApplyScreen
    $(function () {
        $('#txtPaAcctID').keypress(function (evt) {
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                return false;
            }
        });
    });

    $(function () {
        $('#txtPaTaxID').keypress(function (evt) {
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                return false;
            }
        });
    });//by manoranjan  
  
    function LoadPinApplyError() {
        // modified by manoranjan: 02-Mar-2016
        var i = 0;
        var txtPaAcctID = document.getElementById('txtPaAcctID');
        var txtPaTaxID = document.getElementById('txtPaTaxID');
        var txtPaEmail = document.getElementById('txtPaEmail');
        //Account Id	
        arrPinApplyErr[i++] = [txtPaAcctID, '$(\'#txtPaAcctID\').val()== ""', 'Enter SSN/EIN number']
        arrPinApplyErr[i++] = [txtPaAcctID, 'isNaN($(\'#txtPaAcctID\').val())', 'SSN/EIN not numeric']
        arrPinApplyErr[i++] = [txtPaAcctID, '($(\'#txtPaAcctID\').val().length != 9) && ' +
                '($(\'#txtPaAcctID\').val().length != 12)', 'Invalid SSN/EIN number']

        //Tax ID
        
        arrPinApplyErr[i++] = [txtPaTaxID, '$(\'#txtPaTaxID\').val()== ""', 'Enter Tax Account number']
        arrPinApplyErr[i++] = [txtPaTaxID, 'isNaN($(\'#txtPaTaxID\').val())', 'Tax Account number not numeric'];
        arrPinApplyErr[i++] = [txtPaTaxID, '$(\'#txtPaTaxID\').val().length > 0 && ' +
                '$(\'#txtPaTaxID\').val().length < 7', 'Invalid Tax Account number'];      

        //Email
        arrPinApplyErr[i++] = [txtPaEmail, '$(\'#txtPaEmail\').val() == ""', 'Email Address required'];
        arrPinApplyErr[i++] = [txtPaEmail, '$(\'#txtPaEmail\').val() !="" && ' +
                '($(\'#txtPaEmail\').val().indexOf("@") == -1 || $(\'#txtPaEmail\').val().indexOf(".") == -1)',
                'Email Address invalid format'];

        
    }		//LoadPinApplyError

    var dobj = parent.$g.getXmlDocObj();
    var emailobj = parent.$g.getXmlDocObj();

    function ValidatePinApply() {
        //change by ajoy   
        var errMsg = ispSetInputErr(arrPinApplyErr)
        $(AppError_Pa).text(errMsg);
        resolvedIframeheight();
    } //ValidatePinApplyLogin
    $(function (e) {
        $('#txtPaAcctID').keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                SubmitPinApply();
                $("#btnFpApply").click();
            }

        }); 
        $("#txtPaTaxID").keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                SubmitPinApply();
                $("#btnFpApply").click();
            }

        });
        $("#txtPaEmail").keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                SubmitPinApply();
                $("#btnFpApply").click();
            }

        });
        $("#btnPaApply").keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                SubmitPinApply();
                $("#btnFpApply").click();
            }

        });

    });

    function SubmitPinApply() {

        ValidatePinApply();
        var app = $(AppError_Pa).text();

        if (app == '') {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "2", "ENTITY_INFO FUNCTION_CODE", '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtPaAcctID').val(), "ENTITY_INFO ENTITY_ID", '', 0)
            if ($('#txtPaTaxID').val == '') {

                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtPaAcctID').val(), "ENTITY_INFO ACCOUNT_ID", '', 0)
            } else {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtPaTaxID').val(), "ENTITY_INFO ACCOUNT_ID", '', 0)
            }		//if
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtPaEmail').val(), "NAME_ADDRESS EMAIL", '', 0)

            ispCallXMLForm(parent.$g.xmlAccount, dobj, "AccountInfo", "", true);
            parent.$g.xmlAccount.loadXML(dobj.xml);

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ERROR_INFO MESSAGE', "", 0) == "") {
                sTemp = CreateEmail();

                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'NEWPIN', "FUNCTION", '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, sTemp, "DATA", '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, $('#txtPaEmail').val(), "ADDRESS", '', 0);

                ispCallXMLForm(parent.$g.xmlEmail, emailobj, "MailPIN", "");


                oEmail = emailobj;

                $('#LogPinApply').css('display', 'none');
                DisplayThankYou('APPLYPIN');
            } else {
                $(AppError_Pa).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ERROR_INFO MESSAGE', "", 0));
                resolvedIframeheight();
                //			ispHideProgress()
                $('#txtPaAcctID').focus()
            }		//if
        } else {
            //		ispHideProgress()
            $('#txtPaAcctID').focus()
        }		//if
    }		//SubmitPinApply
</script>

<div class="container-fluid no-padding">
    <div id="divPinApply" class="" style="display: none;">
        <div class="container-fluid">
            <div class="row row-no-margin">
                <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3" name="LogPinApply" style="display: none;" id="LogPinApply">
                    <div class="blue_base_box">
                        <h2 id="AppHeaderPinApply"></h2>

                        <div class="inner_white-panel">
                             <div class="row">
                                   <div class="col-lg-12 col-lg-offset-0">
                                 <div id="AppError_Pa" class="errormsg no-padding" style="display:block;"></div>
                                       </div></div>
                            <div class="contentsection">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h4>Please enter your Social Security Number(SSN)/
				                                Employer Identification Number(EIN), your Philadelphia Tax Account No., and 
				                                your e-mail address.<br>
                                            <span class="lblTextRed">* </span>Required Field</h4>
                                    </div>
                                </div>
                                <div class="clearfix"></div>

                                <div class="row">

                                    <div class="col-lg-12">

                                        <form class="form-horizontal login_form">

                                            <div class="form-group text-left-custom">
                                                <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">SSN / EIN<span class="lblTextRed">* </span>:  </label>
                                                <div class="col-sm-9">
                                                    <input id="txtPaAcctID" name="txtPaAcctID" onchange="ValidatePinApply()"
                                                        maxlength="9" size="17" class="form-control input-sm">
                                                    <div class="clear"></div>
                                                </div>
                                            </div>
                                            <div class="form-group text-left-custom">
                                                <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">Phila. Tax Account No.<span class="lblTextRed">* </span>: </label>
                                                <div class="col-sm-9">
                                                    <input id="txtPaTaxID" name="txtPaTaxID" onchange="ValidatePinApply()"
                                                        maxlength="12" size="17" class="form-control input-sm">
                                                    <div class="clear"></div>
                                                </div>
                                            </div>
                                            <div class="form-group text-left-custom">
                                                <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">E-Mail Address<span class="lblTextRed">* </span>: </label>
                                                <div class="col-sm-9">
                                                    <input id="txtPaEmail" name="txtPaEmail" onchange="ValidatePinApply()"
                                                        maxlength="55" size="45" class="form-control input-sm">
                                                    <div class="clear"></div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-4 col-sm-6">
                                                    <input class="btn btn-default submit_button" id="btnPaApply" name="btnPaApply"
                                                        type="button" value="Apply" onclick="SubmitPinApply()" size="48">
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

