<%@ Language="VBScript"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title></title>
    <script src="../js/JqueryMin.js" type="text/javascript"></script>
	<!--#Include File="../Inc/Cache.htm"-->
	<!--#Include File="../Inc/Styles.htm"-->
	<!--#Include File="../Inc/ispFunctions.js.htm"-->
	<!--<script language="JavaScript" src="../Inc/ispXmlProc.js.htm" type="text/javascript"></script>-->
    <!--#Include File="../Inc/ispXmlProc.js.htm"-->

	<script language="javascript" type="text/javascript">
	    var txtHeader = 'Taxpayer Information'
	    var addrIdx
	    var oAcctBalTable
	    var oDfltRow
	    var oPartPaymentRow
	    var CONSTtdBody = 1
	    var aAcctTables = new Array()
	    var aAcctTypes = new Array()
	    aAcctTypes['001'] = 'Wage Tax'
	    aAcctTypes['002'] = 'Earnings Tax'
	    aAcctTypes['003'] = 'Net Profit Tax'
	    aAcctTypes['006'] = 'Amusement Tax'
	    aAcctTypes['008'] = 'Parking Tax'
	    aAcctTypes['009'] = 'Coin Tax'
	    aAcctTypes['011'] = 'Police Serivces'
	    aAcctTypes['012'] = 'Streets Collection Fees'
	    aAcctTypes['014'] = 'Vehicle Rental Tax'
	    aAcctTypes['018'] = 'Realty Transfer Tax'
	    aAcctTypes['023'] = 'Hotel Tax'
	    aAcctTypes['024'] = 'Business Income and Receipts Tax'
	    aAcctTypes['027'] = 'Tobacco Tax'
	    aAcctTypes['028'] = 'Liquor Tax'
	    aAcctTypes['029'] = 'School Income Tax'
	    aAcctTypes['032'] = 'Hospital Tax'
	    aAcctTypes['058'] = 'Valet Parking Tax'
	    aAcctTypes['060'] = 'Real Estate Tax'
	    aAcctTypes['076'] = 'Outdoor Advertising Tax'
	    aAcctTypes['084'] = 'U&O Tax - Landlord'
	    aAcctTypes['085'] = 'U&O Tax - Tenant'
	    aAcctTypes['090'] = 'Assessment Tax'
	    aAcctTypes['091'] = 'Police BRI Tax'
	    aAcctTypes['097'] = 'Entity Level Charges'
	    aAcctTypes['098'] = 'General - 98'
	    aAcctTypes['099'] = 'Entity Level Charges'





	    var dobj = parent.MenuWin.getXmlDocObj();

	    function SetInitFocus() {
	        //			var oTemp = new ActiveXObject("MSXML.DOMDocument")

	        parent.NavWin.ClearImages();
	        AppHeader.innerHTML = txtHeader + '<Font class=hdrMedium>|account balance</Font>';
	        AppError.innerText = '';
	        // divPayments.style.display = 'block';
	        $('#divPayments').css("display", "block");
	        //Load Account Balance XML from Entity Info
	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, '00' + ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO TYPE', '', 0), 'DEL_INFO ENTITY_TYPE', '', 0);
	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0), 'DEL_INFO ENTITY_ID', '', 0);
	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, 'I', 'DEL_INFO FUNCTION', '', 0);
	        PopulateEntityInfo();
	        //Call Mainframe
	        //  ispCallXMLForm(xmloAcctBalance, xmloTemp, 'AccountBalanceCall.asp', '');


	        ispCallXMLForm(parent.MenuWin.xmloAcctBalance, dobj, "AccountBalanceCall.asp", "");

	        parent.MenuWin.xmloAcctBalance = dobj;

	        //alert((new XMLSerializer()).serializeToString(parent.MenuWin.xmloAcctBalance.xml));


	        //			clipboardData.setData('Text', oTemp.xml)
	        //oAcctBalance.loadXML(oTemp.xml)
	        if (ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT ACCOUNT_ID', '', 0) == '') {
	            //No Account Balances
	            //alert('no');
	            // divNoBalances.style.display = "block";
	            //alert('if');
	            $('#divNoBalances').css("display", "block");
	        } else {

	            //Has Account Balances
	            PopulateAccounts();
	        } 	//if

	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, '', 'DEL_INFO FUNCTION', '', 0);
	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, '', 'DEBUG', '', 0);

	        //parent.RightFrame.rows = '*,0';
	        $(parent.RightFrame).attr('rows', '*,0');
	        $('#divDisclaimer').css("display", "block");
	    }  	//SetInitFocus

	    function PopulateEntityInfo() {


	        if (ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0) != '') {
	            //lblEntityAccountID.innerText = ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0);

	            $('#lblEntityAccountID').text(ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', '', 0));

	            //lblEntityId.innerText = ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0);
	            $('#lblEntityId').text(ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0));

	            if (ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == 1) {
	                $('#lblEntityType').text('EIN:');
	                //$('#lblEntityId').text ( ' ' + lblEntityId.innerText.substr(0, 2) + '-' + lblEntityId.innerText.substr(2));
	                $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 2) + '-' + $('#lblEntityId').text().substr(2));
	            } else {
	                $('#lblEntityType').text('SSN:')
	                $('#lblEntityId').text(' ' + $('#lblEntityId').text().substr(0, 3) + '-' + $('#lblEntityId').text().substr(3, 2) + '-' + $('#lblEntityId').text().substr(5))
	            } 	//if
	            addrIdx = LocatePrimaryAddr('60');
	            //alert(ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx));
	            $('#lblEntityName').text(AdjustNameDisplay(ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)));
	            $('#lblEntityAddress').text(ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', addrIdx) + ', ' + ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS CITY', '', addrIdx) + ' ' + ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS STATE', '', addrIdx) + ' ' + ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS ZIP', '', addrIdx));
	        } 	//if
	    } 	//PopulateEntityInfo

	    function PopulateAccounts() {

	        var sCurrAcctType = '', sCurrAcctId = '', bCreateTable = false, oTable

	        var iMaxIdx = ispXmlGetRecCount(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT', '')
	        //alert('iMaxIdx : ' + iMaxIdx);
	        for (idx = 0; idx < iMaxIdx; idx++) {
	            //				alert(iMaxIdx)
	            if (ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT ACCOUNT_ID', '', idx) != '') {
	                if (sCurrAcctType != ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT ACCOUNT_TYPE', '', idx) || sCurrAcctId != ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT ACCOUNT_ID', '', idx)) {
	                    sCurrAcctType = ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT ACCOUNT_TYPE', '', idx)
	                    sCurrAcctId = ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT ACCOUNT_ID', '', idx)

	                    //						bCreateTable = true
	                    if (sCurrAcctType == '084') {
	                        oAcctBalTable = AcctTblCreate(sCurrAcctType, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT BRT_ENTITY', '', idx), ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT BRT_ADDRESS', '', idx));
	                    } else {
	                        oAcctBalTable = AcctTblCreate(sCurrAcctType, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT ACCOUNT_ID', '', idx), ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT BRT_ADDRESS', '', idx));
	                    }		//if
	                    //						bCreateTable = false
	                } 	//if
	                //alert('idx : ' + idx);
	                //alert(oAcctBalTable.innerHTML);
	                AcctTblInsertRow(idx, '_' + sCurrAcctType + '_' + idx);
	                //					alert(oTable.outerHTML)
	                //					return
	            }		//if
	        }		//for

	        //divBalances.innerHTML = oAcctBalTable.outerHTML
	        //divBalances.style.display = "block";
	        $('#divBalances').css("display", "block");
	        Totals_Sum();
	    }		//PopulateAccounts

	    function AcctTblCreate(sAcctType, sEntity, sAddress) {
	        //Account Type Label


	        var oAcctLabel = document.getElementById('lblAcctBalTemplate').cloneNode(true)
	        //	oAcctLabel.innerText = aAcctTypes[sAcctType] + ' ' + sEntity + ' ' + sAddress
	        $(oAcctLabel).text(aAcctTypes[sAcctType] + ' ' + sEntity + ' ' + sAddress);

	        //alert(document.getElementById('tblBalanceTotals'));
	        divBalances.insertBefore(oAcctLabel, document.getElementById('tblBalanceTotals'))
	        //$(oAcctLabel).html('<br />' + $(oAcctLabel).html());
	        //$(oAcctLabel).css("text-align","");

	        //alert('divBalances : ' + divBalances.innerHTML);

	        //Account Table
	        oAcctBalTable = document.getElementById('tblAcctBalTemplate').cloneNode(true)
	        oAcctBalTable.id = oAcctBalTable.id + '_' + sAcctType
	        aAcctTables[aAcctTables.length] = oAcctBalTable



	        ///oDfltRow = oAcctBalTable.document.getElementById('trABT_Default')
	        //oAcctBalTable.childNodes(CONSTtdBody).removeChild(oDfltRow)

	        removeTableRow('trABT_Default');
	        removeTableRow('trABT_PartialPayment');
	        removeTableRow('tblBalanceTotals');

	        //	oPartPaymentRow = $(oAcctBalTable).find('#trABT_PartialPayment').get(0);
	        // AcctBalTable.document.getElementById('trABT_PartialPayment')
	        //alert($(oPartPaymentRow).html());
	        //oAcctBalTable.childNodes(CONSTtdBody).removeChild(oPartPaymentRow)
	        // $(oAcctBalTable).children().eq(CONSTtdBody).find($(oPartPaymentRow)).remove();


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

	        //oDfltRow.id = 'trABT_Default' + idx;
	        //alert('oDfltRow2 : ' + $(oDfltRow).html());
	        //oNewRow = oAcctBalTable.childNodes(CONSTtdBody).appendChild(oDfltRow)

	        //alert($(oAcctBalTable).children().eq(CONSTtdBody));

	        //var rowx = $('#trABT_Default').clone();
	        //rowx.attr('id','trABT_Default1');
	        //alert('rowx : ' + $(rowx).html());
	        // $(oAcctBalTable).children().eq(CONSTtdBody).appendTo($(oDfltRow));
	        //alert("CONSTtdBody" + CONSTtdBody);
	        //$(oDfltRow).appendTo($(oAcctBalTable).children().eq(CONSTtdBody));
	        $(oAcctBalTable).children().eq(0).children().eq(CONSTtdBody + 1).after(oDfltRow);
	        //alert($(oAcctBalTable).html());
	        //alert($(oAcctBalTable).children().eq(CONSTtdBody).attr("id"));

	        //$(oAcctBalTable + ' ' + 'tr:eq(' + CONSTtdBody + ')').before(oDfltRow)

	        //alert($(oAcctBalTable).html());
	        //oNewRow =  $(oAcctBalTable).find('#trABT_Default').get(0);
	        oNewRow = oDfltRow;
	        //alert('oNewRow : ' + $(oNewRow).html());
	        if ((oNewRow == null) || (oNewRow == 'undefine')) {
	            //alert('AcctTblInsertRow : ' + idx);
	            return;
	        }

	        //alert($(oNewRow).html());
	        //alert($(oAcctBalTable).html());
	        oNewRow.id = oNewRow.id + idSuffix;

	        //alert($(oNewRow).children().length);
	        for (i = 0; i < $(oNewRow).children().length; i++) {

	            if (i == 0) {
	                //Select Check Box
	                //oNewRow.childNodes(i).childNodes(0).id = oNewRow.childNodes(i).childNodes(0).id + idSuffix
	                //alert($(oNewRow).children().eq(i).children().eq(0).get(0).id);
	                $(oNewRow).children().eq(i).children().eq(0).get(0).id = $(oNewRow).children().eq(i).children().eq(0).get(0).id + idSuffix;
	            } else if (i == 1) {
	                //Partial Check Box 
	                $(oNewRow).children().eq(i).children().eq(0).get(0).id = $(oNewRow).children().eq(i).children().eq(0).get(0).id + idSuffix
	            } else {
	                //Cells
	                //oNewRow.childNodes(i).id = oNewRow.childNodes(i).id + idSuffix
	                //alert($(oNewRow).html());
	                //alert($(oNewRow).children().eq(i).get(0).html());
	                //alert($(oNewRow).children().eq(i).get(0) );
	                //if(($(oNewRow).children().eq(i).get(0) != null ) || ($(oNewRow).children().eq(i).get(0) !='undefine')
	                //|| ($(oNewRow).children().eq(i).get(0).id !='undefine'))
	                if (($(oNewRow).children().eq(i).get(0) != 'undefine')
										|| ($(oNewRow).children().eq(i).get(0).id != 'undefine')) {
	                    //alert($(oNewRow).children().eq(i).get(0).html());
	                    //alert($(oNewRow).children().eq(i).get(0).id );
	                    $(oNewRow).children().eq(i).get(0).id = $(oNewRow).children().eq(i).get(0).id + idSuffix;
	                    //alert($(oNewRow).children().eq(i).get(0).id );
	                }

	                //alert($(oNewRow).children().eq(i).get(0).id);
	            }
	        } 	//for
	        //alert('out' + idx);
	        if (idx % 2) {
	            //alert(idx);
	            //Row is set to even by default
	            oNewRow.className = 'rowDataOdd'
	        } 	//if
	        document.getElementById('tdABT_Period' + idSuffix).innerHTML = ispFormatPeriod(ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT PERIOD', '', idx), 'D')
	        document.getElementById('tdABT_Principal' + idSuffix).innerHTML = ispFormatMoney(ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT PRINCIPAL_DUE', '', idx), 2)
	        document.getElementById('tdABT_Interest' + idSuffix).innerHTML = ispFormatMoney(ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT INTEREST_DUE', '', idx), 2)
	        document.getElementById('tdABT_Penalty' + idSuffix).innerHTML = ispFormatMoney(ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT PENALTY_DUE', '', idx), 2)
	        document.getElementById('tdABT_Other' + idSuffix).innerHTML = ispFormatMoney(ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT OTHER_DUE', '', idx), 2)
	        SelectRow_Sum(idSuffix, false)
	    }		//AcctTblInsertRow

	    function PayType_Click() {
	        //chkABT_Select base name for Select;		chkABT_Partial base name for Partial
	        var CONSTChkSelectBase = 'chkABT_Select'
	        var CONSTChkPartialBase = 'chkABT_Partial'
	        var oChkSelect; var oChkPartial
	        var activeElement = $(document.activeElement);

	        var evt = window.event || arguments.callee.caller.arguments[0];
	        var source = parent.MenuWin.getEventSource(evt);
	        //alert(source);
	        var sId = source.id; // activeElement.attr('id'); // $(document.activeElement).is(":focus"); // document.activeElement.id
	        //alert(sId);

	        var sIdSuffix;
	        if (sId.indexOf('_', 7) > -1) {

	            sIdSuffix = sId.substr(sId.indexOf('_', 7))
	        }
	        //alert(sId.indexOf('_', 7) + '  ' + sIdSuffix)
	        //var sIdBaseSelect = sId.substr(0,
	        if (sId.search('Partial') > -1) {
	            oChkPartial = document.getElementById(sId);// sId; // document.activeElement
	            oChkSelect = document.getElementById(CONSTChkSelectBase + sIdSuffix);
	            var oOldRow = document.getElementById('trABT_Default' + sIdSuffix);
	            var oNewRow = document.getElementById('trABT_PartialPayment').cloneNode(true);

	            if (oChkPartial.checked == true) {
	                oChkSelect.checked = false
	                oNewRow.id = oNewRow.id + sIdSuffix + 'P'
	                //oNewRow.childNodes(2).childNodes(0).id = oNewRow.childNodes(2).childNodes(0).id + sIdSuffix + 'P'

	                $(oNewRow).children().eq(2).children().eq(0).get(0).id = $(oNewRow).children().eq(2).children().eq(0).get(0).id + sIdSuffix + 'P';

	                //oNewRow.childNodes(3).childNodes(0).id = oNewRow.childNodes(3).childNodes(0).id + sIdSuffix + 'P'

	                $(oNewRow).children().eq(3).children().eq(0).get(0).id = $(oNewRow).children().eq(3).children().eq(0).get(0).id + sIdSuffix + 'P';

	                //oNewRow.childNodes(4).childNodes(0).id = oNewRow.childNodes(4).childNodes(0).id + sIdSuffix + 'P'

	                $(oNewRow).children().eq(4).children().eq(0).get(0).id = $(oNewRow).children().eq(4).children().eq(0).get(0).id + sIdSuffix + 'P';

	                //oNewRow.childNodes(5).childNodes(0).id = oNewRow.childNodes(5).childNodes(0).id + sIdSuffix + 'P'

	                $(oNewRow).children().eq(5).children().eq(0).get(0).id = $(oNewRow).children().eq(5).children().eq(0).get(0).id + sIdSuffix + 'P';

	                //oNewRow.childNodes(6).id = oNewRow.childNodes(6).id + sIdSuffix + 'P'

	                $(oNewRow).children().eq(6).get(0).id = $(oNewRow).children().eq(2).get(0).id + sIdSuffix + 'P';

	                //oNewRow.childNodes(7).id = oNewRow.childNodes(7).id + sIdSuffix + 'P'

	                $(oNewRow).children().eq(7).get(0).id = $(oNewRow).children().eq(7).get(0).id + sIdSuffix + 'P';

	                //oOldRow.parentNode.insertBefore(oNewRow, oOldRow.nextSibling)

	                oOldRow.parentNode.insertBefore(oNewRow, oOldRow.nextSibling);

	                SelectRow_Sum(sIdSuffix, true);
	                //Partial_Sum(oNewRow.childNodes(2).childNodes(0));
	                Partial_Sum($(oNewRow).children().eq(2).children().eq(0).get(0));
	                //oNewRow.childNodes(2).childNodes(0).focus()
	                $(oNewRow).children().eq(2).children().eq(0).get(0).focus();
	                //oNewRow.childNodes(2).childNodes(0).select()
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
	                    //alert('1 : '  + document.getElementsByTagName('table').item(i).rows[j].id);
	                    if (document.getElementsByTagName('table').item(i).rows[j].id.indexOf('_', 7) > -1) {								//alert('2 : ' + document.getElementsByTagName('table').item(i).rows[j].id);
	                        sIdSuffix = document.getElementsByTagName('table').item(i).rows[j].id;
	                        sIdSuffix = sIdSuffix.substr(sIdSuffix.indexOf('_', 7));

	                        //var msg = $(AppError).text(); //test purpose
	                        //$(AppError).text( msg + '   tdABT_Balance :    ' +$(document.getElementById('tdABT_Balance' + sIdSuffix)).html());
	                        //$(AppError).text( msg + '	tdABT_Payment :    ' +$(document.getElementById('tdABT_Payment' + sIdSuffix)).html());

	                        //iTotOutBalDue = iTotOutBalDue + ispRemoveMoney(document.getElementById('tdABT_Balance' + sIdSuffix).innerHTML);

	                        if ($(document.getElementById('tdABT_Balance' + sIdSuffix)).html() != null) {
	                            iTotOutBalDue = iTotOutBalDue + ispRemoveMoney($(document.getElementById('tdABT_Balance' + sIdSuffix)).html());

	                        } else {

	                            iTotOutBalDue = iTotOutBalDue;
	                        }

	                        //iTotAmtSelDue = iTotAmtSelDue + ispRemoveMoney(document.getElementById('tdABT_Payment' + sIdSuffix).innerHTML);
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

	                    bChkSelect = document.getElementById('chkABT_Select' + sRowSuffix).checked;
	                    bChkPartial = document.getElementById('chkABT_Partial' + sRowSuffix).checked;
	                } 	//if

	                if (bChkSelect == true && bChkPartial == false) {
	                    //Full Payment on the current row
	                    ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, 'P', 'DEL_ACCT FUNCTION_CODE', '', iRowIdx)
	                    //alert('1');
	                } else if (bChkSelect == false && bChkPartial == true) {
	                    //Partial Payment on the current row
	                    j++		//Next row for the partial payment row added
	                    sRowSuffix = sRowSuffix + 'P'
	                    ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, 'P', 'DEL_ACCT FUNCTION_CODE', '', iRowIdx)
	                    //alert('2');
	                    ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, document.getElementById('tdABT_Principal' + sRowSuffix).value, 'DEL_ACCT PRINCIPAL_DUE', '', iRowIdx)

	                    //alert('3');

	                    ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, document.getElementById('tdABT_Interest' + sRowSuffix).value, 'DEL_ACCT INTEREST_DUE', '', iRowIdx);

	                    //alert('4');

	                    ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, document.getElementById('tdABT_Penalty' + sRowSuffix).value, 'DEL_ACCT PENALTY_DUE', '', iRowIdx);

	                    //alert('5');
	                    //alert(parent.MenuWin.xmloAcctBalance.xml.xml);
	                    ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, document.getElementById('tdABT_Other' + sRowSuffix).value, 'DEL_ACCT OTHER_DUE', '', iRowIdx)

	                    //alert('6');
	                } else if (bChkSelect == false && bChkPartial == false) {
	                    //No Payment on the current row
	                    ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, '', 'DEL_ACCT FUNCTION_CODE', '', iRowIdx);
	                    //alert('7');
	                }		//if
	                iRowIdx = iRowIdx + 1;
	                bChkSelect = false;
	                bChkPartial = false;
	            } 	//for j - Rows
	        } 	//for i - Tables
	        //Call Mainframe
	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, 'P', 'DEL_INFO FUNCTION', '', 0);
	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalance, '', 'DEL_INFO NOTICE_NUM', '', 0);
	        //alert((new XMLSerializer()).serializeToString(parent.MenuWin.xmloAcctBalanceDelimited.xml));

	        ShortenXML(parent.MenuWin.xmloAcctBalance);


	        //ispCallXMLForm1(parent.MenuWin.xmloAcctBalanceDelimited, oTemp, 'AccountBalanceCall1.asp', '') commented by ajoy as because we have ispCallXMLForm method. 

	        //alert(parent.MenuWin.xmloAcctBalanceDelimited.toString());

	        ispCallXMLForm(parent.MenuWin.xmloAcctBalanceDelimited, dobj, "AccountBalanceCall1.asp", "");
	        //alert(dobj.toString());

	        parent.MenuWin.xmloAcctBalanceDelimited = dobj;
	        //alert((new XMLSerializer()).serializeToString(parent.MenuWin.xmloAcctBalanceDelimited.xml));
	        //clipboardData.setData('Text', oTemp.xml)
	        //			return
	        //oAcctBalance.loadXML(oTemp.xml)

	        if (ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_INFO NOTICE_NUM', '', 0) != '') {
	            if (oButton.id == btnCreditCard.id) {
	                //Credit Card
	                //divBalances.style.display = 'none'
	                $('#divBalances').css("display", "none");
	                //divNoBalances.style.display = 'none'
	                $('#divNoBalances').css("display", "none");
	                //divFinishedBalances.style.display = 'block'
	                $('#divFinishedBalances').css("display", "block");
	                DoCreditCard()
	            } else {
	                //Coupon
	                DoPrintCoupon()
	            }		//if
	        } else {
	            alert('Error occured posting your payment information the server.')
	        }		//if
	    }		//PayCC_Click

	    function Print_Click() {
	        btnCoupon.style.visibility = 'hidden'
	        btnCreditCard.style.visibility = 'hidden'
	        window.print()
	        btnCoupon.style.visibility = 'visible'
	        btnCreditCard.style.visibility = 'visible'
	    } 	//Print_Click

	    function ShortenXML(oXML) {
	        var sTemp = new String
	        var iRecordCount = ispXmlGetRecCount(oXML, 'DEL_ACCT', '')

	        //alert(parent.MenuWin.xmloAcctBalanceDelimited);
	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalanceDelimited, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_INFO ENTITY_TYPE', '', 0), 'DEL_INFO ENTITY_TYPE', '', 0);

	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalanceDelimited, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_INFO ENTITY_ID', '', 0), 'DEL_INFO ENTITY_ID', '', 0);
	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalanceDelimited, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_INFO FUNCTION', '', 0), 'DEL_INFO FUNCTION', '', 0);
	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalanceDelimited, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_INFO NOTICE_NUM', '', 0), 'DEL_INFO NOTICE_NUM', '', 0);
	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalanceDelimited, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_INFO NEXT_ACCOUNT_TYPE', '', 0), 'DEL_INFO NEXT_ACCOUNT_TYPE', '', 0);
	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalanceDelimited, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_INFO NEXT_ACCOUNT_ID', '', 0), 'DEL_INFO NEXT_ACCOUNT_ID', '', 0);
	        ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalanceDelimited, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_INFO NEXT_PERIOD', '', 0), 'DEL_INFO NEXT_PERIOD', '', 0);
	        //alert((new XMLSerializer()).serializeToString(parent.MenuWin.xmloAcctBalanceDelimited.xml));
	        //alert(oXML);
	        for (i = 0; i < ispXmlGetRecCount(oXML, 'DEL_ACCT', '') ; i++) {
	            if (ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT ACCOUNT_TYPE', '', i) != '') {
	                sTemp = sTemp + ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT FUNCTION_CODE', '', i) + ':'
	                sTemp = sTemp + ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT ACCOUNT_TYPE', '', i) + ':'
	                sTemp = sTemp + ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT ACCOUNT_ID', '', i) + ':'
	                sTemp = sTemp + ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT PERIOD', '', i) + ':'
	                sTemp = sTemp + ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT PRINCIPAL_DUE', '', i) + ':'
	                sTemp = sTemp + ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT INTEREST_DUE', '', i) + ':'
	                sTemp = sTemp + ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT PENALTY_DUE', '', i) + ':'
	                sTemp = sTemp + ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT OTHER_DUE', '', i) + ':'
	                sTemp = sTemp + ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT BRT_ENTITY', '', i) + ':'
	                sTemp = sTemp + ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT BRT_ADDRESS', '', i) + ':'
	                sTemp = sTemp + ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_ACCT FILL', '', i) + ':|'
	                ispXmlSetFieldVal(parent.MenuWin.xmloAcctBalanceDelimited, sTemp, 'DEL_ACCT_DELIMITED', '', 0)
	                status = ''

	                //alert('sTemp : ' + sTemp);
	            }		//if
	        }		//for
	        return sTemp
	    } 	//ShortenXML

	    function LocatePrimaryAddr(AddType, AddNewRow) {
	        var iMaxIdx = ispXmlGetRecCount(parent.MenuWin.xmlAccount, 'NAME_ADDRESS', '')
	        //alert(iMaxIdx);
	        var iFirstEmptyRow = -1

	        for (idx = 0; idx < iMaxIdx; idx++) {
	            if (iFirstEmptyRow == -1 &&
				ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == '0') {
	                iFirstEmptyRow = idx
	            } 	//if
	            if (ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == AddType) {
	                if (ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', idx) == '0') {
	                    return idx
	                } 	//if
	            } 	//if
	        } 	//for
	        if (iFirstEmptyRow == -1 && AddNewRow == true) {
	            iFirstEmptyRow = iMaxIdx
	            var xmlTemp = parent.MenuWin.getXmlDocObj(); //new ActiveXObject("MSXML.DOMDocument")
	            xmlTemp.xml = ispXmlGetRecordXml(parent.MenuWin.xmlTemplate, "NAME_ADDRESS", 0);
	            //alert((new XMLSerializer()).serializeToString(parent.MenuWin.xmlTemp.xml));
	            ispAppendNodeXml(parent.MenuWin.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp, "NAME_ADDRESS", 0);
	            //alert((new XMLSerializer()).serializeToString(parent.MenuWin.xmlTemp.xml));
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

	    /*this function moved into ispfunction.js
                function ispFormatPeriod(sPeriod, sType) {
                    //If sType = D (display); Incoming Format YYYYMMDD;		Outgoing Format MM/DD/YYYY
                    //If sType = M (mainframe); Incoming Format MM/DD/YYYY;		Outgoing Format YYYYMMDD
                    if (sType == 'D') {
                        return sPeriod.substr(4, 2) + '/' + sPeriod.substr(6, 2) + '/' + sPeriod.substr(0, 4)
                    } else {
                        return sPeriod.substr(6, 4) + sPeriod.substr(0, 2) + sPeriod.substr(3, 2)
                    }		//if
                }		//ispFormatPeriod
        
                function ispRemoveMoney(sAmount) {
                    if (sAmount == undefined) { return }	//if
        
                    sAmount = sAmount.replace('$', '')
                    sAmount = sAmount.replace(',', '')
                    if (isNaN(sAmount) || sAmount == ' ') {
                        sAmount = 0.00
                    } else {			
                    }		//if
                    return parseFloat(sAmount)
                }		//ispRemoveMoney
                */

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

	        //			for (i = 0; i < data.length; i++) {
	        //				if (data[i][conACCTNUM] == frmePay.ddAccount.options(frmePay.ddAccount.selectedIndex).innerText) {
	        //					break
	        //				} 	//if
	        //			} 	//for

	        //alert((new XMLSerializer()).serializeToString(parent.MenuWin.xmlCC.xml));
	        //clipboardData.setData ('Text', parent.MenuWin.xmloAcctBalance.xml.xml);
	        ispXmlSetFieldVal(parent.MenuWin.xmlCC, '<%= Session("CC_DB_ePay_ID")%>', 'ApplicationID', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_INFO NOTICE_NUM', '', 0), 'AccountNumber', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_INFO NOTICE_NUM', '', 0), 'BillNumber', '', 0)	//Notice Number
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_INFO NOTICE_NUM', '', 0), 'StatementNumber', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, '123', 'DepartMentId', '', 0)	//DOR
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, sToday.getFullYear() + '-' + sMonth + '-' + sDate, 'PaymentDate', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, '<![CDATA[' + AdjustNameDisplay(ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)) + ']]>', 'Customers Customer FirstName', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', addrIdx), 'Customers Customer BillingAddress Address AddressLine1', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS CITY', '', addrIdx), 'Customers Customer BillingAddress Address City', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS STATE', '', addrIdx), 'Customers Customer BillingAddress Address State', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS WORK_PHONE', '', addrIdx), 'Customers Customer PhoneNumber', '', 0)

			ispXmlSetFieldVal(parent.MenuWin.xmlCC, sToday.getFullYear() + '-' + sMonth + '-' + sDate, 'BillingDate', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, sToday.getFullYear() + '-' + sMonth + '-' + sDate, 'DueDate', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, ispRemoveMoney(tdTotAmtSelDue.innerHTML), 'ItemAmount', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, ispRemoveMoney(tdTotAmtSelDue.innerHTML), 'TotalDue', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, ispRemoveMoney(tdTotAmtSelDue.innerHTML), 'TotalAmountdue', '', 0)

			ispXmlSetFieldVal(parent.MenuWin.xmlCC, ispRemoveMoney(tdTotAmtSelDue.innerHTML), 'Details BillingStatementDetail Charges', '', 0)
			ispXmlSetFieldVal(parent.MenuWin.xmlCC, 'Delinquent Tax Payment', 'Details BillingStatementDetail ItemDescription', '', 0)

		    //alert('xmlcc : ' + (new XMLSerializer()).serializeToString(parent.MenuWin.xmlCC.xml));
		    //var strxmlCC = (new XMLSerializer()).serializeToString(parent.MenuWin.xmlCC.xml);
			var encodeCCXML = parent.MenuWin.xmlCC.toString();//var encodeCCXML = XMLToString_Delinquent(parent.MenuWin.xmlCC);// XMLToString(parent.MenuWin.xmlCC)
			encodeCCXML = encodeCCXML.replace(/</g, '&lt;')
			encodeCCXML = encodeCCXML.replace(/>/g, '&gt;')
			encodeCCXML = encodeCCXML.replace(/"/g, '&quot;')
			encodeCCXML = encodeCCXML.replace(/\t/g, '')
			encodeCCXML = encodeCCXML.replace(/\r\n/g, '')
		    //			clipboardData.setData('Text', encodeCCXML)

		    //alert(encodeCCXML);
			frmePay.action = '<%= Session("CC_SiteName")%>'
			frmePay.BillStmt.value = encodeCCXML
			frmePay.submit()
        } 	//DoCreditCard

        function DoPrintCoupon() {
            ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, 'DELBAL', 'COUPON_FORM CPN_FORM', '')
            ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, '98', 'COUPON_FORM CPN_ACCOUNT_TYPE', '')
            ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, ispXmlGetFieldVal(parent.MenuWin.xmloAcctBalance, 'DEL_INFO NOTICE_NUM', '', 0), 'COUPON_FORM CPN_ACCOUNT', '')
            ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, AdjustNameDisplay(ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS NAME', '', addrIdx)), 'COUPON_FORM CPN_NAME', '')
            ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '')
            ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '')
            ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, '', 'COUPON_FORM CPN_ADDR3', '')
            ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '')
            ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '')
            ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, ispXmlGetFieldVal(parent.MenuWin.xmlAccount, 'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '')
            ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, '2012/06/30', 'COUPON_FORM CPN_PERIOD', '')
            ispXmlSetFieldVal(parent.MenuWin.xmlPayCoupon, '2012', 'COUPON_FORM CPN_YEAR', '')
            //ispDisplayProgress('', 'Creating Business Privilege Tax Coupon')
            SetupPassFields()
            //			alert(tempParameters)
            //			return
            //alert(tempParameters);
            parent.DocWin.location.href = '../PayCoupon/PDFCouponCreate.asp?' + tempParameters
        } 	//DoPrintCoupon
	</script>
</head>
<body onload="SetInitFocus()">
	<form id="frmePay" method="post" target="_blank" >
		<input type="hidden" name='BillStmt' />
	</form>
	<!--#Include File="../Inc/AppHeader.htm"-->
  <div id="divPayments" style="DISPLAY: block; VISIBILITY: visible; width:98%">
<!--Entity Information Section-->
		<table class="tblShowBorder" width="90%" bgcolor="whitesmoke" style="MARGIN-LEFT: 4%" border="0"
				 cellspacing="0" cellpadding="0" id="tblEntityInfo">
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
				<td WIDTH="5%"></td></tr>
			<tr>
				<td >&nbsp;</td>
				<td colspan="9">
					<label class="lblInstrNormal">Name: </label><label id="lblEntityName" class="lblTblDataLeft" style="font-weight:bold"></label></td>
				<td colspan="5">
					<label class="lblInstrNormal">Account Id: </label><label id="lblEntityAccountID" class="lblTblDataLeft" style="font-weight:bold"></label></td>
				<td colspan="5">
					<label id="lblEntityType" class="lblInstrNormal">EIN: </label><label id="lblEntityId" class="lblTblDataLeft" style="font-weight:bold"></label></td>
			</tr>
			<tr>
				<td >&nbsp;</td>
				<td colspan="19">
					<label class="lblInstrNormal">Address: </label><label id="lblEntityAddress" class="lblTblDataLeft" style="font-weight:bold"></label>
				</td>
			</tr>
		</table>
		<br />  
<!--Date Filtering Section-->
		<table class="tblNormal" cellspacing="0" cellpadding="0" border="0" style="MARGIN-LEFT: 4%; display:none" width="90%">
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
		<div id="divNoBalances" style="display:none">
			<br /><br />
			<label class="lblTblDataLeft" style="margin-left:4%; font-weight:bold">This account currently has no outstanding balances</label>
		</div>		
<!--Finished Outstanding Balances Section-->
		<div id="divFinishedBalances" style="display:none">
			<br /><br />
			<label class="lblTblDataLeft" style="margin-left:4%; font-weight:bold">Thank you for reconciling some or all of your outstanding balances.</label>
		</div>
<!--Outstanding Balances Section-->
		<div id="divBalances" style="display:none">		

<!--Account Balances Section - Template Section-->
		<div id="divAcctBalTemplate" style="display:none">
			<label id="lblAcctBalTemplate" class="lblTblDataLeft" style="margin-left:4%; font-weight:bold; height:30px"></label>
<!--Account Balance Table Template-->
			<table id="tblAcctBalTemplate" class="tblNormal" cellspacing="0" cellpadding="0" border="0" style="MARGIN-LEFT: 6%" width="90%">
<!--Account Balance TR Spacing Template-->
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
<!--Account Balance Header1 Template-->
				<tr class="rowHeader">
					<td colspan="2" class="celLeft lblTblHeaderCenter">Payment Type</td>
					<td class="celLeft">&nbsp;</td>
					<td class="celLeft">&nbsp;</td>
					<td class="celLeft">&nbsp;</td>
					<td class="celLeft">&nbsp;</td>
					<td class="celLeft">&nbsp;</td>
					<td class="celLeft">&nbsp;</td>
					<td class=celRightLeft>&nbsp;</td>
				</tr>
<!--Account Balance Header2 Template-->
				<tr class="rowHeader">
					<td width="6%" class="celLeft lblTblHeaderCenter">Full</td>
					<td width="6%" class="lblTblHeaderCenter">Partial</td>
					<td width="10%" class="celLeft lblTblHeaderCenter">Period</td>
					<td width="13%" class="celLeft lblTblHeaderCenter">Principal</td>
					<td width="13%" class="celLeft lblTblHeaderCenter">Interest</td>
					<td width="13%" class="celLeft lblTblHeaderCenter">Penalty</td>
					<td width="13%" class="celLeft lblTblHeaderCenter">Other</td>
					<td width="13%" class="celLeft lblTblHeaderCenter">Balance</td>
					<td width="13%" class="celRightLeft lblTblHeaderCenter">Payment</td>
				</tr>
<!--Account Balance Row Default Template-->
				<tr id="trABT_Default" class="rowDataEven">
					<td class="celLeft" nowrap="nowrap" align="center">
						<input id="chkABT_Select" type="checkbox" value="" checked="checked" style="width:12px; margin-left:5px; margin-right:5px" onclick='PayType_Click()'/></td>				
					<td class="celLeft" nowrap="nowrap" align="center">
						<input id="chkABT_Partial" type="checkbox" value="" style="width:12px; margin-left:5px; margin-right:5px" onclick='PayType_Click()'/></td>
					<td id="tdABT_Period" class="celLeft lblTblDataLeft">&nbsp;</td>
					<td id="tdABT_Principal" class="celLeft lblTblDataRight">&nbsp;</td>
					<td id="tdABT_Interest" class="celLeft lblTblDataRight">&nbsp;</td>
					<td id="tdABT_Penalty" class="celLeft lblTblDataRight">&nbsp;</td>
					<td id="tdABT_Other" class="celLeft lblTblDataRight">&nbsp;</td>
					<td id="tdABT_Balance" class="celLeft lblTblDataRight">&nbsp;</td>
					<td id="tdABT_Payment" class="celRightLeft lblTblDataRight">&nbsp;</td>
				</tr>
<!--Account Balance Row Partial Payment Template-->
				<tr id="trABT_PartialPayment" class="" style="background-color:#ffffcc" align="right">
					<td class="celLeft" colspan="2" nowrap="nowrap" align="left">
						<label style="margin-left:20px">Partial Payment</label></td>
					<td class="celLeft" align="center">&nbsp;</td>
					<td class="celLeft"><input id="Text1" type="text" class="lblTblDataRight" style="color:Red; width:80%" value="$0.00" onblur="Partial_Sum(this)" /></td>
					<td class="celLeft"><input id="Text2" type="text" class="lblTblDataRight" style="color:Red; width:80%" value="$0.00" onblur="Partial_Sum(this)" /></td>
					<td class="celLeft"><input id="Text3" type="text" class="lblTblDataRight" style="color:Red; width:80%" value="$0.00" onblur="Partial_Sum(this)" /></td>
					<td class="celLeft"><input id="Text4" type="text" class="lblTblDataRight" style="color:Red; width:80%" value="$0.00" onblur="Partial_Sum(this)" /></td>
					<td id="td1" class="celLeft lblTblDataRight">&nbsp;</td>
					<td id="td2" class="celRightLeft lblTblDataRight">&nbsp;</td>
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
		<div style="width:90%; text-align:center"><br />
<!--			<input type="button" value="Create a Payment Agreement" style="margin-right:15px" />-->
			<input type="button" id='btnCreditCard' value="Pay by Credit Card or eCheck (ePay)"  style="margin-right:15px" onclick='Pay_Click(this)'/>
			<input type="button" id='btnCoupon' value="Create a Payment Coupon" onclick='Pay_Click(this)'/>
			<input type="button" id="btnPrint" value="Print" onclick="Print_Click()" />
		</div>			
  </div>
  <!--Disclaimer Section-->
	<!--<div id="divDisclaimer" style="display:none; margin-left:4%; font-weight:light">
		<br /><br />
			Disclaimer:
			<br />
			The balances shown above may not represent all of the outstanding amounts due for this account.Tax types and years that are under agreement or
			tax types and years that are part of a bankruptcy filing will not appear.			
	</div>-->
	<div id="divDisclaimer" style="display:none; margin-left:4%; font-weight:light;padding-top:70px;font-size:8pt;" class="lblTextBlack">

			<strong>Disclaimer:</strong>
			<br />
			The balances shown above may not represent all of the outstanding amounts due for this account.<br/>Tax types and years that are under agreement or
			tax types and years that are part of a bankruptcy filing will not appear.			
	</div>
	<!--<xml id="xmlCC" src="../xml/CCBilling.xml"></xml>
	<xml id="oAcctBalance" src="../xml/DelinquentForm.xml"></xml>
	<xml id="oAcctBalanceDelimited" src="../xml/DelinquentForm.xml"></xml>
	<xml id="oTemp" src=""></xml>-->
	<!--#Include File="../Inc/ispCoupon.js.htm"-->
</body>
</html>
