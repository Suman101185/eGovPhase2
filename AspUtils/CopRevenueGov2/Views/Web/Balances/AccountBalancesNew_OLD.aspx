<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head id="Head1">
	<title></title>
    <%--<link type="text/css" rel="Stylesheet" href="../Content/Styles/Font.css" />
<link type="text/css" rel="Stylesheet" href="../Content/Styles/Object.css" />--%>
    <link type="text/css" rel="Stylesheet" href="../Content/Styles/framestyle.css" />
<script src="../Content/Scripts/JqueryMin.js" type="text/javascript" language="javascript"></script>
<script src ="../Content/Scripts/ispFunctions.js" type="text/javascript" language="javascript"></script>
<script src ="../Content/Scripts/ispXmlProc.js" type="text/javascript" language="javascript"></script>
<script src ="../Content/Scripts/Accounting.js" type="text/javascript" language="javascript"></script>
<script src ="../Content/Scripts/ispCoupon.js" type="text/javascript" language="javascript"></script>


	<script language="javascript" type="text/javascript">
	    var txtHeader = 'Taxpayer Information';
	    var addrIdx;
	    var oAcctBalTable;
	    var oDfltRow;
	    var oPartPaymentRow;
	    var CONSTtdBody = 1;
	    var aAcctTables = new Array();
	    var aAcctTypes = new Array();
	    aAcctTypes['001'] = 'Wage Tax';
	    aAcctTypes['002'] = 'Earnings Tax';
	    aAcctTypes['003'] = 'Net Profit Tax';
	    aAcctTypes['006'] = 'Amusement Tax';
	    aAcctTypes['008'] = 'Parking Tax'
	    aAcctTypes['009'] = 'Coin Tax';
	    aAcctTypes['011'] = 'Police Serivces';
	    aAcctTypes['012'] = 'Streets Collection Fees';
	    aAcctTypes['014'] = 'Vehicle Rental Tax';
	    aAcctTypes['018'] = 'Realty Transfer Tax';
	    aAcctTypes['023'] = 'Hotel Tax';
	    aAcctTypes['024'] = 'Business Income and Receipts Tax';
	    aAcctTypes['027'] = 'Tobacco Tax';
	    aAcctTypes['028'] = 'Liquor Tax';
	    aAcctTypes['029'] = 'School Income Tax';
	    aAcctTypes['032'] = 'Hospital Tax';
	    aAcctTypes['058'] = 'Valet Parking Tax';
	    aAcctTypes['060'] = 'Real Estate Tax';
	    aAcctTypes['076'] = 'Outdoor Advertising Tax';
	    aAcctTypes['084'] = 'U&O Tax - Landlord';
	    aAcctTypes['085'] = 'U&O Tax - Tenant';
	    aAcctTypes['090'] = 'Assessment Tax';
	    aAcctTypes['091'] = 'Police BRI Tax';
	    aAcctTypes['097'] = 'Entity Level Charges';
	    aAcctTypes['098'] = 'General - 98';
	    aAcctTypes['099'] = 'Entity Level Charges';





	    var dobj = parent.$g.getXmlDocObj();

	    function SetInitFocus() {

	        // parent.NavWin.ClearImages();
	        AppHeader.innerHTML = txtHeader + '<Font class=hdrMedium>|account balance</Font>';
	        //AppError.innerText = '';
	        $(parent.AppError).text('');
	        $('#divPayments').css("display", "block");
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, '00' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0), 'DEL_INFO ENTITY_TYPE', '', 0);
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0), 'DEL_INFO ENTITY_ID', '', 0);
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, 'I', 'DEL_INFO FUNCTION', '', 0);
	        PopulateEntityInfo();

	        ispCallXMLForm(parent.$g.xmloAcctBalance, dobj, "Balances/AccountBalanceCall", "");

	        parent.$g.xmloAcctBalance.loadXML(dobj.xml);

	        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT ACCOUNT_ID', '', 0) == '') {
	            $('#divNoBalances').css("display", "block");
	        }
	        else {
	            PopulateAccounts();
	        }

	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, '', 'DEL_INFO FUNCTION', '', 0);
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, '', 'DEBUG', '', 0);

	        $(parent.RightFrame).attr('rows', '*,0');
	        $('#divDisclaimer').css("display", "block");
	    }

	    function PopulateEntityInfo() {


	        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0) != '') {

	            $('#lblEntityAccountID').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0));

	            $('#lblEntityId').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0));

	            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == 1) {
	                $('#lblEntityType').text('EIN:');
	                $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 2) + '-' + $('#lblEntityId').text().substr(2));
	            } else {
	                $('#lblEntityType').text('SSN:')
	                $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 3) + '-' + $('#lblEntityId').text().substr(3, 2) + '-' + $('#lblEntityId').text().substr(5))
	            } 	//if
	            addrIdx = LocatePrimaryAddr('60');
	            $('#lblEntityName').text(AdjustNameDisplay(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)));
	            $('#lblEntityAddress').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', addrIdx) + ', ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', addrIdx) + ' ' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', addrIdx));
	        } 	//if
	    } 	//PopulateEntityInfo

	    function PopulateAccounts() {

	        var sCurrAcctType = '', sCurrAcctId = '', bCreateTable = false, oTable

	        var iMaxIdx = parent.$x.ispXmlGetRecCount(parent.$g.xmloAcctBalance, 'DEL_ACCT', '')
	        for (idx = 0; idx < iMaxIdx; idx++) {
	            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT ACCOUNT_ID', '', idx) != '') {
	                if (sCurrAcctType != parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT ACCOUNT_TYPE', '', idx) || sCurrAcctId != parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT ACCOUNT_ID', '', idx)) {
	                    sCurrAcctType = parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT ACCOUNT_TYPE', '', idx)
	                    sCurrAcctId = parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT ACCOUNT_ID', '', idx)

	                    //						bCreateTable = true
	                    if (sCurrAcctType == '084') {
	                        oAcctBalTable = AcctTblCreate(sCurrAcctType, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT BRT_ENTITY', '', idx), parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT BRT_ADDRESS', '', idx));

	                    } else {
	                        oAcctBalTable = AcctTblCreate(sCurrAcctType, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT ACCOUNT_ID', '', idx), parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT BRT_ADDRESS', '', idx));
	                    }		//if
	                    //						bCreateTable = false
	                } 	//if

	                AcctTblInsertRow(idx, '_' + sCurrAcctType + '_' + idx);//Sangha

	            }		//if
	        }		//for

	        $('#divBalances').css("display", "block");
	        Totals_Sum();
	    }		//PopulateAccounts

	    function AcctTblCreate(sAcctType, sEntity, sAddress) {
	        //Account Type Label


	        var oAcctLabel = document.getElementById('lblAcctBalTemplate').cloneNode(true);
	        $(oAcctLabel).text(aAcctTypes[sAcctType] + ' ' + sEntity + ' ' + sAddress);

	        divBalances.insertBefore(oAcctLabel, document.getElementById('tblBalanceTotals'))

	        //Account Table
	        oAcctBalTable = document.getElementById('tblAcctBalTemplate').cloneNode(true);
	        oAcctBalTable.id = oAcctBalTable.id + '_' + sAcctType;
	        aAcctTables[aAcctTables.length] = oAcctBalTable;

	        removeTableRow('trABT_Default');
	        removeTableRow('trABT_PartialPayment');
	        removeTableRow('tblBalanceTotals');

	        divBalances.insertBefore($(oAcctBalTable).get(0), document.getElementById('tblBalanceTotals'))


	        return oAcctBalTable

	    } 	//AcctTblCreate

	    function removeTableRow(trId) {
	        $(oAcctBalTable).find('tr').each(function () {

	            if ($(this).attr('id') == trId) {
	                $(this).remove();
	            }

	        });

	    }

	    function AcctTblInsertRow(idx, idSuffix) {
	        var oNewRow
	        oDfltRow = document.getElementById('trABT_Default').cloneNode(true);


	        $(oAcctBalTable).children().eq(0).children().eq(CONSTtdBody + 1).after(oDfltRow);

	        oNewRow = oDfltRow;

	        if ((oNewRow == null) || (oNewRow == 'undefine')) {
	            return;
	        }

	        oNewRow.id = oNewRow.id + idSuffix;

	        for (i = 0; i < $(oNewRow).children().length; i++) {

	            if (i == 0) {

	                $(oNewRow).children().eq(i).children().eq(0).get(0).id = $(oNewRow).children().eq(i).children().eq(0).get(0).id + idSuffix;
	            } else if (i == 1) {
	                //Partial Check Box 

	                $(oNewRow).children().eq(i).children().eq(0).get(0).id = $(oNewRow).children().eq(i).children().eq(0).get(0).id + idSuffix;
	            } else {
	                if (($(oNewRow).children().eq(i).get(0) != 'undefine')
										|| ($(oNewRow).children().eq(i).get(0).id != 'undefine')) {


	                    $(oNewRow).children().eq(i).get(0).id = $(oNewRow).children().eq(i).get(0).id + idSuffix;

	                }
	            }
	        } 	//for
	        //if (idx % 2) {
	        //    //Row is set to even by default
	        //    oNewRow.className = 'rowDataOdd'
	        //} 	//if




	        document.getElementById('tdABT_Period' + idSuffix).innerHTML = ispFormatPeriod(parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT PERIOD', '', idx), 'D')

	        document.getElementById('tdABT_Principal' + idSuffix).innerHTML = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT PRINCIPAL_DUE', '', idx), 2)
	        document.getElementById('tdABT_Interest' + idSuffix).innerHTML = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT INTEREST_DUE', '', idx), 2)
	        document.getElementById('tdABT_Penalty' + idSuffix).innerHTML = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT PENALTY_DUE', '', idx), 2)
	        document.getElementById('tdABT_Other' + idSuffix).innerHTML = ispFormatMoney(parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT OTHER_DUE', '', idx), 2)
	        SelectRow_Sum(idSuffix, false)
	    }		//AcctTblInsertRow

	    function PayType_Click() {
	        //chkABT_Select base name for Select;		chkABT_Partial base name for Partial
	        var CONSTChkSelectBase = 'chkABT_Select'
	        var CONSTChkPartialBase = 'chkABT_Partial'
	        var oChkSelect; var oChkPartial
	        var activeElement = $(document.activeElement);

	        var evt = window.event || arguments.callee.caller.arguments[0];
	        var source = parent.getEventSource(evt);
	        var sId = source.id;

	        var sIdSuffix;
	        if (sId.indexOf('_', 7) > -1) {

	            sIdSuffix = sId.substr(sId.indexOf('_', 7))
	        }

	        if (sId.search('Partial') > -1) {
	            oChkPartial = document.getElementById(sId);// sId; // document.activeElement
	            oChkSelect = document.getElementById(CONSTChkSelectBase + sIdSuffix);
	            var oOldRow = document.getElementById('trABT_Default' + sIdSuffix);
	            var oNewRow = document.getElementById('trABT_PartialPayment').cloneNode(true);

	            if (oChkPartial.checked == true) {
	                oChkSelect.checked = false
	                oNewRow.id = oNewRow.id + sIdSuffix + 'P'

	                $(oNewRow).children().eq(2).children().eq(0).get(0).id = $(oNewRow).children().eq(2).children().eq(0).get(0).id + sIdSuffix + 'P';

	                $(oNewRow).children().eq(3).children().eq(0).get(0).id = $(oNewRow).children().eq(3).children().eq(0).get(0).id + sIdSuffix + 'P';

	                $(oNewRow).children().eq(4).children().eq(0).get(0).id = $(oNewRow).children().eq(4).children().eq(0).get(0).id + sIdSuffix + 'P';

	                $(oNewRow).children().eq(5).children().eq(0).get(0).id = $(oNewRow).children().eq(5).children().eq(0).get(0).id + sIdSuffix + 'P';

	                $(oNewRow).children().eq(6).get(0).id = $(oNewRow).children().eq(2).get(0).id + sIdSuffix + 'P';

	                $(oNewRow).children().eq(7).get(0).id = $(oNewRow).children().eq(7).get(0).id + sIdSuffix + 'P';

	                oOldRow.parentNode.insertBefore(oNewRow, oOldRow.nextSibling);

	                SelectRow_Sum(sIdSuffix, true);

	                Partial_Sum($(oNewRow).children().eq(2).children().eq(0).get(0));

	                $(oNewRow).children().eq(2).children().eq(0).get(0).focus();

	                $(oNewRow).children().eq(2).children().eq(0).get(0).select();
	            } else {
	                oOldRow.parentNode.removeChild(oOldRow.nextSibling)
	            } 	//if
	        } if (sId.search('Select') > -1) {
	            oChkSelect = document.getElementById(sId);
	            oChkPartial = document.getElementById(CONSTChkPartialBase + sIdSuffix);
	            if (oChkSelect.checked == true) {
	                oChkPartial.checked = false
	                if (document.getElementById('trABT_PartialPayment' + sIdSuffix + 'P')) { //.nextSibling.id.search('Partial') > -1) {
	                    document.getElementById('trABT_PartialPayment' + sIdSuffix + 'P').parentElement.removeChild(document.getElementById('trABT_PartialPayment' + sIdSuffix + 'P'))
	                }		//if
	                SelectRow_Sum(sIdSuffix, false)
	                Totals_Sum()
	            } else {
	                SelectRow_Sum(sIdSuffix, true)
	                Totals_Sum()
	            } 	//if
	        }		//if
	    }		//PayType_Click

	    function SelectRow_Sum(idSuffix, bRemove) {
	        if (bRemove == true) {
	            document.getElementById('tdABT_Payment' + idSuffix).innerHTML = '&nbsp;'
	        } else {
	            document.getElementById('tdABT_Balance' + idSuffix).innerHTML = ispFormatMoney(ispRemoveMoney(document.getElementById('tdABT_Principal' + idSuffix).innerHTML) + ispRemoveMoney(document.getElementById('tdABT_Interest' + idSuffix).innerHTML) + ispRemoveMoney(document.getElementById('tdABT_Penalty' + idSuffix).innerHTML) + ispRemoveMoney(document.getElementById('tdABT_Other' + idSuffix).innerHTML), 2)
	            document.getElementById('tdABT_Payment' + idSuffix).innerHTML = document.getElementById('tdABT_Balance' + idSuffix).innerHTML
	        }		//if
	    } 	//SelectRow_Sum

	    function Totals_Sum() {
	        var iTotOutBalDue = 0; var iTotAmtSelDue = 0; var sIdSuffix
	        for (i = 0; i < document.getElementsByTagName('table').length; i++) {
	            if (document.getElementsByTagName('table').item(i).id.indexOf('_', 7) > -1) {
	                for (j = 0; j < document.getElementsByTagName('table').item(i).rows.length; j++) {
	                    if (document.getElementsByTagName('table').item(i).rows[j].id.indexOf('_', 7) > -1) {								//alert('2 : ' + document.getElementsByTagName('table').item(i).rows[j].id);
	                        sIdSuffix = document.getElementsByTagName('table').item(i).rows[j].id;
	                        sIdSuffix = sIdSuffix.substr(sIdSuffix.indexOf('_', 7));

	                        if ($(document.getElementById('tdABT_Balance' + sIdSuffix)).html() != null) {
	                            iTotOutBalDue = iTotOutBalDue + ispRemoveMoney($(document.getElementById('tdABT_Balance' + sIdSuffix)).html());

	                        } else {

	                            iTotOutBalDue = iTotOutBalDue;
	                        }

	                        if ($(document.getElementById('tdABT_Payment' + sIdSuffix)).html() != null) {
	                            iTotAmtSelDue = iTotAmtSelDue + ispRemoveMoney($(document.getElementById('tdABT_Payment' + sIdSuffix)).html());
	                        }
	                        else {

	                            iTotAmtSelDue = iTotAmtSelDue;
	                        }
	                    }		//if
	                }		//for
	            }		//if
	        }		//for
	        if (iTotAmtSelDue == 0) {
	            btnCreditCard.disabled = true
	            btnCoupon.disabled = true
	        } else {
	            btnCreditCard.disabled = false
	            btnCoupon.disabled = false
	        }		//if
	        tdTotOutBalDue.innerHTML = ispFormatMoney(iTotOutBalDue, 2)
	        tdTotAmtSelDue.innerHTML = ispFormatMoney(iTotAmtSelDue, 2)
	    } 	//Totals_Sum

	    function Partial_Sum(oCurr) {
	        var sId = oCurr.id
	        var sIdSuffix = sId.substr(sId.indexOf('_', 7))
	        oCurr.value = ispRemoveMoney(oCurr.value)

	        document.getElementById('tdABT_Payment' + sIdSuffix).innerHTML = ispFormatMoney(ispRemoveMoney(document.getElementById('tdABT_Principal' + sIdSuffix).value) + ispRemoveMoney(document.getElementById('tdABT_Interest' + sIdSuffix).value) + ispRemoveMoney(document.getElementById('tdABT_Penalty' + sIdSuffix).value) + ispRemoveMoney(document.getElementById('tdABT_Other' + sIdSuffix).value), 2)
	        Totals_Sum()
	        oCurr.value = ispFormatMoney(oCurr.value, 2)
	    } 	//Partial_Sum

	    function Pay_Click(oButton) {
	        var sIdSuffix, sRowSuffix
	        var iRowIdx = 0
	        var bChkSelect = false
	        var bChkPartial = false

	        for (i = 0; i < aAcctTables.length; i++) {
	            sIdSuffix = aAcctTables[i].id.substr(aAcctTables[i].id.indexOf('_', 7))
	            for (j = 3; j < aAcctTables[i].rows.length; j++) {
	                sRowSuffix = sIdSuffix + '_' + iRowIdx
	                if (aAcctTables[i].rows[j].id.search('Default') > -1) {
	                    // alert('sangha');
	                    bChkSelect = document.getElementById('chkABT_Select' + sRowSuffix).checked;
	                    bChkPartial = document.getElementById('chkABT_Partial' + sRowSuffix).checked;
	                } 	//if

	                if (bChkSelect == true && bChkPartial == false) {
	                    //Full Payment on the current row
	                    parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, 'P', 'DEL_ACCT FUNCTION_CODE', '', iRowIdx)
	                    //alert('1');
	                } else if (bChkSelect == false && bChkPartial == true) {
	                    //Partial Payment on the current row
	                    j++		//Next row for the partial payment row added
	                    sRowSuffix = sRowSuffix + 'P'
	                    parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, 'P', 'DEL_ACCT FUNCTION_CODE', '', iRowIdx)

	                    parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, document.getElementById('tdABT_Principal' + sRowSuffix).value, 'DEL_ACCT PRINCIPAL_DUE', '', iRowIdx)

	                    parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, document.getElementById('tdABT_Interest' + sRowSuffix).value, 'DEL_ACCT INTEREST_DUE', '', iRowIdx);

	                    parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, document.getElementById('tdABT_Penalty' + sRowSuffix).value, 'DEL_ACCT PENALTY_DUE', '', iRowIdx);

	                    parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, document.getElementById('tdABT_Other' + sRowSuffix).value, 'DEL_ACCT OTHER_DUE', '', iRowIdx)

	                } else if (bChkSelect == false && bChkPartial == false) {
	                    //No Payment on the current row
	                    parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, '', 'DEL_ACCT FUNCTION_CODE', '', iRowIdx);
	                    //alert('7');
	                }		//if
	                iRowIdx = iRowIdx + 1;
	                bChkSelect = false;
	                bChkPartial = false;
	            } 	//for j - Rows
	        } 	//for i - Tables

	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, 'P', 'DEL_INFO FUNCTION', '', 0);
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalance, '', 'DEL_INFO NOTICE_NUM', '', 0);


	        ShortenXML(parent.$g.xmloAcctBalance);

	        ispCallXMLForm(parent.$g.xmloAcctBalanceDelimited, dobj, "AccountBalanceCall1", "");

	        parent.$g.xmloAcctBalanceDelimited.loadXML(dobj.xml);


	        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_INFO NOTICE_NUM', '', 0) != '') {
	            if (oButton.id == btnCreditCard.id) {
	                //Credit Card
	                $('#divBalances').css("display", "none");
	                $('#divNoBalances').css("display", "none");
	                $('#divFinishedBalances').css("display", "block");
	                DoCreditCard()
	            } else {
	                //Coupon

	                DoPrintCoupon()
	            }		//if
	        } else {
	            alert('Error occured posting your payment information the server.');
	        }		//if
	    }		//PayCC_Click

	    function Print_Click() {
	        btnCoupon.style.visibility = 'hidden';
	        btnCreditCard.style.visibility = 'hidden';
	        window.print();
	        btnCoupon.style.visibility = 'visible';
	        btnCreditCard.style.visibility = 'visible';
	    } 	//Print_Click

	    function ShortenXML(oXML) {
	        var sTemp = new String
	        var iRecordCount = parent.$x.ispXmlGetRecCount(oXML, 'DEL_ACCT', '');

	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalanceDelimited, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_INFO ENTITY_TYPE', '', 0), 'DEL_INFO ENTITY_TYPE', '', 0);

	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalanceDelimited, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_INFO ENTITY_ID', '', 0), 'DEL_INFO ENTITY_ID', '', 0);
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalanceDelimited, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_INFO FUNCTION', '', 0), 'DEL_INFO FUNCTION', '', 0);
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalanceDelimited, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_INFO NOTICE_NUM', '', 0), 'DEL_INFO NOTICE_NUM', '', 0);
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalanceDelimited, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_INFO NEXT_ACCOUNT_TYPE', '', 0), 'DEL_INFO NEXT_ACCOUNT_TYPE', '', 0);
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalanceDelimited, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_INFO NEXT_ACCOUNT_ID', '', 0), 'DEL_INFO NEXT_ACCOUNT_ID', '', 0);
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalanceDelimited, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_INFO NEXT_PERIOD', '', 0), 'DEL_INFO NEXT_PERIOD', '', 0);

	        for (i = 0; i < parent.$x.ispXmlGetRecCount(oXML, 'DEL_ACCT', '') ; i++) {
	            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT ACCOUNT_TYPE', '', i) != '') {
	                sTemp = sTemp + parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT FUNCTION_CODE', '', i) + ':'
	                sTemp = sTemp + parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT ACCOUNT_TYPE', '', i) + ':'
	                sTemp = sTemp + parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT ACCOUNT_ID', '', i) + ':'
	                sTemp = sTemp + parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT PERIOD', '', i) + ':'
	                sTemp = sTemp + parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT PRINCIPAL_DUE', '', i) + ':'
	                sTemp = sTemp + parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT INTEREST_DUE', '', i) + ':'
	                sTemp = sTemp + parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT PENALTY_DUE', '', i) + ':'
	                sTemp = sTemp + parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT OTHER_DUE', '', i) + ':'
	                sTemp = sTemp + parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT BRT_ENTITY', '', i) + ':'
	                sTemp = sTemp + parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT BRT_ADDRESS', '', i) + ':'
	                sTemp = sTemp + parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_ACCT FILL', '', i) + ':|'
	                parent.$x.ispXmlSetFieldVal(parent.$g.xmloAcctBalanceDelimited, sTemp, 'DEL_ACCT_DELIMITED', '', 0)
	                status = ''


	            }		//if
	        }		//for
	        return sTemp
	    } 	//ShortenXML

	    function LocatePrimaryAddr(AddType, AddNewRow) {
	        var iMaxIdx = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '')
	        var iFirstEmptyRow = -1

	        for (idx = 0; idx < iMaxIdx; idx++) {
	            if (iFirstEmptyRow == -1 &&
				parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == '0') {
	                iFirstEmptyRow = idx
	            } 	//if
	            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == AddType) {
	                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', idx) == '0') {
	                    return idx
	                } 	//if
	            } 	//if
	        } 	//for
	        if (iFirstEmptyRow == -1 && AddNewRow == true) {
	            iFirstEmptyRow = iMaxIdx
	            var xmlTemp = parent.$g.getXmlDocObj(); //new ActiveXObject("MSXML.DOMDocument")
	            xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "NAME_ADDRESS", 0);

	            parent.$x.ispAppendNodeXml(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp, "NAME_ADDRESS", 0);

	        } 	//if
	        return iFirstEmptyRow
	    } 	//locatePrimaryAddr

	    function AdjustNameDisplay(incName) {
	        var sEntityName = incName
	        var lName = "", fName = "", mName = "", newName = ""

	        if (sEntityName.indexOf("*") != -1) {//If name contains *'s
	            sEntityName = sEntityName.split("*")
	            lName = (sEntityName[0].substr(0, 1)) + (sEntityName[0].substr(1).toLowerCase())
	            if (sEntityName[1]) {
	                fName = (sEntityName[1].substr(0, 1)) + (sEntityName[1].substr(1).toLowerCase())
	            } 	//if

	            if (sEntityName[2]) {
	                mName = sEntityName[2].substr(0, 1).toUpperCase()
	            }
	            sEntityName = fName + " " + mName + " " + lName
	        } 	//if
	        return sEntityName
	    } //AdjustNameDisplay


	    function DoCreditCard() {
	        var sAmount
	        var sToday, sMonth, sDate
	        sToday = new Date()
	        sMonth = sToday.getMonth() + 1
	        sDate = sToday.getDate()

	        if (sMonth <= 9) {
	            sMonth = '0' + sMonth
	        } //if

	        if (sDate <= 9) {
	            sDate = '0' + sDate
	        } //if

	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<%=  Session["CC_DB_ePay_ID"]%>', 'ApplicationID', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_INFO NOTICE_NUM', '', 0), 'AccountNumber', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_INFO NOTICE_NUM', '', 0), 'BillNumber', '', 0)	//Notice Number
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_INFO NOTICE_NUM', '', 0), 'StatementNumber', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '123', 'DepartMentId', '', 0)	//DOR
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sToday.getFullYear() + '-' + sMonth + '-' + sDate, 'PaymentDate', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, '<![CDATA[' + AdjustNameDisplay(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)) + ']]>', 'Customers Customer FirstName', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', addrIdx), 'Customers Customer BillingAddress Address AddressLine1', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', addrIdx), 'Customers Customer BillingAddress Address City', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', addrIdx), 'Customers Customer BillingAddress Address State', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS WORK_PHONE', '', addrIdx), 'Customers Customer PhoneNumber', '', 0)

	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sToday.getFullYear() + '-' + sMonth + '-' + sDate, 'BillingDate', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, sToday.getFullYear() + '-' + sMonth + '-' + sDate, 'DueDate', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, ispRemoveMoney(tdTotAmtSelDue.innerHTML), 'ItemAmount', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, ispRemoveMoney(tdTotAmtSelDue.innerHTML), 'TotalDue', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, ispRemoveMoney(tdTotAmtSelDue.innerHTML), 'TotalAmountdue', '', 0)

	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, ispRemoveMoney(tdTotAmtSelDue.innerHTML), 'Details BillingStatementDetail Charges', '', 0)
	        parent.$x.ispXmlSetFieldVal(parent.$g.xmlCC, 'Delinquent Tax Payment', 'Details BillingStatementDetail ItemDescription', '', 0)


	        var encodeCCXML = parent.$g.xmlCC.toString();
	        encodeCCXML = encodeCCXML.replace(/</g, '&lt;')
	        encodeCCXML = encodeCCXML.replace(/>/g, '&gt;')
	        encodeCCXML = encodeCCXML.replace(/"/g, '&quot;')
	        encodeCCXML = encodeCCXML.replace(/\t/g, '')
	        encodeCCXML = encodeCCXML.replace(/\r\n/g, '')

	        frmePay.action = '<%= Session["CC_SiteName"]%>'
	        frmePay.BillStmt.value = encodeCCXML
	        frmePay.submit()
        } 	//DoCreditCard

        function DoPrintCoupon() {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'DELBAL', 'COUPON_FORM CPN_FORM', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '98', 'COUPON_FORM CPN_ACCOUNT_TYPE', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmloAcctBalance, 'DEL_INFO NOTICE_NUM', '', 0), 'COUPON_FORM CPN_ACCOUNT', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, AdjustNameDisplay(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)), 'COUPON_FORM CPN_NAME', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '', 'COUPON_FORM CPN_ADDR3', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '2012/06/30', 'COUPON_FORM CPN_PERIOD', '');
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '2012', 'COUPON_FORM CPN_YEAR', '');

            SetupPassFields();
            parent.setFrameUrl('PayCoupon/PDFCouponCreate?' + tempParameters);
            // parent.DocWin.location.href = '../PayCoupon/PDFCouponCreate?' + tempParameters;
        } 	//DoPrintCoupon
	</script>
</head>
<body onload="SetInitFocus()">
    <div id="frmePay" method="post" target="_blank" >
		<input type="hidden" name='BillStmt' />
	</div>
   <div class="tab_Tcontainer">

   
    <div class="tab_container">
        <div style="display: block;" id="tab2" class="tab_content">
        <h2 id="AppHeader"></h2>
             <div class="taxpyer_address">
            	<h4 ></h4>
				<div id="divPayments" style="DISPLAY: block; ">
                    <!--Entity Information Section-->

                <div class="account_greybox">
                	
                    <p><strong>Name :</strong> <label id="lblEntityName" class="" style="font-weight:bold"></label></p>
                    <p><strong>Account ID :</strong> <label id="lblEntityAccountID" class="" style="font-weight:bold"></label></p>
                    <p><strong><label id="lblEntityType" class="">EIN: </label></strong> <label id="lblEntityId" class="lblTblDataLeft" style="font-weight:bold"></label></p>
                    
                    <p><strong>Address :</strong> <label id="lblEntityAddress" class="" style="font-weight:bold"></label></p>
                    
                    <div class="clear"></div>
                
                </div>
        		
                    <!--Date Filtering Section-->
		<table class="tblNormal" cellspacing="0" cellpadding="0" border="0" style="MARGIN-LEFT: 4%; /*display:none*/" width="90%">
			<tr>
				<td align=left nowrap> 
					<label class="lblInstrNormal">Date From: </label>
					<input class=inpNormal id=txtFromDate onchange="ValidateBalDate(txtFromDate)" maxlength=10 style="WIDTH: 68px; HEIGHT: 22px" size=9>
					<label class="lblInstrNormal"> Date To: </label>
					<input class=inpNormal width="50%" id=txtToDate onchange="ValidateBalDate(txtToDate)" maxlength=10 style="WIDTH: 68px; HEIGHT: 22px" size=9></td>
			</tr>
			<tr>
				<td align=left>&nbsp;</td>
			</tr></table>

                    <!--No Outstanding Balances Section-->
		<div id="divNoBalances" <%--style="display:none"--%>>
			<br /><br />
			<label class="lblTblDataLeft" style="margin-left:4%; font-weight:bold">This account currently has no outstanding balances</label>
		</div>	
                    
                    <!--Finished Outstanding Balances Section-->
		<div id="divFinishedBalances" <%--style="display:none"--%>>
			<br /><br />
			<label class="lblTblDataLeft" style="margin-left:4%; font-weight:bold">Thank you for reconciling some or all of your outstanding balances.</label>
		</div>	
                   <!--Outstanding Balances Section-->
		<div id="divBalances" <%--style="display:none"--%>>	
            <div id="divAcctBalTemplate" <%--style="display:none"--%>>
			<label id="lblAcctBalTemplate" class="" style="margin-left:4%; font-weight:bold; height:30px"></label>
<!--Account Balance Table Template-->
			<table id="tblAcctBalTemplate" class="additional_horstyle hor-zebra" summary="Employee Pay Sheet">
    
                <tr>
					<td width="6%"></td>
					<td width="6%"></td>
					<td width="10%"></td>
					<td width="13%"></td>
					<td width="13%"></td>
					<td width="13%"></td>
					<td width="13%"></td>
					<td width="13%"></td>
					<td width="13%"></td>
				</tr>
    	<tr>
        	<td colspan="2" align="center" class="additonal_padding border_top  "><strong>Payment Type</strong></td>
            <td class="additonal_padding border_top  no_border_bottom" width="14%" align="center"><strong>Period</strong></td>
            
            <td class="additonal_padding border_top no_border_bottom " width="12%" align="center"><strong>Principal</strong></td>
            <td class="additonal_padding border_top  no_border_bottom" width="12%" align="center"><strong>Intesrest</strong></td>
            <td class="additonal_padding border_top no_border_bottom " width="10%" align="center"><strong>Penalty</strong></td>
            
            <td class="additonal_padding border_top no_border_bottom " width="10%" align="center"><strong>Other</strong></td>
            <td class="additonal_padding border_top no_border_bottom " width="10%" align="center"><strong>Balance</strong></td>
            <td class="additonal_padding border_top no_border_bottom no_border_right" width="" align="center"><strong>Payment</strong></td>

        </tr>
        <tr>
        	<td class=" additonal_padding" width="10%" align="center">Full</td>
            <td class="additonal_padding" width="10%" align="center">Partial</td>
            <td class="additonal_padding" width="10%" align="center">&nbsp;</td>
            <td class="additonal_padding" width="10%" align="center">&nbsp;</td>
            <td class="additonal_padding" width="10%" align="center">&nbsp;</td>
            <td class="additonal_padding" width="10%" align="center">&nbsp;</td>
            <td class="additonal_padding" width="10%" align="center">&nbsp;</td>
            <td class="additonal_padding" width="10%" align="center">&nbsp;</td>
            <td class="additonal_padding  no_border_right " width="10%" align="center">&nbsp;</td>
            
            </tr>
    	<tr class="odd" id="trABT_Default">
    	  <td class="border_top" align="center">
              <input id="chkABT_Select" type="checkbox" value="" checked="checked" onclick='PayType_Click()'/>
    	  </td>
    	  <td class="border_top" align="center">
             <input id="chkABT_Partial" type="checkbox" onclick='PayType_Click()'/>
          </td>
    	  <td class="border_top small_texts" align="center" id="tdABT_Period"></td>
    	  <td class="border_top small_texts" align="center" id="tdABT_Principal"></td>
    	  <td class="border_top small_texts" align="center" id="tdABT_Interest"></td>
    	  <td class="border_top small_texts" align="center" id="tdABT_Penalty"></td>
    	  <td class="border_top small_texts" align="center" id="tdABT_Other"></td>
          <td class="border_top small_texts" align="center" id="tdABT_Balance"></td>
    	  <td class="border_top small_texts no_border_right" align="center" id="tdABT_Payment"></td>
  	  </tr>
        
      
      <tr class="" id="trABT_PartialPayment">
    	  <td class="border_top" align="center">
              <label>Partial Payment</label>
    	  </td>
    	  <td class="border_top" align="center">&nbsp;</td>
    	  <td class="border_top small_texts" align="center">
              <input id="tdABT_Principal" type="text" class="lblTblDataRight" style="color:Red; width:80%" value="$0.00" onblur="Partial_Sum(this)" />
    	  </td>
    	  <td class="border_top small_texts" align="center"> 
              <input id="tdABT_Interest" type="text" class="lblTblDataRight" style="color:Red; width:80%" value="$0.00" onblur="Partial_Sum(this)" />
    	  </td>
    	  <td class="border_top small_texts" align="center">
              <input id="tdABT_Penalty" type="text" class="lblTblDataRight" style="color:Red; width:80%" value="$0.00" onblur="Partial_Sum(this)" />
    	  </td>
    	  <td class="border_top small_texts" align="center">
              <input id="tdABT_Other" type="text" class="lblTblDataRight" style="color:Red; width:80%" value="$0.00" onblur="Partial_Sum(this)" />
    	  </td>          
          <td id="tdABT_Balance" class="border_top small_texts" align="center">&nbsp;</td>
		  <td id="tdABT_Payment" class="border_top small_texts no_border_right" align="center">&nbsp;</td>
  	  </tr>
    	
  
</table>
		</div>
            <!--Account Balance Totals Section-->
		<table id="tblBalanceTotals" class="tblNormal" cellspacing="0" cellpadding="0" border="0" style="MARGIN-LEFT: 6%" width="90%">
			<tr style="height:30px">
				<td width="6%"></td>
				<td width="6%"></td>
				<td width="10%"></td>
				<td width="13%"></td>
				<td width="13%"></td>
				<td width="13%"></td>
				<td width="13%"></td>
				<td width="13%"></td>
				<td width="13%"></td>
			</tr>				
			<tr class=rowDataEven>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td class="celLeft lblTblHeaderLeft" colspan="2" align="left" style="padding-left:10px">Total Outstanding Balance Due</td>
				<td id="tdTotOutBalDue" class="celLeft lblTblHeaderRight">&nbsp;</td>
				<td class=celRightLeft>&nbsp;</td>
			</tr>
			<tr class=rowDataOdd>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td colspan="2" class="celLeft lblTblHeaderLeft" align="left" style="padding-left:10px">Total Amount Selected Due</td>
				<td class="celLeft"><p class=lblTblHeaderRight>&nbsp;</p></td>
				<td id="tdTotAmtSelDue" class="celRightLeft lblTblHeaderRight" style="text-align:right; margin-right:5px">&nbsp;</td>
			</tr>
		</table>
<!--Account Balance Buttons Section-->
		<div style="text-align:center"><br />
<!--			<input type="button" value="Create a Payment Agreement" style="margin-right:15px" />-->
			<input type="button" id='btnCreditCard' value="Pay by Credit Card or eCheck (ePay)" onclick='Pay_Click(this)' class="submit_button2"/>
			<input type="button" id='btnCoupon' value="Create a Payment Coupon" onclick='Pay_Click(this)' class="submit_button2"/>
			<input type="button" id="btnPrint" value="Print" onclick="Print_Click()" class="submit_button2"/>
		</div>	
            </div>	

                    <!--Disclaimer Section-->
	
	<div id="divDisclaimer" <%--style="display:none;--%> margin-left:4%; font-weight:light;padding-top:70px;font-size:8pt;" class="lblTextBlack">

			<strong>Disclaimer:</strong>
			<br />
			The balances shown above may not represent all of the outstanding amounts due for this account.<br/>Tax types and years that are under agreement or
			tax types and years that are part of a bankruptcy filing will not appear.			
	</div>

</div>
			<div class="clear"></div>
            <br />
        <div class="quicklink_btm_gen"></div>
        </div>	
        </div>
     	
    </div>
</div>
</body>
</html>
