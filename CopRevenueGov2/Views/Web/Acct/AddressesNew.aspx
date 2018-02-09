<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<html>
<head>
    <title>COP- E Gov</title>
    <!-- Bootstrap Core CSS -->
    <link href="../Content/Styles/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css">

    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/jquery-1.js"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->


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

            //alert('AddressNew=>::' + parent.$g.xmlAccount);
            parent.$g.loadXmlSync("XML/AddressType2", parseXml_xmlAddresstype2);

        });


        function parseXml_xmlAddresstype2(xml) {
            xmlAddressType2.xml = xml;
        }

        function DisplayAddresses() {
           // alert('I am inside DisplayAddresses() before doing anything');

            AC_Form = 'ADDRESSES';
            var ddAddrType = document.getElementById('ddAddrType');
            var ddAddrBusState = document.getElementById('ddAddrBusState');
            var txtAddr1 = document.getElementById('txtAddr1');
            var txtHeader = document.getElementById('txtHeader');
            //alert(parent.$g.xmlAccount);

            	//CreateAltAddr()
            if (initAddresses == false) {
                //alert('initAddresses false');
                LoadGenericDD(xmlAddressType2, ddAddrType, "DDOWN", false);
                ispLoadZipCode(ddAddrBusState, true);
                LoadAddressErrors();
                CreateAddressTable();
                $('#ddAddrType').attr('disabled', 'true');
            }
            else {
               // alert('initAddresses true');
                ad_CorrectBLAddress();
            }		//if


            

            if (ddAddrType.length == 0) {
                LoadGenericDD(xmlAddressType2, ddAddrType, "DDOWN", false);
            }		//if

            $('#AppHeaderAddress').html(txtHeader + '<Font class=hdrMedium>|addresses</Font>');
            parent.gsInstructionItem = '#Address';
            $('#AppMessageAddress').html('<BR><font class="lblTextRed">*</font> Required Fields');
           


            CurrentLayer = 'AcctAddresses';
            $('#AcctAddresses').css("display", 'block');
            SetDDList(ddAddrBusState, '', 'PA');
            txtAddr1.focus();

            var mnuobj = $(parent.document).find('#mnuAcctAddresses').first();
           
            if (bAddrRequired == true) {
                errAddresses = 'Please enter your secondary address';
            }
            if (errAddresses != '') {
                        
                $(AppError_Add).html(errAddresses);
            }		//if
            initAddresses = true;
        }		

        function CreateAltAddr() {
            debugger;
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

           // alert('CreateAltAddr::' + sMailingAdd);

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
           
            if (sMailingAdd == -1) {
                iAltAddressIdx = LocatePrimaryAddr(' ', true); 		//Next Empty Line
            }		//if
            //EGOVWEB-28 Changed sMailingAdd value
            if (sMailingAdd == -1) {
               // alert('CreateAltAddr:: when sMailingAdd == -1' + sMailingAdd);
              //  alert($("#ddTaxIDType option:selected").attr("CODE"));
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'A', 'NAME_ADDRESS FUNCTION_CODE', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddTaxIDType option:selected").attr("CODE"), 'NAME_ADDRESS TYPE', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtIdNumber').val().replace(/-/g, ''), 'NAME_ADDRESS ID', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '0', 'NAME_ADDRESS RELATIONSHIP_CODE', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, sAddType, 'NAME_ADDRESS ADDRESS_TYPE', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtBusAddress1').val(), 'NAME_ADDRESS ADDRESS1', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtBusAddress2').val(), 'NAME_ADDRESS ADDRESS2', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtBusCity').val(), 'NAME_ADDRESS CITY', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddBusState option:selected").attr("CODE"), 'NAME_ADDRESS STATE', '', iAltAddressIdx);
                if ($('#txtBusZipExt').val() != '') {
                    tmpZip = $('#txtBusZip').val() + '-' + $('#txtBusZipExt').val();
                }
                else {
                    tmpZip = $('#txtBusZip').val();
                }		//if
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, tmpZip, 'NAME_ADDRESS ZIP', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtBusAreaCode').val() + $('#txtBusPhone1').val() + $('#txtBusPhone2').val(), 'NAME_ADDRESS WORK_PHONE', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtBusPhoneExt').val(), 'NAME_ADDRESS WORK_PHONE_EXT', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtFaxAreaCode').val() + $('#txtFaxPhone1').val() + $('#txtFaxPhone2').val(), 'NAME_ADDRESS WORK_FAX', '', iAltAddressIdx);
                //EGOVWEB-28 Added
                sMailingAdd = iAltAddressIdx;
            } 	//if
            CreateAddressTable();
        }		//CreateAltAddr

        function CreateSecAddr() {
            //debugger;
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

            //alert('CreateAltAddr::' + sMailingAdd);
            // alert(sessionStorage.ProfileBusareaCode);
            var phExt = sessionStorage.ProfileBusPhoneExt;
            if (phExt == null) {
                phExt = '';
            }
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

            if (sMailingAdd == -1) {
                iAltAddressIdx = LocatePrimaryAddr(' ', true); 		//Next Empty Line
            }		//if
            //EGOVWEB-28 Changed sMailingAdd value
            if (sMailingAdd == -1) {
               // alert('CreateSecAddr:: when sMailingAdd == -1' + sMailingAdd);
                //iAltAddressIdx
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, 'A', 'NAME_ADDRESS FUNCTION_CODE', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddTaxIDType option:selected").attr("CODE"), 'NAME_ADDRESS TYPE', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtIdNumber').val().replace(/-/g, ''), 'NAME_ADDRESS ID', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '0', 'NAME_ADDRESS RELATIONSHIP_CODE', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, sAddType, 'NAME_ADDRESS ADDRESS_TYPE', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtBusAddress1').val(), 'NAME_ADDRESS ADDRESS1', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtBusAddress2').val(), 'NAME_ADDRESS ADDRESS2', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtBusCity').val(), 'NAME_ADDRESS CITY', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddBusState option:selected").attr("CODE"), 'NAME_ADDRESS STATE', '', 0);
                if ($('#txtBusZipExt').val() != '') {
                    tmpZip = $('#txtBusZip').val() + '-' + $('#txtBusZipExt').val();
                }
                else {
                    tmpZip = $('#txtBusZip').val();
                }		//if
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, tmpZip, 'NAME_ADDRESS ZIP', '', 0);
                // parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtBusAreaCode').val() + $('#txtBusPhone1').val() + $('#txtBusPhone2').val(), 'NAME_ADDRESS WORK_PHONE', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, sessionStorage.ProfileBusareaCode + sessionStorage.ProfileBusPhone1 + sessionStorage.ProfileBusPhone2,
                      'NAME_ADDRESS WORK_PHONE', '', 0);
               // parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtBusPhoneExt').val(), 'NAME_ADDRESS WORK_PHONE_EXT', '', iAltAddressIdx);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, phExt, 'NAME_ADDRESS WORK_PHONE_EXT', '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtFaxAreaCode').val() + $('#txtFaxPhone1').val() + $('#txtFaxPhone2').val(), 'NAME_ADDRESS WORK_FAX', '', 0);
                //EGOVWEB-28 Added
                sMailingAdd = 0;
            } 	//if
           // CreateAddressTable();
        }
        function LoadAddressErrors() {

            var txtAddr1 = document.getElementById('txtAddr1');
            var txtAddr2 = document.getElementById('txtAddr2');
            var txtAddrBusCity = document.getElementById('txtAddrBusCity');
            var txtAddrBusZip = document.getElementById('txtAddrBusZip');
            var txtAddrBusZipExt = document.getElementById('txtAddrBusZipExt');
            var txtAddrAreaCode = document.getElementById('txtAddrAreaCode');
            var txtAddrPhone1 = document.getElementById('txtAddrPhone1');
            var txtAddrPhone2 = document.getElementById('txtAddrPhone2');
           
            var txtAddrPhone1 = document.getElementById('txtAddrPhone1');
            var txtAddrPhone2 = document.getElementById('txtAddrPhone2');
            var txtAddrFaxAreaCode = document.getElementById('txtAddrFaxAreaCode');
            var txtAddrFaxPhone1 = document.getElementById('txtAddrFaxPhone1');
            var txtAddrFaxPhone2 = document.getElementById('txtAddrFaxPhone2');
            var txtAddrPhoneExt = document.getElementById('txtAddrPhoneExt');


            var i = 0;

           
            arrAddr[i++] = [txtAddr1, '$(\'#txtAddr1\').val()==""', 'Address required'];


            
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

            arrAddr[i++] = [txtAddrBusZip, 'ispValidZipCode(document.getElementById(\'txtAddrBusZip\'), document.getElementById(\'ddAddrBusState\'), arrAddr, i)', 'Zip required'];
            arrAddr[i++] = [txtAddrBusZipExt, 'ispValidZipCode(document.getElementById(\'txtAddrBusZipExt\'), document.getElementById(\'ddAddrBusState\'), arrAddr, i, true)', ''];

            arrAddr[i++] = [txtAddrAreaCode, '$(\'#txtAddrAreaCode\').val() == "" || $(\'#txtAddrAreaCode\').val().length != 3', 'Phone required'];
            arrAddr[i++] = [txtAddrPhone1, '$(\'#txtAddrPhone1\').val() == "" || $(\'#txtAddrPhone1\').val().length != 3', 'Phone required'];
            arrAddr[i++] = [txtAddrPhone2, '$(\'#txtAddrPhone2\').val() == "" || $(\'#txtAddrPhone2\').val().length != 4', 'Phone required'];
            arrAddr[i++] = [txtAddrPhoneExt, '($(\'#txtAddrPhoneExt\').val() != "" && isNaN($(\'#txtAddrPhoneExt\').val()))', 'Ext. not numeric'];

            arrAddr[i++] = [txtAddrAreaCode, 'isNaN($(\'#txtAddrAreaCode\').val())', 'Phone not numeric'];
            arrAddr[i++] = [txtAddrPhone1, 'isNaN($(\'#txtAddrPhone1\').val())', 'Phone not numeric'];
            arrAddr[i++] = [txtAddrPhone2, 'isNaN($(\'#txtAddrPhone2\').val())', 'Phone not numeric'];

            arrAddr[i++] = [txtAddrFaxAreaCode, '($(\'#txtAddrFaxAreaCode\').val() != "" && isNaN($(\'#txtAddrFaxAreaCode\').val()))', 'Fax not numeric'];
            arrAddr[i++] = [txtAddrFaxPhone1, '($(\'#txtAddrFaxPhone1\').val() != "" && isNaN($(\'#txtAddrFaxPhone1\').val()))', 'Fax not numeric'];
            arrAddr[i++] = [txtAddrFaxPhone2, '($(\'#txtAddrFaxPhone2\').val() != "" && isNaN($(\'#txtAddrFaxPhone2\').val()))', 'Fax not numeric'];

        }		//LoadAddressErrors


        function CreateAddressTable() {
            var sHTML = '';
            var iRow = 0;
            var bShow = false;
            debugger;
            $('#divAddressGrid').text('');
            iCount = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '');
            iAddressCount = 0;
           
            for (j = 0; j < iCount; j++) {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j) != '0') {
                    //alert(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j));
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', j) == '0') {
                       // alert('At CreateAddressTable::' + parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j));
                        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j) == '60' || parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j) == '100') { //changes
                           // if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j) != '60' ) {
                            LoadAddressValues(j);
                            if (j==0) { // changes
                                sAddrType = 'Primary';
                            }
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
                   ' <thead><tr><td colspan="4" style="border:none;"><strong>Address Summary</strong></td></tr><tr><th class="no_space_at_all" scope="col" width="20%"></th>' +
                    '<th class="no_space_at_all" scope="col" width="40%"></th>' +
                     '<th class="no_space_at_all" scope="col" width="25%"></th>' +
                     ' <th class="no_space_at_all" scope="col" width="15%" ></th></tr></thead>' +
                    '<tbody><tr><td><strong>Type</strong></td>' +
                     '<td ><strong>Street Address</strong></td>' +
                     '<td ><strong>Phone</strong></td>' +
                     ' <td>&nbsp;</td></tr>' + sHTML;
                $('#divAddressGrid').html(sHTML);
                $('#divAddressGrid').css('display', 'block');
            }		//if
            bHaveAddresses = false;
            ClearAddrEditFrame();
        }		//CreateAddressTable


        function LoadAddressValues(j) {

            var ddAddrType = document.getElementById('ddAddrType');
            var code;
            //alert(sAddrType);
            LoadGenericDD(parent.$g.xmlAddressType, ddAddrType, "DDOWN", false);
            sAddrType = GetDesc(ddAddrType, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j));
            //changes
            /*if (sAddrType != "Business Location" || sAddrType != "Minor Business Location") {
                alert('When sAddrType!=Business Location inside LoadAddressValues(' + j + ')');
                code = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j);
                if (code == '60') {
                    //sAddrType = GetDesc(ddAddrType, '100');
                    sAddrType = GetDesc(ddAddrType, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j));
                }
                else {
                    sAddrType = GetDesc(ddAddrType, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', j));
                }
                alert(sAddrType);
            }*/
            
            //alert('sAddrType' + sAddrType);
           // alert(parent.$g.xmlAccount);
            //console.log('LoadAddressValues::' + );

            if (sAddrType == null) { //changes
                sAddrType = 'Primary';
            }
            sAddr1 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', j);
            sAddr2 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', j);
            sCity = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', j);
            sState = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', j);
            sZip = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', j), 0, 5);
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', j).indexOf("-") != -1) {
                sZipExt = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', j), 6, 4);
            }
            iAreaCode = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS WORK_PHONE', '', j), 0, 3);
            if (iAreaCode == '0') {//changes
                iAreaCode = ''
            }
            
          //  alert(splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS WORK_PHONE', '', j), 3, 3));

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
                //parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, sBusLocType, 'NAME_ADDRESS ADDRESS_TYPE', '', 1);
            } else {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddAddrType option:selected").attr("CODE"), 'NAME_ADDRESS ADDRESS_TYPE', '', iCurrAddrRec);
            }	//if

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAddr1.value, 'NAME_ADDRESS ADDRESS1', '', iCurrAddrRec);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAddr2.value, 'NAME_ADDRESS ADDRESS2', '', iCurrAddrRec);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAddrBusCity.value, 'NAME_ADDRESS CITY', '', iCurrAddrRec);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddAddrBusState option:selected").attr("CODE"), 'NAME_ADDRESS STATE', '', iCurrAddrRec);

            if ($('#txtAddrBusZipExt').val() != '') {
                tmpZip = $('#txtAddrBusZip').val() + '-' + $('#txtAddrBusZipExt').val();
            }
            else {
                tmpZip = $('#txtAddrBusZip').val();
            }		//if
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, tmpZip, 'NAME_ADDRESS ZIP', '', iCurrAddrRec);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAddrAreaCode.value + txtAddrPhone1.value + txtAddrPhone2.value, 'NAME_ADDRESS WORK_PHONE', '', iCurrAddrRec);

            if (txtAddrPhoneExt.value.indexOf("x") != -1) {
                iPhoneExt = txtAddrPhoneExt.value.substr(1);
            }
            else {
                iPhoneExt = $('#txtAddrPhoneExt').val();
            }		//if

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, iPhoneExt, 'NAME_ADDRESS WORK_PHONE_EXT', '', iCurrAddrRec);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAddrFaxAreaCode.value + txtAddrFaxPhone1.value + txtAddrFaxPhone2.value, 'NAME_ADDRESS WORK_FAX', '', iCurrAddrRec);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtAddrAttn.value, 'NAME_ADDRESS ATTENTION', '', iCurrAddrRec);
            //alert(parent.$g.xmlAccount);
        }		//PopAddrXml


        function loadAddrEditFrame() {
            ClearAddrEditFrame();//by manoranjan
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
           // alert('loadAddrEditFrame::' + $(source).attr('idx'));
            LoadAddressValues(iCurrAddrRec);
            for (j = 0; j < iAddressCount; j++) {
               
                eval('$("#btnAddrEdit' + j + '").attr("disabled","true")');
            }		//for

            btnAddrAdd.value = 'Update';
            $('#pNoteAdd').css('display', 'none');
           
            $('#pNoteAdd').css('visibility', 'hidden');

            
            $('#pNoteUpd').css('display', 'block');
           
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
            ResolveIframeHeight();

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
              
                eval('$("#btnAddrEdit' + j + '").removeAttr("disabled")');
                
            }		//for
            $(AppError_Add).text('');
           
            iCurrAddrRec = -1;
            btnAddrAdd.value = 'Add';
          
            $('#pNoteUpd').css('display', 'none');
            $('#pNoteUpd').css('visibility', 'hidden');

           
            $('#pNoteAdd').css('visibility', 'hidden');

            LoadGenericDD(xmlAddressType2, ddAddrType, "DDOWN", false);

            ddAddrType.selectedIndex = 0;
            $('#ddAddrType').attr('class', 'form-control input-sm');
            txtAddr1.value = '';
           
            $('#txtAddr1').attr('class', 'form-control input-sm');
            txtAddr2.value = '';
           
            $('#txtAddr2').attr('class', 'form-control input-sm');
            txtAddrBusCity.value = '';
            
            $('#txtAddrBusCity').attr('class', 'form-control input-sm');
            SetDDList(ddAddrBusState, '', 'PA');
            
            $('#ddAddrBusState').attr('class', 'form-control input-sm');
            txtAddrBusZip.value = '';
           
            $('#txtAddrBusZip').attr('class', 'form-control input-sm');

            txtAddrBusZipExt.value = '';
           
            $('#txtAddrBusZipExt').attr('class', 'form-control input-sm');
            txtAddrAreaCode.value = '';
           
            $('#txtAddrAreaCode').attr('class', 'form-control input-sm');
            txtAddrPhone1.value = '';
           
            $('#txtAddrPhone1').attr('class', 'form-control input-sm');
            txtAddrPhone2.value = '';
            
            $('#txtAddrPhone2').attr('class', 'form-control input-sm');
            txtAddrPhoneExt.value = '';
           
            $('#txtAddrPhoneExt').attr('class', 'form-control input-sm');
            txtAddrFaxAreaCode.value = '';
           
            $('#txtAddrFaxAreaCode').attr('class', 'form-control input-sm');
            txtAddrFaxPhone1.value = '';
           
            $('#txtAddrFaxPhone1').attr('class', 'form-control input-sm');
            txtAddrFaxPhone2.value = '';
          
            $('#txtAddrFaxPhone2').attr('class', 'form-control input-sm');
            txtAddrAttn.value = '';
            
            $('#txtAddrAttn').attr('class', 'form-control input-sm');
            errAddresses = '';
            
        }		

        function ResolveIframeHeight() {
            //----------Manoranjan------------------------------
            var iframe = window.parent.document.getElementById('ifrmDocwin');
            var container = $('#tab1').css("height");
            iframe.style.height = container;
            //----------------------------------------
        }
        function UpdateAddr() {

            var btnAddrAdd = document.getElementById('btnAddrAdd');

            var strAddUpdate = btnAddrAdd.value;
            ValidateAddr();
           
            if ($(AppError_Add).text() == '') {
              

                if (bAddrAddressChanged == true) {
                    if (ac_CheckAddress() == false) {
                        
                        return;
                    }		//if
                }		//if
                //End Code1 Validation
                //CreateAltAddr();

                PopAddrXml();

                CreateAddressTable();
                

                if (strAddUpdate == 'Add') {
                    
                    $('#AddrTable').css('display', 'none');//style.display = 'none';
                    $('#AddrTable').css('visibility', 'hidden');


                  
                    $('#divAddressGrid').css('display', 'none');
                    $('#divAddressGrid').css('visibility', 'hidden');

                   
                    $('#divAfterAdd').css('display', 'block');
                    $('#divAfterAdd').css('visibility', 'visible');

                    lbAddressesChanged = true;
                    bAddrRequired = false;
                    IsAddrShown = true;
                   
                }		//if
            } else {
                errAddresses = true;
                IsAddrShown = true;
               
            }		//if
            ResolveIframeHeight();
        }		


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
               

                $(AppError_Add).text(errAddresses);
                if (errAddresses != '') {
                    ResolveIframeHeight();
                    parent.ScrollTop(errAddresses);
                }

            }
            
        }	//ValidateAddr


        function ReplyYes() {
            $('#divAfterAdd').css('display', 'none');
            $('#divAfterAdd').css('visibility', 'hidden');
            $('#AddrTable').css('display', 'block');
            $('#AddrTable').css('visibility', 'visible');
            $('#divAddressGrid').css('display', 'block');
            $('#divAddressGrid').css('visibility', 'visible');
            $(parent.document).find('#imgAddresses').first().attr('src', '../Content/Images/address_tbd.gif');
           
            $(parent.document).find('#imgAddresses').first().attr('title', 'Required');
            lbAddressesChanged = false;
            $(parent.document).find('#imgSubmit').first().attr('src', '../Content/Images/submit_tbd.gif');
          
            $(parent.document).find('#imgSubmit').first().attr('disabled', 'true');
           
            $(parent.document).find('#imgSubmit').first().css('cursor', '');
           	
            $('#btnAddrCancel').attr('disabled', 'true');
            ResolveIframeHeight();
        }	//ReplyYes

        function ReplyNo() {
            //suman ,
            $('#divAfterAdd').css('display', 'none');
            $('#divAfterAdd').css('visibility', 'hidden');
            $('#AddrTable').css('display', 'block');
            $('#AddrTable').css('visibility', 'visible');
            $('#divAddressGrid').css('display', 'block');
            $('#divAddressGrid').css('visibility', 'visible');

           
            $(parent.document).find('#imgAddresses').first().attr('title', '');
            $('#btnAddrCancel').removeAttr('disabled');
            ResolveIframeHeight();
            alert('You must click Submit in order to save your new Business Location(s).');

        }	//ReplyNo

        function AC_AddressDisabled(bDisabled) {
           

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

           
            if (bDisabled == true) {
                $('#ddAddrType').css('visibility', 'hidden');
                $('#ddAddrType').css('display', 'none');
              
                $('#ddAddrBusState').css('visibility', 'hidden');
                $('#ddAddrBusState').css('display', 'none');
            } else {
              
                $('#ddAddrType').css('visibility', 'visible');
                $('#ddAddrType').css('display', 'block');

                
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
               
                $('#divAddressGrid').css('display', 'block');
              
                $('#AddrTable').css('display', 'none');
               
                $('#PrintAddressHdr').css('display', 'block');
                CreateAddressTable();
            } else {
               
                $('#AddrTable').css('display', 'block');
               
                $('#PrintAddressHdr').css('display', 'none');
            }		//if
        }		//Address_Print
      
        $(function () {
            $('#txtAddr1').keyup(function () {
                var yourInput = $(this).val();
                re = /[`~!$%^*()_|+=?;'",<>{\}[\]]/;
                var isSplChar = re.test(yourInput);
                if (isSplChar) {
                    var no_spl_char = yourInput.replace(/[`~!$%^*()_|+=?;'",<>{\}[\]]/, '');
                    $(this).val(no_spl_char);
                }
            });

        });
        $(function () {
            $('#txtAddr2').keyup(function () {
                var yourInput = $(this).val();
                re = /[`~!$%^*()_|+=?;'",<>{\}[\]]/;
                var isSplChar = re.test(yourInput);
                if (isSplChar) {
                    var no_spl_char = yourInput.replace(/[`~!$%^*()_|+=?;'",<>{\}[\]]/, '');
                    $(this).val(no_spl_char);
                }
            });

            $('#txtAddrAreaCode').keypress(function (evt) {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                    return false;
                }
            });

            $('#txtAddrPhone1').keypress(function (evt) {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                    return false;
                }
            });

            $('#txtAddrPhone2').keypress(function (evt) {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                    return false;
                }
            });


            $('#txtAddrPhoneExt').keypress(function (evt) {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                    return false;
                }
            });

            $('#txtAddrFaxAreaCode').keypress(function (evt) {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                    return false;
                }
            });

            $('#txtAddrFaxPhone1').keypress(function (evt) {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                    return false;
                }
            });

            $('#txtAddrFaxPhone2').keypress(function (evt) {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                    return false;
                }
            });
        });



    </script>

</head>
<body>
    <%--<div class="tab-content customtabs" id="tab1">   --%>

    <div style="display: block;" id="AcctAddresses" role="tabpanel" class="tab-pane active">
        <h2>Taxpayer Information  |   <span>Addresses</span>  </h2>
        <div class="inner_white-panel">

            <div class="contentsection">

                <div class="row">
                    <div class="col-lg-12 col-lg-offset-0 no-padding-left">
                        <div id="AppError_Add" class="errormsg no-padding" style="display: block;"></div>
                    </div>



                </div>

                <h4><%--<a href="#" onclick="parent.InstructionLinks();">Click here</a> for more information on completing this screen.<br />--%>
                    <span style="color: red">*</span> Required fields</h4>
                <div class="row">

                    <div class="col-lg-12 col-xs-12 col-sm-12" id="AddrTable">
                        <div class="well custom_well">
                            <form class="form-horizontal addressee_form">

                                <div class="form-group">
                                    <label class="col-sm-2 address-form-title">Address Type<span style="color: red">*</span> : </label>

                                    <div class="col-sm-5">
                                        <select class="form-control input-sm" id="ddAddrType" name="ddAddrType" onchange="ValidateAddr()">
                                            <option selected></option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">

                                    <label class="col-sm-2 address-form-title">Address<span style="color: red">*</span>: </label>

                                    <div class="col-sm-5">

                                        <input class="form-control input-sm" id="txtAddr1" name="txtAddr1" maxlength="30" size="35"
                                            onchange="ValidateAddr()"><br>

                                        <input class="form-control input-sm" id="txtAddr2" name="txtAddr2" size="35"
                                            onchange="ValidateAddr()" maxlength="30">
                                    </div>

                                </div>

                                <div class="form-group">

                                    <label class="col-sm-2 address-form-title">City/State/Zip<span style="color: red">*</span>:</label>


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

                                    <label class="col-sm-2 address-form-title">Work Phone<span style="color: red">*</span>: </label>

                                    <div class="col-sm-2">
                                        <input class="form-control input-sm" id="txtAddrAreaCode" name="txtAddrAreaCode" maxlength="3" size="4"
                                            onchange="ValidateAddr()">
                                    </div>
                                    <div class="col-sm-2">
                                        <input class="form-control input-sm" id="txtAddrPhone1" name="txtAddrPhone1" maxlength="3" size="4"
                                            onchange="ValidateAddr()">
                                    </div>
                                    <div class="col-sm-2">
                                        <input class="form-control input-sm" id="txtAddrPhone2" name="txtAddrPhone2" maxlength="4" size="5"
                                            onchange="ValidateAddr()">
                                    </div>
                                    <div class="col-sm-3 customwidth_input no-padding">
                                        <span class="small_span2">Ext:</span>
                                        <input class="form-control input-sm" id="txtAddrPhoneExt" name="txtAddrPhoneExt" maxlength="5" size="6"
                                            onchange="ValidateAddr()">
                                    </div>

                                </div>

                                <div class="form-group">

                                    <label class="col-sm-2 address-form-title">Fax: </label>

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

                                    <label class="col-sm-2 address-form-title">Attention: </label>

                                    <div class="col-sm-5">
                                        <input class="form-control input-sm" id="txtAddrAttn" name="txtAddrAttn" maxlength="30" size="35"
                                            onchange="ValidateAddr()">
                                    </div>


                                </div>
                                <div class="clear-fix"></div>
                                <div class="form-group">
                                    <div class="col-lg-12 col-md-12 notify no-padding address-form-title">
                                        <p class="note">Note: post office box numbers are not accepted in the "address" field.</p>
                                        <br />
                                        <p class="note" id="pNoteAdd" style="display: none; visibility: hidden;">Note: to save the address, you must click the "Add" button to the left.</p>
                                        <p class="note" id="pNoteUpd" style="display: none; visibility: hidden;">Note: to save the address, you must click the "Update" button to the left.</p>

                                    </div>
                                </div>

                                <div class="form-group">

                                    <div class="col-sm-12 text-center">
                                        <input class="btn btn-default submit_button_light" type="button" id="btnAddrAdd" onclick="UpdateAddr()" value="Add" /><input class="btn btn-default submit_button" type="button" id="btnAddrCancel" onclick="    ClearAddrEditFrame()" value="Cancel" />
                                        <%-- <a  class="submit_button_light" id="btnAddrAdd" onclick="UpdateAddr()">Add</a><a id="btnAddrCancel" class="submit_button" onclick="ClearAddrEditFrame()">Cancel</a>--%>
                                    </div>

                                </div>
                            </form>
                            <div class="clear"></div>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div id="divAfterAdd" class="business_location col-md-7 col-sm-10 col-xs-12">
                        <p class="address-popup-y-n">
                            <label>
                                &nbsp;	Do you have any additional new Business Locations in 
			Philadelphia or its vicinity?</label><br>
                        </p>
                        <div class="col-md-12 text-center">
                            <input id="btnYes" onclick="ReplyYes()" style="width: 70px" type="button" value='Yes' class="btn btn-primary">&nbsp; 
		<input id="btnNo" style="width: 70px" onclick="ReplyNo()" type="button" value="No" class="btn btn-danger">
                        </div>
                    </div>
                    <div id="divAddressGrid" style="display: none;" class="col-lg-12 col-sm-12 table-responsive pull-left address-page-table">
                    </div>

                </div>
                <div class="row">
                    <div class="form-group" id="divbtnSubmit" style="display: block">
                        <div class="col-sm-12 text-center">
                             <a class="btn btn-default submit_button_light" onclick="DoSubmit()" id="imgSubmit">Continue</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>



        <div class="clear"></div>

    </div>

    <%--   </div>--%>
</body>
</html>





