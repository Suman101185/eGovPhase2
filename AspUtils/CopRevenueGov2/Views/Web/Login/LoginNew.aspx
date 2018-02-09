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
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
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

            $('#AppHeader').html(txtHeader + '<Font >|login</Font>');


            try {

                $('#txtAccountNumber').text('');

                $('#txtPIN').text('');

            }
            catch (ex) {

            }

            LoadLoginError();
            // alert("here display login after errror");

            $('#txtAccountNumber').focus();
        }

        function LoadLoginError() {
            var i = 0;

            arrLoginErr[i++] = [$('#txtAccountNumber'), '$(\'#txtAccountNumber\').val() == ""', 'Enter ID Number'];
            arrLoginErr[i++] = [$('#txtAccountNumber'), '($(\'#txtAccountNumber\').val().length > 9)',
                    'Invalid Account Number'];

            arrLoginErr[i++] = [$('txtPIN'), ' $(\'#txtPIN\').val() == ""', 'Enter PIN Number'];
            arrLoginErr[i++] = [$('txtPIN'), 'regInteger.exec($(\'#txtPIN\').val()) != $(\'#txtPIN\').val()', 'PIN Number must be an Integer'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "0"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "00"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "0000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "00000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "0000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "00000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "000000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "0000000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "00000000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "000000000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [$('txtPIN'), '$(\'#txtPIN\').val() == "0000000000000"', 'PIN Number must be greater than zero'];
        }

        function ValidateLogin() {
            var err_text = ispSetInputErr(arrLoginErr);
            $(parent.AppError).text(err_text);

        }

        function DoLogin() {
            //debugger;

            var dobj = parent.$g.getXmlDocObj();

            $(parent.AppError).text('');
            if ($('#txtAccountNumber').val() == null || $('#txtAccountNumber').val() == '') {

                $(parent.AppError).text('Account ID can not be blank');
                return false;
            }
            else {

                if ($('#txtPIN').val() == null || $('#txtPIN').val() == '') {
                    $(parent.AppError).text('PIN Number can not be blank');
                    return false;
                } else {
                    ValidateLogin();

                    if ($(parent.AppError).text() == '') {



                        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "I", "ENTITY_INFO FUNCTION_CODE", '', 0);
                        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtAccountNumber').val(), "ENTITY_INFO ENTITY_ID", '', 0);
                        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtPIN').val(), "ENTITY_INFO PIN", '', 0);



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
                                        //var uName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME', '', '');
                                        //parent.fillUserAfterLogin(true, uName);


                                        break;
                                    case 'SIT':
                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '29') == 1) { //Chayan
                                            $(parent.document).find('#mnuReSchool').first().trigger('click'); //chayan
                                        } else {

                                            // parent.DocWin.location.href = '../Acct/ApplyMain';
                                            parent.setFrameUrl('Acct/ApplyMain');
                                        }
                                        break
                                    case 'WAGE':

                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '1') == 1) { //Chayan
                                            $(parent.document).find('#mnuReWage').first().trigger('click'); //chayan
                                        } else {
                                            // parent.DocWin.location.href = '../Acct/ApplyMain';
                                            parent.setFrameUrl('Acct/ApplyMain');
                                        }
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
                                        break;
                                    case 'BPTlf':
                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '24') == 1) { //Chayan
                                            $(parent.document).find('#mnuBPTlf').first().trigger('click'); //chayan
                                        }
                                        else if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '3') == 1) { //Chayan
                                            $(parent.document).find('#mnuReNPT').first().trigger('click'); //chayan
                                        } else {
                                            // parent.DocWin.location.href = '../Acct/ApplyMain';
                                            parent.setFrameUrl('Acct/ApplyMain');
                                        }
                                        break;
                                    case 'NPT':
                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '3') == 1) { //Chayan
                                            $(parent.document).find('#mnuReNPT').first().trigger('click'); //chayan
                                        } else {
                                            //  parent.DocWin.location.href = '../Acct/applymain';
                                            parent.setFrameUrl('Acct/ApplyMain');
                                        } 	//if
                                        break
                                    case 'U&O':
                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '84') == 1) { //Chayan
                                            $(parent.document).find('#mnuUO').first().trigger('click'); //chayan
                                        } else {
                                            // parent.DocWin.location.href = '../Acct/applymain';
                                            parent.setFrameUrl('Acct/ApplyMain');
                                        }
                                        break
                                    case 'TOB':

                                        if (parent.GetNodeCount(parent.$g.xmlAccount, 'TAX_ACCT ACCOUNT', '27') == 1) { //Chayan

                                            $(parent.document).find('#mnuTOB').first().trigger('click'); //chayan
                                        } else {
                                            //  parent.DocWin.location.href = '../Acct/ApplyMain';
                                            parent.setFrameUrl('Acct/ApplyMain');
                                        }
                                        break
                                    case 'DELPAY':
                                        $(parent.mnuPayBalances).trigger('click');
                                        break
                                }
                            }
                        } else {


                            $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ERROR_INFO MESSAGE', "", 0));
                            //$(parent.AppError).text("Please valid ID Number and PIN Number");
                            $('#txtAccountNumber').focus();
                        }


                    } else {

                        if ($(parent.AppError).text() == 'Enter ID Number' || $(parent.AppError).text() == 'Invalid Account Number') {
                            $(parent.AppError).text("Please valid ID Number");
                            $('#txtAccountNumber').focus();
                        } else {
                            $(parent.AppError).text("Please valid PIN Number");
                            $('#txtPIN').focus();

                        }

                    }

                }
            }
        }

    </script>
</head>
<body>

    <div class="col-lg-12 col-md-12 block3">
        <div id="divLogin" style="display: none;">
            
                    <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3" style="display: none;" id="LogLogin">
                        <div class="blue_base_box">
                            <h2>Tax Payer Information  |   <span>Login</span>  </h2>

                            <div class="inner_white-panel">

                                <div class="contentsection">
                                    
                                        
                                            <h4>Please enter your Philadelphia Tax Account Number, Employer Identification Number (EIN) or Social Security Number (SSN) as your Tax Account Id.</h4>
                                        
                                    <div class="clearfix"></div>

                                    <div class="row">

                                        <div class="col-lg-12">

                                            <form class="form-horizontal login_form">
                                                <div class="form-group text-left-custom">
                                                    <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">TAX account ID : </label>
                                                    <div class="col-sm-9">
                                                        <%-- <input type="email" class="form-control input-sm" id="inputEmail3" placeholder="Email">--%>
                                                        <input type="text" name="txtAccountNumber" class="form-control input-sm" id="txtAccountNumber" onchange="ValidateLogin()" maxlength="9" size="14" value="" />
                                                    </div>
                                                </div>
                                                <div class="form-group text-left-custom">
                                                    <label for="inputPassword3" class="col-sm-3 control-label text-left-custom">Password :</label>
                                                    <div class="col-sm-9">
                                                        <%--<input type="password" class="form-control  input-sm" id="inputPassword3" placeholder="Password">--%>
                                                        <input type="password" id="txtPIN" class="form-control input-sm" onchange="ValidateLogin()" maxlength="13" size="15" value="" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-offset-4 col-sm-6">
                                                        <%-- <button type="submit" class="btn btn-default submit_button" id="btnLogin" onclick="DoLogin()">Submit</button>--%>
                                                        <input type="button" class="btn btn-default submit_button" value="Submit" id="btnLogin" onclick="return DoLogin();" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-offset-4 col-sm-6">
                                                        <div class="checkbox">
                                                            <label>
                                                                <p><a onclick="ShowForm('divForgotPin')" id="lnkForgotPin" class="move_to_right">Forgot Password?</a></p>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>

                                            </form>

                                        </div>

                                        <div class="clearfix"></div>

                                    </div>

                                </div>

                            </div>

                        </div>
                        <div class="clearfix"></div>
                        <%-- <div style="display: none;" id="LogLogin" class="tab_content">
            <h2 id="AppHeader"></h2>--%>

                        <%--<div class="contentsection">
            <h4> Please enter your Philadelphia Tax Account Number, Employer
      Identification Number (EIN) or Social Security Number (SSN) as your Tax Account Id.</h4>  
                 <div class="clearfix"></div>
                         
            <div class="row">
             <div class="col-lg-5 col-lg-offset-4">

                <div class="form-horizontal login_form">
              <div class="form-group">
                    <label for="inputEmail3" class="col-sm-3 control-label">TAX account ID : </label>
                    <div class="col-sm-9">
                                                       
                        <input type="text" name="txtAccountNumber" class="form-control input-sm" id="txtAccountNumber"  onchange="ValidateLogin()"  maxlength="9" size="14" value=""/>
                    </div>
                </div>
            	
                
              
                 <div class="form_segment">
                        
                        <label>Password : </label>
                        
                        <div class="here_input">
                        
                            <input type="password" name="" id="txtPIN" onchange="ValidateLogin()"  maxlength="13" size="15" value=""/>

                            <div class="clear"></div>
                        </div>
                        
                       
                        
                        <div class="clear"></div>
              
              </div>
              
              
                 <div class="form_segment">
                        
                        <label>&nbsp;</label>
                        
                        <div class="here_input">
                        	<input type="button" class="submit_button" value="Submit" id="btnLogin" onclick="DoLogin()"/>
                        </div>
                        
                        <div class="clear"></div>
              
              </div>
              
            	
                 <div class="form_segment">
                        
                        <p><a  onclick="ShowForm('divForgotPin')" id="lnkForgotPin" class="move_to_right">Forgot Password?</a></p>
                        
                        <div class="here_input">
                        	&nbsp;
                        </div>
                        
                        <div class="clear"></div>
              
              </div>
                
                <div class="clear"></div>
            </div>

                 </div>
                 <div class="clearfix"></div>
               </div>


            </div>--%>



                        <%--  <div class="quicklink_btm_gen"></div>
        </div>--%>
                    </div>
                </div>

            </div>
        
</body>

</html>
