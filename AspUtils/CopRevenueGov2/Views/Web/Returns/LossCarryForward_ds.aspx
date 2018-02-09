<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><html>
<head>
<script ID="clientEventHandlersJS" LANGUAGE="javascript">

    var gUserAddr = '<%Response.Write(Request.ServerVariables["REMOTE_ADDR"]);%>'
    var txtHeader = 'Taxpayer Information'
    var sBPT = 'BPT'
    var sBIRT = 'BIRT'
    var sBPT_long = 'Business Privilege Tax'
    var sBIRT_long = 'Business Income and Receipts Tax'

    function isLoaded() {
        if (parent.DocWin.document.readyState != 'complete') {
            setTimeout('isLoaded()', 100)
        } 	//if
    } 	//isLoaded

    function DisplayLCF() {
        parent.$g.loadXmlSync('XML/LossCarryForward', parent.$g.parseXml_xmlLcf);
        //parent.$g.loadXmlSync('../XML/LossCarryForward.xml', parent.MenuWin.parseXml_xmlLcf);
        setTimeout('isLoaded()', 100)
        //	AppHeader.innerHTML = txtHeader + '<Font class=hdrMedium>|Loss Carry Forward Form</Font>'	
        $('#AppHeader').html(txtHeader + '<Font class=hdrMedium>|Loss Carry Forward Form</Font>');

        //AppHeader.refresh
        //	var Account_AccountID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', "", 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlLcf, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', "", 0), 'LCF_INFO ACCOUNT_ID', '', 0)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlLcf, new Date().getFullYear() - 1, 'LCF_INFO YEAR_X', '', 0)
        ispCallXMLForm(parent.$g.xmlLcf, parent.$g.xmlLcf, "Returns/LossCarryForwardReturn", "")
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'ERROR_INFO MESSAGE', "", 0) == "") {
            PopulateLcf()
        } else {	//Mainframe Error
            //		lblAccountName.innerText = ''
            $('#lblAccountName').text('')
            //		lblAccountNumber.innerText = ''
            $('#lblAccountNumber').text('')
            //		lblYearCurrent.innerText = ''
            $('#lblYearCurrent').text('')
            //		lblLcfAmount.innerText = ''
            $('#lblLcfAmount').text('')
            //		lblIncomeLoss.innerText = ''
            $('#lblIncomeLoss').text('')
            //		lblYearMinus1.innerText = ''
            $('#lblYearMinus1').text('')
            //		lblYearMinus1Amount.innerText = ''
            $('#lblYearMinus1Amount').text('')
            //		lblYearMinus2.innerText = ''
            $('#lblYearMinus2').text('')
            //		lblYearMinus2Amount.innerText = ''
            $('#lblYearMinus2Amount').text('')
            //		lblYearMinus3.innerText = ''
            $('#lblYearMinus3').text('')
            //		lblYearMinus3Amount.innerText = ''
            $('#lblYearMinus3Amount').text('')
            //		lblYearMinus4.innerText = ''
            $('#lblYearMinus4').text('')
            //		lblEstimatedTax.innerText = ''
            $('#lblEstimatedTax').text('')
            //		AppError.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'ERROR_INFO/MESSAGE', "", 0)
            $('#AppError').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'ERROR_INFO MESSAGE', "", 0))
        } 	//if
    } 	//DisplayLCF

    function PopulateLcf() {
        sFirstName = ''
        sMIName = ''
        sLastName = ''
        //LCF Header
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == 1) {
            //		lblAccountName.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS/NAME', '', 0)
            $('#lblAccountName').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0))
        } else {
            sEntityName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0).split('*')
            sLastName = sEntityName[0]
            if (sEntityName[1]) {
                sFirstName = sEntityName[1] + ' '
            }		//if
            if (sEntityName[2]) {
                sMIName = sEntityName[2].substr(0, 1) + ' '
            }		//if
            //		lblAccountName.innerText = sFirstName + sMIName + sLastName
            $('#lblAccountName').text(sFirstName + sMIName + sLastName);

        }		//if
        //	lblAccountNumber.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO/ACCOUNT_ID', "", 0)
        $('#lblAccountNumber').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', "", 0));

        //Loss Carry Forward Amount
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR', "", 0) > 2011) {
            //		lblYearCurrent.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO/YEAR', "", 0) + ' ' + sBIRT_long
            $('#lblYearCurrent').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR', "", 0) + ' ' + sBIRT_long);
        } else {
            //		lblYearCurrent.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO/YEAR', "", 0) + ' ' + sBPT_long
            $('#lblYearCurrent').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR', "", 0) + ' ' + sBPT_long);
        }		//if
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO COMMENT', "", 0) == '') {
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO AMOUNT', "", 0) == '') {
                //			lblLcfAmount.innerText = '$0.00'
                $('#lblLcfAmount').text('$0.00');
            } else {
                //			lblLcfAmount.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO/AMOUNT', "", 0)
                $('#lblLcfAmount').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO AMOUNT', "", 0));
            } 	//if
        } else {
            //		lblLcfAmount.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO/COMMENT', "", 0)
            $('#lblLcfAmount').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO COMMENT', "", 0));
        }		//if
        //Income/Loss Line
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR', "", 0) > 2014) {
            //		lblIncomeLoss.innerText = sBIRT
            $('#lblIncomeLoss').text(sBIRT);
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR', "", 0) > 2012) {
            //		lblIncomeLoss.innerText = sBIRT + '/' + sBPT
            $('#lblIncomeLoss').text(sBIRT + '/' + sBPT);
        } else {
            //		lblIncomeLoss.innerText = sBPT)
            $('#lblIncomeLoss').text(sBPT);
        }		//if
        //Past Returns
        var oLbl, LcfInfo_Year
        for (idx = 1; idx < 4; idx++) {
            oLbl = '#lblYearMinus' + idx
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + idx, "", 0) < 2012) {
                //			oLbl.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO/YEAR_' + idx, "", 0) + ' ' + sBPT
                $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + idx, "", 0) + ' ' + sBPT);
            } else {
                //			oLbl = eval('lblYearMinus' + idx)
                //			oLbl.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO/YEAR_' + idx, "", 0) + ' ' + sBIRT
                $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + idx, "", 0) + ' ' + sBIRT);
            }		//if
            oLbl = '#lblYearMinus' + idx + 'Amount'
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO COMMENT_' + idx, "", 0) == '') {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO INCOME_' + idx, "", 0) == '') {
                    //				oLbl.innerText = '$0.00'
                    $(oLbl).text('$0.00');
                } else {
                    //				oLbl.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO/INCOME_' + idx, "", 0)
                    $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO INCOME_' + idx, "", 0));
                }		//if
            } else {
                //			oLbl.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO/COMMENT_' + idx, "", 0)
                $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO COMMENT_' + idx, "", 0));
            } 	//if
        } 	//for
        lblYearMinus4.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + (idx - 1), "", 0) - 1
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO EST_PAID_X', "", 0) == '') {
            //		lblEstimatedTax.innerText = '$0.00'
            $('#lblEstimatedTax').text('$0.00');
        } else {
            //		lblEstimatedTax.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO/EST_PAID_X', "", 0)
            $('#lblEstimatedTax').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO EST_PAID_X', "", 0));
        } 	//if
    } 	//PopulateLcf

    function PrintLcf() {
        //	btnPrintLcf.style.visibility = 'hidden'
        $('#btnPrintLcf').css('visibility', 'hidden');
        $('#AppError').text('');
        window.print()
        //	btnPrintLcf.style.visibility = 'visible'
        $('#btnPrintLcf').css('visibility', 'visible');

    } 	//PrintLcf
</script>

<title></title>
</head>
<body onload="DisplayLCF()">
<!--<xml id="parent.$g.xmlLcf" src="../XML/LossCarryForward.xml"></xml>-->
<div style="display: block; visibility: visible" id="divLCF">
      <%
    Html.RenderAction("AppHeader", "INC");   
            %>
	<br />
	<table class="" cellSpacing=0 cellPadding=0 border=0 style="MARGIN-LEFT: 4%" id=tblLCF width="60%">
 <!--Default column size row-->
 		<tr height=0>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
			<td WIDTH="5%"></td>
		</tr>
		<tr height="30px" valign=top>
			<td colspan=20 align=center height=20px><br /><label class="lblNormal">TAX FILING INFORMATION</label></td>
		</tr>
		<tr height="50px" valign=middle>
			<td align=center colspan=10>
				<label class="lblInstrNormal" id="lblAccountName">John Q Sample</label></td>
			<td align=center colspan=10>
				<label class="lblInstrNormal">Account #: 
					<label class="lblInstrNormal" id="lblAccountNumber">9999999</label></label></td>
		</tr>
		<tr height="30px" valign=top>
			<td colspan=20>
				<label class="lblNormal">Loss carry forward available for the 
					<label class="lblNormal" id="lblYearCurrent">2012 Business Income and Receipts Tax</label> return: </label></td>
		</tr>
		<tr height="30px" valign=middle>
			<td>&nbsp;</td>
			<td colspan=19>
				<label class="lblInstrNormal" id="lblLcfAmount">$0.00</label></td>
		</tr>
		<tr height="30px" valign=top>
			<td colspan=20>
				<label class="lblNormal">This figure is based on the income / loss reported on the following 
					<label class="lblNormal" id="lblIncomeLoss">BIRT</label> returns:</label></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan=19>
				<label class="lblInstrNormal" id="lblYearMinus1">2011 BIRT</label>
				<label class="lblInstrNormal"> Return: </label>
				<label class="lblInstrNormal" id="lblYearMinus1Amount">$0.00</label></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan=19>
				<label class="lblInstrNormal" id="lblYearMinus2">2010 BIRT</label>
				<label class="lblInstrNormal"> Return: </label>
				<label class="lblInstrNormal" id="lblYearMinus2Amount">$0.00</label></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan=19>
				<label class="lblInstrNormal" id="lblYearMinus3">2009 BIRT</label>
				<label class="lblInstrNormal"> Return: </label>
				<label class="lblInstrNormal" id="lblYearMinus3Amount">$0.00</label></td>
		</tr>
		<tr height="30px" valign=middle>
			<td colspan=20>
				<label class="lblNormal">Losses maybe carried forward for only 3 years. Losses reported on 
					<label class="lblNormal" id="lblYearMinus4">2008</label> and prior returns have expired.</label></td>
		</tr>
		<tr height="30px" valign=top>
			<td colspan=20><br />
				<label class="lblNormal">Estimated Business Income and Receipts Tax payment on file to be included on Line 6B:</label></td>
		</tr>
		<tr height="30px" valign=middle>
			<td>&nbsp;</td>
			<td colspan=19>
				<label class="lblInstrNormal" id="lblEstimatedTax">$0.00</label></td>
		</tr>
		<tr height="30px" valign=top>
			<td colspan=20>
				<label class="lblNormal">If the payment on file does not agree with your records, send an e-mail to revenue@phila.gov or call 215-686-6600</label><br /></td>
		</tr>
		<tr height="50px" valign=bottom>
			<td colspan=20 align=center>
				<input type=button value="Print" id="btnPrintLcf" onclick='PrintLcf()' style="width: 100px" /></td>
		</tr>
	</table>
</div>
</body>
</html>
