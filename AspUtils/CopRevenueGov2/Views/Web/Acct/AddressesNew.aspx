<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>


<script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>

<script type="text/javascript" language="javascript" src="../Content/Scripts/jquery-1.js"></script>
<!-- Bootstrap Core CSS -->
<link href="../Content/Styles/bootstrap.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="../Content/Styles/copegov.css" rel="stylesheet">
<link href="../Content/Styles/style.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css">


<script id="clientEventHandlersJS" language="javascript" type="text/javascript">
    //EHD - 20100609 - EGOVWEB-28

    var arrAddr = new Array();
    var bHaveAddresses = false;
    var iCurrAddrRec = -1;
    var sAddr1, sAddr2, sCity, sState, sZip, sZipExt, iAreaCode, iPhone1, iPhone2, iPhoneExt, sAddrType;
    var iFaxAreaCode, iFax1, iFax2, sAttn, iCount, sEdit, iAddressCount;
    var errAddresses = '', initAddresses = false, sZipExt = '';
    var sInitAddrType, iInitAddrIndex;
    var strAddr1 = "", strAddr2 = "", strAddrType = "";
    var iAltAddressIdx = '', bAddrAddressChanged = true, bAddrRequired = false;
    var xmlAddressType2 = parent.$g.getXmlDocObj();


    $(document).ready(function () {

        parent.$g.loadXmlSync("XML/AddressType2", parseXml_xmlAddresstype2);

    });


    function parseXml_xmlAddresstype2(xml) {
        xmlAddressType2.xml = xml;
    }

    function DisplayAddresses() {


        AC_Form = 'ADDRESSES';
        var ddAddrType = document.getElementById('ddAddrType');
        var ddAddrBusState = document.getElementById('ddAddrBusState');
        var txtAddr1 = document.getElementById('txtAddr1');
        var txtHeader = document.getElementById('txtHeader');


        //	CreateAltAddr()
        if (initAddresses == false) {
            LoadGenericDD(xmlAddressType2, ddAddrType, "DDOWN", false);
            ispLoadZipCode(ddAddrBusState, true);
            LoadAddressErrors();
            CreateAddressTable();
            $('#ddAddrType').attr('disabled', 'true');
        }
        else {
            ad_CorrectBLAddress();
        }		//if


        //	if (initAddresses == false) {
        //	CreateAddressTable()
        //	}		//if

        if (ddAddrType.length == 0) {
            LoadGenericDD(xmlAddressType2, ddAddrType, "DDOWN", false);
        }		//if

        $('#AppHeaderAddress').html(txtHeader + '<Font class=hdrMedium>|addresses</Font>');
        parent.gsInstructionItem = '#Address';
        $('#AppMessageAddress').html(parent.gsInstructionText + '<BR><font class="lblTextRed">*</font> Required Fields');
        $('#InstructionText').html(' for more information on completing this screen.');


        CurrentLayer = 'AcctAddresses';
        $('#AcctAddresses').css("display", 'block');
        SetDDList(ddAddrBusState, '', 'PA');
        txtAddr1.focus();

        var mnuobj = $(parent.document).find('#mnuAcctAddresses').first();
        // parent.MenuProcessCurrent(mnuobj);
        if (bAddrRequired == true) {
            errAddresses = 'Please enter your secondary address';
        }
        if (errAddresses != '') {
            $(parent.AppError).html(errAddresses);

        }		//if
        initAddresses = true;
    }		//DisplayAddresses

    function CreateAltAddr() {

        var ddTaxIDType = document.getElementById('ddTaxIDType');
        var txtIdNumber = document.getElementById('txtIdNumber');
        var txtBusAddress1 = document.getElementById('txtBusAddress1');
        var txtBusAddress2 = document.getElementById('txtBusAddress2');
        var txtBusCity = document.getElementById('txtBusCity');
        var ddBusState = document.getElementById('ddBusState');
        var txtBusZipExt = document.getElementById('txtBusZipExt');
        var txtBusZip = document.getElementById('txtBusZip');
        var txtBusAreaCode = document.getElementById('txtBusAreaCode');
        var txtBusPhone1 = document.getElementById('txtBusPhone1');
        var txtBusPhone2 = document.getElementById('txtBusPhone2');
        var txtBusPhoneExt = document.getElementById('txtBusPhoneExt');
        var txtFaxAreaCode = document.getElementById('txtFaxAreaCode');
        var txtFaxPhone1 = document.getElementById('txtFaxPhone1');
        var txtFaxPhone2 = document.getElementById('txtFaxPhone2');




        var tmpZip;
        if (parent.sNew != true) {
            return;
        }		//if

        var sAddType = ' 08 17 18 19 ';
        if (sAddType.search(txtBusZip.value.substr(0, 2)) != '-1') {
            sAddType = '100'; 		//Business Location
        } else {
            sAddType = '102'; 		//Headquarters
        }		//if
        //clipboardData.setData ('Text', parent.$g.xmlAccount.xml)
        if (sMailingAdd == -1) {
            iAltAddressIdx = LocatePrimaryAddr(' ', true); 		//Next Empty Line
        }		//if
        //EGOVWEB-28 Changed sMailingAdd value
        if (sMailingAdd == -1) {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'A', 'NAME_ADDRESS FUNCTION_CODE', '', iAltAddressIdx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddTaxIDType option:selected").attr("CODE"), 'NAME_ADDRESS TYPE', '', iAltAddressIdx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtIdNumber.value.replace(/-/g, ''), 'NAME_ADDRESS ID', '', iAltAddressIdx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '0', 'NAME_ADDRESS RELATIONSHIP_CODE', '', iAltAddressIdx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, sAddType, 'NAME_ADDRESS ADDRESS_TYPE', '', iAltAddressIdx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusAddress1.value, 'NAME_ADDRESS ADDRESS1', '', iAltAddressIdx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusAddress2.value, 'NAME_ADDRESS ADDRESS2', '', iAltAddressIdx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusCity.value, 'NAME_ADDRESS CITY', '', iAltAddressIdx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddBusState option:selected").attr("CODE"), 'NAME_ADDRESS STATE', '', iAltAddressIdx);
            if (txtBusZipExt.value != '') {
                tmpZip = txtBusZip.value + '-' + txtBusZipExt.value;
            }
            else {
                tmpZip = txtBusZip.value;
            }		//if
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, tmpZip, 'NAME_ADDRESS ZIP', '', iAltAddressIdx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusAreaCode.value + txtBusPhone1.value + txtBusPhone2.value, 'NAME_ADDRESS WORK_PHONE', '', iAltAddressIdx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusPhoneExt.value, 'NAME_ADDRESS WORK_PHONE_EXT', '', iAltAddressIdx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtFaxAreaCode.value + txtFaxPhone1.value + txtFaxPhone2.value, 'NAME_ADDRESS WORK_FAX', '', iAltAddressIdx);
            //EGOVWEB-28 Added
            sMailingAdd = iAltAddressIdx;
        } else {		//Remove Alt Address
            /*		parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/FUNCTION_CODE', '', iAltAddressIdx)
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/TYPE', '', iAltAddressIdx)
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/ID', '', iAltAddressIdx)
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/RELATIONSHIP_CODE', '', iAltAddressIdx)
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/ADDRESS_TYPE', '', iAltAddressIdx)
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/ADDRESS1', '', iAltAddressIdx)
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/ADDRESS2', '', iAltAddressIdx)
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/CITY', '', iAltAddressIdx)
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/STATE', '', iAltAddressIdx)
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/ZIP', '', iAltAddressIdx)
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/WORK_PHONE', '', iAltAddressIdx)
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/WORK_PHONE_EXT', '', iAltAddressIdx)
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'NAME_ADDRESS/WORK_FAX', '', iAltAddressIdx)*/
        }		//if
        CreateAddressTable();
    }		//CreateAltAddr


    function LoadAddressErrors() {

        var txtAddr1 = document.getElementById('txtAddr1');
        var txtAddr2 = document.getElementById('txtAddr2');
        var txtAddrBusCity = document.getElementById('txtAddrBusCity');
        var txtAddrBusZip = document.getElementById('txtAddrBusZip');
        var txtAddrBusZipExt = document.getElementById('txtAddrBusZipExt');
        var txtAddrAreaCode = document.getElementById('txtAddrAreaCode');
        var txtAddrPhone1 = document.getElementById('txtAddrPhone1');
        var txtAddrPhone2 = document.getElementById('txtAddrPhone2');
        var txtAddrFaxAreaCode = document.getElementById('txtAddrFaxAreaCode');
        var txtAddrPhone1 = document.getElementById('txtAddrPhone1');
        var txtAddrPhone2 = document.getElementById('txtAddrPhone2');
        var txtAddrFaxAreaCode = document.getElementById('txtAddrFaxAreaCode');
        var txtAddrFaxPhone1 = document.getElementById('txtAddrFaxPhone1');
        var txtAddrFaxPhone2 = document.getElementById('txtAddrFaxPhone2');

        var i = 0;

        //	arrAddr[i++] = [ddAddrType, 'ddAddrType.options(ddAddrType.selectedIndex).innerText=="Select"', 'Select Address Type']
        arrAddr[i++] = [txtAddr1, '$(\'#txtAddr1\').val()==""', 'Address required'];


        //	if	(ddAddrType.options(ddAddrType.selectedIndex).innerText == "Business Location")	{
        if (strAddrType == "Business Location") {
            arrAddr[i++] = [txtAddr1, '($(\'#txtAddr1\').val() != "") && ' +
                '((strAddr1.indexOf("PO ") == 0 || strAddr1.indexOf("P.O") == 0) || ' +
                '(strAddr1.indexOf("PO.") == 0 || strAddr1.indexOf("P O") == 0) || ' +
                '(strAddr1.indexOf("BOX ") == 0 || strAddr1.indexOf(" BOX ") != -1) || ' +
                '(strAddr1.indexOf(" PO ") != -1 || strAddr1.indexOf(" P.O") != -1) || ' +
                '(strAddr1.indexOf(" PO.") != -1 || strAddr1.indexOf(" P O ") != -1))',
                    'PO Boxes are not valid business locations.'];
            arrAddr[i++] = [txtAddr2, '($(\'#txtAddr2\').val() != "") && ' +
                '((strAddr2.indexOf("PO ") == 0 || strAddr2.indexOf("P.O") == 0) || ' +
                '(strAddr2.indexOf("PO.") == 0 || strAddr2.indexOf("P O") == 0) || ' +
                '(strAddr2.indexOf("BOX ") == 0 || strAddr2.indexOf(" BOX ") != -1) || ' +
                '(strAddr2.indexOf(" PO ") != -1 || strAddr2.indexOf(" P.O") != -1) || ' +
                '(strAddr2.indexOf(" PO.") != -1 || strAddr2.indexOf(" P O ") != -1))',
                    'PO Boxes are not valid business locations.'];
        }		//if
        arrAddr[i++] = [txtAddrBusCity, '$(\'#txtAddrBusCity\').val()==""', 'City required'];
        arrAddr[i++] = [txtAddrBusZip, 'ispValidZipCode($(\'#txtAddrBusZip\').attr("id"),$(\'#ddAddrBusState\').attr("id"), arrAddr, i)', ''];

        arrAddr[i++] = [txtAddrBusZipExt, 'ispValidZipCode($(\'#txtAddrBusZipExt\').attr("id"), $(\'#ddAddrBusState\').attr("id"), arrAddr, i, true)', ''];
        arrAddr[i++] = [txtAddrAreaCode, '$(\'#txtAddrAreaCode\').val() == "" || $(\'#txtAddrAreaCode\').val().length != 3', 'Phone Required'];
        arrAddr[i++] = [txtAddrPhone1, '$(\'#txtAddrPhone1\').val() == "" || $(\'#txtAddrPhone1\').val().length != 3', 'Phone Required'];
        arrAddr[i++] = [txtAddrPhone2, '$(\'#txtAddrPhone2\').val() == "" || $(\'#txtAddrPhone2\').val().length != 4', 'Phone Required'];

        arrAddr[i++] = [txtAddrAreaCode, 'isNaN($(\'#txtAddrAreaCode\').val())', 'Phone Not Numeric'];
        arrAddr[i++] = [txtAddrPhone1, 'isNaN($(\'#txtAddrPhone1\').val())', 'Phone Not Numeric'];
        arrAddr[i++] = [txtAddrPhone2, 'isNaN($(\'#txtAddrPhone2\').val())', 'Phone Not Numeric'];

        arrAddr[i++] = [txtAddrFaxAreaCode, '($(\'#txtAddrFaxAreaCode\').val() != "" && isNaN($(\'#txtAddrFaxAreaCode\').val()))', 'Fax Not Numeric'];
        arrAddr[i++] = [txtAddrFaxPhone1, '($(\'#txtAddrFaxPhone1\').val() != "" && isNaN($(\'#txtAddrFaxPhone1\').val()))', 'Fax Not Numeric'];
        arrAddr[i++] = [txtAddrFaxPhone2, '($(\'#txtAddrFaxPhone1\').val() != "" && isNaN($(\'#txtAddrFaxPhone1\').val()))', 'Fax Not Numeric'];
    }		//LoadAddressErrors


    function CreateAddressTable() {
        var sHTML = '';
        var iRow = 0;
        var bShow = false;

        $('#divAddressGrid').text('');
        iCount = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '');
        iAddressCount = 0;
        for (j = 0; j < iCount; j++) {
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j) != '0') {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', j) == '0') {
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j) != '60') {
                        LoadAddressValues(j);
                        bHaveAddresses = true;
                        sEdit = 'btnAddrEdit' + iAddressCount;
                        iRow = iRow + 1;
                        sHTML = sHTML + '<tr class=' + setRow(iRow) + '>';
                        sHTML = sHTML + '<td>' + sAddrType + '</td>' +
                                    '<td>' + sAddr1 + ' ' +
                                    sAddr2 + '   ' + sCity + ', ' + sState + ' ' + sZip + '-' + sZipExt + '</td>' +
                                    '<td>' +
                                    iAreaCode + '-' + iPhone1 + '-' + iPhone2 + ' ' + iPhoneExt + '</td>' +
                                    '<td class="no_border_right" align="center">' + '<a  class="small_edit" id=' + sEdit + " " + 'idx=' + j + ' onclick="loadAddrEditFrame()">' + 'Edit</a>' +
                                    '</td></TR>';
                        ++iAddressCount;
                    }		//if
                }		//if
            }		//if
        }		//for
        sHTML = sHTML + '</TABLE>';
        if (bHaveAddresses == true) {
            sHTML = ' <table class="table table-condensed table-striped custom_table02 no_margin_top" summary="Employee Pay Sheet"> ' +
              ' <thead><tr><th scope="col" width="25%">Address Summary </th>' +
               '<th scope="col" width="45%">&nbsp;</th>' +
                '<th scope="col" width="45%">&nbsp;</th>' +
                ' <th scope="col" width="15%" >&nbsp;</th></tr></thead>' +
                '<tbody><tr><td><strong>Type</strong></td>' +
                 '<td><strong>Street Address</strong></td>' +
                 '<td><strong>Phone</strong></td>' +
                 ' <td>&nbsp;</td></tr>' + sHTML;
            $('#divAddressGrid').html(sHTML);
            $('#divAddressGrid').css('display', 'block');
        }		//if
        bHaveAddresses = false;
        ClearAddrEditFrame();
    }		//CreateAddressTable


    function LoadAddressValues(j) {

        var ddAddrType = document.getElementById('ddAddrType');

        LoadGenericDD(parent.$g.xmlAddressType, ddAddrType, "DDOWN", false);
        sAddrType = GetDesc(ddAddrType, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j));
        //alert('sAddrType' + sAddrType);
        sAddr1 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', j);
        sAddr2 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', j);
        sCity = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', j);
        sState = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', j);
        sZip = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', j), 0, 5);
        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', j).indexOf("-") != -1) {
            sZipExt = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', j), 6, 4);
        }
        iAreaCode = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS WORK_PHONE', '', j), 0, 3);
        iPhone1 = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS WORK_PHONE', '', j), 3, 3);
        iPhone2 = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS WORK_PHONE', '', j), 6, 4);
        iPhoneExt = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS WORK_PHONE_EXT', '', j);
        if (iPhoneExt.length > 0) {
            iPhoneExt = 'x' + iPhoneExt;
        }
        iFaxAreaCode = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS WORK_FAX', '', j), 0, 3);
        iFax1 = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS WORK_FAX', '', j), 3, 3);
        iFax2 = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS WORK_FAX', '', j), 6, 4);
        sAttn = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ATTENTION', '', j);
    }		//LoadAddressValues


    function PopAddrXml() {
        var txtAddrBusZip = document.getElementById('txtAddrBusZip');
        var ddAddrType = document.getElementById('ddAddrType');
        var txtAddr1 = document.getElementById('txtAddr1');
        var txtAddr2 = document.getElementById('txtAddr2');
        var txtAddrBusCity = document.getElementById('txtAddrBusCity');
        var ddAddrBusState = document.getElementById('ddAddrBusState');
        var txtAddrBusZip = document.getElementById('txtAddrBusZip');
        var tmpZip = document.getElementById('tmpZip');
        var txtAddrAreaCode = document.getElementById('txtAddrAreaCode');
        var txtAddrPhone1 = document.getElementById('txtAddrPhone1');
        var txtAddrPhone2 = document.getElementById('txtAddrPhone2');
        var txtAddrPhoneExt = document.getElementById('txtAddrPhoneExt');
        var txtAddrFaxAreaCode = document.getElementById('txtAddrFaxAreaCode');
        var txtAddrFaxPhone1 = document.getElementById('txtAddrFaxPhone1');
        var txtAddrFaxPhone2 = document.getElementById('txtAddrFaxPhone2');
        var txtAddrAttn = document.getElementById('txtAddrAttn');


        var sFunction, lastIdx, sAction, sType, sID, tmpZip;
        var sBusLocType = ' 08 17 18 19 ';
        //var xmlTemp = new ActiveXObject("MSXML.DOMDocument");
        var xmlTemp = parent.$g.getXmlDocObj();
        xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "NAME_ADDRESS", 0);
        sAction = 'A';
        sType = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0);
        sID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', 0);

        if (iCurrAddrRec == -1) {
            iCurrAddrRec = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', ''); 		// - 1
            parent.$x.ispAppendNodeXml(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp, 'NAME_ADDRESS', 0);
        } else {
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS FUNCTION_CODE', '', iCurrAddrRec) != 'A') {
                sAction = 'U';
            }		//if
        }		//if

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, sType, 'NAME_ADDRESS TYPE', '', iCurrAddrRec);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, sID, 'NAME_ADDRESS ID', '', iCurrAddrRec);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '0', 'NAME_ADDRESS RELATIONSHIP_CODE', '', iCurrAddrRec);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, sAction, 'NAME_ADDRESS FUNCTION_CODE', '', iCurrAddrRec);

        if (sAction == 'A') {
            if (sBusLocType.search(txtAddrBusZip.value.substr(0, 2)) != '-1') {
                sBusLocType = '100'; 		//Business Location
            } else {
                sBusLocType = '101'; 		//Minor Business Location
            }		//if
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, sBusLocType, 'NAME_ADDRESS ADDRESS_TYPE', '', iCurrAddrRec);
        } else {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddAddrType option:selected").attr("CODE"), 'NAME_ADDRESS ADDRESS_TYPE', '', iCurrAddrRec);
        }	//if

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAddr1.value, 'NAME_ADDRESS ADDRESS1', '', iCurrAddrRec);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAddr2.value, 'NAME_ADDRESS ADDRESS2', '', iCurrAddrRec);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAddrBusCity.value, 'NAME_ADDRESS CITY', '', iCurrAddrRec);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddAddrBusState option:selected").attr("CODE"), 'NAME_ADDRESS STATE', '', iCurrAddrRec);

        if (txtAddrBusZipExt.value != '') {
            tmpZip = txtAddrBusZip.value + '-' + txtAddrBusZipExt.value;
        }
        else {
            tmpZip = txtAddrBusZip.value;
        }		//if
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, tmpZip, 'NAME_ADDRESS ZIP', '', iCurrAddrRec);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAddrAreaCode.value + txtAddrPhone1.value + txtAddrPhone2.value, 'NAME_ADDRESS WORK_PHONE', '', iCurrAddrRec);

        if (txtAddrPhoneExt.value.indexOf("x") != -1) {
            iPhoneExt = txtAddrPhoneExt.value.substr(1);
        }
        else {
            iPhoneExt = txtAddrPhoneExt.value;
        }		//if

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, iPhoneExt, 'NAME_ADDRESS WORK_PHONE_EXT', '', iCurrAddrRec);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAddrFaxAreaCode.value + txtAddrFaxPhone1.value + txtAddrFaxPhone2.value, 'NAME_ADDRESS WORK_FAX', '', iCurrAddrRec);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAddrAttn.value, 'NAME_ADDRESS ATTENTION', '', iCurrAddrRec);
    }		//PopAddrXml


    function loadAddrEditFrame() {

        var btnAddrAdd = document.getElementById('btnAddrAdd');
        var txtAddr1 = document.getElementById('txtAddr1');
        var txtAddr2 = document.getElementById('txtAddr2');
        var txtAddrBusCity = document.getElementById('txtAddrBusCity');
        var ddAddrBusState = document.getElementById('ddAddrBusState');
        var txtAddrBusZip = document.getElementById('txtAddrBusZip');
        var txtAddrBusZipExt = document.getElementById('txtAddrBusZipExt');
        var txtAddrAreaCode = document.getElementById('txtAddrAreaCode');
        var txtAddrPhone1 = document.getElementById('txtAddrPhone1');
        var txtAddrPhone2 = document.getElementById('txtAddrPhone2');
        var txtAddrPhoneExt = document.getElementById('txtAddrPhoneExt');
        var txtAddrFaxAreaCode = document.getElementById('txtAddrFaxAreaCode');
        var txtAddrFaxPhone1 = document.getElementById('txtAddrFaxPhone1');
        var txtAddrFaxPhone2 = document.getElementById('txtAddrFaxPhone2');
        var txtAddrAttn = document.getElementById('txtAddrAttn');
        var ddAddrType = document.getElementById('ddAddrType');

        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);

        iCurrAddrRec = $(source).attr('idx');

        LoadAddressValues(iCurrAddrRec);
        for (j = 0; j < iAddressCount; j++) {
            //eval('btnAddrEdit' + j + '.disabled = true')
            eval('$("#btnAddrEdit' + j + '").attr("disabled","true")');
        }		//for

        btnAddrAdd.value = 'Update';
        $('#pNoteAdd').css('display', 'none');//.style.display = 'none';
        //pNoteAdd.style.visibility = 'hidden';
        $('#pNoteAdd').css('visibility', 'hidden');

        //pNoteUpd.style.display = 'block';
        $('#pNoteUpd').css('display', 'block');
        //pNoteUpd.style.visibility = 'visible';
        $('#pNoteUpd').css('visibility', 'visible');

        SetDDList(ddAddrType, 'innerText', sAddrType, '')
        txtAddr1.value = sAddr1;
        txtAddr2.value = sAddr2;
        txtAddrBusCity.value = sCity;
        SetDDList(ddAddrBusState, 'innerText', sState, '');
        txtAddrBusZip.value = sZip;
        txtAddrBusZipExt.value = sZipExt;
        txtAddrAreaCode.value = iAreaCode;
        txtAddrPhone1.value = iPhone1;
        txtAddrPhone2.value = iPhone2;
        if (iPhoneExt.indexOf("x") != -1) {
            txtAddrPhoneExt.value = iPhoneExt.substr(1);
        }
        else {
            txtAddrPhoneExt.value = iPhoneExt;
        }		//if

        txtAddrFaxAreaCode.value = iFaxAreaCode;
        txtAddrFaxPhone1.value = iFax1;
        txtAddrFaxPhone2.value = iFax2;
        txtAddrAttn.value = sAttn;
        $('#txtAddr1').focus();
    }		//loadAddrEditFrame


    function ClearAddrEditFrame() {

        var ddAddrType = document.getElementById('ddAddrType');
        var txtAddr1 = document.getElementById('txtAddr1');
        var txtAddr2 = document.getElementById('txtAddr2');
        var txtAddrBusCity = document.getElementById('txtAddrBusCity');
        var btnAddrAdd = document.getElementById('btnAddrAdd');
        var ddAddrBusState = document.getElementById('ddAddrBusState');
        var txtAddrBusZip = document.getElementById('txtAddrBusZip');
        var txtAddrBusZipExt = document.getElementById('txtAddrBusZipExt');
        var txtAddrAreaCode = document.getElementById('txtAddrAreaCode');
        var txtAddrPhone1 = document.getElementById('txtAddrPhone1');
        var txtAddrPhone2 = document.getElementById('txtAddrPhone2');
        var txtAddrPhoneExt = document.getElementById('txtAddrPhoneExt');
        var txtAddrFaxAreaCode = document.getElementById('txtAddrFaxAreaCode');
        var txtAddrFaxPhone1 = document.getElementById('txtAddrFaxPhone1');
        var txtAddrFaxPhone2 = document.getElementById('txtAddrFaxPhone2');
        var txtAddrAttn = document.getElementById('txtAddrAttn');


        for (j = 0; j < iAddressCount; j++) {
            //eval('btnAddrEdit' + j + '.disabled = false');
            eval('$("#btnAddrEdit' + j + '").removeAttr("disabled")');
            //  eval($('#btnAddrEdit' + j + ').css("disabled","false"));
        }		//for

        $(parent.AppError).text('');
        iCurrAddrRec = -1;
        btnAddrAdd.value = 'Add';
        //pNoteUpd.style.display = 'none';
        //pNoteUpd.style.visibility = 'hidden';
        $('#pNoteUpd').css('display', 'none');
        $('#pNoteUpd').css('visibility', 'hidden');

        //pNoteAdd.style.display = 'block';
        //pNoteAdd.style.visibility = 'visible';
        //   $('#pNoteAdd').css('display', 'none');//Sanghamitra
        $('#pNoteAdd').css('visibility', 'hidden');

        LoadGenericDD(xmlAddressType2, ddAddrType, "DDOWN", false);

        ddAddrType.selectedIndex = 0;
        $('#ddAddrType').attr('class', 'form-control input-sm');
        txtAddr1.value = '';
        //txtAddr1.className = 'inpNormal';
        $('#txtAddr1').attr('class', 'form-control input-sm');
        txtAddr2.value = '';
        //txtAddr2.className = 'inpNormal';
        $('#txtAddr2').attr('class', 'form-control input-sm');
        txtAddrBusCity.value = '';
        //txtAddrBusCity.className = 'inpNormal';
        $('#txtAddrBusCity').attr('class', 'form-control input-sm');
        SetDDList(ddAddrBusState, '', 'PA');
        //ddAddrBusState.className = 'inpNormal';
        $('#ddAddrBusState').attr('class', 'form-control input-sm');
        txtAddrBusZip.value = '';
        //txtAddrBusZip.className = 'inpNormal';
        $('#txtAddrBusZip').attr('class', 'form-control input-sm');

        txtAddrBusZipExt.value = '';
        //txtAddrBusZipExt.className = 'inpNormal';
        $('#txtAddrBusZipExt').attr('class', 'form-control input-sm');
        txtAddrAreaCode.value = '';
        //txtAddrAreaCode.className = 'inpNormal';
        $('#txtAddrAreaCode').attr('class', 'form-control input-sm');
        txtAddrPhone1.value = '';
        //txtAddrPhone1.className = 'inpNormal';
        $('#txtAddrPhone1').attr('class', 'form-control input-sm');
        txtAddrPhone2.value = '';
        //txtAddrPhone2.className = 'inpNormal';
        $('#txtAddrPhone2').attr('class', 'form-control input-sm');
        txtAddrPhoneExt.value = '';
        //txtAddrPhoneExt.className = 'inpNormal';
        $('#txtAddrPhoneExt').attr('class', 'form-control input-sm');
        txtAddrFaxAreaCode.value = '';
        //txtAddrFaxAreaCode.className = 'inpNormal';
        $('#txtAddrFaxAreaCode').attr('class', 'form-control input-sm');
        txtAddrFaxPhone1.value = '';
        //txtAddrFaxPhone1.className = 'inpNormal';
        $('#txtAddrFaxPhone1').attr('class', 'form-control input-sm');
        txtAddrFaxPhone2.value = '';
        //txtAddrFaxPhone2.className = 'inpNormal';
        $('#txtAddrFaxPhone2').attr('class', 'form-control input-sm');
        txtAddrAttn.value = '';
        //txtAddrAttn.className = 'inpNormal';
        $('#txtAddrAttn').attr('class', 'form-control input-sm');
        errAddresses = '';
        //  SetNavButtons();
        // SetSubmitButton();
    }		//ClearAddrEditFrame


    function UpdateAddr() {

        var btnAddrAdd = document.getElementById('btnAddrAdd');

        var strAddUpdate = btnAddrAdd.value;
        ValidateAddr();

        if ($(parent.AppError).text() == '') {
            //Code1 Validation

            if (bAddrAddressChanged == true) {
                if (ac_CheckAddress() == false) {
                    //alert('Return...')
                    return;
                }		//if
            }		//if
            //End Code1 Validation
            //alert('Update...')

            PopAddrXml();

            CreateAddressTable();
            ClearAddrEditFrame();

            if (strAddUpdate == 'Add') {
                //AddrTable.style.visibility = 'hidden';
                $('#AddrTable').css('display', 'none');//style.display = 'none';
                $('#AddrTable').css('visibility', 'hidden');

                //divAddressGrid.style.display = 'none';
                //divAddressGrid.style.visibility = 'hidden';
                $('#divAddressGrid').css('display', 'none');
                $('#divAddressGrid').css('visibility', 'hidden');

                //divAfterAdd.style.display = 'block';
                //divAfterAdd.style.visibility = 'visible';
                $('#divAfterAdd').css('display', 'block');
                $('#divAfterAdd').css('visibility', 'visible');


                lbAddressesChanged = true;
                bAddrRequired = false;
                IsAddrShown = true;
                // SetNavButtons();
                // SetSubmitButton();
            }		//if
        } else {
            errAddresses = true;
            IsAddrShown = true;
            //		lbAddressesChanged = false
        }		//if
    }		//UpdateAddr


    function setRow(iRow) {
        if (iRow % 2 == 0) {
            return '';
        } else {
            return 'odd';
        }		//if
    }		//setRow


    function GetDesc(ddObj, Code) {
        for (i = 0; i < ddObj.options.length; i++) {
            if ($(ddObj.options[i]).attr('CODE') == Code) {
                return $(ddObj.options[i]).text();
            }		//if
        }		//for
    }		//GetDesc


    function ValidateAddr() {

        var ddAddrType = document.getElementById('ddAddrType');
        var txtAddr1 = document.getElementById('txtAddr1');
        var txtAddr2 = document.getElementById('txtAddr2');

        strAddrType = $("#ddAddrType option:selected").text();
        strAddr1 = txtAddr1.value.toUpperCase();
        strAddr2 = txtAddr2.value.toUpperCase();
        LoadAddressErrors();

        errAddresses = ispSetInputErr(arrAddr);

        //Code1 checking
        if (bAddrAddressChanged != 'accepted') {
            bAddrAddressChanged = true;
        }		//if
        if ($(AcctAddresses).css('display') == 'block') {
            $(parent.AppError).text(errAddresses);
        }		//if
    }	//ValidateAddr


    function ReplyYes() {
        $('#divAfterAdd').css('display', 'none');
        $('#divAfterAdd').css('visibility', 'hidden');
        $('#AddrTable').css('display', 'block');
        $('#AddrTable').css('visibility', 'visible');
        $('#divAddressGrid').css('display', 'block');
        $('#divAddressGrid').css('visibility', 'visible');

        $(parent.document).find('#imgAddresses').first().attr('src', '../Content/Images/address_tbd.gif');
        //parent.NavWin.imgAddresses.title = 'Required';
        $(parent.document).find('#imgAddresses').first().attr('title', 'Required');
        lbAddressesChanged = false;
        $(parent.document).find('#imgSubmit').first().attr('src', '../Content/Images/submit_tbd.gif');
        //parent.NavWin.imgSubmit.disabled = true;
        $(parent.document).find('#imgSubmit').first().attr('disabled', 'true');
        //parent.NavWin.imgSubmit.style.cursor = '';
        $(parent.document).find('#imgSubmit').first().css('cursor', '');
        //	for (j=0; j<iAddressCount; j++) {
        //		eval('btnAddrEdit' + j + '.disabled = true')
        //	}		//for	
        $('#btnAddrCancel').attr('disabled', 'true');
    }	//ReplyYes

    function ReplyNo() {
        //suman ,
        $('#divAfterAdd').css('display', 'none');
        $('#divAfterAdd').css('visibility', 'hidden');
        $('#AddrTable').css('display', 'block');
        $('#AddrTable').css('visibility', 'visible');
        $('#divAddressGrid').css('display', 'block');
        $('#divAddressGrid').css('visibility', 'visible');
        //--------------------------------------------------------------

        //	parent.NavWin.imgAddresses.src = '../Images/address_opt.gif'
        $(parent.document).find('#imgAddresses').first().attr('title', '');
        $('#btnAddrCancel').removeAttr('disabled');
        alert('You must click Submit in order to save your new Business Location(s).');

    }	//ReplyNo

    function AC_AddressDisabled(bDisabled) {
        //	ddAddrType.disabled = bDisabled
        //--------------------------------------------
        /*
            $('#txtAddr1').css('disabled', bDisabled);
            $('#txtAddr2').css('disabled', bDisabled);
            $('#txtAddrBusCity').css('disabled', bDisabled);
            $('#ddAddrBusState').css('disabled', bDisabled);
            $('#txtAddrBusZip').css('disabled', bDisabled);
            $('#txtAddrBusZipExt').css('disabled', bDisabled);
        */

        if (bDisabled == true) {
            $('#txtAddr1').attr('disabled', bDisabled);
            $('#txtAddr2').attr('disabled', bDisabled);
            $('#txtAddrBusCity').attr('disabled', bDisabled);
            $('#ddAddrBusState').attr('disabled', bDisabled);
            $('#txtAddrBusZip').attr('disabled', bDisabled);
            $('#txtAddrBusZipExt').attr('disabled', bDisabled);
        }
        else {
            $('#txtAddr1').removeAttr('disabled');
            $('#txtAddr2').removeAttr('disabled');
            $('#txtAddrBusCity').removeAttr('disabled');
            $('#ddAddrBusState').removeAttr('disabled');
            $('#txtAddrBusZip').removeAttr('disabled');
            $('#txtAddrBusZipExt').removeAttr('disabled');
        }

        //txtAddr2.disabled = bDisabled
        //txtAddrBusCity.disabled = bDisabled
        //ddAddrBusState.disabled = bDisabled
        //txtAddrBusZip.disabled = bDisabled
        //txtAddrBusZipExt.disabled = bDisabled
        if (bDisabled == true) {
            $('#ddAddrType').css('visibility', 'hidden');
            $('#ddAddrType').css('display', 'none');
            //ddAddrBusState.style.visibility = 'hidden'
            $('#ddAddrBusState').css('visibility', 'hidden');
            $('#ddAddrBusState').css('display', 'none');
        } else {
            //ddAddrType.style.visibility = 'visible'
            $('#ddAddrType').css('visibility', 'visible');
            $('#ddAddrType').css('display', 'block');

            //ddAddrBusState.style.visibility = 'visible'
            $('#ddAddrBusState').css('visibility', 'visible');
            $('#ddAddrBusState').css('display', '');
        }		//if
    }		//AC_AddressDisable

    function AC_AddressChangePopulate() {
        //EHD - 2008.12.01 - Added for the Code1 Addition
        var txtAddr1 = document.getElementById('txtAddr1');
        var txtAddr2 = document.getElementById('txtAddr2');
        var txtAddrBusCity = document.getElementById('txtAddrBusCity');
        var ddAddrBusState = document.getElementById('ddAddrBusState');
        var txtAddrBusZip = document.getElementById('txtAddrBusZip');
        var txtAddrBusZipExt = document.getElementById('txtAddrBusZipExt');

        txtAddr1.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address1', '', 0).substring(0, 30);
        txtAddr2.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address2', '', 0).substring(0, 30);
        txtAddrBusCity.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'City', '', 0).substring(0, 20);
        SetDDList(ddAddrBusState, '', parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'State', '', 0));
        txtAddrBusZip.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Zip', '', 0);
        txtAddrBusZipExt.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Zip4', '', 0);
    }		//AddressChangePopulate

    function ad_CorrectBLAddress() {
        var tmpZip;
        var ddTaxIDType = document.getElementById('ddTaxIDType');
        var txtIdNumber = document.getElementById('txtIdNumber');
        var txtBusAddress1 = document.getElementById('txtBusAddress1');
        var txtBusAddress2 = document.getElementById('txtBusAddress2');
        var txtBusCity = document.getElementById('txtBusCity');
        var ddBusState = document.getElementById('ddBusState');
        var txtBusZipExt = document.getElementById('txtBusZipExt');
        var txtBusZip = document.getElementById('txtBusZip');
        var txtBusAreaCode = document.getElementById('txtBusAreaCode');
        var txtBusPhone1 = document.getElementById('txtBusPhone1');
        var txtBusPhone2 = document.getElementById('txtBusPhone2');
        var txtBusPhoneExt = document.getElementById('txtBusPhoneExt');
        var txtFaxAreaCode = document.getElementById('txtFaxAreaCode');
        var txtFaxPhone1 = document.getElementById('txtFaxPhone1');
        var txtFaxPhone2 = document.getElementById('txtFaxPhone2');


        if (sMailingAdd != -1) {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'A', 'NAME_ADDRESS FUNCTION_CODE', '', sMailingAdd);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddTaxIDType option:selected").attr('CODE'), 'NAME_ADDRESS TYPE', '', sMailingAdd);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtIdNumber.value.replace(/-/g, ''), 'NAME_ADDRESS ID', '', sMailingAdd);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '0', 'NAME_ADDRESS RELATIONSHIP_CODE', '', sMailingAdd);
            //		parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, sAddType, 'NAME_ADDRESS/ADDRESS_TYPE', '', sMailingAdd)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusAddress1.value, 'NAME_ADDRESS ADDRESS1', '', sMailingAdd);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusAddress2.value, 'NAME_ADDRESS ADDRESS2', '', sMailingAdd);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusCity.value, 'NAME_ADDRESS CITY', '', sMailingAdd);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddBusState option:selected").attr('CODE'),
                    'NAME_ADDRESS STATE', '', sMailingAdd);
            if (txtBusZipExt.value != '') {
                tmpZip = txtBusZip.value + '-' + txtBusZipExt.value
            } else {
                tmpZip = txtBusZip.value
            }		//if
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, tmpZip, 'NAME_ADDRESS ZIP', '', sMailingAdd);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusAreaCode.value + txtBusPhone1.value + txtBusPhone2.value,
                    'NAME_ADDRESS WORK_PHONE', '', sMailingAdd);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusPhoneExt.value, 'NAME_ADDRESS WORK_PHONE_EXT', '', sMailingAdd);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtFaxAreaCode.value + txtFaxPhone1.value + txtFaxPhone2.value,
                    'NAME_ADDRESS WORK_FAX', '', sMailingAdd);

            CreateAddressTable();
        }		//if
    }		//CorrectBLAddress

    function Address_Print(bPrint) {
        if (bPrint == true) {
            $('#AcctAddresses').css('display', 'block');
            ////		AcctAddresses.style.pageBreakBefore = 'always'

            //divAddressGrid.style.display = 'block';
            $('#divAddressGrid').css('display', 'block');
            //AddrTable.style.display = 'none';
            $('#AddrTable').css('display', 'none');
            //PrintAddressHdr.style.display = 'block';
            $('#PrintAddressHdr').css('display', 'block');
            CreateAddressTable();
        } else {
            //AddrTable.style.display = 'block';
            $('#AddrTable').css('display', 'block');
            //PrintAddressHdr.style.display = 'none';
            $('#PrintAddressHdr').css('display', 'none');
        }		//if
    }		//Address_Print

</script>



<div class="tab-content customtabs">

    <div style="display: none;" id="AcctAddresses" role="tabpanel" class="tab-pane active">
        <h2>Tax Payer Information  |   <span>Addresses</span>  </h2>
        <div class="inner_white-panel">
            <div class="contentsection">
                <h4><a href="#" target="_self">Click here</a> for more information on completing this screen.<br />
                    * Required fields</h4>
                <div class="row">
                    <div class="col-lg-6 no-padding-left" id="AddrTable">
                        <div class="well custom_well">
                            <form class="form-horizontal addressee_form">

                                <div class="form-group">

                                    <label class="col-sm-3 control-label text-left-custom">Address Type* : </label>

                                    <div class="col-sm-9">
                                        <select class="form-control input-sm" id="ddAddrType" name="ddAddrType" onchange="ValidateAddr()">
                                            <option selected></option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">

                                    <label class="col-sm-3 control-label text-left-custom">Address*: </label>

                                    <div class="col-sm-9">

                                        <input class="form-control input-sm" id="txtAddr1" name="txtAddr1" maxlength="30" size="35"
                                            onchange="ValidateAddr()"><br>

                                        <input class="form-control input-sm" id="txtAddr2" name="txtAddr2" size="35"
                                            onchange="ValidateAddr()" maxlength="30">
                                    </div>

                                </div>

                                <div class="form-group">

                                    <label class="col-sm-3 control-label text-left-custom">City/State/Zip*:</label>


                                    <div class="col-sm-2">
                                        <input class="form-control input-sm" id="txtAddrBusCity" maxlength="20" name="txtAddrBusCity" onchange="ValidateAddr()">
                                    </div>
                                    <div class="col-sm-2">
                                        <%-- <span class="mandatory_Arrow">*</span>--%>
                                        <select class="form-control input-sm" id="ddAddrBusState" name="ddAddrBusState">
                                            <option selected></option>
                                        </select>
                                        <%--<span class="mandatory_Arrow">*</span>--%>
                                    </div>
                                    <div class="col-sm-2">
                                        <input class="form-control input-sm" id="txtAddrBusZip" maxlength="5" size="6" name='txtAddrBusZip"'
                                            onchange="ValidateAddr()">
                                        <%-- <span class="here_alert">-</span>--%>
                                    </div>
                                    <div class="col-sm-2">
                                        <input class="form-control input-sm" id="txtAddrBusZipExt" maxlength="4" size="5" name='txtAddrBusZipExt"'
                                            onchange="ValidateAddr()">
                                    </div>

                                </div>

                                <div class="form-group">

                                    <label class="col-sm-3 control-label text-left-custom">Work Phone*: </label>

                                    <div class="col-sm-2 below_margin01">
                                        <input class="form-control input-sm" id="txtAddrAreaCode" name="txtAddrAreaCode" maxlength="3" size="4"
                                            onchange="ValidateAddr()"><%--<span class="mandatory_Arrow">-</span>--%>
                                    </div>
                                    <div class="col-sm-2 below_margin01">
                                        <input class="form-control input-sm" id="txtAddrPhone1" name="txtAddrPhone1" maxlength="3" size="4"
                                            onchange="ValidateAddr()"><%--<span class="mandatory_Arrow">-</span>--%>
                                    </div>
                                    <div class="col-sm-2 below_margin01">
                                        <input class="form-control input-sm" id="txtAddrPhone2" name="txtAddrPhone2" maxlength="4" size="5"
                                            onchange="ValidateAddr()">
                                    </div>
                                    <div class="col-sm-3 customwidth_input">
                                        <span class="small_span2">Ext:</span>
                                        <input class="form-control input-sm" id="txtAddrPhoneExt" name="txtAddrPhoneExt" maxlength="5" size="6"
                                            onchange="ValidateAddr()">
                                    </div>

                                </div>

                                <div class="form-group">

                                    <label class="col-sm-3 control-label text-left-custom">Fax: </label>

                                    <div class="col-sm-2">
                                        <input class="form-control input-sm" id="txtAddrFaxAreaCode" maxlength="3" size="4" name="txtAddrFaxAreaCode"
                                            onchange="ValidateAddr()">
                                    </div>
                                    <%-- <div><span class="">-</span></div>--%>
                                    <div class="col-sm-2">
                                        <input class="form-control input-sm" id="txtAddrFaxPhone1" maxlength="3" name="txtAddrFaxPhone1" size="4"
                                            onchange="ValidateAddr()"><%--<span class="">-</span>--%>
                                    </div>
                                    <div class="col-sm-2">
                                        <input class="form-control input-sm" id="txtAddrFaxPhone2" maxlength="4" size="5" name="txtAddrFaxPhone2"
                                            onchange="ValidateAddr()">
                                    </div>

                                </div>

                                <div class="form-group">

                                    <label class="col-sm-3 control-label text-left-custom">Attention: </label>

                                    <div class="col-sm-9">
                                        <input class="form-control input-sm" id="txtAddrAttn" name="txtAddrAttn" maxlength="30" size="35"
                                            onchange="ValidateAddr()">
                                    </div>


                                </div>

                                <div class="form-group">
                                    <div class="col-lg-12 col-md-12 notify">
                                        <p class="note">Note: post office box numbers are not accepted in the "address" field.</p>
                                        <br />
                                        <p class="note" id="pNoteAdd" style="display: none; visibility: hidden;">Note: to save the address, you must click the "Add" button to the right.</p>
                                        <p class="note" id="pNoteUpd" style="display: none; visibility: hidden;">Note: to save the address, you must click the "Update" button to the right.</p>

                                    </div>
                                </div>

                                <div class="form-group">

                                    <div class="col-sm-offset-3 col-sm-9">
                                        <input class="btn btn-default submit_button_light" type="button" id="btnAddrAdd" onclick="UpdateAddr()" value="Add" /><input class="btn btn-default submit_button" type="button" id="btnAddrCancel" onclick="    ClearAddrEditFrame()" value="Cancel" />
                                        <%-- <a  class="submit_button_light" id="btnAddrAdd" onclick="UpdateAddr()">Add</a><a id="btnAddrCancel" class="submit_button" onclick="ClearAddrEditFrame()">Cancel</a>--%>
                                    </div>

                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div id="divAfterAdd" class="business_location">
                        <p>
                            <label>
                                &nbsp;	Do you have any additional new Business Locations in 
			Philadelphia or its vicinity?</label><br>
                            <br>
                            <input id="btnYes" onclick="ReplyYes()" style="margin: 20px 20px 40px 147px; width: 70px" type="button" value='Yes' class="btn btn-primary">&nbsp; 
		<input id="btnNo" style="margin: 20px 20px 40px; width: 70px" onclick="ReplyNo()" type="button" value="No" class="btn btn-danger">
                        </p>
                    </div>
                    <div id="divAddressGrid" style="display: none;" class="col-lg-12 no-padding table-responsive">
                    </div>
                </div>
            </div>

        </div>



        <div class="clear"></div>
        
    </div>



    <%-- <div class="quicklink_btm_gen"></div>--%>
</div>




