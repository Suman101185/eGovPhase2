<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>
<script language="javascript" type="text/javascript"  >

    var arrCouponErr = new Array()
    var	strAccountName;
    

    function DisplayCoupon() {
        //EOGVWEB-53 EDD Added if statement for calling print coupon from Tobacco
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'TOBACCO') {
            CouponCnclBtn.value = 'Return to Tobacco Tax'
            //EOGVWEB-69 EDD Added if statement for calling print coupon from other Tax Forms
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'WAGE') {
            CouponCnclBtn.value = 'Return to Wage Tax'
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'SCHOOL') {
            CouponCnclBtn.value = 'Return to School Tax'
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'BPTEZ') {
            CouponCnclBtn.value = 'Return to Business Income and Receipts Tax'
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'BPTLF') {
            CouponCnclBtn.value = 'Return to Business Income and Receipts Tax'
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'NPT') {
            CouponCnclBtn.value = 'Return to Net Profit Tax'
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'UO') {
            CouponCnclBtn.value = 'Return to Use and Occupancy Tax'

        }		//if

        var	strAcctType = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ACCOUNT_TYPE", "")
        var	strAccountAddr = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ADDR", "")
        var	strAccountAddr2 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ADDR2", "")
        var strAccountAddr3 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ADDR3", "")
        var strAccountCity = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_CITY", "")
        var strAccountState = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_STATE", "")
        var strAccountZip = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_ZIP_CODE", "")
        var strAccountAddr4 = "";
        var HoldDate, DateOnly;

        strAccountName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_NAME", "")

        coup1.style.display = "block"
        coup2.style.display = "block"
        coup3.style.display = "block"
        coup4.style.display = "none"

        AdjustNameDisplay()

        strAccountAddr4 = strAccountCity + ", " + strAccountState + " " + strAccountZip

        if (strAccountAddr3 = " " ) {
            strAccountAddr3 = strAccountAddr4
            strAccountAddr4 = ""
        }
	
        if (strAccountAddr2 = " ") {
            strAccountAddr2 = strAccountAddr3
            strAccountAddr3 = ""
        }

        sName.innerText = strAccountName
        sAddr1.innerText = strAccountAddr
        sAddr2.innerText = strAccountAddr2
        sAddr3.innerText = strAccountAddr3
        sAddr4.innerText = strAccountAddr4
        sName.innerText = strAccountName
	
        HoldDate = new Date()
        DateOnly = HoldDate.toDateString()
        sTodayDate.innerText = DateOnly

        switch (strAcctType) {
            case '01':   //"WAG"
                sPOBox.innerText = "P.O.Box 8040"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '02':    //Earnings   ERN
                sPOBox.innerText = "P.O.Box 1648"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '03':    //Net Profits   NPT
                sPOBox.innerText = "P.O.Box 1393"   // PO box for coupons only
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '06':    //Amusement    AMU
                sPOBox.innerText = "P.O.Box 124"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '08':    //Parking    PRK
                sPOBox.innerText = "P.O.Box 124"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '09':    //Coin Operated    COI
                sPOBox.innerText = "P.O.Box 124"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '11':   //Police    POL
                sPOBox.innerText = "P.O.Box 60"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '14':   //Vehicle Rental   VRT
                sPOBox.innerText = "P.O.Box 124"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '18':   //Realty Transfer   RTT
                sPOBox.innerText = "P.O.Box 124"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '23':   //Hotel   HOT
                sPOBox.innerText = "P.O.Box 53180"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '24':   //Business Income and Receipts   BIR
                sPOBox.innerText = "P.O.Box 1393"   // PO box for coupons only
                sPhone.innerText = "Phone: (215) 686-6600"
                break
                //EGOVWEB-49 - Items 6-8		
            case '27':   //Tobacco   TOB
                sPOBox.innerText = "P.O.Box 53250"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '28':   //Liquor   LIQ
                sPOBox.innerText = "P.O.Box 1018"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '29':   //School Income   SIT
                sPOBox.innerText = "P.O.Box 389"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '58':   //Valet Parking   VPT
                sPOBox.innerText = "P.O.Box 124"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '60':   //Real Estate   REA
                sPOBox.innerText = "P.O.Box 8409"
                sPhone.innerText = "Phone: (215) 686-6442"
                break
            case '76':   //Outdoor Advertizing   OAT
                sPOBox.innerText = "P.O.Box 124"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '84':   //U&O - Landlord   UOL
                sPOBox.innerText = "P.O.Box 1049"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '85':   //U&O - Tenant   UOT
                sPOBox.innerText = "P.O.Box 1049"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '90': //Assessment Screen   ASM
                sPOBox.innerText = "P.O.Box 1600"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '91':   //Police BRI   GNP
                sPOBox.innerText = "P.O.Box 60"
                sPhone.innerText = "Phone: (215) 686-3055"
                break
            case '97':   //Entity Level Charges   GEN
                sPOBox.innerText = "P.O.Box 1600"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '98':   //General   GN2
                sPOBox.innerText = "P.O.Box 1600"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
            case '99':   //Entity Level Charges   GN9
                sPOBox.innerText = "P.O.Box 1600"
                sPhone.innerText = "Phone: (215) 686-6600"
                break
                return
        }		//switch

       // parent.NavWin.lbl1.innerHTML = '' 
       // parent.NavWin.rowLabel.style.display = 'none' 

        tblBillHeader.style.display = 'none'

    }		//DisplayCoupon

    function SubmitCoupon() {

        parent.DocWin.print()
	
    }		//SubmitCoupon   			

    function window.onbeforeprint() {

        //	CouponMargin.height = 565

        coup1.style.display = 'none'
        coup2.style.display = 'none'
        coup3.style.display = 'none'
        coup4.style.display = 'block'
	
        divPrintMsg.style.visibility = 'hidden'
        tblBillHeader.style.display = 'block'
        CPrintCouponBtn.style.display='none'
        CouponCnclBtn.style.display='none'
        //	CouponMargin.style.height = '5.93in'
        //	CouponMargin.height = 15

    }  //window.onbeforeprint

    function window.onafterprint() {

        CPrintCouponBtn.style.display='block'
        CouponCnclBtn.style.display='block'
        divPrintMsg.style.visibility = 'visible'
        tblBillHeader.style.display = 'none'	
        //	CouponMargin.style.height = '0in'
        //	CouponMargin.height = 15

        coup1.style.display = 'block'
        coup2.style.display = 'block'
        coup3.style.display = 'block'
        coup4.style.display = 'none'

    }  //window.onbeforeprint


    function ReturnToSelection() {
        //EOGVWEB-89 EDD Added Current Year to return to the return the user was on when they left to print the coupon
        var sCurrReturnYear = parseInt(parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_YEAR ", "")) + 1
        //EOGVWEB-53 EDD Added if statement for calling print coupon from Tobacco
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'TOBACCO') {
            //parent.DocWin.location.href = '../?y=' + sCurrReturnYear
            parent.setFrameUrl('Returns/Tobacco?y=' + sCurrReturnYear);
            //EOGVWEB-69 EDD Added if statement for calling print coupon from other Tax forms
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'WAGE') {
            // parent.DocWin.location.href = '../Returns/Wage?y=' + sCurrReturnYear
            parent.setFrameUrl('Returns/Wage?y=' + sCurrReturnYear);
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'SCHOOL') {
            //parent.DocWin.location.href = '../Returns/SchoolAsp?y=' + sCurrReturnYear
            parent.setFrameUrl('Returns/School?y=' + sCurrReturnYear);
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'BPTEZ') {
            // parent.DocWin.location.href = '../Returns/BPTez?y=' + sCurrReturnYear
            parent.setFrameUrl('Returns/BPTez?y=' + sCurrReturnYear);
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'BPTLF') {
            // parent.DocWin.location.href = '../Returns/BPT_LF/BPTlf?y=' + sCurrReturnYear
            parent.setFrameUrl('Returns/BPT_LF?y=' + sCurrReturnYear);
        } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, "COUPON_FORM CPN_FORM", "") == 'NPT') {
            //parent.DocWin.location.href = '../Returns/NPT/NPT?y=' + sCurrReturnYear
            parent.setFrameUrl('Returns/NPT?y=' + sCurrReturnYear);
        } else {
            //parent.DocWin.location.href = 'PayCoupon'
            parent.setFrameUrl('PayCoupon/PayCoupon');
        }		//if
    } //ReturnToSelection

    function AdjustNameDisplay() { 
        var sEntityName = strAccountName 
        var lName = "", fName = "", mName = "", newName = "" 

        if (sEntityName.indexOf("*")!=-1) {    //If name contains *'s 
            sEntityName = sEntityName.split("*") 
            lName = (sEntityName[0].substr(0,1).toUpperCase()) + (sEntityName[0].substr(1).toLowerCase())
            if (sEntityName[1]) { 
                fName = (sEntityName[1].substr(0,1).toUpperCase()) + (sEntityName[1].substr(1).toLowerCase()) 
            }  //if 
            if (sEntityName[2]) { 
                mName = sEntityName[2].substr(0,1).toUpperCase()
            }  //if</SPAN> 

            strAccountName = fName + " " + mName + " " + lName 

        } //if return sEntityName 

    } //AdjustNameDisplay

</script>
<HTML>
<HEAD>
<script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>

<link rel="Stylesheet" href="../Content/Styles/Font.css" />
<link rel="Stylesheet" href="../Content/Styles/Object.css" />


<TITLE></TITLE>
</HEAD>

    <%
        Html.RenderAction("AppHeader","INC");    
    %>

<body onload="DisplayCoupon()">
<table cellSpacing="0" cellPadding="0"  border="0" 
	style="MARGIN-LEFT: 0px; WIDTH: 7in; TOP: 0px" id=topPayCoupon>
<tr height="2">
	<tr style ="FONT-SIZE: 10pt; FONT-FAMILY: Arial" id="coup1" >
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>																																		
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td>
		<td width="5%"><p>&nbsp;</p></td></tr>	

	<tr style ="FONT-SIZE: 14pt" id="coup2" >
		<td colspan=4><p>&nbsp;</p></td>
		<td colspan=3><p><INPUT id=CPrintCouponBtn onclick=SubmitCoupon() type=button value="Print Coupon"></p></td>
		<td colspan=4><p>&nbsp;</p></td>
		<td colspan=3><p><INPUT id=CouponCnclBtn onclick=ReturnToSelection() type=button value=Cancel></p></td>
   	<td colspan=6><p>&nbsp;</p></td></tr>

	<tr style ="FONT-SIZE: 12pt;  FONT-FAMILY: Arial" id="coup3">
		<td colspan="20"><p>&nbsp;</p></td></tr>

	<tr style ="FONT-SIZE: 11pt;  FONT-FAMILY: Arial" >
		<td colspan="20">
			<table id=tblBillHeader>
				<tr style ="FONT-SIZE: 10pt; FONT-FAMILY: Arial">
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>																																		
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td>
					<td width="5%"><p></p></td></tr>	
				<tr>
					<td><p>&nbsp;</p></td>
					<td nowrap colspan="3"><p id="sPOBox" class="label">P.O. Box {BOX}</p></td>
					<td colspan="7" rowspan="5" align="right"><P id=cityseal><IMG id=IMG2 src="http://is-partner.com/wage/images/cityseal.gif" style="WIDTH: 1in; HEIGHT: 1in"></P></td>
					<td colspan="6" align="right"><p>&nbsp;</p></td>
					<td nowrap colspan="3"><p class="label">City Of Philadelphia</p></td></tr>
				<tr style ="FONT-SIZE: 11pt;  FONT-FAMILY: Arial">
					<td ><p>&nbsp;</p></td>
					<td nowrap colspan="3"><p id="sPhillyZip" class="label">Philadelphia, PA 19105</p></td>
					<td colspan="6"><p>&nbsp;</p></td>
					<td nowrap colspan="3"><p class="label">Department of Revenue</p></td></tr>
				<tr style ="FONT-SIZE: 11pt;  FONT-FAMILY: Arial">
					<td colspan="4"><p>&nbsp;</p></td>
					<td colspan="6"><p>&nbsp;</p></td>
					<td nowrap colspan="3" align="left"><p id="sPhone" class="label">Phone: {PHONE}</p></td></tr>
				<tr style ="FONT-SIZE: 12pt;  FONT-FAMILY: Arial">
					<td colspan="20"><p>&nbsp;</p></td></tr>
				<tr style ="FONT-SIZE: 12pt;  FONT-FAMILY: Arial">
					<td colspan="20"><p>&nbsp;</p></td></tr>
				<tr style ="FONT-SIZE: 12pt;  FONT-FAMILY: Arial">
					<td colspan="17" align="left" width="5%"><p>&nbsp;</p></td>
					<td colspan="3"><p id="sTodayDate" class="label">{Date}</p></td></tr>
				<tr style ="FONT-SIZE: 12pt;  FONT-FAMILY: Arial">
					<td colspan="20"><p>&nbsp;</p></td></tr>
				<tr style ="FONT-SIZE: 12pt;  FONT-FAMILY: Arial">
					<td colspan="3"><p>&nbsp;</p></td>
					<td colspan="17"><p id="sName" class="label">{NAME}</p></td>
				<tr style ="FONT-SIZE: 12pt;  FONT-FAMILY: Arial">
					<td colspan="3"><p>&nbsp;</p></td>
					<td colspan="17"><p id="sAddr1" class="label">{ADDR1}</p></td></tr>
				<tr style ="FONT-SIZE: 12pt;  FONT-FAMILY: Arial">
					<td colspan="3"><p>&nbsp;</p></td>
					<td colspan="17"><p id="sAddr2" class="label">{ADDR2}</p></td></tr>
				<tr style ="FONT-SIZE: 12pt;  FONT-FAMILY: Arial">
					<td colspan="3"><p>&nbsp;</p></td>
					<td colspan="17"><p id="sAddr3" class="label">{ADDR3}</p></td></tr>
				<tr style ="FONT-SIZE: 12pt;  FONT-FAMILY: Arial">
					<td colspan="3"><p>&nbsp;</p></td>
					<td colspan="17"><p id="sAddr4" class="label">{ADDR4}</p></td></tr>
			</table></td></tr>

	<tr>
		<td colspan=3></td>
		<td colspan=14>
			<div id="divPrintMsg">
				<BR><label class=lblInstrBold>Printing Note:</label>
				<BR><BR><label class=lblInstrNormal>This page must print on a single sheet of paper. To accomplish this make sure your browser's
						Printer Margins are set to the following sizes:</label>
				<BR><BR><label class=lblInstrNormal>Top: 0.50",&nbsp;&nbsp;&nbsp;Bottom: 0.50",&nbsp;&nbsp;&nbsp;Left: 0.50",
						&nbsp;&nbsp;&nbsp;Right: 0.50"</label>
				<BR><BR><label class=lblInstrNormal>To set the margins.</label>
				<br><OL><LI class=lblInstrNormal>Go to File &gt; Page Setup... and set the Margins. Click OK. 
						<LI class=lblInstrNormal>Print page. All information should fit on one page. </LI></OL></div></td>
		<td colspan=3></td></tr>

	<tr style ="FONT-SIZE: 12pt;  FONT-FAMILY: Arial" id="coup4">
		<td colspan="20"><p style="HEIGHT: .8in"></p></td></tr>
	<tr style ="FONT-SIZE: 12pt;  FONT-FAMILY: Arial" id="coup5" height="3">
		<td colspan="20">
            <%
                Html.RenderAction("CouponImageInclude","PayCoupon");    
            %>
		</td></tr>
		
</table>
</body>
</HTML>
