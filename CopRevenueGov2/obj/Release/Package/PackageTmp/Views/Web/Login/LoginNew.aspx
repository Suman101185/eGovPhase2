 <%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    <title></title>

    <!-- Bootstrap Core CSS -->
    <link href="../Content/Styles/bootstrap.css" rel="stylesheet" />

    <!-- Custom CSS -->
    <link href="../Content/Styles/copegov.css" rel="stylesheet" />
    <link href="../Content/Styles/style.css" rel="stylesheet" />
    <link href="../Content/Styles/Font.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css" />

    <script type="text/javascript" language="javascript" src="Content/Scripts/global.js"></script>
    <script type="text/javascript" language="javascript" src="Content/Scripts/ispXmlProc.js"></script>


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script id="clientEventHandlersJS" language="javascript" type="text/javascript">

        var arrLoginErr = new Array();

        function DisplayLogin() {
          
            parent.sNew = false;
            $('#divLogin').css('display', 'block');
            $('#LogLogin').css('display', 'block');


            $('#AppHeader').html(txtHeader + '<Font >|login </Font>');

            try {

                $('#txtAccountNumber').text('');
                $('#txtPIN').text('');
            }
            catch (ex) {

            }
            LoadLoginError();
           

            $('#txtAccountNumber').focus();          
        }

        function LoadLoginError() {
            var i = 0;

            arrLoginErr[i++] = [$('#txtAccountNumber'), '$(\'#txtAccountNumber\').val() == ""', 'Enter ID number'];
            arrLoginErr[i++] = [$('#txtAccountNumber'), '($(\'#txtAccountNumber\').val().length > 9)',
                    'Invalid account number'];

            arrLoginErr[i++] = [$('txtPIN'), ' $(\'#txtPIN\').val() == ""', 'Enter PIN number'];
            arrLoginErr[i++] = [$('txtPIN'), 'regInteger.exec($(\'#txtPIN\').val()) != $(\'#txtPIN\').val()', 'PIN number must be an integer'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "0"', 'PIN number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "00"', 'PIN number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "000"', 'PIN number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "0000"', 'PIN number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "00000"', 'PIN number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "000000"', 'PIN number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "0000000"', 'PIN number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "00000000"', 'PIN number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "000000000"', 'PIN number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "0000000000"', 'PIN number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "00000000000"', 'PIN number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "000000000000"', 'PIN number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "0000000000000"', 'PIN number must be greater than zero'];
        }

        function ValidateLogin() {
            $(AppError).text('');
            $('#txtAccountNumber').removeClass("inpError");
            $('#txtPIN').removeClass("inpErrorPwd");
            var err_text = ispSetInputErr(arrLoginErr);
            $(AppError).text(err_text);
           // resolvedIframeheight();
        }
       
        $(function () {
            $('#txtPIN').keypress(function (evt) {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                           return false;
                       }
            });
        });
      
        $(function () {
            $('#txtAccountNumber').keypress(function (evt) {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                    return false;
                }
            });
        });
       
        function DoLogin() {
            debugger;
            var dobj = parent.$g.getXmlDocObj();

            $(AppError).text('');
            $('#txtAccountNumber').removeClass("inpError");
            $('#txtPIN').removeClass("inpErrorPwd");

            if ($('#txtAccountNumber').val() == null || $('#txtAccountNumber').val() == '') {

                $(AppError).text('Account ID can not be blank');
                $('#txtAccountNumber').attr('class', 'form-control inpError');
                $('#txtAccountNumber').focus();
                resolvedIframeheight();
                return false;
              
            }
            else {

                if ($('#txtPIN').val() == null || $('#txtPIN').val() == '') {
                    $(AppError).text('PIN number can not be blank');
                    $('#txtPIN').attr('class', 'form-control inpErrorPwd');
                    $('#txtPIN').focus();
                    resolvedIframeheight();
                    return false;
                } else {
                    ValidateLogin();

                    if ($(AppError).text() == '') {

                        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "I", "ENTITY_INFO FUNCTION_CODE", '', 0);
                        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtAccountNumber').val(), "ENTITY_INFO ENTITY_ID", '', 0);
                        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtPIN').val(), "ENTITY_INFO PIN", '', 0);


                        //'''''''Sudipta'''''''''
                        var acctNumber = $('#txtAccountNumber').val();
                        var pin = $('#txtPIN').val();

                        localStorage.setItem("AccountNumber", acctNumber);
                        localStorage.setItem("Pin", pin);
                        //'''''''''''''''''''




                        ispCallXMLForm(parent.$g.xmlAccount, dobj, "AccountInfo");

                        if (parent.$x.ispXmlGetFieldVal(dobj, 'ERROR_INFO MESSAGE', "", 0) == "") {

                            if (parent.$x.ispXmlGetFieldVal(dobj, 'ENTITY_INFO FORCEPINCHG', "", 0) == "Y") {

                                parent.$g.xmlAccount.loadXML(dobj.xml)
                                ShowForm('LogChangePin');

                            } else {

                                parent.$g.xmlAccount.loadXML(dobj.xml);
                               
                                switch (gsLoginPage) {
                                    case 'PROFILE':
                                    case '':
                                        parent.setFrameUrl('Acct/ApplyMain');
                                       
                                        break;
                                    case 'SIT':
                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '29') == 1) { //Chayan
                                            $(parent.document).find('#mnuReSchool').first().trigger('click'); //chayan
                                           
                                        } else {

                                            
                                            parent.setFrameUrl('Acct/ApplyMain');
                                        }
                                        getLoginName();
                                        break
                                    case 'WAGE':

                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '1') == 1) { //Chayan
                                            $(parent.document).find('#mnuReWage').first().trigger('click'); //chayan
                                           
                                        } else {
                                           
                                            parent.setFrameUrl('Acct/ApplyMain');                                           
                                        }
                                        getLoginName();
                                        break
                                    case 'BPTez':
                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '24') == 1) { //Chayan
                                            $(parent.document).find('#mnuReBPTez').first().trigger('click'); //chayan
                                           
                                        }
                                        else if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '3') == 1) { //Chayan
                                            $(parent.document).find('#mnuReNPT').first().trigger('click'); //chayan
                                          
                                        } else {
                                            //parent.DocWin.location.href = '../Acct/ApplyMain';
                                            parent.setFrameUrl('Acct/ApplyMain');
                                        } 	//if
                                        getLoginName();
                                        break;
                                    case 'BPTlf':
                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '24') == 1) { //Chayan
                                            $(parent.document).find('#mnuBPTlf').first().trigger('click'); //chayan                                           
                                        }
                                        else if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '3') == 1) { //Chayan
                                            $(parent.document).find('#mnuReNPT').first().trigger('click'); //chayan
                                        } else {
                                            
                                            parent.setFrameUrl('Acct/ApplyMain');
                                        }
                                        getLoginName();
                                        break;
                                    case 'NPT':
                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '3') == 1) { //Chayan
                                            $(parent.document).find('#mnuReNPT').first().trigger('click'); //chayan
                                        } else {
                                           
                                            parent.setFrameUrl('Acct/ApplyMain');
                                        } 	//if
                                        getLoginName();
                                        break
                                    case 'U&O':
                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '84') == 1) { //Chayan
                                            $(parent.document).find('#mnuUO').first().trigger('click'); //chayan
                                        } else {
                                           
                                            parent.setFrameUrl('Acct/ApplyMain');
                                        }
                                        getLoginName();
                                        break
                                    case 'TOB':

                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '27') == 1) { //Chayan

                                            $(parent.document).find('#mnuTOB').first().trigger('click'); //chayan
                                        } else {
                                           
                                            parent.setFrameUrl('Acct/ApplyMain');
                                        }
                                        getLoginName();
                                        break
                                    case 'DELPAY':
                                        $(parent.mnuPayBalances).trigger('click');
                                        getLoginName();
                                        break
                                }
                            }
                        } else {

                            
                            $(AppError).text(parent.$x.ispXmlGetFieldVal(dobj, 'ERROR_INFO MESSAGE', "", 0));
                           
                           
                            $('#txtAccountNumber').focus();
                        }


                    } else {

                        if ($(AppError).text() == 'Enter ID number' || $(AppError).text() == 'Invalid account number') {
                            $(AppError).text("Please enter valid account number");
                            $('#txtAccountNumber').attr('class', 'form-control inpError');
                            $('#txtAccountNumber').focus();
                        } else {
                            $(AppError).text("Please enter valid PIN number");
                            $('#txtPIN').attr('class', 'form-control inpErrorPwd');
                            $('#txtPIN').focus();

                        }

                    }

                }
            }          
        }

        $(function (e) {
            $('#txtAccountNumber').keyup(function (e) {
                if ((e.which == 13) || (e.keyCode == 13)) {
                    DoLogin();
                    $("#btnLogin").click();
                }

            });
            $("#txtPIN").keyup(function (e) {
                if ((e.which == 13) || (e.keyCode == 13)) {
                    DoLogin();
                    $("#btnLogin").click();
                }

            });
            $("#btnLogin").keyup(function (e) {
                if ((e.which == 13) || (e.keyCode == 13)) {
                    DoLogin();
                    $("#btnLogin").click();
                }

            });
          
        });
        function LocatePrimaryAddr(AddType, AddNewRow) {

            var iMaxIdx = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '');

            var iFirstEmptyRow = -1;

            for (idx = 0; idx < iMaxIdx; idx++) {
                if (iFirstEmptyRow == -1 &&
                        parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == '0') {
                    iFirstEmptyRow = idx;
                }		//if

                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == AddType) {

                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', idx) == '0') {

                        return idx;
                    }

                    //if
                }		//if
            }		//for

            if (iFirstEmptyRow == -1 && AddNewRow == true) {
                iFirstEmptyRow = iMaxIdx;
               

                var xmlTemp = parent.$g.getXmlDocObj();
                xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "NAME_ADDRESS", 0);

                parent.$x.ispAppendNodeXml(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp, 'NAME_ADDRESS', 0);


            }		//if
            return iFirstEmptyRow;
        }		//locatePrimaryAddr
        function getLoginName()
        {
            addrIdx = LocatePrimaryAddr('60');          

            var uName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME', '', addrIdx);
            if (uName.indexOf("*") >= 0) {
                uName = uName.replace(/\*/g, " ");
            }
            parent.fillUserAfterLogin(true, uName);
        }

        function ClickHelp(sLink) {
            window.open(sLink)
        }
    </script>
</head>
<body>

    <div class="container-fluid no-padding">
        <div id="divLogin" style="display: none;" class="block3">
            <%--<div class="col-lg-8">--%>
                 <p style="font: 14px/18px Verdana;font-weight:bold">Tax returns prior to 2012 and Use & Occupancy returns prior to 2014 must be obtained via our <a style="cursor:pointer" onclick="ClickHelp('https://beta.phila.gov/services/payments-assistance-taxes/tax-forms-instructions/ ')">Tax Forms</a> page or customer service at 215 686-6600. </p>
           <%-- </div>--%>
         <div class="container-fluid">
          <div class="row">
             
            <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3" style="display: none;" id="LogLogin">
                 <p style="font: 17px/25px Verdana;font-weight:bold;text-align:center;margin-top:25px;color:#FF0000">Please Log-In to file a return</p>
                <div class="blue_base_box" style="margin-top:10px !important">
                    <h2>Taxpayer Information  |   <span>Login</span>  </h2>

                    <div class="inner_white-panel">
                        <div class="row">
                            <div class="col-lg-12 col-lg-offset-0">
                                <div id="AppError" class="errormsg no-padding" style="display: block;"></div>
                            </div>
                        </div>
                        <div class="contentsection">


                            <h4>Please enter your Philadelphia Tax Account Number, Employer Identification Number (EIN) or Social Security Number (SSN) as your Tax Account ID and PIN to file or pay your City Taxes.</h4>

                            <div class="clearfix"></div>

                            <div class="row">

                                <div class="col-lg-12">

                                    <form class="form-horizontal login_form">
                                        <div class="form-group text-left-custom">
                                            <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">Tax account ID : </label>
                                            <div class="col-sm-9">
                                               
                                                <input type="text" name="txtAccountNumber" class="form-control input-sm" id="txtAccountNumber" onchange="ValidateLogin()" maxlength="9" size="14" value="" />

                                            </div>
                                        </div>
                                        <div class="form-group text-left-custom">
                                            <label for="inputPassword3" class="col-sm-3 control-label text-left-custom">PIN :</label>
                                            <div class="col-sm-6">
                                              
                                                <input type="password" id="txtPIN" class="form-control input-sm" maxlength="13" size="15" value="" onchange="ValidateLogin()" style="border: Red; width:100% !important;" />
                                               </div>
                                            <div class="col-sm-3">
                                          
                                                    
                                                        <p style="padding-left:4px"><a onclick="ShowForm('divForgotPin')" id="A1" class="move_to_right" style="cursor:pointer;color:#FF0000">Forgot PIN?</a></p>
                                                   
                                               
                                            </div>
                                            
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-offset-4 col-sm-6">
                                              
                                                <input type="button" class="btn btn-default submit_button" value="Submit" id="btnLogin" onclick="return DoLogin();" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-offset-2 col-sm-8">
                                                <div class="checkbox">
                                                    <label>
                                                        <p><a onclick="ShowForm('LogApplyFirst')" id="lnkForgotPin" class="move_to_right" style="color:#FF0000">Register for a Philadelphia Tax Account Number</a></p>
                                                    </label>
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

</body>

</html>
