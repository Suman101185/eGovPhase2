<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head >
   
    <title></title>
    <script ID="clientEventHandlersJS" LANGUAGE="javascript" type="text/javascript">

        var arrLoginErr = new Array();
        var ispCCWin;
        var txtBPL = 'obtain your CAL by completing the CAL application found at http://www.phila.gov/revenue/bpt.html   and mail it, a copy of your forthcoming BIR account confirmation email';

        function DisplayThankYou() {
            debugger;
            $('#AcctThankYou').css('display', 'block');
            $('#AcctExistThankYou').css('display', 'none');
            $('#AcctNewThankYou').css('display', 'none');
            $('#divBPTAccount').css('display', 'none');
            $('#divBPTExemption').css('display', 'none');
            $('#divBPTNoExemption').css('display', 'none');
            txaComments.value = '';

            var icount;
            var scode;
            if (parent.sNew == true) {
                $('#AcctNewThankYou').css('display', 'block');

                $('#profile').addClass("disabled").find("a").removeAttr("onclick");
                $('#tax').addClass("disabled").find("a").removeAttr("onclick");
                $('#addr').addClass("disabled").find("a").removeAttr("onclick");
                $('#offcr').addClass("disabled").find("a").removeAttr("onclick");

                iCount = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'TAX_ACCT', '');
                for (i = 0; i < iCount; i++) {
                    sCode = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ACCOUNT', '', i);
                    if (sCode == '24') {
                        $('#divBPTAccount').css('display', 'block');
                        sExemptionRequest = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'UOL_BRT', '', i).substr(0, 1);
                        sExemptionQuailified = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'UOL_BRT', '', i).substr(8, 1);
                        if (sExemptionQuailified == 'A') {		//Accepted
                            $('#divBPTExemption').css('display', 'block');
                        } else {
                            $('#divBPTNoExemption').css('display', 'block');
                        }		//if
                        break
                    } 	//if
                }		//for
            } else {
                $('#AcctExistThankYou').css('display', 'block');
                $('#lblUpdateMsg').css('display', 'block');
            }		//if
            this.focus()
            $('#AppHeaderThankyou').html(txtHeader + '<Font class=hdrMedium>|thank you</Font>');
            $('#AppMessageThankyou').html('');
            $(parent.RightFrame).attr('rows', '*.0');

            ////----------Manoranjan------------------------------
            //var iframe = window.parent.document.getElementById('ifrmDocwin');
            //var container = $('#tab1').css("height");
            //iframe.style.height = container;
            ////----------------------------------------
        }		//DisplayThankyou




        function DoThankYou() {            
            var sEmailMsg;
            var txaComments=document.getElementById('txaComments');
            if (txaComments.value != '') {
                sEmailMsg = '<p align=middle><strong>Comments and Feedback</strong></p>';
                sEmailMsg += '<p>The following comments or feedback was submitted by: ';
                sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0) + '</p>';
                sEmailMsg += '<p>Company: ';
                sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TRADE_NAME', '', 0) + '</p>';
                sEmailMsg += '<p>E-mail address: ';
                sEmailMsg += parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS EMAIL', '', 0) + '</p><br>';
                sEmailMsg += '<p><strong>Message: </strong></p>';
                sEmailMsg += '<p>' + txaComments.value + '</p>';

                sEmailMsg = ispReplace(sEmailMsg, '>', '&GT&');
                sEmailMsg = ispReplace(sEmailMsg, '<', '&LT&');

                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, sEmailMsg, 'DATA', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlEmail, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS EMAIL', '', 0), 'ADDRESS', '', 0);
                ispCallXMLForm(parent.$g.xmlEmail, parent.$g.xmlEmail, 'MailPIN', '');
            }		//if

            if ($('#AcctNewThankYou').css('display') == 'block') {
                $(parent.document).find('#mnuLogLogout').first().trigger('click');
            } else {
               
                $('#ApplyPinThankYou').css('display', 'none');
              
                $('#ForgotPinThankYou').css('display', 'none');
               
                parent.sNew = false;
                
                parent.setFrameUrl('Acct/ApplyMain');
                
            }		//if
           
        }		//DoThankYou



        function ShowReturns() {
            var lDisplay = false;
           
           
            $('#divReturns').css("display", "none");
            
            $('#mnuReWage').css("display", "none");
           
            $('#mnuReSchool').css("display", "none");
            
            $('#mnuLCF').css("display", "none");
            $('#mnuBPTlf').css("display", "none");
           
            $('#mnuReBPTez').css("display", "none");
           
            $('#mnuReNPT').css("display", "none");
           
            $('#mnuReERN').css("display", "none");
            var taxcount = 0;
            TotalAccounts = 0
            
            taxcount = GetSingleNodeCount(parent.$g.xmlAccount, 'TAX_ACCT', '');
            var acc = '';
            for (i = 0; i < taxcount; i++) {

                acc = $(parent.$g.xmlAccount.xml).find('ACCOUNT').eq(i).text();

                if (acc != '0') {
                    if (acc == '1') {

                        $('#mnuReWage').css("display", "block");
                        lDisplay = true;
                    }
                    if (acc == '29') {
                        $('#mnuReSchool').css("display", "block");
                        lDisplay = true;
                    }
                    if (acc == '24') {
                        $('#mnuLCF').css('display', 'block');
                        $('#mnuBPTlf').css("display", "block");
                        lDisplay = true;

                        $('#mnuReBPTez').css("display", "block");

                        lDisplay = true;
                    }
                    if (acc == '27') {


                        $('#mnuTOB').css("display", "block");
                        lDisplay = true;
                    }
                    if (acc == '3') {
                        $('#mnuReNPT').css("display", "block");
                        lDisplay = true;
                    }
                    if (acc == '84') {
                        $('#mnuUO').css("display", "block");
                        lDisplay = true;
                    }
                    if (acc == '2') {
                        if (parent.gEnvironment == 'U') {
                            $('#mnuReERN').css("display", "block");
                            lDisplay = true;

                        }
                    }
                    if (lDisplay == true) {

                        $('#divReturns').css("display", "block");
                        //EGOVWEB-107 Added

                       
                    }

                    //if
                }		//if
            }		//for


            
        } 	//ShowReturns

        function GetSingleNodeCount(oXML, sElement, val)//Chayan
        {
            var count = 0;
            $(oXML.xml).find(sElement).each(function () {

                count = count + 1;

            });
            return count;
        }


</script>
</head>

    <%--<body style="min-height:500px !important;">--%>
    <body >
         <div id="AcctThankYou" style="display: none;" role="tabpanel" class="tab-pane active">
    
        <div style="display: none;" Id="Div1" class="tab_content">
            <h2 id="AppHeaderThankyou"></h2>
            <div class="inner_white-panel">
                <div class="contentsection">
                    <div class="row">
          
            <div class="thankyou">
            
<!--      -------------------------     --> 
           
      <div Id="ApplyPinThankYou" Name="ApplyPinThankYou" style="DISPLAY: none; VISIBILTY: visible">
			<table cellSpacing="0" cellPadding="1" width="95%" border="0"
					 style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%">
				<tr vAlign="top" align="left">
					<td width="75%">
                          <h4  id="hdrThankYou" name="hdrThankYou">The PIN is now being generated. Shortly, you will receive via
				e-mail the Philadelphia Revenue Personal Identification Number (PIN) for this tax entity.</h4>
                        <h4>You must get the PIN from this e-mail before using "Online Services"</h4>
						</td>
				<td></td></tr>
			</table>

          <table cellSpacing="0" cellPadding="0" width="60%" border="0" 
		style="MARGIN-TOP: 15px; MARGIN-LEFT: 4%">	
  <tr height=40 valign="bottom">
		<td align="middle">
            <input class="submit_button" id="btnThankYou" name="btnThankYou"
					 type="submit" value ="Thank You" onclick="DoThankYou()" />
		</td></tr>
</table>
      </div>
            
            
            
               
            <div class="thankyou">
                <h4 id="AppMessageThankyou"></h4>
      <div Id="AcctNewThankYou" Name="AcctNewThankYou" style="DISPLAY: none; VISIBILTY: visible">
			<table cellSpacing="0" cellPadding="1" width="95%" border="0"
					 style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%">
				<tr vAlign="top" align="left">
					<td width="75%">
                          <h4  id="h1" name="hdrThankYou">Your Tax Account Application is now being processed. Shortly, you will receive, via email, your Philadelphia Tax Account Number and Personal Identification Number (PIN). Your account number and PIN are needed for any online activity such as making changes to your account, filing tax returns and/or submitting tax payments.</h4>
						</td>
				<td></td></tr>
			</table>
      </div>

       <div Id="AcctExistThankYou" Name="AcctExistThankYou" style="DISPLAY: none; VISIBILTY: visible">
			<table cellSpacing="0" cellPadding="1" width="95%" border="0"
					 style="MARGIN-BOTTOM: 5px; MARGIN-LEFT: 4%"></TR>
				<tr vAlign="top" align="left">
					<td width="98%">
						
                     <h4  id="h2" name="hdrThankYou">The Taxpayer Information changes are now being processed. Thank you for using the City 
							of Philadelphia's e-Government System.</h4>
						</td>
				<td></td></tr>
				</table>
		</div>
                <div style="display:none; visibility:visible">
                <table cellSpacing="0" cellPadding="0" width="80%" border="0" style="MARGIN-TOP: 15px; MARGIN-LEFT: 4%">	
  <tr height=40>
		<td>
			<div id="divBPTAccount">
				<div id="divBPTNoExemption">
					<h4>If you registered for a Business Income and Receipts Tax (BIR) account you must also obtain a Commercial Activity License (CAL) from the Department of Licenses & Inspections (L&I). You can apply on-line at the <a href="https://secure.phila.gov/li/licenses/" target="_blank">Licenses and Inspections Web Site</a>. When you pay for the Commercial Activity License by credit card on-line, you will get your license in the mail within 2 weeks.<br /><br />You may also obtain obtain your CAL by completing the CAL application found at <a href="http://www.phila.gov/revenue/bpt.html" target="_blank">http://www.phila.gov/revenue/bpt.html</a> and mail it, a copy of your forthcoming BIR account confirmation email and a parent.$300 check made payable to the City of Philadelphia to:</h4>
				</div>
				<div id="divBPTExemption">
					<h4>Since you registered for a Business Income and Receipts Tax (BIR) account you must also obtain a Commercial Activity License (CAL) from the Department of Licenses & Inspections (L&I).  By qualifying for “New Business” status the CAL fee is waived. To obtain obtain your CAL by completing the CAL application found at <a href="http://www.phila.gov/revenue/bpt.html" target="_blank">http://www.phila.gov/revenue/bpt.html</a> and mail it, a copy of your forthcoming BIR account confirmation email to:</h4>
				</div>
				<h4  style="MARGIN-TOP: 15px; MARGIN-LEFT: 30px">
					Philadelphia Department	of Licenses and Inspection<br />
					License Issuance Unit<br />
					P.O. Box 1942<br />
					Philadelphia, PA 19105-1942</h4>
				<h4>You may also visit L&I in person at the above address.  Please be sure to bring the aforementioned documents. You may be required to get an additional location based license depending on your business operation.  You may also check the Business Services Center website at <a href="https://business.phila.gov/Pages/Home.aspx" target="_blank">https://business.phila.gov/Pages/Home.aspx</a> to determine your licensing and permitting requirements. For any questions concerning licenses call 311 from the City Of Philadelphia, 215-686-8686 from outside the city or email <a href="mailto:license.issuance@phila.gov">license.issuance@phila.gov</a>.</h4>
				<h4>If you have any questions concerning your tax account, e-mail us at <a href="mailto:revenue@phila.gov">revenue@phila.gov</a> or visit us on-line at <a href="http://www.phila.gov/revenue" target="_blank">www.phila.gov/revenue</a>.</h4>
			</div>
            </td>
      </tr>
                    </table>
					
			</div>

           
            <div class="smaller_form" style="margin-left:4%;">
            	<h4>We would appreciate your comments / feedback concerning your online
					experience.<br>Please enter your comments / feedback below:</h4>
                <textarea id="txaComments" class="fulllength"></textarea>
            	<h4 id="lblUpdateMsg">
					  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  Click "Thank You" to continue.&nbsp;&nbsp;&nbsp;
			<input class="submit_button" id="Submit1" name="btnThankYou"
					 type="button" value ="Thank You" onclick="DoThankYou()" /></h4>
               
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
            </div>
 
            
            <div class="clear"></div>
            </div>
        </div>
     	</div></div>
    </div>
             </div>
</body>
    </html>

