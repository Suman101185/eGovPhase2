<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    <Script type="text/javascript" language="javascript">
        var arrPinApplyErr = new Array();
        var oEmail = parent.$g.getXmlDocObj();

        function DisplayPinApply() {

            parent.sNew = false;
            LogPinApply.style.display = 'block';
            AppHeaderPinApply.innerHTML = txtHeader + '<Font class=hdrMedium>|PIN apply</Font>';
            //added by ajoy
            loadXmlFiles();
            ClearPinApplyScreen();
            LoadPinApplyError();
            txtPaAcctID.focus();
        }		//DisplayPinApply


        function loadXmlFiles() {
            // parent.$g.loadXmlSync('../xml/email', parent.load_oEmail);
            parent.$g.loadXmlSync('XML/email', parent.load_oEmail);
        }



        function load_oEmail(xml) {
            oEmail.xml = xml;
        }

        function ClearPinApplyScreen() {
           
            document.getElementById('txtPaAcctID').value = "";
            $('#txtPaAcctID').attr('class', 'inpNormal');
           

            document.getElementById('txtPaTaxID').value = "";
            $('#txtPaTaxID').attr('class', 'inpNormal');

            document.getElementById('txtPaEmail').value = "";
            $('#txtPaEmail').attr('class', 'inpNormal');


            //for (i = 0; i < document.all.length; i++) {
            //    if (document.all.item(i).id.search(/txt/i) != -1) {
            //        document.all.item(i).value = '';
            //        document.all.item(i).className = 'inpNormal';
            //    }		//if
            //}		//for
        }		//ClearPinApplyScreen


        function LoadPinApplyError() {
            var i = 0;

            //Account Id	
            arrPinApplyErr[i++] = [txtPaAcctID, 'txtPaAcctID.value == ""', 'Enter Taxpayer ID']
            arrPinApplyErr[i++] = [txtPaAcctID, 'isNaN(txtPaAcctID.value)', 'Taxpayer ID Not Numeric']
            arrPinApplyErr[i++] = [txtPaAcctID, '(txtPaAcctID.value.length !== 9) && ' +
                    (txtPaAcctID.value.length !== 12), 'Invalid Taxpayer ID']

            //Tax ID
            //	arrPinApplyErr[i++] = [txtPaTaxID, 'txtPaTaxID.value == ""', 'Enter Tax Account ID']
            arrPinApplyErr[i++] = [txtPaTaxID, 'txtPaTaxID.value != "" && ' +
                    'isNaN(txtPaTaxID.value)', 'Tax Account ID Not Numeric'];
            arrPinApplyErr[i++] = [txtPaTaxID, 'txtPaTaxID.value.length > 0 && ' +
                    'txtPaTaxID.value.length < 7', 'Invalid Tax Account ID'];

            //Contact Name
            //	arrPinApplyErr[i++] = [txtPaContactName, 'txtPaContactName.value == ""', 'Enter Contact Name']

            //Email
            arrPinApplyErr[i++] = [txtPaEmail, 'txtPaEmail.value == ""', 'Email Address Required'];
            arrPinApplyErr[i++] = [txtPaEmail, 'txtPaEmail.value !="" && ' +
                    '(txtPaEmail.value.indexOf("@") == -1 || txtPaEmail.value.indexOf(".") == -1)',
                    'Email Address Invalid Format'];

            //Phone Number
            /*	arrPinApplyErr[i++] = [txtPaAreaCode, 'txtPaAreaCode.value == "" || txtPaAreaCode.value.length != 3',
                        'Phone Required']
                arrPinApplyErr[i++] = [txtPaPhone1, 'txtPaPhone1.value == "" || txtPaPhone1.value.length != 3',
                        'Phone Required']
                arrPinApplyErr[i++] = [txtPaPhone2, 'txtPaPhone2.value == "" || txtPaPhone2.value.length != 4',
                        'Phone Required']
            
                arrPinApplyErr[i++] = [txtPaAreaCode, 'isNaN(txtPaAreaCode.value)', 'Phone Not Numeric']
                arrPinApplyErr[i++] = [txtPaPhone1, 'isNaN(txtPaPhone1.value)', 'Phone Not Numeric']
                arrPinApplyErr[i++] = [txtPaPhone2, 'isNaN(txtPaPhone2.value)', 'Phone Not Numeric']
                
                arrPinApplyErr[i++] = [txtPaPhoneExt, 'txtPaPhoneExt.value != "" && isNaN(txtPaPhoneExt.value)',
                        'Phone Extension Not Numeric']
            */
        }		//LoadPinApplyError

        var dobj = parent.$g.getXmlDocObj();
        var emailobj = parent.$g.getXmlDocObj();

        function ValidatePinApply() {
            //change by ajoy   
            var errMsg = ispSetInputErr(arrPinApplyErr)
            $(parent.AppError).text(errMsg);
        } //ValidatePinApplyLogin


        function SubmitPinApply() {

            ValidatePinApply()
            var app = $(parent.AppError).text();

            if (app == '') {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "2", "ENTITY_INFO FUNCTION_CODE", '', 0)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPaAcctID.value, "ENTITY_INFO ENTITY_ID", '', 0)
                if ($('#txtPaTaxID').val == '') {
                   
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPaAcctID.value, "ENTITY_INFO ACCOUNT_ID", '', 0)
                } else {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPaTaxID.value, "ENTITY_INFO ACCOUNT_ID", '', 0)
                }		//if
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPaEmail.value, "NAME_ADDRESS EMAIL", '', 0)

                ispCallXMLForm(parent.$g.xmlAccount, dobj, "AccountInfo", "", true);
                parent.$g.xmlAccount.loadXML(dobj.xml);

                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ERROR_INFO MESSAGE', "", 0) == "") {
                    sTemp = CreateEmail();

                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, 'NEWPIN', "FUNCTION", '', 0);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, sTemp, "DATA", '', 0);
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, txtPaEmail.value, "ADDRESS", '', 0);

                    ispCallXMLForm(parent.$g.xmlEmail, emailobj, "MailPIN", "");


                    oEmail = emailobj;

                    $('#LogPinApply').css('display', 'none');
                    DisplayThankYou('APPLYPIN');
                } else {
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ERROR_INFO MESSAGE', "", 0));
                    //			ispHideProgress()
                    txtPaAcctID.focus()
                }		//if
            } else {
                //		ispHideProgress()
                txtPaAcctID.focus()
            }		//if
        }		//SubmitPinApply
</Script>
    <title></title>
</head>
<body>
  
    <div class="tab_container">
        <div style="display: none;" id="LogPinApply" name="LogPinApply" class="tab_content">
            <h2 id="AppHeaderPinApply"></h2>
           	
            <div class="thankyou">
           
             <h4> Please enter your Social Security Number(SSN)/
				Employer Identification Number(EIN), your Philadelphia Tax Account No., and 
				your e-mail address.<br>
                        <font class="lblTextRed">* </font>Required Field</h4>
            
            
            
            <div class="login_form">
            	
                  <div class="form_segment" style="width:55%;">
                        
                        <label> SSN / EIN: * </label>
                        
                        <div class="here_input">
                            <input  id="txtPaAcctID" name="txtPaAcctID" onchange=ValidatePinApply()
				 maxlength="9" size="17">
                           
                            <div class="clear"></div>
                        </div>
                                                
                        <div class="clear"></div>
              
              </div>
              
              
              

               <div class="form_segment" style="width:55%;">
                        
                        <label> Phila. Tax Account No.: *</label>
                        
                        <div class="here_input">
                       <input id="txtPaTaxID" name="txtPaTaxID" onchange=ValidatePinApply()
				 maxlength="12" size="17">
                          
                            <div class="clear"></div>
                        </div>
                        
                       
                        
                        <div class="clear"></div>
              
              </div>
              
                 <div class="form_segment" style="width:55%;">
                        
                        <label> E-Mail Address: *</label>
                        
                        <div class="here_input">
                       
                          <input  id="txtPaEmail" name="txtPaEmail" onchange=ValidatePinApply()
				maxlength="40" size="45" >
                            <div class="clear"></div>
                        </div>
                        
                       
                        
                        <div class="clear"></div>
              
              </div>
              
              
              <div class="form_segment">
                        
                        <label>&nbsp;</label>
                        
                        <div class="here_input">
                        	
                   <input class="submit_button" id="btnPaApply" name="btnPaApply"
				type="button" value="Apply" 
				onclick="SubmitPinApply()" size="48">
                           
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
