<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<html>
<head>
<!-- Bootstrap Core CSS -->
<link href="../Content/Styles/bootstrap.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="../Content/Styles/copegov.css" rel="stylesheet">
<link href="../Content/Styles/style.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css">


<script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>

<script type="text/javascript" language="javascript" src="../Content/Scripts/jquery-1.js"></script>

<script id="clientEventHandlersJS" type="text/javascript" language="javascript">
    var arrPart = new Array()
    var sPartName, sPartIdType, sPartID, sPartRel, sPartAddr1, sPartAddr2, sPartCity, sPartState;
    var sPartZip, iPartnerCount;
    var sPartZipExt = '';
    var iCurrPartRec = -1;
    //EHD - 20100528 - EGOVWEB-24 - Changed 1 Line
    var idx = 0;
    var bHavePartners = false, bOfficersAddressChanged = true, bOfficersRequired = false;

    var errPartners = '', initPartners = false;

    function DisplayPartners() {

        var ddPartTaxIDType = document.getElementById('ddPartTaxIDType');
        var ddRelationship = document.getElementById('ddRelationship');
        var ddPartBusState = document.getElementById('ddPartBusState');
        var txtHeader = document.getElementById('txtHeader');
        var txtPartName = document.getElementById('txtPartName');


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
        $('#AppMessageOfficer').html('<font class=lblTextRed>*</font> Required Fields');
        //$('#InstructionText').html(' for more information on completing this screen.');

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
                $(AppError).html(errPartners);
            }		//if
            var menuobj = parent.$(parent.document).find('#mnuAcctPartners').first();
            // parent.MenuProcessCurrent(menuobj);
        }		//if
    }		//DisplayPartners


    /////Sudipta'''''''
    function LoadPartnersError() {
        var i = 0;
        debugger;
        var txtPartName = document.getElementById('txtPartName');
        var ddPartTaxIDType = document.getElementById('ddPartTaxIDType');
        var txtPartTaxID = document.getElementById('txtPartTaxID');
        var ddRelationship = document.getElementById('ddRelationship');
        var txtPartAddr1 = document.getElementById('txtPartAddr1');
        var txtPartBusCity = document.getElementById('txtPartBusCity');
        var txtPartBusZip = document.getElementById('txtPartBusZip');
        var txtBusZip = document.getElementById('txtBusZip');
        var txtPartBusZipExt = document.getElementById('txtPartBusZipExt');


        arrPart[i++] = [txtPartName, '$(\'#txtPartName\').val()==""', 'Name required'];
        arrPart[i++] = [ddPartTaxIDType, '$("#ddPartTaxIDType option:selected").text()=="Select"', 'Select ID Type'];
        arrPart[i++] = [ddPartTaxIDType, 'CheckEIN_SSN()==false', 'SSN/EIN & ID combination are duplicated'];
        arrPart[i++] = [txtPartTaxID, '$(\'#txtPartTaxID\').val()==""', 'ID Required']
        arrPart[i++] = [txtPartTaxID, '$(\'#txtPartTaxID\').val().length != 9', 'Enter SSN/EIN Number'];
        arrPart[i++] = [txtPartTaxID, 'isNaN($(\'#txtPartTaxID\').val().replace(/-/g,""))==true', 'ID Not Numeric'];
        arrPart[i++] = [txtPartTaxID, 'CheckEIN_SSN()==false', 'SSN/EIN & ID combination are duplicated'];
        arrPart[i++] = [ddRelationship, '$("#ddRelationship option:selected").text()=="Select"', 'Select Relationship'];
        arrPart[i++] = [txtPartAddr1, '$(\'#txtPartAddr1\').val()==""', 'Address required'];
        arrPart[i++] = [txtPartBusCity, '$(\'#txtPartBusCity\').val()==""', 'City required'];
        arrPart[i++] = [txtPartBusZip, '$(\'#txtPartBusZip\').val()==""', 'Zip Required-Range 150 - 196'];
        arrPart[i++] = [txtPartBusZip, 'ispValidZipCode(document.getElementById(\'txtPartBusZip\'), document.getElementById(\'ddPartBusState\'), arrPart, i)', ''];
        arrPart[i++] = [txtPartBusZipExt, 'ispValidZipCode(document.getElementById(\'txtPartBusZipExt\'), document.getElementById(\'ddPartBusState\'), arrPart, i, true)', ''];

    }		//LoadPartnersError

    //''''''''''''''


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
                //if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', j) != '0') {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', j) != '' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', j) != '0') {
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', j) == '8' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', j) == '19') {
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
                                      '<td>' + sPartRel + '</td>' +
                                      '<td class="no_border_right" align="center">' + '<a  class="small_edit" id=' + sEdit + ' ' + 'idx=' + j + ' onclick="loadPartEditFrame()">' + 'Edit</a>' +
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
                    }
                }		//if
            }		//if
        }		//for

        sHTML = sHTML + '</TABLE>';
        if (bHavePartners == true) {

            sHTML = ' <table class="hor-zebra" summary="Partners/Officers Summary" style="float: left;"> ' +
             ' <thead><tr><th scope="col" width="25%">Partners/Officers Summary </th>' +
              '<th scope="col" width="22%">&nbsp;</th>' +
               '<th scope="col" width="40%">&nbsp;</th>' +
               ' <th scope="col" width="25%" class="no_border_right">&nbsp;</th></tr></thead>' +
               '<tbody><tr><td><strong>Name</strong></td>' +
                '<td><strong>Address</strong></td>' +
                '<td><strong>ID</strong></td>' +
                 '<td><strong>Position</strong></td>' +
                 ' <td class="no_border_right" align="left">&nbsp;</td></tr>' + sHTML;

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
        debugger;
        var ddPartTaxIDType = document.getElementById('ddPartTaxIDType');
        var ddRelationship = document.getElementById('ddRelationship');
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
        debugger;
        var txtPartName = document.getElementById('txtPartName');
        var ddPartTaxIDType = document.getElementById('ddPartTaxIDType');
        var txtPartTaxID = document.getElementById('txtPartTaxID');
        var ddRelationship = document.getElementById('ddRelationship');
        var txtPartAddr1 = document.getElementById('txtPartAddr1');
        var txtPartAddr2 = document.getElementById('txtPartAddr2');
        var txtPartBusCity = document.getElementById('txtPartBusCity');
        var ddPartBusState = document.getElementById('ddPartBusState');
        var txtPartBusZip = document.getElementById('txtPartBusZip');
        var txtPartBusZipExt = document.getElementById('txtPartBusZipExt');
        var btnPartAdd = document.getElementById('btnPartAdd');
        debugger;
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);

        iCurrPartRec = parent.$(source).attr('idx');
        loadPartValues(iCurrPartRec);

        for (j = 0; j < iPartnerCount; j++) {
            //eval('btnPartEdit' + j + '.disabled = true')
            eval('$("#btnPartEdit' + j + '").attr("disabled",true)');
        }		//for	

        btnPartAdd.value = 'Update';

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS FUNCTION_CODE', '', iCurrPartRec) == 'U' ||
                parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS FUNCTION_CODE', '', iCurrPartRec) == '') {
            //ddPartTaxIDType.className='inpDisabled'
            $('#ddPartTaxIDType').attr('class', 'inpDisabled');
            //ddPartTaxIDType.disabled=true
            $('#ddPartTaxIDType').attr('disabled', true);

            //txtPartTaxID.className='inpDisabled'
            $('#txtPartTaxID').attr('class', 'inpDisabled');
            //txtPartTaxID.disabled=true
            $('#txtPartTaxID').attr('disabled', true);

            //ddRelationship.className = 'inpDisabled'
            $('#ddRelationship').attr('class', 'inpDisabled');
            //ddRelationship.disabled = true
            $('#ddRelationship').attr('disabled', true);
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
        
        var txtPartName = document.getElementById('txtPartName');
        var ddPartTaxIDType = document.getElementById('ddPartTaxIDType');
        var txtPartTaxID = document.getElementById('txtPartTaxID');
        var ddRelationship = document.getElementById('ddRelationship');
        var txtPartAddr1 = document.getElementById('txtPartAddr1');
        var txtPartAddr2 = document.getElementById('txtPartAddr2');
        var txtPartBusCity = document.getElementById('txtPartBusCity');
        var ddPartBusState = document.getElementById('ddPartBusState');
        var txtPartBusZip = document.getElementById('txtPartBusZip');
        var txtPartBusZipExt = document.getElementById('txtPartBusZipExt');
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
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddPartTaxIDType option:selected").attr('CODE'), 'NAME_ADDRESS TYPE', '', iCurrPartRec)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPartTaxID.value.replace(/-/g, ''), 'NAME_ADDRESS ID', '', iCurrPartRec)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddRelationship option:selected").attr('CODE'), 'NAME_ADDRESS RELATIONSHIP_CODE', '', iCurrPartRec);
        }

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPartAddr1.value.substr(0, txtPartAddr1.maxLength), 'NAME_ADDRESS ADDRESS1', '', iCurrPartRec);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPartAddr2.value.substr(0, txtPartAddr1.maxLength), 'NAME_ADDRESS ADDRESS2', '', iCurrPartRec);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtPartBusCity.value, 'NAME_ADDRESS CITY', '', iCurrPartRec);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount,
                $("#ddPartBusState option:selected").attr('CODE'), 'NAME_ADDRESS STATE', '', iCurrPartRec);

        if (txtPartBusZipExt.value != '') {
            tmpZip = txtPartBusZip.value + '-' + txtPartBusZipExt.value;
        } else {
            tmpZip = txtPartBusZip.value;
        }		//if
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, tmpZip, 'NAME_ADDRESS ZIP', '', iCurrPartRec);

    }


    function clearPartEditFrame() {

        var txtPartName = document.getElementById('txtPartName');
        var ddPartTaxIDType = document.getElementById('ddPartTaxIDType');
        var txtPartTaxID = document.getElementById('txtPartTaxID');
        var ddRelationship = document.getElementById('ddRelationship');
        var txtPartAddr1 = document.getElementById('txtPartAddr1');
        var txtPartAddr2 = document.getElementById('txtPartAddr2');
        var txtPartBusCity = document.getElementById('txtPartBusCity');
        var ddPartBusState = document.getElementById('ddPartBusState');
        var txtPartBusZip = document.getElementById('txtPartBusZip');
        var txtPartBusZipExt = document.getElementById('txtPartBusZipExt');
        var btnPartAdd = document.getElementById('btnPartAdd');

        for (j = 0; j < iPartnerCount; j++) {
            //eval('btnPartEdit' + j + '.disabled = false')
            eval('$("#btnPartEdit' + j + '").removeAttr("disabled")');
        }		//for	

        $(AppError).text('');
        iCurrPartRec = -1;
        btnPartAdd.value = "Add";
        //	parent.NavWin.btnOfficers.style.backgroundColor = ''

        $('#ddPartTaxIDType').attr('class', 'form-control input-sm');
        $('#ddPartTaxIDType').removeAttr('disabled');
        $('#txtPartTaxID').attr('class', 'form-control input-sm');
        $('#txtPartTaxID').removeAttr('disabled');

        txtPartName.value = '';
        $('#txtPartName').attr('class', 'form-control input-sm');
        ddPartTaxIDType.selectedIndex = 0;
        txtPartTaxID.value = '';
        ddRelationship.selectedIndex = 0;
        $('#ddRelationship').attr('class', 'form-control input-sm');
        $('#ddRelationship').removeAttr('disabled');
        txtPartAddr1.value = '';
        $('#txtPartAddr1').attr('class', 'form-control input-sm');
        txtPartAddr2.value = '';
        $('#txtPartAddr2').attr('class', 'form-control input-sm');
        txtPartBusCity.value = '';
        $('#txtPartBusCity').attr('class', 'form-control input-sm');
        SetDDList(ddPartBusState, '', 'PA');
        $('#ddPartBusState').attr('class', 'form-control input-sm');
        txtPartBusZip.value = '';
        $('#txtPartBusZip').attr('class', 'form-control input-sm');
        txtPartBusZipExt.value = '';
        $('#txtPartBusZipExt').attr('class', 'form-control input-sm');
        errPartners = '';

        //SetSubmitButton();
    }

    function CheckEIN_SSN() {
        var ddPartTaxIDType=document.getElementById('ddPartTaxIDType');
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
       $(AppError).text('');
        return true;
    }		//CheckEIN_SSN

    function updatePart() {
        debugger;
        var btnPartAdd = document.getElementById('btnPartAdd');
        var strAddUpdate = btnPartAdd.value;
        LoadPartnersError();
        ValidatePart();
        //	CheckEIN_SSN()
        if ($(AppError).text() == '') {
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

    //''''Sudipta''''''''

    function ValidatePart() {
        debugger;
        ClearErrors();
        LoadPartnersError();
        errPartners = ispSetInputErr(arrPart);
        if ($('#AcctPartners').css('display') == 'block') {
            $(AppError).text(errPartners);
        }		//if

        if (errPartners == '') {
            //parent.$(parent.document).find('#imgSubmit').attr('disabled', 'true');//sanghamitra
            lbPartnerChanged = true;
            if (bOfficersAddressChanged != 'accepted') {
                bOfficersAddressChanged = true;
            }
        } else {
            bOfficersAddressChanged = false;
            //if
        }		//if
        // SetNavButtons();
        //  SetSubmitButton();
    }		//ValidatePart

    function AC_OfficersDisabled(bDisabled) {

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
        var txtPartAddr1 = document.getElementById('txtPartAddr1');
        var txtPartAddr2 = document.getElementById('txtPartAddr2');
        var txtPartBusCity = document.getElementById('txtPartBusCity');
        var ddPartBusState = document.getElementById('ddPartBusState');
        var txtPartBusZip = document.getElementById('txtPartBusZip');
        var txtPartBusZipExt = document.getElementById('txtPartBusZipExt');

        //EHD - 2008.12.01 - Added for the Code1 Addition
        txtPartAddr1.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address1', '', 0).substring(0, 30);
        txtPartAddr2.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address2', '', 0).substring(0, 30);
        txtPartBusCity.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'City', '', 0).substring(0, 20);
        SetDDList(ddPartBusState, '', parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'State', '', 0));
        txtPartBusZip.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Zip', '', 0);
        txtPartBusZipExt.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Zip4', '', 0);
    }		//AddressChangePopulate

    function Partners_Print(bPrint) {
        var ddPartTaxIDType = document.getElementById('ddPartTaxIDType');
        var ddRelationship = document.getElementById('ddRelationship');

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

    <title></title>
    </head>
<body>
<%--<div class="tab-content customtabs">--%>
    <div id="AcctPartners" style="display: none;" role="tabpanel" class="tab-pane active">
        <h2>Taxpayer Information  |   <span>Partners / Officers </span></h2>
        <div class="inner_white-panel">
            <div class="contentsection">
                <h4><span>Completing the Officer/Partner page is mandatory if registered as a Corporation, Partnership or Joint Venture.</span></h4><h4> <span style="color:red">Note:</span> Partners/Officers must include their Social Security Number; corporate partners must include the EIN of the corporation. </h4>
                 <h4><%--<a href="#" onclick="parent.InstructionLinks();">Click here</a> for more information on completing this screen.<br />  --%>             
                    <span style="color:red">*</span> Required fields</h4>
                 <%-- sudipta--%>
                 <div class="row">
                                                 <div class="col-lg-12 col-lg-offset-0 no-padding-left">
                                                  <div id="AppError" class="errormsg no-padding" style="display:block;">
                                                   </div>
                                                     </div>
                                             <%-- <div class="col-lg-12 col-xs-12 col-sm-12">
                                                  <form class="form-horizontal addressee_form">
                                                  <div class="" style="display:none">
                                                  
                                                   <h4>--%><%--<a href="#" onclick="parent.InstructionLinks();">Click here</a> for more information on completing this screen. Please review this instructions before completing this Application. </h4>--%>
                                                  <%--</div></form>
                                                  </div>--%>
                                                 
                                             </div>

                <%--'''''''--%>

                <div class="row">
                    <div class="col-lg-12 no-padding-left" id="AddrTable">
                        <div class="well custom_well" id="divOfficersInput">
                            <form class="form-horizontal addressee_form">
                                <div class="form-group">

                                    <label class="col-sm-3 control-label text-left-custom">Name<span style="color:red">*</span>  :  </label>

                                    <div class="col-sm-9">
                                        <input class="form-control input-sm" id="txtPartName"
                                            name="txtPartName" maxlength="40" onchange="ValidatePart()">
                                    </div>

                                </div>

                                <div class="form-group">

                                    <label class="col-sm-3 control-label text-left-custom">SSN/EIN <span style="color:red">*</span> : </label>

                                    <div class="col-sm-3 below_margin01">
                                        <select class="form-control" id="ddPartTaxIDType" name="ddPartTaxIDType"
                                            onchange="ValidatePart()">
                                        </select>
                                        <%-- <span class="mandatory_Arrow">&nbsp;&nbsp;*</span>--%>
                                    </div>
                                    <div class="col-sm-6">
                                        <input class="form-control input-sm" id="txtPartTaxID" name="txtPartTaxID" maxlength="9"
                                            onchange="ValidatePart()">
                                    </div>

                                </div>

                                <div class="form-group">

                                    <label class="col-sm-3 control-label text-left-custom">Relationship <span style="color:red">*</span> :</label>

                                    <div class="col-sm-9">
                                        <select class="form-control input-sm" id="ddRelationship" name="ddRelationship"
                                            onchange="ValidatePart()">
                                        </select>

                                    </div>
                                </div>

                                <div class="form-group">

                                    <label class="col-sm-3 control-label text-left-custom">Address <span style="color:red">*</span>  :  </label>

                                    <div class="col-sm-9">

                                        <input class="form-control input-sm" id="txtPartAddr1" name="txtPartAddr1" maxlength="30"
                                            onchange="ValidatePart()"><br>
                                        <input class="form-control input-sm" id="txtPartAddr2" name="txtPartAddr2" maxlength="30"
                                            onchange="ValidatePart()">
                                    </div>

                                </div>


                                <div class="form-group">

                                    <label class="col-sm-3 control-label text-left-custom">City/State/Zip<span style="color:red">*</span>:</label>
                                    <div class="col-sm-2">
                                        <input class="form-control input-sm" id="txtPartBusCity" maxlength="20" name="txtPartBusCity" onchange="ValidatePart()">
                                        <%-- <span class="mandatory_Arrow">*</span>--%>
                                    </div>
                                    <div class="col-sm-2">
                                        <select class="form-control input-sm" id="ddPartBusState" name="ddPartBusState" onchange="ValidatePart()">
                                        </select>
                                    </div>
                                    <div class="col-sm-2">
                                        <%-- <span class="mandatory_Arrow">*</span>--%>
                                        <input class="form-control input-sm" id="txtPartBusZip" maxlength="5" name='txtPartBusZip"'
                                            onchange="ValidatePart()">
                                        <%-- <span class="mandatory_Arrow">-</span>  --%>
                                    </div>
                                    <div class="col-sm-2">
                                        <input class="form-control input-sm" id="txtPartBusZipExt" maxlength="4" name='txtPartBusZipExt"'
                                            onchange="ValidatePart()">
                                    </div>

                                </div>




                                <div class="form-group">

                                    <div class="col-sm-offset-3 col-sm-9">
                                        <input class="btn btn-default submit_button_light" type="button" id="btnPartAdd" onclick="updatePart()" value="Add" /><input class="btn btn-default submit_button" type="button" id="btnPartCancel" onclick="    clearPartEditFrame()" value="Cancel" />

                                    </div>

                                    <div class="clear"></div>
                                    
                                </div>
                            </form>
                        </div>
                    </div>
                    <div id="divOfficersGrid" style="display: block;" class="table table-condensed table-striped custom_table01">
                    </div>

                    <div class="clear"></div>
                    <br />
                    <div id="divOfficersMsgs" style="display: none;" class="divOfficer_sMsgs">
                  
                                <h4 style="color:red;">
                <b>Warning</b> - You are registering with a Social Security Number so no Officers or Partners are allowed.</h4> </div>
                     <div class="form-group" id="divbtnSubmit" style="display: block">
                        <div class="col-sm-offset-3 col-sm-5  text-right">                                                               
                            <a class="btn btn-default submit_button" onclick="DoSubmit()" id="imgSubmit">Submit</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clear"></div>


        </div>



        <div class="clear"></div>
      <%--  <br />--%>
        <%--   <div class="quicklink_btm_gen"></div>--%>
    </div>
<%--</div>--%>

      </body>
</html>    
