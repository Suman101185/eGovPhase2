<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
<%--     <link href="../Content/Styles/framestyle.css" rel="stylesheet" type="text/css" />--%>

    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
    
    <script type="text/javascript" language="javascript" src="../Content/Scripts/jquery-1.js"></script>
    <title></title>
    <script ID="clientEventHandlersJS" type="text/javascript" LANGUAGE="javascript">
        var arrPart = new Array()
        var sPartName, sPartIdType, sPartID, sPartRel, sPartAddr1, sPartAddr2, sPartCity, sPartState;
        var sPartZip, iPartnerCount;
        var sPartZipExt = '';
        var iCurrPartRec = -1;
        //EHD - 20100528 - EGOVWEB-24 - Changed 1 Line
        var bHavePartners = false, bOfficersAddressChanged = true, bOfficersRequired = false;

        var errPartners = '', initPartners = false;

        function DisplayPartners() {
            AC_Form = 'PARTNERS';
            if (initPartners == false) {
                LoadGenericDD(parent.$g.xmlEntityType, ddPartTaxIDType, "DDOWN", false);
                LoadGenericDD(parent.$g.xmlRelationships, ddRelationship, "DDOWN", false);
                ispLoadZipCode(ddPartBusState, true);
                ddPartBusState.selectedIndex = 0;
                LoadPartnersError();
                CreatePartnersTable();
            }		//if

            $('#AppHeaderOfficer').html(txtHeader + '<Font class=hdrMedium>|partners/officers</Font>');
            parent.gsInstructionItem = '#Officer';
            $('#AppMessageOfficer').html(parent.gsInstructionText +
                     '<BR><font class=lblTextRed>*</font> Required Fields');
            $('#InstructionText').html(' for more information on completing this screen.');

            CurrentLayer = 'AcctPartners';
            //AcctPartners.style.display = 'block';
            $('#AcctPartners').css('display', 'block');

            //divOfficersMsgs.style.display = 'none'
            $('#divOfficersMsgs').css('display', 'none');
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == 2) {		//SSN
                $('#AppMessageOfficer').css('display', 'none');//Sanghamitra
                //divOfficersInput.style.display = 'none'
                $('#divOfficersInput').css('display', 'none');
                //divOfficersGrid.style.display = 'none'
                $('#divOfficersGrid').css('display', 'none');
                //divOfficersMsgs.style.display = 'block'
                $('#divOfficersMsgs').css('display', 'block');

            } else {
                SetDDList(ddPartBusState, '', 'PA');
                txtPartName.focus();
              
                if (bOfficersRequired == true) {  //bin
                    errPartners = 'Filling up officer/partner detail is mandatary';
                }
                if (errPartners != '') {
                    $(parent.AppError).html(errPartners);
                }		//if
                var menuobj = parent.$(parent.document).find('#mnuAcctPartners').first();
               // parent.MenuProcessCurrent(menuobj);
            }		//if
        }		//DisplayPartners


        function LoadPartnersError() {
            var i = 0

            arrPart[i++] = [txtPartName, 'txtPartName.value==""', 'Name required'];
            arrPart[i++] = [ddPartTaxIDType, 'parent.$(ddPartTaxIDType.options[ddPartTaxIDType.selectedIndex]).text()=="Select"', 'Select ID Type'];
            arrPart[i++] = [ddPartTaxIDType, 'CheckEIN_SSN()==false', 'SSN/EIN & ID combination are duplicated'];
            arrPart[i++] = [txtPartTaxID, 'txtPartTaxID.value==""', 'ID Required']
            arrPart[i++] = [txtPartTaxID, 'txtPartTaxID.value.length != 9', 'Enter SSN/EIN Number'];
            arrPart[i++] = [txtPartTaxID, 'isNaN(txtPartTaxID.value.replace(/-/g,""))==true', 'ID Not Numeric'];
            arrPart[i++] = [txtPartTaxID, 'CheckEIN_SSN()==false', 'SSN/EIN & ID combination are duplicated'];
            arrPart[i++] = [ddRelationship, 'parent.$(ddRelationship.options[ddRelationship.selectedIndex]).text()=="Select"', 'Select Relationship'];
            arrPart[i++] = [txtPartAddr1, 'txtPartAddr1.value==""', 'Address required'];
            arrPart[i++] = [txtPartBusCity, 'txtPartBusCity.value==""', 'City required'];
            arrPart[i++] = [txtPartBusZip, 'ispValidZipCode(txtPartBusZip, ddPartBusState, arrPart, i)', ''];
            arrPart[i++] = [txtPartBusZipExt, 'ispValidZipCode(txtPartBusZipExt, ddPartBusState, arrPart, i, true)', ''];
        }		//LoadPartnersError


        function CreatePartnersTable() {
            var sHTML = '';
            var iRow = 0;
            var sRowClass = 'rowDataOdd';
            var bShow = false;

            //alert ('trying to build table')
            //step 1) header table
            //suman -------
            //divOfficersGrid.innerHTML = ''	
            //parent.$('#divOfficersGrid').html('');//Sangha
            $('#divOfficersGrid').html('');//Sangha
            //--------------
            iCount = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '');
            iPartnerCount = 0;
            //alert(parent.$g.xmlAccount.xml)

            for (j = 0; j < iCount; j++) {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j) == '60') {
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', j) != '0') {
                        //				if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS/NAME', '', j) != '') {
                        loadPartValues(j);
                        bHavePartners = true;
                        sEdit = 'btnPartEdit' + iPartnerCount;
                        iRow++;
                        sHTML = sHTML + '<tr class=' + setRow(iRow) + '>';

                        sHTML = sHTML + '<td>' + sPartName + '</td>' +
                                     
                                      '<td>' + sPartAddr1 + ' ' +
                                      sPartAddr2 + '   ' + sPartCity + ', ' + sPartState + ' ' + sPartZip + '-' + sPartZipExt + '</td>' +
                                      '<td>' + sPartIdType + ':' + sPartID + '</td>' +
                                      '<td>' + sPartRel +  '</td>' +
                                      '<td class="no_border_right" align="center">' + '<a  class="small_edit" id=' + sEdit + ' '+ 'idx=' + j + ' onclick="loadPartEditFrame()">' + 'Edit</a>' +
                                      '</td></TR>';

                        //sHTML = sHTML + '<td align=left><p class=lblTextBlack style="MARGIN-LEFT: 5px">' + sPartName + '&nbsp;</p></td>' +
                        //                '<td class=celLeft align=left><p class=lblTextBlack style="MARGIN-LEFT: 5px">' + sPartAddr1 + ' ' +
                        //                sPartAddr2 + '   ' + sPartCity + ', ' + sPartState + ' ' + sPartZip + '-' + sPartZipExt + '&nbsp;</p></td>' +
                        //                '<td class=celLeft align=left><p class=lblTextBlack style="MARGIN-LEFT: 5px">' +
                        //                sPartIdType + ': ' + sPartID + '</p></td>' +
                        //                '<td class=celLeft align=left><p class=lblTextBlack style="MARGIN-LEFT: 5px">' +
                        //                sPartRel + '&nbsp;</p></td>' +
                        //                '<td class=celLeft align=middle>' +
                        //                '<input type=button class=btnSmall value="Edit"  id=' + sEdit + ' name=' + sEdit +
                        //                ' idx=' + j + ' onclick="loadPartEditFrame()"></INPUT></td></TR>';
                        ++iPartnerCount;
                        //				}		//if
                    }		//if
                }		//if
            }		//for

            sHTML = sHTML + '</TABLE>';
            if (bHavePartners == true) {

                sHTML = ' <table class="hor-zebra" summary="Partners/Officers Summary"> ' +
                 ' <thead><tr><th scope="col" width="25%">Partners/Officers Summary </th>' +
                  '<th scope="col" width="45%">&nbsp;</th>' +
                   '<th scope="col" width="45%">&nbsp;</th>' +
                   ' <th scope="col" width="15%" class="no_border_right">&nbsp;</th></tr></thead>' +
                   '<tbody><tr><td><strong>Name</strong></td>' +
                    '<td><strong>Address</strong></td>' +
                    '<td><strong>ID</strong></td>' +
                     '<td><strong>Position</strong></td>' +
                     ' <td class="no_border_right" align="center">&nbsp;</td></tr>' + sHTML;
             

                //sHTML = '<table class=tblNormal width="95%" cellSpacing="0" cellPadding="0" style="MARGIN-TOP: 5px; MARGIN-LEFT: 20px">' +
                //    '<tr><td width="35%"><hr width="100%">&nbsp;</hr></td>' +
                //    '<td width="30%" align=middle class=lblTextBold>Partners/Officers Summary</td>' +
                //    '<td width="35%"><hr width="100%">&nbsp;</hr></td></hr></tr></table>' +
                //    '<table class=tblNormal width="95%" cellSpacing="0" cellPadding="0" style="MARGIN-LEFT: 20px">' +
                //    '<tr class=rowHeader><td width="15%"><p class=lblTextBold align=middle>Name</p></td>' +
                //    '<td class=celLeft width="42%"><p class=lblTextBold align=middle>Address</p></td>' +
                //    '<td class=celLeft width="18%"><p class=lblTextBold align=middle>ID</p></td>' +
                //    '<td class=celLeft width="15%"><p class=lblTextBold align=middle>Position</p></td>' +
                //    '<td class=celLeft width="10%"><p class=lblTextBold align=middle>&nbsp;</p></td></tr>' + sHTML;
                $('#divOfficersGrid').html(sHTML);//Sanghamitra
                $('#divOfficersGrid').css('display', 'block');//Sanghamitra
            }		//if
            bHavePartners = false;
        }		//CreatePartnersTable

        function setRow(iRow) {
            if (iRow % 2 == 0) {
                return '';
            } else {
                return 'odd';
            }		//if
        }		//setRow

        function loadPartValues(j) {

            sPartName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', j);
            sPartIdType = GetDesc(ddPartTaxIDType, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TYPE', '', j));
            sPartID = FormatSsnEin(sPartIdType,
                    parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ID', '', j));
            //EGOVWEB-67
            if (sPartIdType == "SSN") {
                sPartID = 'XXX-XX-XX' + sPartID.substr(9);
            } else {
                sPartID = 'XX-XXXXX' + sPartID.substr(8);
            }		//if
            sPartRel = GetDesc(ddRelationship, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', j));
            sPartAddr1 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', j);
            sPartAddr2 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', j);
            sPartCity = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', j);
            sPartState = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', j);
            sPartZip = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', j), 0, 5);
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', j).indexOf("-") != -1) {
                sPartZipExt = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', j), 6, 4);
            }		//if
        }		//loadPartValues


        function loadPartEditFrame() {
            var evt = window.event || arguments.callee.caller.arguments[0];
            var source = parent.getEventSource(evt);

            iCurrPartRec = parent.$(source).attr('idx');
            loadPartValues(iCurrPartRec);

            for (j = 0; j < iPartnerCount; j++) {
                //eval('btnPartEdit' + j + '.disabled = true')
                eval('$("#btnPartEdit' + j + '").attr("disabled","true")');
            }		//for	

            btnPartAdd.value = 'Update';

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS FUNCTION_CODE', '', iCurrPartRec) == 'U' ||
                    parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS FUNCTION_CODE', '', iCurrPartRec) == '') {
                //ddPartTaxIDType.className='inpDisabled'
                $('#ddPartTaxIDType').attr('class', 'inpDisabled');
                //ddPartTaxIDType.disabled=true
                $('#ddPartTaxIDType').attr('disabled', 'true');

                //txtPartTaxID.className='inpDisabled'
                $('#txtPartTaxID').attr('class', 'inpDisabled');
                //txtPartTaxID.disabled=true
                $('#txtPartTaxID').attr('disabled', 'true');

                //ddRelationship.className = 'inpDisabled'
                $('#ddRelationship').attr('class', 'inpDisabled');
                //ddRelationship.disabled = true
                $('#ddRelationship').attr('disabled', 'true');
            }		//if

            txtPartName.value = sPartName;
            SetDDList(ddPartTaxIDType, 'innerText', sPartIdType, '');
            txtPartTaxID.value = sPartID.replace(/-/g, '');
            SetDDList(ddRelationship, 'innerText', sPartRel, '');
            txtPartAddr1.value = sPartAddr1;
            txtPartAddr2.value = sPartAddr2;
            txtPartBusCity.value = sPartCity;
            SetDDList(ddPartBusState, 'innerText', sPartState, '');
            txtPartBusZip.value = sPartZip;
            txtPartBusZipExt.value = sPartZipExt;
            txtPartName.focus();
        }


        function popPartXml(sAction) {
            //var xmlTemp = new ActiveXObject("MSXML.DOMDocument")
            var xmlTemp = parent.$g.getXmlDocObj();

            var sAction, tmpZip
            //xmlTemp.loadXML(parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, 'NAME_ADDRESS', 0))
            xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, 'NAME_ADDRESS', 0);
            sAction = 'A';
            //	sType = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'ENTITY_INFO/TYPE', '', 0)
            //	sID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount,'ENTITY_INFO/ENTITY_ID', '', 0)

            if (iCurrPartRec == -1) {
                iCurrPartRec = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '');		// - 1
                parent.$x.ispAppendNodeXml(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp,
                        'NAME_ADDRESS', 0);

            } else {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS FUNCTION_CODE', '', iCurrPartRec) != 'A') {
                    sAction = 'U';
                }		//if
            }		//if

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, sAction, 'NAME_ADDRESS FUNCTION_CODE', '', iCurrPartRec);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 60, 'NAME_ADDRESS ADDRESS_TYPE', '', iCurrPartRec);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPartName.value, 'NAME_ADDRESS NAME', '', iCurrPartRec);
            //EGOVWEB-67 Mask SSN
            if (sAction != 'U') {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(ddPartTaxIDType.options[ddPartTaxIDType.selectedIndex]).attr('CODE'), 'NAME_ADDRESS TYPE', '', iCurrPartRec)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPartTaxID.value.replace(/-/g, ''), 'NAME_ADDRESS ID', '', iCurrPartRec)
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(ddRelationship.options[ddRelationship.selectedIndex]).attr('CODE'), 'NAME_ADDRESS RELATIONSHIP_CODE', '', iCurrPartRec);
            }		//if
            //	parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, ddPartTaxIDType.options(ddPartTaxIDType.selectedIndex).CODE, 'NAME_ADDRESS/TYPE', '', iCurrPartRec)	
            //	parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPartTaxID.value.replace(/-/g,''), 'NAME_ADDRESS/ID', '', iCurrPartRec)	
            //	parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, ddRelationship.options(ddRelationship.selectedIndex).CODE, 'NAME_ADDRESS/RELATIONSHIP_CODE', '', iCurrPartRec)	
            //EGOVWEB-83
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPartAddr1.value.substr(0, txtPartAddr1.maxLength), 'NAME_ADDRESS ADDRESS1', '', iCurrPartRec);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPartAddr2.value.substr(0, txtPartAddr1.maxLength), 'NAME_ADDRESS ADDRESS2', '', iCurrPartRec);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPartBusCity.value, 'NAME_ADDRESS CITY', '', iCurrPartRec);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount,
                    parent.$(ddPartBusState.options[ddPartBusState.selectedIndex]).attr('CODE'), 'NAME_ADDRESS STATE', '', iCurrPartRec);

            if (txtPartBusZipExt.value != '') {
                tmpZip = txtPartBusZip.value + '-' + txtPartBusZipExt.value;
            } else {
                tmpZip = txtPartBusZip.value;
            }		//if
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, tmpZip, 'NAME_ADDRESS ZIP', '', iCurrPartRec);
            //	loadPartXml(xmlTemp)
        }		//popPartXml

        /*
        function loadPartXml(xmlTemp) {
        var lastIdx
        
            if (iCurrPartRec!=0) {
                parent.$x.ispXmlReplaceNode(parent.$g.xmlAccount,'NAME_ADDRESS',iCurrPartRec,xmlTemp,'NAME_ADDRESS',0)
            } else {
                if (bHavePartners==true) {
                    lastIdx = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, "NAME_ADDRESS", "n") -1
                    parent.$x.ispAppendNodeXml(parent.$g.xmlAccount,'NAME_ADDRESS',lastIdx,xmlTemp,'NAME_ADDRESS',0)
                } else {
                    parent.$x.ispXmlReplaceNode(parent.$g.xmlAccount,'NAME_ADDRESS',0,xmlTemp,'NAME_ADDRESS',0)
                }	
            }	
        }
        */

        function clearPartEditFrame() {

            for (j = 0; j < iPartnerCount; j++) {
                //eval('btnPartEdit' + j + '.disabled = false')
                eval('$("#btnPartEdit' + j + '").removeAttr("disabled")');
            }		//for	

            $(parent.AppError).text('');
            iCurrPartRec = -1;
            btnPartAdd.value = "Add";
            //	parent.NavWin.btnOfficers.style.backgroundColor = ''

            $('#ddPartTaxIDType').attr('class', 'inpNormal');
            $('#ddPartTaxIDType').removeAttr('disabled');
            $('#txtPartTaxID').attr('class', 'inpNormal');
            $('#txtPartTaxID').removeAttr('disabled');

            txtPartName.value = '';
            $('#txtPartName').attr('class', 'inpNormal');
            ddPartTaxIDType.selectedIndex = 0;
            txtPartTaxID.value = '';
            ddRelationship.selectedIndex = 0;
            $('#ddRelationship').attr('class', 'inpNormal');
            $('#ddRelationship').removeAttr('disabled');
            txtPartAddr1.value = '';
            $('#txtPartAddr1').attr('class', 'inpNormal');
            txtPartAddr2.value = '';
            $('#txtPartAddr2').attr('class', 'inpNormal');
            txtPartBusCity.value = '';
            $('#txtPartBusCity').attr('class', 'inpNormal');
            SetDDList(ddPartBusState, '', 'PA');
            $('#ddPartBusState').attr('class', 'inpNormal');
            txtPartBusZip.value = '';
            $('#txtPartBusZip').attr('class', 'inpNormal');
            txtPartBusZipExt.value = '';
            $('#txtPartBusZipExt').attr('class', 'inpNormal');
            errPartners = '';
           
            //SetSubmitButton();
        }

        function CheckEIN_SSN() {

            lsEntType = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0);
            lsEntID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0);
            lsPartType = $(ddPartTaxIDType.options[ddPartTaxIDType.selectedIndex]).attr('CODE');
            lsPartID = $('#txtPartTaxID').val().replace(/-/g, '');

            if (lsPartID == lsEntID && lsPartType == lsEntType) {
                return false;
            }		//if

            if (iPartnerCount != 0) {
                for (j = 0; j < iPartnerCount + 1; j++) {
                    if (iCurrPartRec != j) {
                        lsEntType = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS TYPE', '', j);
                        lsEntID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ID', '', j);
                        if (lsPartID == lsEntID && lsPartType == lsEntType) {
                            return false;
                        }		//if
                    }		//if
                }		//for	
            }		//if

            $('#ddPartTaxIDType').attr('class', 'inpNormal');
            $('#txtPartTaxID').attr('class', 'inpNormal');
            $(parent.AppError).text('');
            return true;
        }		//CheckEIN_SSN

        function updatePart() {
            var strAddUpdate = btnPartAdd.value;
            ValidatePart();
            //	CheckEIN_SSN()
            if ($(parent.AppError).text() == '') {
                //Code1 Validation
                if (bOfficersAddressChanged == true) {
                    if (ac_CheckAddress() == false) {
                        return;
                    }		//if
                }		//if
                //End Code1 Validation
                popPartXml();
                CreatePartnersTable();
                clearPartEditFrame();
               
                if (strAddUpdate == 'Add') {
                    IsOfficerShown = true;
                    bOfficersRequired = false;
                }
                else {
                    IsOfficerShown = true;
                }
            }
            //if
        }		//updatePart

        function ValidatePart() {
            errPartners = ispSetInputErr(arrPart);
            if ($('#AcctPartners').css('display') == 'block') {
                $(parent.AppError).text(errPartners);
            }		//if

            if (errPartners != '') {
                //parent.$(parent.document).find('#imgSubmit').attr('disabled', 'true');//sanghamitra
            } else {
                lbPartnerChanged = true;
                if (bOfficersAddressChanged != 'accepted') {
                    bOfficersAddressChanged = true;
                }		//if
            }		//if
           // SetNavButtons();
          //  SetSubmitButton();
        }		//ValidatePart

        function AC_OfficersDisabled(bDisabled) {
            /*
                    txtPartName.disabled = bDisabled
            //	ddPartTaxIDType.disabled = bDisabled
            //	txtPartTaxID.disabled = bDisabled
            //	ddRelationship.disabled = bDisabled
                txtPartAddr1.disabled = bDisabled
                txtPartAddr2.disabled = bDisabled
                txtPartBusCity.disabled = bDisabled
                ddPartBusState.disabled = bDisabled
                txtPartBusZip.disabled = bDisabled
                txtPartBusZipExt.disabled = bDisabled
            
                */
            if (bDisabled == true) {
                $('#txtPartName').attr('disabled', 'true');

                //	ddPartTaxIDType.disabled = bDisabled
                //	txtPartTaxID.disabled = bDisabled
                //	ddRelationship.disabled = bDisabled

                $('#txtPartAddr1').attr('disabled', 'true');
                $('#txtPartAddr2').attr('disabled', 'true');
                $('#txtPartBusCity').attr('disabled', 'true');
                $('#ddPartBusState').attr('disabled', 'true');
                $('#txtPartBusZip').attr('disabled', 'true');
                $('#txtPartBusZipExt').attr('disabled', 'true');
            }
            else {
                $('#txtPartName').removeAttr('disabled');

                //	ddPartTaxIDType.disabled = bDisabled
                //	txtPartTaxID.disabled = bDisabled
                //	ddRelationship.disabled = bDisabled

                $('#txtPartAddr1').removeAttr('disabled');
                $('#txtPartAddr2').removeAttr('disabled');
                $('#txtPartBusCity').removeAttr('disabled');
                $('#ddPartBusState').removeAttr('disabled');
                $('#txtPartBusZip').removeAttr('disabled');
                $('#txtPartBusZipExt').removeAttr('disabled');

            }

            if (bDisabled == true) {
                $('#ddPartBusState').css('visibility', 'hidden');
                $('#ddPartTaxIDType').css('visibility', 'hidden');
                $('#ddRelationship').css('visibility', 'hidden');
            } else {
                $('#ddPartBusState').css('visibility', 'visible');
                $('#ddPartTaxIDType').css('visibility', 'visible');
                $('#ddRelationship').css('visibility', 'visible');

            }		//if
        }		//AC_AddressDisable

        function AC_OfficersChangePopulate() {
            //EHD - 2008.12.01 - Added for the Code1 Addition
            txtPartAddr1.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address1', '', 0).substring(0, 30);
            txtPartAddr2.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address2', '', 0).substring(0, 30);
            txtPartBusCity.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'City', '', 0).substring(0, 20);
            SetDDList(ddPartBusState, '', parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'State', '', 0));
            txtPartBusZip.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Zip', '', 0);
            txtPartBusZipExt.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Zip4', '', 0);
        }		//AddressChangePopulate

        function Partners_Print(bPrint) {
            if (bPrint == true) {
                LoadGenericDD(parent.$g.xmlEntityType, ddPartTaxIDType, "DDOWN", false);
                LoadGenericDD(parent.$g.xmlRelationships, ddRelationship, "DDOWN", false);
                //AcctPartners.style.display = 'block'
                $('#AcctPartners').css('display', 'block');
                //divOfficersGrid.style.display = 'block'
                $('#divOfficersGrid').css('display', 'block');
                //divOfficersInput.style.display = 'none'
                $('#divOfficersInput').css('display', 'none');
                //PrintPartnersHdr.style.display = 'block'
                $('#PrintPartnersHdr').css('display', 'block');
                CreatePartnersTable()
            } else {
                //divOfficersInput.style.display = 'block'
                $('#divOfficersInput').css('display', 'block');
                //PrintPartnersHdr.style.display = 'none'
                $('#PrintPartnersHdr').css('display', 'none');
            } 	//if
        } 	//Address_Print
</script>
</head>
<body>


    <div id="AcctPartners" style="DISPLAY: none;" class="tab_content">
        		 <h2 id="AppHeaderOfficer"></h2>
                <div class="taxpyer_address">
            	<h4 id="AppMessageOfficer"></h4>
              
              <div class="greyborderbox" id="divOfficersInput">
              
              <div class="form_segment">
                        
                        <label>Name*  :  </label>
                        
                        <div class="here_input">
                           
                           <INPUT class='input_size3' id="txtPartName" 
				name="txtPartName" maxlength=40 size=48 onchange="ValidatePart()">
                             <div class="clear"></div>
                         
                        </div>
                                                
                        <div class="clear"></div>
              
              </div>
              
              <div class="form_segment">
                        
                        <label>SSN/EIN * : </label>
                        
                        <div class="here_input">
                            <SELECT class='input_size2' id="ddPartTaxIDType" name="ddPartTaxIDType" 
				style="WIDTH: 80px" onchange="ValidatePart()"></SELECT>
                       <span class="mandatory_Arrow">&nbsp;&nbsp;*</span>
			<INPUT class="input_size2" id=txtPartTaxID name="txtPartTaxID" maxlength=9 size=11
					onchange="ValidatePart()">

                       
                            <div class="clear"></div>
                        </div>
                                                
                        <div class="clear"></div>
              
              </div>
              
              <div class="form_segment">
                        
                        <label>Relationship * :</label>
                        
                        <div class="here_input">
                        
                            <SELECT class="input_size3" id="ddRelationship" name="ddRelationship" 
				style="WIDTH: 160px" onchange="ValidatePart()"></SELECT>
                          
                               <div class="clear"></div>                        
                        </div>
                        <div class="clear"></div>
                       
                   
              
              </div>
              
              <div class="form_segment">
                        
                        <label>Address *  :  </label>
                        
                        <div class="here_input">
        
                            <INPUT class='bottom_margin input_size3' id="txtPartAddr1" name="txtPartAddr1" maxlength=30 size=35 
				onchange="ValidatePart()">
                         <INPUT class="bottom_margin input_size3" id="txtPartAddr2" name="txtPartAddr2" maxlength=30 size=35
				onchange="ValidatePart()">
                            <div class="clear"></div>
                        </div>
                                                
                        <div class="clear"></div>
              
              </div>


                  <div class="form_segment">
                        
                        <label>City/State/Zip*:</label>
                      <div class="here_input">
                                 <INPUT class='inpNormal' id="txtPartBusCity" maxLength=20 name=txtPartBusCity size=23 onchange="ValidatePart()">
                       <span class="mandatory_Arrow">*</span>
			<SELECT class='input_size1' id="ddPartBusState" name=ddPartBusState style="WIDTH: 50px" onchange="ValidatePart()"> 
					</SELECT>
                                <span class="mandatory_Arrow">*</span>
                                 <INPUT class='inpNormal' id="txtPartBusZip" maxLength=5 size=6 name='txtPartBusZip"' 
					onchange="ValidatePart()">
                             <span class="mandatory_Arrow">-</span>                          
                            <INPUT class='inpNormal' id="txtPartBusZipExt" maxLength=4 size=5 name='txtPartBusZipExt"' 
					onchange="ValidatePart()">
                            <div class="clear"></div>
                        </div>
                       
                        
                       
                        
                        <div class="clear"></div>
              
              </div>
              
             
              
            
            
               <div class="form_segment scnd_additional_margin" style="width:100%">
                       
                       <div class="here_input" style="width:136%">
                            <input class="submit_button_light" type="button" id="btnPartAdd" onclick="updatePart()" value="Add" /><input class="submit_button" type="button" id="btnPartCancel" onclick="    clearPartEditFrame()" value="Cancel"/>
                         
                        </div>
                      
                        <div class="clear"></div>
              <div class="clear"></div>
                    </div>
              
              </div>
              
               
            
            
            </div>
            <div class="clear"></div>
            <div id="divOfficersGrid" style="DISPLAY: block; ">
</div>


        <div id="divOfficersMsgs" class="divOfficer_sMsgs" style="DISPLAY: none;">
<h4>
	<b>Warning</b> - You are registering with a Social Security Number so no Officers or Partners are allowed.</h4>
</div>
       


			<div class="clear"></div>
            <br />
     <%--   <div class="quicklink_btm_gen"></div>--%>
        </div>

</body>
</html>
