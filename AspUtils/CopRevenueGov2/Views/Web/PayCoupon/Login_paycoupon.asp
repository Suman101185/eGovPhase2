<html>
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<!--#Include File="../Inc/Cache.htm"-->
<!--#Include File="../Inc/Styles.htm"-->
<!--#Include File="../Inc/ispFunctions.js.htm"-->																															
																															
<script language='JavaScript' src='../Inc/ispXmlProc.js.htm'></script>
<TITLE></TITLE>
</head>

<body onload="DisplayCoupLogin()"><!--#Include File="../Inc/AppHeader.htm"-->


<xml id="oCouponInfo" src="../xml/PayCoupon.xml"></xml>

<DIV style="DISPLAY: none; VISIBILTY: visible" id="LogCoupon">
<table cellSpacing="0" cellPadding="0" width="60%" border="0"
		 style  ="MARGIN-TOP: 5px; MARGIN-LEFT: 4%"></TR>
  <tr vAlign="top" align="left">
    <td>
     <p class="lblTextBlack">  All tax payments should be mailed with a proper scannable
      payment document. Coupon books are mailed for these remittances. If you need a scannable
      payment coupon for any tax type, enter the Social Security Nummber (SSN), Employer 
      Identification Number (EIN), Philadelphia Tax Account Number or Real Estate Tax Number (BRT) 
      below.  You will be presented with a list of the active tax types for that entity. 
      If you receive a message indicating "This account number is not active", click 
       <a id=lnkApply class="lblLink" onclick="LogApply()">here</a>
       to register for a tax account number.</p>
       <p></p>
		</td>
   </tr>
   <tr vAlign="top" align="left">
    <td>
			<p class="lblTextBlack"><FONT color=red>The Earnings and 
      School Income Tax are temporarily not available due to technical 
      difficulties.</FONT></p>
			<p></p>
    </td>
   </tr>
 </table>
 
 <table cellSpacing="0" cellPadding="0" width="60%" border="0"
		 style  ="MARGIN-TOP: 5px; MARGIN-LEFT: 4%"></TR>
  <tr vAlign="top" align="left">
   <td>
	 <p class="lblTextBlack">  Please enter your Philadelphia Tax Account Number, Employer
      Identification Number (EIN), Social Security Number (SSN) or Real Estate Tax Number (BRT) 
      as your Tax Account Id.</p></td>
  </tr>
  </table>
   
<table class=tblShowBorder bgcolor="whitesmoke"
		 cellSpacing=0 cellPadding=0 width="497" style="MARGIN-TOP: 15px; MARGIN-LEFT: 4%; WIDTH: 497px; HEIGHT: 50px">
  <tr height=50>
		<td width="50%" align=left nowrap><label class="lblInstrNormal" style="MARGIN-LEFT: 10px">
				Tax Account ID:&nbsp;</label>
			<input class=inpNormal id=txtCouponAcctID
					 name="txtCouponAcctID" onchange="ValidateCoupLogin()" maxlength=12 size=14>
		<td width="20%" align=middle><input class="btnNormal" id="btnSubPrint" name="btnSubPrint"
			  type="submit" value="Submit" onclick="DoCoupLogin()" ></td>
	</tr>
</table>
</DIV>
</body>
<script ID="clientEventHandlersJS" LANGUAGE="javascript">
var arrCoupLoginErr = new Array()

function DisplayCoupLogin() {
	parent.MenuWin.sNew = false
	LogCoupon.style.display = 'block'
	AppHeader.innerHTML = '<Font class=hdrLarge>Online Services</Font>' + '<Font class=hdrMedium>|Print Payment Coupons</Font>'
	txtCouponAcctID.innerText = ''
	LoadCoupLoginError()
	txtCouponAcctID.focus()
	
}		//DisplayCoupLogin

function LoadCoupLoginError() {
	var i=0

	arrCoupLoginErr[i++] = [txtCouponAcctID, 'txtCouponAcctID.value == ""', 'Enter ID Number']
	arrCoupLoginErr[i++] = [txtCouponAcctID, '(txtCouponAcctID.value.length > 12)',
			'Invalid Account Number']
}		//LoadCoupLoginError

function LogApply() {

	LogCoupon.style.display = 'none'
	parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuLogNewAcct)
	ShowForm('LogApplyFirst')

}

function ValidateCoupLogin() {
	AppError.innerText = ispSetInputErr(arrCoupLoginErr)	

}		//ValidateCoupLogin

function DoCoupLogin() {
	var i=0
	var Fieldx
	AppError.innerText = ''
	parent.MenuWin.mnuOnline.online = 'yes'

	ValidateCoupLogin()
	
	if (AppError.innerText == '') {
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "ERROR_INFO/PROGRAM_TYPE", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "ERROR_INFO/ERROR", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "ERROR_INFO/LINE", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "ERROR_INFO/MESSAGE", '', 0)

		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, "I", "ENTITY_INFO/FUNCTION_CODE", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, txtCouponAcctID.value, "ENTITY_INFO/ENTITY_ID", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, "0", "ENTITY_INFO/ENT_TYPE", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "ENTITY_INFO/ACCOUNT_ID", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "ENTITY_INFO/NAME", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "ENTITY_INFO/ADDRESS1", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "ENTITY_INFO/ADDRESS2", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "ENTITY_INFO/ADDRESS3", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "ENTITY_INFO/CITY", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "ENTITY_INFO/STATE", '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "ENTITY_INFO/ZIP_CODE", '', 0)
		for (i = 0; i < 200; i++) {
			ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "TAX_ACCT/FUNC_CODE", '', i)
			ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, "0", "TAX_ACCT/ACCOUNT", '', i)
			ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "TAX_ACCT/ACCOUNT_ID", '', i)
			ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "TAX_ACCT/START_DATE", '', i)
			ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "TAX_ACCT/END_DATE", '', i)
			ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, " ", "TAX_ACCT/FREQUENCY_CODE", '', i)
		}  //for

//alert(parent.MenuWin.xmlPayCoupon.xml)		
		ispCallXMLForm(parent.MenuWin.xmlPayCoupon, oCouponInfo, "PayCouponRecv.asp", "")
//alert(oCouponInfo.xml)

//alert(parent.MenuWin.xmlPayCoupon.xml)
//parent.DocWin.location.href = '../PayCoupon/PayCoupon.asp'
// return

		if (ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO/MESSAGE', "", 0) == ""){
				parent.MenuWin.xmlPayCoupon.loadXML(oCouponInfo.xml)
				parent.DocWin.location.href = 'PayCoupon.asp'
			} else {
				AppError.innerText = ispXmlGetFieldVal(oCouponInfo, 'ERROR_INFO/MESSAGE', "", 0)
				txtCouponAcctID.focus()
		}		//if
	
	} //if
	
}		//DoCoupLogin

</script>
</html>