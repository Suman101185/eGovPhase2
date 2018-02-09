<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>  
    <title></title>
    <script  type="text/javascript" language="javascript">
        var arrForgotPinErr = new Array();
        var oEmail = parent.$g.getXmlDocObj();
        var oAcctInfo = parent.$g.getXmlDocObj();
        function DisplayForgotPin() {

            parent.sNew = false;

            $('#divForgotPin').css("display", "block");
            $('#AppHeaderForgotPin').html(txtHeader + '<Font class=hdrMedium>|Forgot PIN</Font>');

            ClearForgotPinScreen();
            LoadForgotPinError();
            txtFpAcctID.focus();
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
            $('#txtFpTaxID').attr('class', 'inpNormal');

        } 	//ClearForgotPinScreen


        function LoadForgotPinError() {
            var i = 0;

            //Account Id	
            arrForgotPinErr[i++] = [txtFpAcctID, 'txtFpAcctID.value == ""', 'Enter SSN/EIN Number']
            arrForgotPinErr[i++] = [txtFpAcctID, 'isNaN(txtFpAcctID.value)', 'SSN/EIN Not Numeric']
            arrForgotPinErr[i++] = [txtFpAcctID, '(txtFpAcctID.value.length !== 9)', 'Invalid SSN/EIN Number']

            //Tax ID
            arrForgotPinErr[i++] = [txtFpTaxID, 'txtFpTaxID.value == ""', 'Enter Tax Account Number']
            arrForgotPinErr[i++] = [txtFpTaxID, 'isNaN(txtFpTaxID.value)', 'Tax Account Number Not Numeric']
            arrForgotPinErr[i++] = [txtFpTaxID, 'txtFpTaxID.value.length < 7', 'Invalid Tax Account Number']
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
</head>
<body>
    <div class="tab_container">
        <div style="display: none;" id="divForgotPin" name="divForgotPin" class="tab_content">
            <h2 id="AppHeaderForgotPin"></h2>
           	
            <div class="thankyou">
           
             <h4> Please enter your Employee Identification Number (EIN) or Social Security Number
                        (SSN).<br>
                        <br>
                        For Earnings Tax and School Income Tax filers, your Social Security number is your
                        Philadelphia Tax Account number.<br>
                        <br>
                        <font class="lblTextRed">* </font>Required Field</h4>
            
            
            
            <div class="login_form">
            	
                  <div class="form_segment" style="width:55%;">
                        
                        <label> SSN / EIN: * </label>
                        
                        <div class="here_input">
                            
                           
                             <input  id="txtFpAcctID" name="txtFpAcctID" onchange="ValidateForgotPin()"
                        maxlength="9" size="17" class="inpNormal">
                            <div class="clear"></div>
                        </div>
                                                
                        <div class="clear"></div>
              
              </div>
              
              
             		 <div class="form_segment" style="width:55%;">
                        
                        <label> Phila. Tax Account No.: *</label>
                        
                        <div class="here_input">
                       
                           <input  id="txtFpTaxID" name="txtFpTaxID" onchange="ValidateForgotPin()"
                        maxlength="9" size="17" class="inpNormal">

                            <div class="clear"></div>
                        </div>
                        
                       
                        
                        <div class="clear"></div>
              
              </div>
              

              
              
              <div class="form_segment">
                        
                        <label>&nbsp;</label>
                        
                        <div class="here_input">
                        	
                   
                             <input class="submit_button" id="btnFpApply" name="btnFpApply" type="button" value="Apply"
                            onclick="return SubmitForgotPin()" size="48">
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
</body>
</html>
