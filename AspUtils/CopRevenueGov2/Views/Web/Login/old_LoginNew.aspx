<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    <title></title>
    <link href="../Content/Styles/framestyle.css" rel="stylesheet" type="text/css" />
   

    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
    
    <script type="text/javascript" language="javascript" src="../Content/Scripts/jquery-1.js"></script>

    <script id="clientEventHandlersJS" language="javascript" type="text/javascript">

        var arrLoginErr = new Array();

        function DisplayLogin() {
            parent.sNew = false;

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
            txtAccountNumber.focus();
        }

        function LoadLoginError() {
            var i = 0;

            arrLoginErr[i++] = [txtAccountNumber, 'txtAccountNumber.value == ""', 'Enter ID Number'];
            //	arrLoginErr[i++] = [txtAccountNumber, '(txtAccountNumber.value.length !== 7) && ' +
            //			'(txtAccountNumber.value.length !== 12)', 'Invalid Account Number']
            arrLoginErr[i++] = [txtAccountNumber, '(txtAccountNumber.value.length > 9)',
                    'Invalid Account Number'];
                   
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == ""', 'Enter PIN Number'];
            arrLoginErr[i++] = [txtPIN, 'regInteger.exec(txtPIN.value) != txtPIN.value', 'PIN Number must be an Integer'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "0"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "00"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "0000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "00000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "0000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "00000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "000000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "0000000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "00000000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "000000000000"', 'PIN Number must be greater than zero'];
            arrLoginErr[i++] = [txtPIN, 'txtPIN.value == "0000000000000"', 'PIN Number must be greater than zero'];
        }		//LoadLoginError

        function ValidateLogin() {
            var err_text = ispSetInputErr(arrLoginErr);
            $(parent.AppError).text(err_text);
            
        }

        function DoLogin() {
           
          
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
                        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAccountNumber.value, "ENTITY_INFO ENTITY_ID", '', 0);
                        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPIN.value, "ENTITY_INFO PIN", '', 0);



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
                            txtAccountNumber.focus();
                        }

                        
                    } else {
                        
                        if ($(parent.AppError).text() == 'Enter ID Number' || $(parent.AppError).text() == 'Invalid Account Number') {
                            $(parent.AppError).text("Please valid ID Number");
                            txtAccountNumber.focus();
                        } else {
                            $(parent.AppError).text("Please valid PIN Number");
                            txtPIN.focus();
                        }
                        
                    }

                }
            }
        }

    </script>
</head>
<body>
 
    <div class="tab_Tcontainer">

   
    <div class="tab_container">
        <div style="display: none;" id="LogLogin" class="tab_content">
            <h2 id="AppHeader"></h2>
           	
            <div class="thankyou">
            <h4> Please enter your Philadelphia Tax Account Number, Employer
      Identification Number (EIN) or Social Security Number (SSN) as your Tax Account Id.</h4>
            
            
            
            
            

                <div class="login_form">
              
            	
                  <div class="form_segment">
                        
                        <label>TAX account ID : </label>
                        
                        <div class="here_input">
                            <input type="text" name="txtAccountNumber" id="txtAccountNumber"  onchange="ValidateLogin()"  maxlength="9" size="14" value=""/>
                            
                            <div class="clear"></div>
                        </div>
                                                
                        <div class="clear"></div>
              
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

<br />
<br />

            </div>
            
            
            
            <div class="quicklink_btm_gen"></div>
        </div>
     	
    </div>
        </div>
</body>

</html>
