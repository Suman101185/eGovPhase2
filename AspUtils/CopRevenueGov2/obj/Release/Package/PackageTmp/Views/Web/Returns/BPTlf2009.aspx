<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<script language="javascript" type="text/javascript">
var b_txtBPT1_4 = false
var arrPage1Err = new Array()
var xSecErr = 'ERROR_INFO/'
var xFldErrProgram = xSecErr + 'PROGRAM'
var xFldErrError = xSecErr + 'ERROR'
var xFldErrLine = xSecErr + 'LINE'
var xFldErrMessage = xSecErr + 'MESSAGE'
		
var xSecInfo = 'BPT_INFO/'
var xFldInfAcctID = xSecInfo + 'ACCOUNT_ID'
var xFldInfPeriod = xSecInfo + 'PERIOD'
var xFldInfVer = xSecInfo + 'VERSION'
var xFldInfRetStat = xSecInfo + 'RETURN_STATUS'
var xFldInfLastUpdDate = xSecInfo + 'LAST_UPD_DATE'
var xFldInfRecDate = xSecInfo + 'RECORDING_DATE'
var xFldInfExtDate = xSecInfo + 'EXTENSION_DATE'
var xFldInfSeq = xSecInfo + 'SEQUENCE'
var xFldInfAdjRef = xSecInfo + 'ADJUSTMENT_REF_NO'
var xFldInfUserId = xSecInfo + 'USER_ID'
var xFldInfABtaxRate = xSecInfo + 'SCH_AB_TAX_RATE'
var xFldInfDtaxRate = xSecInfo + 'SCH_D_TAX_RATE'
var xFldInfEmanTaxRate = xSecInfo + 'SCH_E_M_TAX_RATE'
var xFldInfEwhoTaxRate = xSecInfo + 'SCH_E_W_TAX_RATE'
var xFldInfEretTaxRate = xSecInfo + 'SCH_E_R_TAX_RATE'
var xFldInfLossCarry = xSecInfo + 'LOSS_CARRY_FOWARD'

var xSecPg1 = 'BPT_PG1/'
var xFldPg1Li1 = xSecPg1 + 'NET_INCOME'
var xFldPg1Li2 = xSecPg1 + 'GROSS_RECEIPTS'
var xFldPg1Li3 = xSecPg1 + 'TAX_DUE'
var xFldPg1Li4 = xSecPg1 + 'ESTIMATED_TAX'
var xFldPg1Li5 = xSecPg1 + 'TOTAL_TAX'
var xFldPg1Li6 = xSecPg1 + 'NPT_TAX_CREDIT'
var xFldPg1Li7 = xSecPg1 + 'BPT_TAX_CREDIT'
var xFldPg1Li8 = xSecPg1 + 'TOTAL_PAY_CREDITS'
var xFldPg1Li9 = xSecPg1 + 'NET_TAX'
var xFldPg1Li10 = xSecPg1 + 'INTEREST_PENALTY'
var xFldPg1Li11 = xSecPg1 + 'AMOUNT_OWED'
var xFldPg1Li12 = xSecPg1 + 'REFUND'
var xFldPg1Li13 = xSecPg1 + 'NPT_OVERPAY'
var xFldPg1Li14 = xSecPg1 + 'BPT_OVERPAY'

function AdjustNameDisplay(incName) {
	var sEntityName = incName
	var lName = "", fName = "", mName = "", newName = ""
		
	if (sEntityName.indexOf("*") != -1)	{//If name contains *'s
		sEntityName = sEntityName.split("*")
		lName = (sEntityName[0].substr(0,1)) + (sEntityName[0].substr(1).toLowerCase())
		if (sEntityName[1]) {
			fName = (sEntityName[1].substr(0,1)) + (sEntityName[1].substr(1).toLowerCase())
		}		//if
		
		if (sEntityName[2]) {
			mName = sEntityName[2].substr(0,1).toUpperCase()
		}		//if
		newName = fName + " " + mName + " " + lName
		return newName
	} else {
		return sEntityName
	}		//if
}		//AdjustNameDisplay

function DisplayBPTlfReturn() {
//Check that user has a BPT account
	if (parent.MenuWin.xmlAccount.documentElement.selectSingleNode("//*/TAX_ACCT[ACCOUNT = 24]")) {
		parent.MenuWin.ispHighlightMenu(parent.MenuWin.mnuBPTlfYear09)
		parent.MenuWin.xmlBPTlf.loadXML(parent.MenuWin.xmlBPTlfTemplate.xml)
		BPT.style.display = 'block'
		AppHeader.innerHTML = txtHeader + '<Font class=hdrMedium>|Business Profit Tax for </Font>' + 
				'<Font class=hdrMedium>' + (sCurrYear-1) + '</Font>'
		parent.MenuWin.gsInstructionItem = '#BPTlfReturn'
		AppMessage.innerHTML = /* parent.MenuWin.gsInstructionText*/ '' +
				'<BR>The Business Profit Tax for '+ (sCurrYear-1) + ' is due April 15, '+ sCurrYear + '.'
//		InstructionText.innerHTML = ' for Instructions on filing this return'

		ispXmlSetFieldVal(parent.MenuWin.xmlBPTlf, 'INQ', xFldInfRetStat, '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlBPTlf, 
				ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO/ACCOUNT_ID', '', 0),
				xFldInfAcctID, '', 0)
		ispXmlSetFieldVal(parent.MenuWin.xmlBPTlf, '12/31/'+ (sCurrYear-1), xFldInfPeriod, '', 0)
		ispCallXMLForm(parent.MenuWin.xmlBPTlf, parent.MenuWin.xmlBPTlf, "BPTlfReturn","")
		if (ispXmlGetFieldVal(parent.MenuWin.xmlBPTlf, xFldErrError, '', 0) != 0) { 
			parent.RightFrame.rows = '*,0'
			BPT.style.display = 'block'
			FieldLock(true)
			AppError.innerText = ispXmlGetFieldVal(parent.MenuWin.xmlBPTlf,	xFldErrMessage, "", 0)
			btnBPTSubmit.disabled = true
			chkAmended.disabled = true
			return
		}		//if
		if (ispXmlGetFieldVal(parent.MenuWin.xmlBPTlf, xFldInfRetStat, '', 0) == 'EZ') { 
			parent.MenuWin.xmlBPTlf.loadXML(oBPTlfTemp.xml)
			parent.MenuWin.ispMenu_onclick(parent.MenuWin.mnuReBPTez)
		}		//if
		if (parent.MenuWin.divAcctInfo.style.display == 'none') {
			parent.MenuWin.divAcctInfo.style.display = 'block'
			parent.MenuWin.divAccount.style.display = 'none'
		}		//if
	}	else {
		parent.MenuWin.xmlBPTlf.loadXML(oBPTlfTemp.xml)
		parent.MenuWin.ispMenu_onclick(parent.MenuWin.mnuAcctInfo)
	}		//if

	parent.RightFrame.rows = '*,0'
	BPT_Pg1.style.display = 'block'
	LoadError()
	CheckBPTXML()
	SetBPTFields()
	PopulateBPTHeader()
	PopulateBPTData()
	PerformCalcsBPTlfPg1()
}	//DisplayBPTlfReturn

function CheckBPTXML(){
var bPeriodExist = true
var firstOfYear = '01/01/' + (sCurrYear-1)

	if (ispXmlGetFieldVal(parent.MenuWin.xmlBPTlf, xFldInfPeriod, '', 0) != '' &&
			new Date(ispXmlGetFieldVal(parent.MenuWin.xmlBPTlf, xFldInfPeriod, '', 0)) < 
			new Date(firstOfYear)) {
			///new Date('01/01/2005')) {
		bPeriodExist = false
	}		//if

	if (ispXmlGetFieldVal(parent.MenuWin.xmlBPTlf, xFldInfPeriod, '', 0) == '') {
		bPeriodExist = false
	}		//if

	if (bPeriodExist == false) {
		with (parent.MenuWin) {
//error_info
			ispXmlSetFieldVal(xmlBPTlf, '', xFldErrProgram, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldErrError, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldErrLine, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldErrMessage, '', 0)
//BPT_info	
			ispXmlSetFieldVal(xmlBPTlf, '12/31/' + (sCurrYear-1), xFldInfPeriod, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfVer, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfRetStat, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfLastUpdDate, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfRecDate, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfExtDate, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfSeq, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfAdjRef, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfUserId, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfABtaxRate, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfDtaxRate, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfEmanTaxRate, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfEwhoTaxRate, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfEretTaxRate, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, '', xFldInfLossCarry, '', 0)
//BPT_pg1
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li1, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li2, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li3, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li4, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li5, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li6, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li7, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li8, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li9, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li10, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li11, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li12, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li13, '', 0)
			ispXmlSetFieldVal(xmlBPTlf, 0, xFldPg1Li14, '', 0)
		}		//with
//BPT_schdA
		ClearBPTlfSchdA()
//BPT_schdB
		ClearBPTlfSchdB()
//BPT_schdC1
		ClearBPTlfSchdC1()
//BPT_SchdD
		ClearBPTlfSchdD()
//BPT_SchdE
		ClearBPTlfSchdE()
		ClearPreparerXML(parent.MenuWin.xmlBPTlf, xSecInfo)
	}		//if
}		//CheckBPTXML

function SetBPTFields() {
	chkAgreement.checked = false
	chkAmended.checked = false

	if (ispXmlGetFieldVal(parent.MenuWin.xmlBPTlf, xFldInfVer, '', 0) == '') {
		FieldLock(false)
		chkAmended.disabled = true
		chkTaxpayer.checked = false
	} else {
		if (ispXmlGetFieldVal(parent.MenuWin.xmlBPTlf, xFldScALi1, '', 0) != '') {
			lblLnkSchdB.onclick = ''
			lblLnkSchdB.style.cursor = 'default'
			lblLnkSchdB.disabled = true
		} else if (ispXmlGetFieldVal(parent.MenuWin.xmlBPTlf, xFldScBLi1, '', 0) != '') {
			lblLnkSchdA.onclick = ''
			lblLnkSchdA.style.cursor = 'default'
			lblLnkSchdA.disabled = true
		}		//if
		chkAmended.disabled = false
		FieldLock(true)
	}		//if
}		//SetBPTFields

function PopulateBPTHeader() {
var addrIdx
	if (ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO/ENTITY_ID', '', 0) != '') {
		lblAccountId.innerText = ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO/ACCOUNT_ID', '', 0)
		lblEntityId.innerText = ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO/ENTITY_ID', '', 0)
		if (ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO/TYPE', '', 0) == 1) {
			lblEntityType.innerText = 'EIN:'
			lblEntityId.innerText = ' ' + lblEntityId.innerText.substr(0,2) + '-'	+ 
					lblEntityId.innerText.substr(2)
		} else {
			lblEntityType.innerText = 'SSN:'
			lblEntityId.innerText = ' ' + lblEntityId.innerText.substr(0,3) + '-'	+ 
					lblEntityId.innerText.substr(3,2) + '-' + lblEntityId.innerText.substr(5)
		}		//if
		lblName.innerText = AdjustNameDisplay(ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS/NAME', '', addrIdx))
		addrIdx = LocatePrimaryAddr()	
		lblAddress.innerText = ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS/ADDRESS1', '', addrIdx) +
				' ' + ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS/CITY', '', addrIdx) +
				' ' + ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS/STATE', '', addrIdx) +
				' ' + ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS/ZIP', '', addrIdx)
	}		//if
}		//PopulateBPTHeader

function PopulateBPTData() {
	with (parent.MenuWin) {
		dBPTNetRate = ispXmlGetFieldVal(xmlBPTlf, xFldInfABtaxRate, '', 0)
		dBPTGrossRate = ispXmlGetFieldVal(xmlBPTlf, xFldInfDtaxRate, '', 0)
		dBPTManufacturerRate = ispXmlGetFieldVal(xmlBPTlf, xFldInfEmanTaxRate, '', 0)
		dBPTWholesaleRate = ispXmlGetFieldVal(xmlBPTlf, xFldInfEwhoTaxRate, '', 0)
		dBPTRetailerRate = ispXmlGetFieldVal(xmlBPTlf, xFldInfEretTaxRate, '', 0)
//alert(dBPTNetRate)		
//BPT_Pg1
		lblBPT1_1.innerText = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li1, '', 0), 0)
		lblBPT1_2.innerText = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li2, '', 0), 0)
		lblBPT1_3.innerText = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li3, '', 0), 0)
		txtBPT1_4.value = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li4, '', 0), 0)
		lblBPT1_5.innerText = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li5, '', 0), 0)
		txtBPT1_6a.value = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li6, '', 0), 0)
		txtBPT1_6b.value = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li7, '', 0), 0)
		lblBPT1_6c.innerText = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li8, '', 0), 0)
//EGOVWEB-60 Changed xFldPg1Li8 to xFldPg1Li9
		lblBPT1_7.innerText = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li9, '', 0), 0)
		txtBPT1_8.value = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li10, '', 0), 0)
		lblBPT1_9.innerText = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li11, '', 0), 0)
		txtBPT1_10a.value = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li12, '', 0), 0)
		txtBPT1_10b.value = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li13, '', 0), 0)
		txtBPT1_10c.value = ispFormatMoney(ispXmlGetFieldVal(xmlBPTlf, xFldPg1Li14, '', 0), 0)
	}		//with
//BPT_SchdA
	PopulateBPTlfSchdA()
//BPT_SchdB
	PopulateBPTlfSchdB()
//BPT_SchdC1
	PopulateBPTlfSchdC1()
//BPT_SchdD
	PopulateBPTlfSchdD()
//BPT_SchdE
	PopulateBPTlfSchdE()
	PopulatePreparer(parent.MenuWin.xmlBPTlf, xSecInfo)
}		//PopulateBPTData

function FieldLock(bDisabled) {
	txtTermDate.disabled = bDisabled

	lblBPT1_1.disabled = bDisabled
	lblBPT1_2.disabled = bDisabled
	lblBPT1_3.disabled = bDisabled
	txtBPT1_4.disabled = bDisabled
	lblBPT1_5.disabled = bDisabled
	txtBPT1_6a.disabled =	bDisabled
	txtBPT1_6b.disabled = bDisabled
	lblBPT1_6c.disabled = bDisabled
	lblBPT1_7.disabled = bDisabled
	txtBPT1_8.disabled = bDisabled
	lblBPT1_9.disabled = bDisabled
	txtBPT1_10a.disabled = bDisabled
	txtBPT1_10b.disabled = bDisabled
	txtBPT1_10c.disabled = bDisabled
	
	btnBPTSubmit.disabled = bDisabled
	
	FieldLockBPTlfSchdA(bDisabled)
	FieldLockBPTlfSchdB(bDisabled)
	FieldLockBPTlfSchdC1(bDisabled)
	FieldLockBPTlfSchdD(bDisabled)
	FieldLockBPTlfSchdE(bDisabled)
	DisablePreparer(bDisabled)
}		//FieldLock

function SetFocus() {
	document.activeElement.select()
}		//SetFocus

function btnBPTPrint_onclick() {
var objCurrDisplayed

	btnBPTPrint.style.visibility = 'hidden'
	btnBPTSubmit.style.visibility = 'hidden'

	if (BPT.style.display == 'block') {
		objCurrDisplayed = 'BPT'
		BPT_SchdA.style.display = "block"
		BPT_SchdB.style.display = "block"
		BPT_SchdC1.style.display = "block"
		BPT_SchdD.style.display = "block"
		BPT_SchdE.style.display = "block"
	}		//if
	AppError.innerText = ''
	window.print()
	btnBPTPrint.style.visibility = 'visible'
	btnBPTSubmit.style.visibility = 'visible'

	if (objCurrDisplayed == 'BPT') {
		BPT_SchdA.style.display = "none"
		BPT_SchdB.style.display = "none"
		BPT_SchdC1.style.display = "none"
		BPT_SchdD.style.display = "none"
		BPT_SchdE.style.display = "none"
	}		//if
}		//btnBPTPrint_onclick

function btnBPTSubmit_onclick() {
	var tempXML = new ActiveXObject("MSXML.DOMDocument")	
	AppError.innerText = ''
	ValidateWorksheet('BPT_Pg1')
	if (AppError.innerText != ''){
		ShowPage('Pg1')
		return
	}		//if
	ValidateWorksheet('BPT_SchdA')
	if (AppError.innerText != ''){
		ShowPage('SchdA')
		return
	}		//if
	ValidateWorksheet('BPT_SchdB')
	if (AppError.innerText != ''){
		ShowPage('SchdB')
		return
	}		//if
	ValidateWorksheet('BPT_SchdC1')
	if (AppError.innerText != ''){
		ShowPage('SchdC1')
		return
	}		//if
	ValidateWorksheet('BPT_SchdD')
	if (AppError.innerText != ''){
		ShowPage('SchdD')
		return
	}		//if
	ValidateWorksheet('BPT_SchdE')
	if (AppError.innerText != ''){
		ShowPage('SchdE')
		return
	}		//if

	if (AppError.innerText == ''){
		AppError.innerText = ValidatePreparer()
	}		//if

	if (AppError.innerText == ''){
		txtTermDate_onblur()
		ispXmlSetFieldVal(parent.MenuWin.xmlBPTlf, '', xFldInfRetStat, '', 0)
		PopulateXmlBPTlf()
		parent.DocWin.ispCallXMLForm(parent.MenuWin.xmlBPTlf, tempXML, "BPTlfReturn", "")
		if (ispXmlGetFieldVal(tempXML, xFldErrProgram, '', 0) == '') {
			parent.MenuWin.xmlBPTlf.loadXML(tempXML.xml)
//			BPT.style.display = 'none'
			DisplayBPTlfThankYou()
		} else {
			parent.MenuWin.xmlBPTlf.loadXML(tempXML.xml)
			AppError.innerText = ispXmlGetFieldVal(tempXML, xFldErrMessage, '', 0)
		}		//if
	}		//if
}		//btnBPTSubmit_onclick

function DisplayBPTlfThankYou() {
	frmePay.imgCards.src = '../../Images/epay.gif'
	xmlCC.src = '../../xml/CCBilling.xml'
	xmlCCTemplate.src = '../../xml/CCBilling.xml'

//	BPT.style.display = "none"
	BPT_Pg1.style.display = "none"
	BPT_SchdA.style.display = "none"
	BPT_SchdB.style.display = "none"
	BPT_SchdC1.style.display = "none"
	BPT_SchdD.style.display = "none"
	BPT_SchdE.style.display = "none"

	lblThankYouName.innerText = lblName.innerText
	lblAcctNo.innerText = ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO/ENTITY_ID', '', 0)
	if (ispXmlGetFieldVal(parent.MenuWin.xmlBPTlf, xFldInfAdjRef, '', 0) != '') {
		lblConfirmNo.innerText = ispXmlGetFieldVal(parent.MenuWin.xmlBPTlf, xFldInfAdjRef, '', 0)
	} else {
		lblConfirmNo.innerText = ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO/ACCOUNT_ID', '', 0)
	}		//if Adjustment reference number
	divBPTlfThankYou.style.display = 'block'
return
//	this.focus()
//	parent.MenuWin.gsInstructionItem = ''
//	AppMessage.innerHTML = ''
//	AppHeader.innerHTML = txtHeader + '<Font class=hdrMedium>|thank you</Font>'
//	ccFeeText.innerText = 'A user fee of 2.49% will be charged in addition to the amount of tax due.'
}		//DisplayThankyou

function txtTermDate_onblur() {
	if (AppError.innerText == "" && txtTermDate.value != ""){
		var strBD = ispValidateDate(txtTermDate.value)
		
		if (strBD == false){
			AppError.innerText = 'Invalid termination date'
			txtTermDate.className = 'inpError'
			blnErr = true
		} else {
			txtTermDate.className = 'inpNormal'
			txtTermDate.value = strBD
		}		//if
	} else {
		txtTermDate.className = 'inpNormal'
	}		//if
}		//txtToDate_onblur

function chkAmended_onclick() {
	if (chkAmended.checked == true) {
		BPT_Pg1.style.display = 'block'
		btnBPTSubmit.disabled = false
		FieldLock(false)
		txtBPT1_4.focus()
		ClearPreparer()
	} else {
		BPT_Pg1.style.display = 'block'
		PopulateBPTData()
		btnBPTSubmit.disabled = true
		chkAgreement.checked = false
		FieldLock(true)
		PopulatePreparer(parent.MenuWin.xmlBPTlf, xSecInfo)
	}		//if
}		//chkAmended_onclick

function ShowPage(iSch) {
	BPT_Pg1.style.display = 'none'
	BPT_SchdA.style.display = 'none'
	BPT_SchdB.style.display = 'none'
	BPT_SchdC1.style.display = 'none'
	BPT_SchdD.style.display = 'none'
	BPT_SchdE.style.display = 'none'
	sPrevWrkSht = sCurrWrkSht
	AppError.innerText = ''
	var FocusItem
	switch (iSch)	{
		case "Pg1":
			sCurrWrkSht = 'PG1'
			BPT_Pg1.style.display = 'block'
			if (sPrevWrkSht == 'SCHDA') {
				lblBPT1_1.innerText = lblBPT_SchA_12.innerText
			} else if (sPrevWrkSht == 'SCHDB') {
				lblBPT1_1.innerText = lblBPT_SchB_12.innerText
			}		//if
			PerformCalcsBPTlfPg1()
			break
		case "SchdA":
			if (PrepForMath(txtBPT_SchB_1.value) != 0) {		
				alert('You have already filled out Schedule B. \n' +
						'Click on the \'Return to Page 1\' button to preserve the Schedule B values. \n' +
						'Once you enter a value on Schedule A, Schedule B will be cleared.')
			}		//if
			sCurrWrkSht = 'SCHDA'
			BPT_SchdA.style.display = 'block'
			FocusItem = txtBPT_SchA_1
			break
		case "SchdB":
			if (PrepForMath(txtBPT_SchA_1.value) != 0) {
				alert('You have already filled out Schedule A. \n' +
						'Click on the \'Return to Page 1\' button to preserve the Schedule A values. \n' +
						'Once you enter a value on Schedule B, Schedule A will be cleared.')
			}		//if
			sCurrWrkSht = 'SCHDB'
			BPT_SchdB.style.display = 'block'
			FocusItem = txtBPT_SchB_1
			break
		case "SchdC1":
			sCurrWrkSht = 'SCHDC1'
			BPT_SchdC1.style.display = 'block'
			if (sPrevWrkSht == 'SCHDA') {
				btnC1GoTo.value = 'Return to Schedule A'
				btnC1GoTo.onclick = Function('ShowPage("SchdA");')
			} else {
				btnC1GoTo.value = 'Return to Schedule B'
				btnC1GoTo.onclick = Function('ShowPage("SchdB");')
			}		//if
			FocusItem = txtBPT_SchC1_1A
			break
		case "SchdD":
			sCurrWrkSht = 'SCHDD'
			BPT_SchdD.style.display = 'block'
			lblBPT_SchD_10.innerText = lblBPT_SchE_15.innerText
			PerformCalcsBPTlfSchdD()
			FocusItem = txtBPT_SchD_1
			break
		case "SchdE":
			sCurrWrkSht = 'SCHDE'
			BPT_SchdE.style.display = 'block'
			PerformCalcsBPTlfSchdE()
			FocusItem = txtBPT_SchE_1
			break
	}		//switch

	if (FocusItem) {
		if (FocusItem.disabled == false) {
			FocusItem.focus()
		}		//if
	}		//if
}		//ShowPage

function LoadError(){
	var i=0

//BPT_Pg1	
	arrPage1Err[i++] = [txtTermDate, 'txtTermDate.value != "" & ispValidateDate(txtTermDate.value) == false', 'Invalid to termination date']
	arrPage1Err[i++] = [txtBPT1_4, 'txtBPT1_4.value == ""', 'Answer Question 4']
	arrPage1Err[i++] = [txtBPT1_4, 'ispValue(txtBPT1_4.value) == false', 'Value for Question 4 must be numeric']
	arrPage1Err[i++] = [txtBPT1_4, 'ispNegativeNumber(txtBPT1_4.value) == false', 'Value for Question 4 must NOT be negative']
	arrPage1Err[i++] = [txtBPT1_6a, 'txtBPT1_6a.value == ""', 'Answer Question 6a']
	arrPage1Err[i++] = [txtBPT1_6a, 'ispValue(txtBPT1_6a.value) == false', 'Value for Question 6a must be numeric']
	arrPage1Err[i++] = [txtBPT1_6a, 'ispNegativeNumber(txtBPT1_6a.value) == false', 'Value for Question 6a must NOT be negative']
	arrPage1Err[i++] = [txtBPT1_6b, 'txtBPT1_6b.value == ""', 'Answer Question 6b']
	arrPage1Err[i++] = [txtBPT1_6b, 'ispValue(txtBPT1_6b.value) == false', 'Value for Question 6b must be numeric']
	arrPage1Err[i++] = [txtBPT1_6b, 'ispNegativeNumber(txtBPT1_6b.value) == false', 'Value for Question 6b must NOT be negative']
	arrPage1Err[i++] = [txtBPT1_8, 'txtBPT1_8.value == ""', 'Answer Question 8']
	arrPage1Err[i++] = [txtBPT1_8, 'ispValue(txtBPT1_8.value) == false', 'Value for Question 8 must be numeric']
	arrPage1Err[i++] = [txtBPT1_8, 'ispNegativeNumber(txtBPT1_8.value) == false', 'Value for Question 8 must NOT be negative']
	//EGOVWEB-60 Added error section for txtBPT1_10a
	arrPage1Err[i++] = [txtBPT1_10a, 'txtBPT1_10a.value == ""', 'Answer Question 10a']
	arrPage1Err[i++] = [txtBPT1_10a, 'ispValue(txtBPT1_10a.value) == false', 'Value for Question 10a must be numeric']
	arrPage1Err[i++] = [txtBPT1_10a, 'ispNegativeNumber(txtBPT1_10a.value) == false', 'Value for Question 10a must NOT be negative']
	arrPage1Err[i++] = [txtBPT1_10b, 'txtBPT1_10b.value == ""', 'Answer Question 10b']
	arrPage1Err[i++] = [txtBPT1_10b, 'ispValue(txtBPT1_10b.value) == false', 'Value for Question 10b must be numeric']
	arrPage1Err[i++] = [txtBPT1_10b, 'ispNegativeNumber(txtBPT1_10b.value) == false', 'Value for Question 10b must NOT be negative']
	arrPage1Err[i++] = [txtBPT1_10c, 'txtBPT1_10c.value == ""', 'Answer Question 10c']
	arrPage1Err[i++] = [txtBPT1_10c, 'ispValue(txtBPT1_10c.value) == false', 'Value for Question 10c must be numeric']
	arrPage1Err[i++] = [txtBPT1_10c, 'ispNegativeNumber(txtBPT1_10c.value) == false', 'Value for Question 10c must NOT be negative']
//BPT_SchdA
	LoadErrorBPTlfSchdA()
//BPT_SchdB
	LoadErrorBPTlfSchdB()
//BPT_SchdC1
	LoadErrorBPTlfSchdC1()
//BPT_SchdD
	LoadErrorBPTlfSchdD()
//BPT_SchdE
	LoadErrorBPTlfSchdE()
}		//LoadError

function PopulateXmlBPTlf() {
	with (parent.MenuWin) {
		//Page 1
		ispXmlSetFieldVal(xmlBPTlf, '12/31/' + (sCurrYear-1), xFldInfPeriod, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(lblBPT1_1.innerText), xFldPg1Li1, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(lblBPT1_2.innerText), xFldPg1Li2, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(lblBPT1_3.innerText), xFldPg1Li3, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(txtBPT1_4.value), xFldPg1Li4, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(lblBPT1_5.innerText), xFldPg1Li5, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(txtBPT1_6a.value), xFldPg1Li6, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(txtBPT1_6b.value), xFldPg1Li7, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(lblBPT1_6c.innerText), xFldPg1Li8, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(lblBPT1_7.innerText), xFldPg1Li9, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(txtBPT1_8.value), xFldPg1Li10, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(lblBPT1_9.innerText), xFldPg1Li11, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(txtBPT1_10a.value), xFldPg1Li12, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(txtBPT1_10b.value), xFldPg1Li13, '', 0)
		ispXmlSetFieldVal(xmlBPTlf, ispStripCurrency(txtBPT1_10c.value), xFldPg1Li14, '', 0)
	}		//with
	//BPT_SchdA
		if (lblLnkSchdA.disabled == true || PrepForMath(txtBPT_SchA_1.value) == 0) {
			ClearBPTlfSchdA()
		} else {
			PopulateXmlBPTlfSchdA()
		}		//if
	//BPT_SchdB
		if (lblLnkSchdB.disabled == true || PrepForMath(txtBPT_SchB_1.value) == 0) {
			ClearBPTlfSchdB()
		} else {
			PopulateXmlBPTlfSchdB()
		}		//if
	//BPT_SchdC1
	PopulateXmlBPTlfSchdC1()
	//BPT_SchdD
	PopulateXmlBPTlfSchdD()
	//BPT_SchdE
	PopulateXmlBPTlfSchdE()
	PopulatePreparerXML(parent.MenuWin.xmlBPTlf, xSecInfo)
	ispXmlSetFieldVal(parent.MenuWin.xmlBPTlf, '', 'DEBUG', '', 0)
}		//PopulateXmlBPTlf

function ValidateWorksheet(formId) {
	var sId = document.activeElement.id
	var ObjSelected
	
	AppError.innerText = ""
	if (sId == 'txtPercentage') {
		//Do nothing
	} else if (sId != "")	{
		ObjSelected = document.getElementById(sId)
		ObjSelected.value = ispFormatMoney(ObjSelected.value, 0)
	}		//if

	switch(formId){
		case "BPT_Pg1":
			AppError.innerText = ispSetInputErr(arrPage1Err)
			PerformCalcsBPTlfPg1()
			break	
		case "BPT_SchdA":
			AppError.innerText = ispSetInputErr(arrSchdAErr)
			PerformCalcsBPTlfSchdA()
			break
		case "BPT_SchdB":
			AppError.innerText = ispSetInputErr(arrSchdBErr)
			PerformCalcsBPTlfSchdB()
			break
		case "BPT_SchdC1":
			AppError.innerText = ispSetInputErr(arrSchdC1Err)
			PerformCalcsBPTlfSchdC1()
			break
		case "BPT_SchdD":
			AppError.innerText = ispSetInputErr(arrSchdDErr)
			PerformCalcsBPTlfSchdD()
			if (ObjSelected == 'txtBPT_SchD_7' && PrepForMath(ObjSelected.value) > 0) {
				alert('You have entered or changed an amount greater then 0 on line 7. \n' +
						'You will have to fill out Schedule E')
			}		//if
			break
		case "BPT_SchdE":
			AppError.innerText = ispSetInputErr(arrSchdEErr)
			PerformCalcsBPTlfSchdE()
			break
	}		//Switch
	
	if (AppError.innerText == ""){
	} else {
		AppError.scrollIntoView(true)
	}		//if
}		//ValidateWorksheet			

//Begin Calculations
function PrepForMath(numString) {	//Removes $ and , from the string and forces the string into a number
	var temp
	temp = numString

	if (temp.indexOf("(") == -1){
		return temp = (1* (temp.replace(/[,$]/g,"")))
	}	else {		//Negative Value
		temp = temp.replace(/[,$()]/g,"")
		temp = (-1) * temp
		return temp
	}		//if
}		//PrepForMath

function PerformCalcsBPTlfPg1(){
	CalcBPTlfPg1Line3()
	CalcBPTlfPg1Line5()
	CalcBPTlfPg1Line6c()
	CalcBPTlfPg1Line7()
	//EGOVWEB-60 rewrite CalcBPTlfPg1Line9 and CalcBPTlfPg1Line10a into CalcBPTlfPg1Line9_10
	CalcBPTlfPg1Line9_10()
//	CalcBPTlfPg1Line9()
//	CalcBPTlfPg1Line10a()
}		//PerformCalcsBPTlfPg1

function CalcBPTlfPg1Line3(){
	if (lblBPT1_1.innerText != '' && lblBPT1_2.innerText != '')	{
		lblBPT1_3.innerText = ispFormatMoney(PrepForMath(lblBPT1_1.innerText) + PrepForMath(lblBPT1_2.innerText), 0)
		if (b_txtBPT1_4 == false && PrepForMath(lblBPT1_3.innerText) != 0) {
			txtBPT1_4.value = lblBPT1_3.innerText
			b_txtBPT1_4 = true
		} else if (b_txtBPT1_4 == true && PrepForMath(lblBPT1_3.innerText) != 0 && PrepForMath(txtBPT1_4.value) == 0) {
			AppError.innerText = 'The line 4 can not be 0 if line 3 has a value'
			txtBPT1_4.className = 'inpError'
		}		//if
	}		//if
}		//CalcBPTlfPg1Line3

function CalcBPTlfPg1Line5(){
	if (txtBPT1_4.value != '')	{
		lblBPT1_5.innerText = ispFormatMoney(PrepForMath(lblBPT1_3.innerText) + PrepForMath(txtBPT1_4.value), 0)
	}		//if
}		//CalcBPTlfPg1Line5

function CalcBPTlfPg1Line6c(){
	if (txtBPT1_6a.value != '' && txtBPT1_6b.value != '')	{
		lblBPT1_6c.innerText = ispFormatMoney(PrepForMath(txtBPT1_6a.value) + PrepForMath(txtBPT1_6b.value), 0)
	}		//if
}		//CalcBPTlfPg1Line6c

function CalcBPTlfPg1Line7(){
	if (lblBPT1_5.innerText != '' && lblBPT1_6c.innerText != '')	{
		lblBPT1_7.innerText = ispFormatMoney(PrepForMath(lblBPT1_5.innerText) - PrepForMath(lblBPT1_6c.innerText), 0)
		if (lblBPT1_7.innerText < 0) {
			lblBPT1_7.innerText = ispFormatMoney(0, 0)
		}		//if
	}		//if
}		//CalcBPTlfPg1Line7

//EGOVWEB-60 rewrite CalcBPTlfPg1Line9 and CalcBPTlfPg1Line10a into CalcBPTlfPg1Line9_10
function CalcBPTlfPg1Line9_10() {
	if (lblBPT1_7.innerText != '' && txtBPT1_8.value != '') {
		lblBPT1_9.innerText = ispFormatMoney(PrepForMath(lblBPT1_7.innerText) + PrepForMath(txtBPT1_8.value), 0)
	} 	//if

	txtBPT1_8.disabled = false
	if (lblBPT1_9.innerText != '') {
		if (PrepForMath(lblBPT1_9.innerText) < 0) {
			txtBPT1_8.disabled = true
			if (txtBPT1_10a.value == '') {
				txtBPT1_10a.value = ispFormatMoney(0, 0)
			} 	//if

			if (txtBPT1_10b.value == '') {
				txtBPT1_10b.value = ispFormatMoney(0, 0)
			} 	//if

			if (txtBPT1_10c.value == '') {
				txtBPT1_10c.value = ispFormatMoney(0, 0)
			} 	//if

			if (PrepForMath(txtBPT1_10a.value) + PrepForMath(txtBPT1_10b.value) + PrepForMath(txtBPT1_10c.value) != Math.abs(PrepForMath(lblBPT1_7.innerText))) {
				AppError.innerText = 'Lines 10a, 10b and 10c must equal Line 7'
			} 	//if

			lblBPT1_9.innerText = ispFormatMoney(0, 0)
		} else {
			txtBPT1_10a.value = ispFormatMoney(0, 0)
			txtBPT1_10b.value = ispFormatMoney(0, 0)
			txtBPT1_10c.value = ispFormatMoney(0, 0)
		} 	//if
	} 	//if
} 	//CalcBPTlfPg1Line9_10

/*function CalcBPTlfPg1Line9(){
	if (lblBPT1_7.innerText != '' && txtBPT1_8.value != '')	{
			lblBPT1_9.innerText = ispFormatMoney(PrepForMath(lblBPT1_7.innerText) + PrepForMath(txtBPT1_8.value), 0)
			txtBPT1_10a.value = ispFormatMoney(0, 0)
	}		//if
}		//CalcBPTlfPg1Line9

function CalcBPTlfPg1Line10a(){
	if (lblBPT1_9.innerText != '')	{
		if (PrepForMath(lblBPT1_9.innerText) < 0) {
			txtBPT1_10a.value = ispFormatMoney(PrepForMath(lblBPT1_9.innerText) * -1, 0)
			lblBPT1_9.innerText = ispFormatMoney(0, 0)
		}		//if
	}		//if
	if (PrepForMath(txtBPT1_10a.value) > 0) {
		if (PrepForMath(txtBPT1_10b.value) + PrepForMath(txtBPT1_10c.value) > PrepForMath(txtBPT1_10a.value)) {
			if (AppError.innerText == '') {
				AppError.innerText = 'The sum of lines 10b and 10c can not be greater than the amount of line 10a'
				txtBPT1_10b.className = 'inpError'
				txtBPT1_10c.className = 'inpError'
			}		//if
		}		//if
	}		//if
}		//CalcBPTlfPg1Line10a	*/
</script>

<DIV id="BPT" style="DISPLAY: block; VISIBILITY: visible" Name="BPT">  
<table class=tblShowBorder width="90%" bgcolor="whitesmoke" style="MARGIN-LEFT: 4%" border=0
		 cellSpacing=0 cellPadding=0 id=TABLE1>
  <tr>
    <td WIDTH="2%"></td>
    <td WIDTH="8%"></td>
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
  <tr>
		<td >&nbsp;</td>
		<td >
			<label class="lblInstrNormal">Name:&nbsp;</label>
		</td>
		<td colspan=10>
			<label id=lblName class="lblTextBlack" nowrap></label></td>
		<td colspan=3 align=right>
			<label id=lblAccountType class="lblInstrNormal">Account No.: &nbsp;</label></td>
		<td colspan=4>
			<label id=lblAccountId class="lblTextBlack"></label></td>
	</tr>
  <tr>
		<td >&nbsp;</td>
		<td >
			<label class="lblInstrNormal">Address:&nbsp;</label>
		</td>
		<td colspan=10>
			<label id=lblAddress class="lblTextBlack"></label></td>
		<td colspan=3 align=right>
			<label id=lblEntityType class="lblInstrNormal">EIN: &nbsp;</label></td>
		<td colspan=4>
			<label id=lblEntityId class="lblTextBlack"></label></td>
	</tr>
</table>

<div id="BPT_Pg1" style="DISPLAY: block; VISIBILTY: visible" Name="BPT_Pg1">
<table class=tblShowBorder id=TABLE1 style="MARGIN-LEFT: 4%" cellSpacing=0 cellPadding=0 width="90%" border=0>
  <tr>
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
  <tr>
		<td align=left nowrap>
			<INPUT id=chkAmended type=checkbox onclick="chkAmended_onclick()">
				<label class="lblTextBlacksmall">Check if amended return.</label>
		</td>
	</tr>
	<tr>
		<td colspan=17>
			<label class="lblTextBlacksmall">If your business terminated in 
				<script>document.write(sCurrYear - 1)</script>,
					enter the termination date here <u>AND</u> file a CHANGE FORM.</label>
		</td>
		<td colspan=3 style="VERTICAL-ALIGN: bottom">
			<input class=inpNormal
				 id=txtTermDate onfocus="SetFocus()" maxlength=10
				 onblur="return txtTermDate_onblur()">
		</td>
	</tr>
</table>

<table class=tblShowBorder id=TABLE2 style="MARGIN-LEFT: 4%" cellSpacing=0 cellPadding=0 width="90%" border=0>
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
  <tr class=rowDataOdd>
		<td colspan=20><label class="lblInstrNormal"><br><u><b>COMPUTATION OF TAX DUE OR OVERPAYMENT</b></u></label></td>
	</tr>
  <tr class=rowDataEven>
		<td><label class="lblInstrNormal">1.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">NET INCOME PORTION OF TAX (from </label>
			<label id="lblLnkSchdB" class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage('SchdB')>Schedule B, Line 12</label>
			<label class="lblInstrNormal"> or </label>
			<label id="lblLnkSchdA" class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage('SchdA')>Schedule A, Line 12</label>
			<label class="lblInstrNormal">).</label>
		</td>
		<td colspan=3>
			<label class=inpReadOnlyRt id=lblBPT1_1 style="WIDTH: 100%"></label></td>
	</tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">2.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">GROSS RECEIPTS PORTION OF TAX (from </label>
			<label class="lblLink" style="FONT-SIZE: 7pt" onclick=ShowPage('SchdD')>Schedule D, Line 11</label>
			<label class="lblInstrNormal">).</label>
		</td>
		<td colspan=3>
			<label class=inpReadOnlyRt id=lblBPT1_2 style="WIDTH: 100%"></label></td>
	</tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">3.</label></td>
		<td colspan=8>
			<label class="lblInstrNormal">Tax Due for the 2009 Business Privilege Tax</label></td>
		<td colspan=8 align=right>
			<label class="lblInstrNormal">[Calculated - add lines 1 and 2]&nbsp;</label></td>
		<td colspan=3>
			<label class=inpReadOnlyRt id=lblBPT1_3 style="WIDTH: 100%"></label></td>
	</tr>
  <tr class=rowDataOdd>
		<td>
			<label class="lblInstrNormal">4.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal"><B><U>MANDATORY</U> 2010 BPT Estimated Payment <u>(repeat line 3)</u></label></B></td>
		<td colspan=3>
			<input class=inpNormal id=txtBPT1_4 onchange="ValidateWorksheet('BPT_Pg1')"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataEven>
		<td>
			<label class="lblInstrNormal">5.</label></td>
		<td colspan=8>
			<label class="lblInstrNormal">Total Due by <B>4/15/2010</B></label></td>	
		<td colspan=8 align=right>
			<label class="lblInstrNormal">[Calculated - add lines 3 and 4]&nbsp;</label></td>
		<td colspan=3>
			<label class=inpReadOnlyRt id=lblBPT1_5 style="WIDTH: 100%"></label></td>
	</tr>

  <tr class=rowDataOdd>
		<td colspan=20><label class="lblInstrNormal"><br><u><b>ESTIMATED PAYMENTS AND OTHER CREDITS</b></u></label></td>
	</tr>
  <tr class=rowDataEven>
		<td ><label class="lblInstrNormal">6a.</label></td>
		<td colspan=16>
				<label class="lblInstrNormal">Credit from overpayment of 2008 or 2009 Net Profit Tax</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtBPT1_6a onchange="ValidateWorksheet('BPT_Pg1')"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataOdd>
		<td style="VERTICAL-ALIGN: top"><label class="lblInstrNormal">6b.</label></td>
		<td colspan=16>
				<label class="lblInstrNormal">Include any estimated and/or extension payments of 2009 BPT previously
			  made,<br>and any credit from overpayment of the 2008 BPT return</label>
		</td>
		<td colspan=3 style="VERTICAL-ALIGN: bottom">
			<input class=inpNormal id=txtBPT1_6b onchange="ValidateWorksheet('BPT_Pg1')"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataEven>
		<td ><label class="lblInstrNormal">6c.</label></td>
		<td colspan=8>
			<label class="lblInstrNormal">Total Payments and Credits</label></td>
		<td colspan=8 align=right>
			<label class="lblInstrNormal">[Calculated - add lines 6a and 6b]&nbsp;</label></td>
		<td colspan=3>
			<label class=inpReadOnlyRt id=lblBPT1_6c style="WIDTH: 100%"></label></td>
	</tr>
  <tr class=rowDataOdd>
		<td >
			<label class="lblInstrNormal">7.</label></td>
		<td colspan=8>
			<label class="lblInstrNormal">Net Tax Due</label>
		</td>
		<td colspan=8 align=right>
			<label class="lblInstrNormal">[Calculated - line 5 minus 6c]&nbsp;</label>
		</td>
		<td colspan=3>
			<label class=inpReadOnlyRt id=lblBPT1_7 style="WIDTH: 100%"></label></td>
	</tr>
  <tr class=rowDataEven>
		<td >
			<label class="lblInstrNormal">8.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Interest and Penalty (see instruction Sheet II)</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtBPT1_8 onchange="ValidateWorksheet('BPT_Pg1')"
			 onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataOdd>
		<td valign=top>
			<label class="lblInstrNormal">9.</label></td>
		<td colspan=8>
			<label class="lblInstrNormal"><u><b>TOTAL DUE</b></u> including Interest and Penalty<br>
					<b>Use payment coupon. Make check payable to: "City of Philadelphia"</label></td>
		<td colspan=8 align=right valign=bottom>
			<label class="lblInstrNormal">[Calculated - add line 7 and 8]&nbsp;</label></td>
		<td colspan=3 valign=bottom>
			<label class=inpReadOnlyRt id=lblBPT1_9 style="WIDTH: 100%"></label></td>
	</tr>
  <tr class=rowDataEven>
		<td colspan=20>
			<label class="lblInstrNormal"><br><u><b>OVERPAYMENT OPTIONS</b></u></label></td>
	</tr>
  <tr class=rowDataOdd>
		<td >
			<label class="lblInstrNormal">10a.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Refunded. <b>Do not file separate Refund Petition</b></label></td>
		<td colspan=3>
			<input class=inpNormal id=txtBPT1_10a onchange="ValidateWorksheet('BPT_Pg1')"
					onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
<!--EGOVWEB-60
			<label class=inpReadOnlyRt id=lblBPT1_10a style="WIDTH: 100%"></label></td>-->
	</tr>
  <tr class=rowDataEven>
		<td >
			<label class="lblInstrNormal">10b.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Applied, up to the tax due,	to the 2009 Net Profits Tax Return</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtBPT1_10b onchange="ValidateWorksheet('BPT_Pg1')"
					onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
  <tr class=rowDataOdd>
		<td >
			<label class="lblInstrNormal">10c.</label></td>
		<td colspan=16>
			<label class="lblInstrNormal">Applied to the 2010	Business Privilege Tax</label></td>
		<td colspan=3>
			<input class=inpNormal id=txtBPT1_10c onchange="ValidateWorksheet('BPT_Pg1')"
					onfocus="SetFocus()" maxlength=10 style="WIDTH: 100%"></td>
	</tr>
	<TR><TD colspan=20>
		<% Html.RenderAction("PreparerSection", "Inc"); %>
	</TD></TR>
  <TR>
		<td colspan=6></td>
		<td colspan=3>
			<input id="btnBPTPrint" type="button" value="Print" LANGUAGE=javascript onclick="return btnBPTPrint_onclick()">
		</td>
		<td colspan=2></td>
		<td colspan=3>
			<input id="btnBPTSubmit" type="button" value="Submit" LANGUAGE=javascript onclick="return btnBPTSubmit_onclick()">
		</td>
		<td colspan=6></td>
	</TR>
</table>
<br style='PAGE-BREAK-AFTER: always'></div><!--BPTlf_Page1-->