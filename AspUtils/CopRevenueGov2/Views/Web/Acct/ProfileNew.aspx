<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

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
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<script language="javascript" type="text/javascript">
    $(document).ready(function () {



        ////On Click Event
        //$("ul.tabs li").click(function () {
        //    $("ul.tabs li").removeClass("active"); //Remove any "active" class
        //    $(this).addClass("active"); //Add "active" class to selected tab
        //    $(".tab_content").hide(); //Hide all tab content
        //    var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
        //    $(activeTab).fadeIn(); //Fade in the active content
        //    return false;
        //});

    });

    function vbFindNAIC(code) {
        var node, value, sIdx, pIdx;

        node = $(parent.$g.xmlNAIC.xml).find('L1 L2 L3[CD="' + code + '"]').first();

        if (node) {

            value = $(node).attr('DESC');

            sIdx = $(node).parent('L2').attr('DESC');  //Node.parentNode.attributes.item(0).text

            pIdx = $(node).parent('L2').parent('L1').attr('DESC'); //= Node.parentNode.parentNode.attributes.item(0).text

            popNAIC(pIdx, sIdx, value);
        }
    }
</script>

<script id="clientEventHandlersJS" language="javascript" type="text/javascript">
    //EHD - 20100528 - EGOVWEB-24
    //EHD - 20100601 - EGOVWEB-22
    //EHD - 20100603 - EGOVWEB-26
    //EHD - 20100609 - EGOVWEB-28

    var arrProfile = new Array();
    //var xmlNAIC2 = new ActiveXObject("MSXML.DOMDocument");
    //var xmlNAIC3 = new ActiveXObject("MSXML.DOMDocument");

    var xmlNAIC2 = parent.$g.getXmlDocObj();
    var xmlNAIC3 = parent.$g.getXmlDocObj();

    //    if (window.ActiveXObject) {
    //        xmlNAIC2 = new ActiveXObject("Microsoft.XMLDOM");
    //        xmlNAIC2.async = false;
    //    }
    //    else if (document.implementation && document.implementation.createDocument){
    //        xmlNAIC2 = document.implementation.createDocument("", "", null);
    //    }

    //    if (window.ActiveXObject) {
    //        xmlNAIC3 = new ActiveXObject("Microsoft.XMLDOM");
    //        xmlNAIC3.async = false;
    //    }
    //    else if (document.implementation && document.implementation.createDocument) {
    //        xmlNAIC3 = document.implementation.createDocument("", "", null);
    //    }


    var iPrimaryAddr;
    var errProfile = '';
    var initProfile = false;

    //  alert(initProfile);

    //EHD - 2008.11.21 - Added for the Code1 Addition
    var bAcctAddressChanged = false;

    function Test() {
        parent.setFrameUrl('Returns/Liquor2013');
    }


    function DisplayProfile() {

        //Default Action
        $(".tab_content").hide(); //Hide all content
        $("ul.tabs li:first").addClass("").show(); //Activate first tab
        $(".tab_content:first").show(); //Show first tab content

        var ddBusState = document.getElementById('ddBusState');
        var ddTaxIDType = document.getElementById('ddTaxIDType');
        var ddRace = document.getElementById('ddRace');
        var ddGender = document.getElementById('ddGender');
        var txtEmail = document.getElementById('txtEmail');
        var ddOrgType = document.getElementById('ddOrgType');
        var txtHeader = document.getElementById('txtHeader');

        if (initProfile == false) {

            ispLoadZipCode(ddBusState, true);

            LoadGenericDD(parent.$g.xmlEntityType, ddTaxIDType, "DDOWN", false);

            LoadGenericDD(parent.$g.xmlEthnicity, ddRace, "DDOWN", false);

            LoadGenericDD(parent.$g.xmlSex, ddGender, "DDOWN", false);

            LoadNAIC_L1();

            LoadProfError(); //sanghamitra

            PopulateProfile();

            //alert('after LOADNAIC_L1');
        }		//if

        $('#AppHeaderprofile').html(txtHeader + '<Font class=hdrMedium>|profile </Font>');	// + parent.MenuWin.sNew
        parent.gsInstructionItem = '#Profile';
        $('#AppMessageProfile').html(parent.gsInstructionText +
                '<BR><font class="lblTextRed">*</font> Required Fields');
        $('#InstructionText').html(' for more information on completing this screen. Please review these instructions' +
                ' before completing this Application.');

        CurrentLayer = 'AcctProfile';
        $('#AcctProfile').css('display', 'block');
        $('#divbtnSubmit').css('display', 'block');
        $('#divAcctTaxes').css('display', 'none');

        if (parent.sNew == true) {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '60', 'NAME_ADDRESS ADDRESS_TYPE', '', 0); 		//Initiallize first row as primary address
            $('#ddOrgType').focus();
            $('#rowMailingAdd').css('display', '');
        }
        else {
            //suman ------------------------------------
            $('#rowMailingAdd').attr('disabled', 'true');
            //rowMailingAdd.disabled = true;
            //------------------------------------------
            //EGOVWEB-22  		rowMailingAdd1.disabled = true
            $('#rowMailingAdd2').attr('disabled', 'true');
            if (txtEmail.value == '') {
                txtEmail.focus();
                $(parent.AppError).text('Email Address Required');
            } else {
                if ((txtEmail.value.indexOf("@") == -1) || (txtEmail.value.indexOf(".") == -1)) {
                    txtEmail.focus();
                    $(parent.AppError).text('Email Address Invalid Format');
                } else {
                    //if (ddOrgType.options[ddOrgType.selectedIndex].innerText=="Select") {
                    if ($("#ddOrgType option:selected").text() == "Select") {
                        ddOrgType.focus();
                        $(parent.AppError).text('Select Organization Type');
                    } else {
                        txtBusAddress1.focus();
                        if (txtLastName.value != '') {
                            //								txtFirstName.focus()
                        } else {
                            //								txtEntityName.focus()
                        }		//if
                    }		//if
                }		//if
            }		//if
        } 	//if
        var menu_acctprof = $(parent.document).find('#mnuAcctProfile').first(); //Sanghamitra

        // parent.MenuWin.MenuProcessCurrent(menu_acctprof)  //Sanghamitra

        if (errProfile != '') {
            $(parent.AppError).html(errProfile);
        }		//if
        initProfile = true;
    }		//DisplayProfile


    function toTitleJscript(str) {
        return str.replace(/(\s[a-z])/g, function (match) {
            return
            match.toUpperCase()
        });
    }		//if


    function LoadProfError() {
        var i = 0;
        arrProfile = new Array();
        var ddNAIC1 = document.getElementById('ddNAIC1');
        var ddNAIC2 = document.getElementById('ddNAIC2');
        var ddNAIC3 = document.getElementById('ddNAIC3');
        var txtEntityName = document.getElementById('txtEntityName');
        var txtBusAreaCode = document.getElementById('txtBusAreaCode');
        var txtBusPhone1 = document.getElementById('txtBusPhone1');
        var txtBusAddress2 = document.getElementById('txtBusAddress2');
        var txtBusAddress1 = document.getElementById('txtBusAddress1');
        var txtTradeName = document.getElementById('txtTradeName');
        var txtBusCity = document.getElementById('txtBusCity');
        var txtBusPhone2 = document.getElementById('txtBusPhone2');
        var txtBusPhoneExt = document.getElementById('txtBusPhoneExt');
        var txtFaxAreaCode = document.getElementById('txtFaxAreaCode');
        var txtFaxPhone1 = document.getElementById('txtFaxPhone1');
        var txtFaxPhone2 = document.getElementById('txtFaxPhone2');
        var txtEmail = document.getElementById('txtEmail');
        var txtBusStartDate = document.getElementById('txtBusStartDate');
        var txtBusZip = document.getElementById('txtBusZip');
        var txtBusZipExt = document.getElementById('txtBusZipExt');
        var ddOrgType = document.getElementById('ddOrgType');
        var radMailingAdd_1 = document.getElementById('radMailingAdd_1');
        var radMailingAdd_2 = document.getElementById('radMailingAdd_2');
        var radMailingAdd2_1 = document.getElementById('radMailingAdd2_1');
        var radMailingAdd2_2 = document.getElementById('radMailingAdd2_2');
        var ddBusState = document.getElementById('ddBusState');
        var txtHomeAreaCode = document.getElementById('txtHomeAreaCode');
        var txtHomePhone1 = document.getElementById('txtHomePhone1');
        var txtHomePhone2 = document.getElementById('txtHomePhone2');
        var txtBusStartDate = document.getElementById('txtBusStartDate');

        if ($('#rowEntityName').css('display').toUpperCase() == 'BLOCK') {
            //arrProfile[i++] = [txtEntityName, 'txtEntityName.value == ""', 'Entity Name required'];
           
            arrProfile[i++] = [txtEntityName, '$(\'#txtEntityName\').val() == ""', 'Entity Name required'];
            arrProfile[i++] = [txtBusAreaCode, '($(\'#txtBusAreaCode\').val() == "" || $(\'#txtBusAreaCode\').val().length != 3)',
                    'Business Phone Required'];
            arrProfile[i++] = [txtBusPhone1, '($(\'#txtBusPhone1\').val() == "" || $(\'#txtBusPhone1\').val().length != 3)',
                    'Business Phone Required'];
            arrProfile[i++] = [txtBusPhone2, '($(\'#txtBusPhone2\').val() == "" || $(\'#txtBusPhone2\').val().length != 4)',
            'Business Phone Required'];
            arrProfile[i++] = [txtBusAreaCode, 'isNaN($(\'#txtBusAreaCode\').val())', 'Business Phone Not Numeric'];
            arrProfile[i++] = [txtBusPhone1, 'isNaN($(\'#txtBusPhone1\').val())', 'Business Phone Not Numeric'];
            arrProfile[i++] = [txtBusPhone2, 'isNaN($(\'#txtBusPhone2\').val())', 'Business Phone Not Numeric'];
            arrProfile[i++] = [txtBusPhoneExt, '$(\'#txtBusPhoneExt\').val() != "" && isNaN($(\'#txtBusPhoneExt\').val())',
                    'Business Phone Extension Not Numeric'];
        }		//if

        if ($('#rowIndName').css('display').toUpperCase() == "BLOCK") {
            arrProfile[i++] = [txtFirstName, '$(\'#txtFirstName\').val() == ""', 'First Name required'];
            arrProfile[i++] = [txtLastName, '$(\'#txtLastName\').val() == ""', 'Last Name required'];

            arrProfile[i++] = [txtHomeAreaCode, '($(\'#txtHomeAreaCode\').val() == "" || $(\'#txtHomeAreaCode\').val().length != 3)',
                    'Home Phone Required'];
            arrProfile[i++] = [txtHomePhone1, '($(\'#txtHomePhone1\').val() == "" || $(\'#txtHomePhone1\').val().length != 3)',
                    'Home Phone Required'];
            arrProfile[i++] = [txtHomePhone2, '($(\'#txtHomePhone2\').val() == "" || $(\'#txtHomePhone2\').val() != 4)',
                    'Home Phone Required'];
            arrProfile[i++] = [txtHomeAreaCode, '($(\'#txtHomeAreaCode\').val() != "" && isNaN($(\'#txtHomeAreaCode\').val()))',
                    'Home Phone Not Numeric'];
            arrProfile[i++] = [txtHomePhone1, '($(\'#txtHomePhone1\').val() != "" && isNaN($(\'#txtHomePhone1\').val()))',
                    'Home Phone Not Numeric'];
            arrProfile[i++] = [txtHomePhone2, '($(\'#txtHomePhone2\').val() != "" && isNaN($(\'#txtHomePhone2\').val()))',
                    'Home Phone Not Numeric'];
        }		//if
        
        arrProfile[i++] = [txtTradeName, 'false', ''];
        arrProfile[i++] = [txtBusAddress1, '$(\'#txtBusAddress1\').val() ==""', 'Address required'];
        arrProfile[i++] = [txtBusAddress1, '(document.getElementById(\'radMailingAdd_1\').checked == true) && ' +
                '(($(\'#txtBusAddress1\').val().indexOf("PO ") == 0 || $(\'#txtBusAddress1\').val().indexOf("P.O") == 0) || ' +
                '($(\'#txtBusAddress1\').val().indexOf("PO.") == 0 || $(\'#txtBusAddress1\').val().indexOf("P O") == 0) || ' +
                '($(\'#txtBusAddress1\').val().indexOf("BOX ") == 0 || $(\'#txtBusAddress1\').val().indexOf(" BOX ") != -1) || ' +
                '($(\'#txtBusAddress1\').val().indexOf(" PO ") != -1 || $(\'#txtBusAddress1\').val().indexOf(" P.O") != -1) || ' +
                '($(\'#txtBusAddress1\').val().indexOf(" PO.") != -1 || $(\'#txtBusAddress1\').val().indexOf(" P O ") != -1))',
                    'PO Boxes are not valid business locations. Please select ' +
                    "'" + 'No' + "'" + ' for the first question on the Profile tab and enter a complete' +
                    ' street address for the business location on the Address tab.'];
        arrProfile[i++] = [txtBusAddress2, 'false', ''];
        arrProfile[i++] = [txtBusCity, '$(\'#txtBusCity\').val() ==""', 'Address required'];
        arrProfile[i++] = [$('#ddBusState'), 'false', ''];
        
        arrProfile[i++] = [txtBusZip, 'ispValidZipCode(document.getElementById(\'txtBusZip\'),  $(\'#ddBusState\').attr("id"), arrProfile, i)', ''];
        arrProfile[i++] = [txtBusZipExt, 'ispValidZipCode(document.getElementById(\'txtBusZipExt\'),  $(\'#ddBusState\').attr("id"), arrProfile, i, true)', ''];

        arrProfile[i++] = [txtFaxAreaCode, '($(\'#txtFaxAreaCode\').val()!= "" && isNaN($(\'#txtFaxAreaCode\').val()))',
                'Fax Not Numeric'];
        arrProfile[i++] = [txtFaxPhone1, '($(\'#txtFaxPhone1\').val()!= "" && isNaN($(\'#txtFaxPhone1\').val()))',
                'Fax Not Numeric'];
        arrProfile[i++] = [txtFaxPhone2, '($(\'#txtFaxPhone2\').val() != "" && isNaN($(\'#txtFaxPhone2\').val()))',
                'Fax Not Numeric'];

        arrProfile[i++] = [txtEmail, '$(\'#txtEmail\').val() == ""', 'Email Address Required'];
        arrProfile[i++] = [txtEmail,
                '$(\'#txtEmail\').val() !="" && ($(\'#txtEmail\').val().indexOf("@") == -1 || ' +
                '$(\'#txtEmail\').val().indexOf(".") == -1 || $(\'#txtEmail\').val().indexOf("@.") != -1 || ' +
                '$(\'#txtEmail\').val().indexOf("@") == 0)',
                'Email Address Invalid Format'];

        arrProfile[i++] = [txtEmail,
                '$(\'#txtEmail\').val() !="" && ($(\'#txtEmail\').val().indexOf(".BIZ") == -1 && $(\'#txtEmail\').val().indexOf(".COM") == -1) && ' +
                '($(\'#txtEmail\').val().indexOf(".INFO") == -1 && $(\'#txtEmail\').val().indexOf(".NAME") == -1) && ' +
                '($(\'#txtEmail\').val().indexOf(".NET") == -1  && $(\'#txtEmail\').val().indexOf(".ORG") == -1) && ' +
                '($(\'#txtEmail\').val().indexOf(".PRO") == -1  && $(\'#txtEmail\').val().indexOf(".AERO") == -1) && ' +
                '($(\'#txtEmail\').val().indexOf(".CAT") == -1  && $(\'#txtEmail\').val().indexOf(".EDU") == -1) && ' +
                '($(\'#txtEmail\').val().indexOf(".GOV") == -1  && $(\'#txtEmail\').val().indexOf(".INT") == -1) && ' +
                '($(\'#txtEmail\').val().indexOf(".JOBS") == -1 && $(\'#txtEmail\').val().indexOf(".MIL") == -1) && ' +
                '($(\'#txtEmail\').val().indexOf(".MOBI") == -1 && $(\'#txtEmail\').val().indexOf(".MUSEUM") == -1) && ' +
                '($(\'#txtEmail\').val().indexOf(".TEL") == -1  && $(\'#txtEmail\').val().indexOf(".TRAVEL") == -1) && ' +
                '($(\'#txtEmail\').val().indexOf(".US") == -1   && $(\'#txtEmail\').val().indexOf(".ASIA") == -1)',
                'Email Address Invalid Domain'];

        arrProfile[i++] = [ddOrgType, '$("#ddOrgType option:selected").text()=="Select"',
                'Select Organization Type'];

        if (txtBusStartDate.disabled == false) {
            arrProfile[i++] = [txtBusStartDate, '$(\'#txtBusStartDate\').val() == ""', 'Enter Business Start Date'];
            arrProfile[i++] = [txtBusStartDate, '($("#txtBusStartDate").attr("className") != "inpDisabled") && ' +
                '(new Date($(\'#txtBusStartDate\').val()).valueOf()) > ' +
                '(new Date((new Date().getMonth() + 2).toString() + "/" + new Date().getDate().toString() ' +
                ' + "/" + (new Date().getFullYear()).toString()).valueOf()) ',
                'Business Start Date can not be Greater than 1 month from the current date'];
            arrProfile[i++] = [txtBusStartDate, '($("#txtBusStartDate").attr("className") != "inpDisabled") && ' +
                '(new Date($(\'#txtBusStartDate\').val()).valueOf()) < ' +
                '(new Date((new Date().getMonth() + 1).toString() + "/" + new Date().getDate().toString() ' +
                '+ "/" + (new Date().getFullYear() - 5).toString()).valueOf()) ',
                'Business Start Date must be within 5 Years of the current date'];
        }		//if

        arrProfile[i++] = [ddNAIC1, '$("#ddNAIC1 option:selected").text()=="Select"',
        'Enter Business Function'];

        //arrProfile[i++] = [ddNAIC2, '$(ddNAIC2.options[ddNAIC2.selectedIndex]).text()=="Select"',
        //'Enter Business Function'];

        arrProfile[i++] = [ddNAIC2, '$("#ddNAIC2 option:selected").text()=="Select"',
                'Enter Business Function'];
        arrProfile[i++] = [ddNAIC3, '$("#ddNAIC3 option:selected").text()=="Select"',
                'Enter Business Function'];
        //EHD - 20100528 - EGOVWEB-23
        //arrProfile[i++] = [ddNAIC1, '$(ddTaxIDType.options[ddTaxIDType.selectedIndex]).text()=="EIN" && $(ddNAIC1.options[ddNAIC1.selectedIndex]).text()=="NonBusiness"', 'Non-Business type is not allowed for EIN Account'];

        arrProfile[i++] = [ddNAIC1, '$("#ddTaxIDType option:selected").text()=="EIN" && $("#ddNAIC1 option:selected").text()=="NonBusiness"', 'Non-Business type is not allowed for EIN Account'];

        arrProfile[i++] = [radMailingAdd_1, '$("#rowMailingAdd").css("visibility") == "visible" && ' +
                '(document.getElementById(\'radMailingAdd_1\').checked == false && document.getElementById(\'radMailingAdd_2\').checked == false)', 'Respond Yes Or No To Mailing Address/Business Location Question'];
        arrProfile[i++] = [radMailingAdd_2, '$("#rowMailingAdd").css("visibility") == "visible" && ' +
                '(document.getElementById(\'radMailingAdd_1\').checked == false && document.getElementById(\'radMailingAdd_2\').checked == false)', 'Respond Yes Or No To Mailing Address/Business Location Question'];

        arrProfile[i++] = [radMailingAdd2_1, '$("#rowMailingAdd2").css("visibility") == "visible" && ' +
                '(document.getElementById(\'radMailingAdd2_1\').checked == false && document.getElementById(\'radMailingAdd2_2\').checked == false)', 'Respond Yes Or No To Second Mailing Address/Business Location Question'];
        arrProfile[i++] = [radMailingAdd2_2, '$("#rowMailingAdd2").css("visibility")== "visible" && ' +
                '(document.getElementById(\'radMailingAdd2_1\').checked == false &&  document.getElementById(\'radMailingAdd2_2\').checked == false)', 'Respond Yes Or No To Second Mailing Address/Business Location Question'];
    }		//LoadProfError

    function ClearErrors() {
        for (idx = 0; idx < arrProfile.length; idx++) {
            arrProfile[idx][0].className = 'form-control input-sm';//SanG
        }		//for
        $(parent.AppError).text('');
    }		//ClearErrors

    function LocatePrimaryAddr(AddType, AddNewRow) {

        var iMaxIdx = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '');

        var iFirstEmptyRow = -1;

        for (idx = 0; idx < iMaxIdx; idx++) {
            if (iFirstEmptyRow == -1 &&
                    parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == '0') {
                iFirstEmptyRow = idx;
            }		//if

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == AddType) {

                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', idx) == '0') {

                    return idx;
                }

                //if
            }		//if
        }		//for

        if (iFirstEmptyRow == -1 && AddNewRow == true) {
            iFirstEmptyRow = iMaxIdx;
            //alert('MS DOM Active x alert');
            /* SUMAN 22-12-2012
            var xmlTemp = new ActiveXObject("MSXML.DOMDocument");
            xmlTemp.loadXML(parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "NAME_ADDRESS", 0));
            */

            var xmlTemp = parent.$g.getXmlDocObj();
            xmlTemp.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlTemplate, "NAME_ADDRESS", 0);

            parent.$x.ispAppendNodeXml(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, xmlTemp, 'NAME_ADDRESS', 0);


        }		//if
        return iFirstEmptyRow;
    }		//locatePrimaryAddr


    function PopulateProfile() {


        var temp, addrIdx;

        addrIdx = LocatePrimaryAddr('60');


        var ddNAIC1 = document.getElementById('ddNAIC1');
        var ddNAIC2 = document.getElementById('ddNAIC2');
        var ddNAIC3 = document.getElementById('ddNAIC3');
        var txtEntityName = document.getElementById('txtEntityName');
        var txtBusAreaCode = document.getElementById('txtBusAreaCode');
        var txtBusPhone1 = document.getElementById('txtBusPhone1');
        var txtBusAddress2 = document.getElementById('txtBusAddress2');
        var txtBusAddress1 = document.getElementById('txtBusAddress1');
        var txtTradeName = document.getElementById('txtTradeName');
        var txtBusCity = document.getElementById('txtBusCity');
        var txtBusPhone2 = document.getElementById('txtBusPhone2');
        var txtBusPhoneExt = document.getElementById('txtBusPhoneExt');
        var txtFaxAreaCode = document.getElementById('txtFaxAreaCode');
        var txtFaxPhone1 = document.getElementById('txtFaxPhone1');
        var txtFaxPhone2 = document.getElementById('txtFaxPhone2');
        var txtEmail = document.getElementById('txtEmail');
        var txtBusStartDate = document.getElementById('txtBusStartDate');
        var ddTaxIDType = document.getElementById('ddTaxIDType');
        var txtIdNumber = document.getElementById('txtIdNumber');
        var ddOrgType = document.getElementById('ddOrgType');
        var ddBusState = document.getElementById('ddBusState');
        var txtBusZip = document.getElementById('txtBusZip');
        var txtBusZipExt = document.getElementById('txtBusZipExt');
        var txtHomeAreaCode = document.getElementById('txtHomeAreaCode');
        var txtHomePhone1 = document.getElementById('txtHomePhone1');
        var txtHomePhone2 = document.getElementById('txtHomePhone2');
        var txtLastName = document.getElementById('txtLastName');
        var ddRace = document.getElementById('ddRace');
        var txtRaceOther = document.getElementById('txtRaceOther');
        var ddGender = document.getElementById('ddGender');

        var pos = 0;
        try {

            SetDDList(ddTaxIDType, 'CODE', parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', addrIdx), null);
            pos = 1;

            txtIdNumber.value = FormatSsnEin($("#ddTaxIDType option:selected").text(), parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ENTITY_ID', '', addrIdx));
            pos = 2;

            txtEntityName.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME', '', addrIdx);

            var uName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME', '', addrIdx);
            if (uName.indexOf("*") >= 0) {
                uName = uName.replace(/\*/g, " ");
            }
            parent.fillUserAfterLogin(true, uName);
            pos = 3;

            $('#ddTaxIDType').attr('disabled', 'true');

            $('#txtIdNumber').attr('disabled', 'true');

            if (parent.sNew == true) {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', addrIdx) == '1') {
                    LoadGenericDD(parent.$g.xmlOrgType, ddOrgType, "DDOWN", false, '1');
                    pos = 4;
                }
                else {
                    LoadGenericDD(parent.$g.xmlOrgType, ddOrgType, "DDOWN", false, '2');
                    pos = 5;
                }		//if
                SetDDList(ddBusState, '', 'PA', null);
                pos = 6;
                changeOrgType();
                pos = 7;
            }
            else {

                pos = 8;

                if ((parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ORGTYPE', '', 0) == '61') ||
                    (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ORGTYPE', '', 0) == '100')) {

                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'ENTITY_INFO ORGTYPE', '', 0);
                    pos = 9;
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ORGTYPE', '', 0) == '61') {
                        parent.sNew = true;
                    }	//if

                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', addrIdx) == '1') {
                        LoadGenericDD(parent.$g.xmlOrgType, ddOrgType, "DDOWN", false, '1');
                    } else {
                        LoadGenericDD(parent.$g.xmlOrgType, ddOrgType, "DDOWN", false, '2');
                    }		//if
                    SetDDList(ddBusState, '', 'PA', null);
                    changeOrgType();
                }
                else {
                    pos = 10;
                    LoadGenericDD(parent.$g.xmlOrgType, ddOrgType, "DDOWN", false);

                    $('#ddOrgType').attr('disabled', 'true');
                    $('#ddOrgType').attr('class', 'form-control');
                    $('#txtBusStartDate').attr('disabled', 'true');
                    $('#txtBusStartDate').attr('class', 'form-control input-sm');
                }		//if
                pos = 11;
                txtTradeName.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'TRADE_NAME', '', addrIdx);
                pos = 12;
                // alert(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ADDRESS1', '', addrIdx));
                txtBusAddress1.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ADDRESS1', '', addrIdx);
                pos = 13;
                txtBusAddress2.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ADDRESS2', '', addrIdx);
                pos = 14;
                txtBusCity.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'CITY', '', addrIdx);
                pos = 15;

                SetDDList(ddBusState, '', parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'STATE', '', addrIdx), null);


                pos = 16;

                temp = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ZIP', '', addrIdx);
                txtBusZip.value = temp.slice(0, 5);
                if (temp.indexOf("-") != -1) {
                    txtBusZipExt.value = temp.substr(6, 4);
                }		//if

                txtBusAreaCode.value = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'WORK_PHONE', '', addrIdx), 0, 3);
                txtBusPhone1.value = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'WORK_PHONE', '', addrIdx), 3, 3);
                txtBusPhone2.value = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'WORK_PHONE', '', addrIdx), 6, 4);
                txtBusPhoneExt.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'WORK_PHONE_EXT', '', addrIdx);

                txtFaxAreaCode.value = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'WORK_FAX', '', addrIdx), 0, 3);
                txtFaxPhone1.value = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'WORK_FAX', '', addrIdx), 3, 3);
                txtFaxPhone2.value = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'WORK_FAX', '', addrIdx), 6, 4);

                txtHomeAreaCode.value = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'OTHER_PHONE', '', addrIdx), 0, 3);
                txtHomePhone1.value = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'OTHER_PHONE', '', addrIdx), 3, 3);
                txtHomePhone2.value = splitField(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'OTHER_PHONE', '', addrIdx), 6, 4);
                txtEmail.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'EMAIL', '', addrIdx); 		// + '.com'
                SetDDList(ddOrgType, 'CODE', parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ORGTYPE', '', addrIdx), null);
                txtBusStartDate.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO START_DATE', '', addrIdx);
                changeOrgType();
                //EGOVWEB-115 - Disable Entity Name changing requires proof
                if (txtLastName.value != '') {
                    $('#txtFirstName').attr('disabled', 'true');
                    $('#txtMIName').attr('disabled', 'true');
                    $('#txtLastName').attr('disabled', 'true');
                    //txtMIName.disabled = true;
                    //txtLastName.disabled = true;
                }
                else {
                    //txtEntityName.disabled = true;
                    $('#txtEntityName').attr('disabled', 'true');
                } 	//if


                //var xmltest = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO NAIC_CODE', '', addrIdx);

                //alert((new XMLSerializer()).serializeToString(parent.$g.xmlAccount));
                vbFindNAIC(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO NAIC_CODE', '', addrIdx));

                //alert('vbFindNAIC');

                //EGOVWEB-26 - Changes Started	
                //if ($(ddNAIC3.options[ddNAIC3.selectedIndex]).attr('CODE') == "99999") 
                if ($("#ddNAIC3 option:selected").attr('CODE') == "99999") {
                    //Do nothing
                } else if ($("#ddNAIC1 option:selected").text() != "Select") {	//Business type was previously selected
                    lockField(ddNAIC1);
                    lockField(ddNAIC2);
                    lockField(ddNAIC3);
                }		//if


                //EGOVWEB-26 - Changes Ended

                SetDDList(ddRace, '', parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ORIGIN', '', addrIdx), null);

                txtRaceOther.value = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'OTHER', '', addrIdx);

                SetDDList(ddGender, '', parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'GENDER', '', addrIdx), null);

            }		//if
        }
        catch (ex) {

            alert(pos + ',  PopulateProfile : ' + ex.message);
        }
    }		//PopulateProfile



    function UpdateProfileXml(lCheck) {
        var tmpZip;
        var txtEntityName = document.getElementById('txtEntityName');
        var txtEmail = document.getElementById('txtEmail');
        var txtIdNumber = document.getElementById('txtIdNumber');
        var ddOrgType = document.getElementById('ddOrgType');
        var chkBPT = document.getElementById('chkBPT');
        var chkWage = document.getElementById('chkWage');
        var chkLiquor = document.getElementById('chkLiquor');
        var chkHotel = document.getElementById('chkHotel');
        var chkNPT = document.getElementById('chkNPT');
        var chkRental = document.getElementById('chkRental');
        var chkAmusement = document.getElementById('chkAmusement');
        var chkEarn = document.getElementById('chkEarn');
        var txtRaceOther = document.getElementById('txtRaceOther');
        var txtBusStartDate = document.getElementById('txtBusStartDate');
        var txtTradeName = document.getElementById('txtTradeName');
        var txtBusAddress1 = document.getElementById('txtBusAddress1');
        var txtBusAddress2 = document.getElementById('txtBusAddress2');
        var txtBusCity = document.getElementById('txtBusCity');
        var txtBusZipExt = document.getElementById('txtBusZipExt');
        var txtBusAreaCode = document.getElementById('txtBusAreaCode');
        var txtBusZip = document.getElementById('txtBusZip');
        var txtBusAreaCode = document.getElementById('txtBusAreaCode');
        var txtBusPhoneExt = document.getElementById('txtBusPhoneExt');
        var txtFaxAreaCode = document.getElementById('txtFaxAreaCode');
        var txtFaxPhone1 = document.getElementById('txtFaxPhone1');
        var txtFaxPhone2 = document.getElementById('txtFaxPhone2');
        var txtHomeAreaCode = document.getElementById('txtHomeAreaCode');
        var txtHomePhone1 = document.getElementById('txtHomePhone1');
        var txtHomePhone2 = document.getElementById('txtHomePhone2');
        var txtBusPhone1 = document.getElementById('txtBusPhone1');
        var txtBusPhone2 = document.getElementById('txtBusPhone2');

        if ($("#ddNAIC1 option:selected").text() == "Select") {
            if (chkBPT.checked == false && chkWage.checked == false && chkLiquor.checked == false && +
                    chkHotel.checked == false && chkNPT.checked == false && chkRental.checked == false && +
                    chkAmusement.checked == false) {
                if (chkEarn.checked == true || chkSchool.checked == true) {
                    vbFindNAIC('99999');
                }		//if
            }		//if
        }		//if

        ValidateProf();
        if (errProfile != '') {
            return false;
        }

        var idx = LocatePrimaryAddr('60', true); 		//Primary Address

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusStartDate.value, 'ENTITY_INFO START_DATE', '', idx);
        //parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(ddOrgType.options[ddOrgType.selectedIndex]).attr('CODE'), 'ENTITY_INFO ORGTYPE', '', idx);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddOrgType option:selected").attr('CODE'), 'ENTITY_INFO ORGTYPE', '', idx);

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ORGTYPE', '', idx) == '60') {
            //parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(ddRace.options[ddRace.selectedIndex]).attr('CODE'), 'ENTITY_INFO ORIGIN', '', idx);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddRace option:selected").attr('CODE'), 'ENTITY_INFO ORIGIN', '', idx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtRaceOther.value, 'ENTITY_INFO OTHER', '', idx);
            //parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(ddGender.options[ddGender.selectedIndex]).attr('CODE'), 'ENTITY_INFO GENDER', '', idx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddGender option:selected").attr('CODE'), 'ENTITY_INFO GENDER', '', idx);


        } else {
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'ENTITY_INFO ORIGIN', '', idx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'ENTITY_INFO OTHER', '', idx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '', 'ENTITY_INFO GENDER', '', idx);
        }		//if
        //parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(ddNAIC3.options[ddNAIC3.selectedIndex]).attr('CODE'),
        // 'ENTITY_INFO NAIC_CODE', '', idx);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddNAIC3 option:selected").attr('CODE'),
                'ENTITY_INFO NAIC_CODE', '', idx);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddNAIC3 option:selected").attr('SIC'),
                'ENTITY_INFO SIC_CODE', '', idx);

        if (parent.sNew == true) {
            // parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $($('#ddTaxIDType').options[$('#ddTaxIDType').selectedIndex]).attr('CODE'),
            // 'ENTITY_INFO TYPE', '', idx);

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddTaxIDType option:selected").attr('CODE'),
                    'ENTITY_INFO TYPE', '', idx);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtIdNumber.value.replace(/-/g, ''),
                    'ENTITY_INFO ENTITY_ID', '', idx);
        }		//if
        //	}		//if

        //	var idx = LocatePrimaryAddr('60')		//Primary Address

        //	if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS/FUNCTION_CODE', '', idx) != "") {
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, '60', 'NAME_ADDRESS ADDRESS_TYPE', '', idx);
        // parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount,
        //$($('#ddTaxIDType').options[$('#ddTaxIDType').selectedIndex]).attr('CODE'), 'NAME_ADDRESS TYPE', '', idx);

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount,
               $("#ddTaxIDType option:selected").attr('CODE'), 'NAME_ADDRESS TYPE', '', idx);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtIdNumber.value.replace(/-/g, ''), 'NAME_ADDRESS ID', '', idx);


        //----------

        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == '2' &&			//2=SSN
                (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ORGTYPE', '', 0) == '60' ||		//60=Individual
                parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ORGTYPE', '', 0) == '161')) {	//161=LLC Individual
            txtEntityName.value = txtLastName.value + '*' + txtFirstName.value + '*' + txtMIName.value;
        }		//if
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtEntityName.value, 'NAME_ADDRESS NAME', '', idx);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtTradeName.value, 'NAME_ADDRESS TRADE_NAME', '', idx);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusAddress1.value, 'NAME_ADDRESS ADDRESS1', '', idx);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusAddress2.value, 'NAME_ADDRESS ADDRESS2', '', idx);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusCity.value, 'NAME_ADDRESS CITY', '', idx);
        //parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $($('#ddBusState').options[$('#ddBusState').selectedIndex]).attr('CODE'),
        //'NAME_ADDRESS STATE', '', idx);

        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddBusState option:selected").attr('CODE'),
        'NAME_ADDRESS STATE', '', idx);
        if (txtBusZipExt.value != '') {
            tmpZip = txtBusZip.value + '-' + txtBusZipExt.value;
        } else {
            tmpZip = txtBusZip.value;
        }		//if
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, tmpZip, 'NAME_ADDRESS ZIP', '', idx)
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusAreaCode.value + txtBusPhone1.value + txtBusPhone2.value,
                'NAME_ADDRESS WORK_PHONE', '', idx);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtBusPhoneExt.value, 'NAME_ADDRESS WORK_PHONE_EXT', '', idx);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtFaxAreaCode.value + txtFaxPhone1.value + txtFaxPhone2.value,
                'NAME_ADDRESS WORK_FAX', '', idx);
        var otherphone = txtHomeAreaCode.value + txtHomePhone1.value + txtHomePhone2.value;
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, otherphone,
                'NAME_ADDRESS OTHER_PHONE', '', idx);
        parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtEmail.value, 'NAME_ADDRESS EMAIL', '', idx);
        //	}		//if
        lbProfileChanged = false;
        return true;
    }		//UpdateProfileXml

    function splitField(value, start, end) {

        if (value.length != 0) {
            return value.substr(start, end);
        } else {
            return '';
        }
    }

    function popNAIC(iPidx, iSidx, sVal) {
        var ddNAIC2 = document.getElementById('ddNAIC2');
        var ddNAIC3 = document.getElementById('ddNAIC3');
        var xmlTemp = parent.$g.getXmlDocObj(); //new ActiveXObject("MSXML.DOMDocument")
        //alert(xmlTemp);

        var iCount = parent.$x.ispXmlGetRecCount(parent.$g.xmlNAIC, 'L1', '')
        var ddNAIC1 = document.getElementById('ddNAIC1');
        for (i = 0; i < iCount; i++) {
            if (iPidx == parent.$x.ispXmlGetFieldVal(parent.$g.xmlNAIC, 'L1', 'DESC', i)) {
                ddNAIC1.selectedIndex = i;
                loadNAIC_L2(i);
                var jCount = parent.$x.ispXmlGetRecCount(xmlNAIC2, 'L2', '');
                for (j = 0; j < jCount; j++) {
                    if (iSidx == parent.$x.ispXmlGetFieldVal(xmlNAIC2, 'L2', 'DESC', j)) {
                        ddNAIC2.selectedIndex = j;
                        loadNAIC_L3(j);
                        var kCount = parent.$x.ispXmlGetRecCount(xmlNAIC3, 'L3', '');
                        for (k = 0; k < kCount; k++) {
                            if (sVal == parent.$x.ispXmlGetFieldVal(xmlNAIC3, 'L3', 'DESC', k)) {
                                ddNAIC3.selectedIndex = k;
                                k = kCount;
                            }		//if
                        }		//for
                        j = jCount;
                    }		//if
                }		//for
                i = iCount;
            }		//if
        }		//for
        DisplayMailingRad();
    }

    function lockField(obj) {

        $(obj).attr('class', 'form-control');
        $(obj).attr('disabled', 'true');
    }

    function SetAddressChange() {

        //EHD - 2008.11.21 - Added for Code1 to check if an address field changed
        //var evt = parent.MenuWin.getEvent();
        var evt;
        var source;
        if (window.event != null && window.event != 'undefined') {
            evt = window.event;
            //source = evt.srcElement;
        }
        else {
            if (arguments.callee != null && arguments.callee != 'undefined') {
                if (arguments.callee.caller != null && arguments.callee.caller != 'undefined') {
                    evt = arguments.callee.caller.caller.arguments[0];
                    //source = evt.target;				
                }
            }
        }

        var source = parent.getEventSource(evt);
        if (evt) {
            var lId = source.id;
            if (lId == 'txtBusAddress1' || lId == 'txtBusCity' ||
                    lId == 'ddBusState' || lId == 'txtBusZip' || lId == 'txtBusZipExt') {
                bAcctAddressChanged = true;
            }		//if
        }		//if
    }		//SetAddressChange

    function ValidateProf() {
      
        var strEmail = "";
        var strBusAddress1 = "";
        var txtEmail = document.getElementById('txtEmail');
        var txtBusAddress1 = document.getElementById('txtBusAddress1');
        var txtBusStartDate = document.getElementById('txtBusStartDate');
        var ddRace = document.getElementById('ddRace');

        strEmail = txtEmail.value.toUpperCase();
        txtEmail.value = strEmail;
        strBusAddress1 = txtBusAddress1.value.toUpperCase();
        txtBusAddress1.value = strBusAddress1;

        //EHD - 2008.11.21 - Added for the Code1 Addition
        SetAddressChange();
        LoadProfError();
        
        errProfile = ispSetInputErr(arrProfile);
        

        //var evt = parent.MenuWin.getEvent();
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);

        if ($('#AcctProfile').css('display') == 'block') {
            $(parent.AppError).text(errProfile);
        }		//if

        if (errProfile != '') {
        } else if (evt) {
            var lId = $(source).attr('id');
            lbProfileChanged = true;

            if (parent.sNew == true) {
                var lAction = "A";
            } else {
                var lAction = "U";
            }		//if

            if (lId == 'txtBusStartDate' || lId == 'ddOrgType' ||
                    lId == 'ddRace' || lId == 'txtRaceOther' || lId == 'ddGender' ||
                    lId == 'ddNAIC1' || lId == 'ddNAIC2' || lId == 'ddNAIC3') {
                if (lId == 'txtBusStartDate' &&
                        (new Date(txtBusStartDate.value).valueOf()) <
                        (new Date((new Date().getMonth() + 1).toString() +
                        "/" + new Date().getDate().toString() +
                        "/" + (new Date().getFullYear() - 2).toString()).valueOf())) {
                    alert('WARNING:\n  Business Start Date is older then 2 years,\n' +
                            '  if this correct ignore this message\n');
                }
                //if
                $('#txtRaceOther').attr('class', 'form-control input-sm');//SanG
                $('#txtRaceOther').removeAttr('disabled');
                //if ($(ddRace.options[ddRace.selectedIndex]).text().toUpperCase() != 'OTHER')
                if ($("#ddRace option:selected").text().toUpperCase() != 'OTHER') {
                    $('#txtRaceOther').attr('class', 'inpDisabled');
                    $('#txtRaceOther').attr('disabled', 'true');
                    $('#txtRaceOther').val('');
                }		//if
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, lAction, 'ENTITY_INFO FUNCTION_CODE', '', 0)
            } else {
                if (lAction == "A") {
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, lAction, 'NAME_ADDRESS FUNCTION_CODE', '', 0)
                } else {
                    var idx = LocatePrimaryAddr('60')
                    parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, lAction, 'NAME_ADDRESS FUNCTION_CODE', '', idx)
                }		//if
            }		//if
        }		//if

        //SetSubmitButton();
    }		//ValidateProf

    function LoadNAIC_L1() {

        var iCount = parent.$x.ispXmlGetRecCount(parent.$g.xmlNAIC, 'L1', '');
        var ddNAIC1 = document.getElementById('ddNAIC1');
        ddNAIC1.options.length = iCount;

        for (i = 0; i < iCount; i++) {
            var x = parent.$x.ispXmlGetFieldVal(parent.$g.xmlNAIC, 'L1', 'DESC', i);
            $(ddNAIC1.options[i]).text(x);
        }


    }		//LoadNAIC_L1

    function loadNAIC_L2(iIdx) {
        var ddNAIC2 = document.getElementById('ddNAIC2');
        $('#ddNAIC2').attr('class', 'form-control input-sm');//SanG
        //suman -----------------------------------------------------------------
        //xmlNAIC2.loadXML(parent.$x.ispXmlGetRecordXml(parent.$g.xmlNAIC, 'L1', iIdx));
        xmlNAIC2.xml = parent.$x.ispXmlGetRecordXml(parent.$g.xmlNAIC, 'L1', iIdx);
        //------------------------------------------------------------------------

        var iCount = parent.$x.ispXmlGetRecCount(xmlNAIC2, 'L2', '');
        ddNAIC2.options.length = iCount;

        for (i = 0; i < iCount; i++) {
            $(ddNAIC2.options[i]).text(parent.$x.ispXmlGetFieldVal(xmlNAIC2, 'L2', 'DESC', i));
        }
    }		//loadNAIC_L2

    function loadNAIC_L3(iIdx) {

        $(ddNAIC3).attr('class', 'form-control');//SanG
        //suman --------------------------------------------------
        //xmlNAIC3.loadXML(parent.$x.ispXmlGetRecordXml(xmlNAIC2, 'L2', iIdx));
        xmlNAIC3.xml = parent.$x.ispXmlGetRecordXml(xmlNAIC2, 'L2', iIdx);
        //---------------------------------------------------------
        var ddNAIC3 = document.getElementById('ddNAIC3');
        var iCount = parent.$x.ispXmlGetRecCount(xmlNAIC3, 'L3', '');
        ddNAIC3.options.length = iCount;

        for (i = 0; i < iCount; i++) {
            $(ddNAIC3.options[i]).text(parent.$x.ispXmlGetFieldVal(xmlNAIC3, 'L3', 'DESC', i));
            $(ddNAIC3.options[i]).attr('CODE', parent.$x.ispXmlGetFieldVal(xmlNAIC3, 'L3', 'CD', i));
            $(ddNAIC3.options[i]).attr('SIC', parent.$x.ispXmlGetFieldVal(xmlNAIC3, 'L3', 'SIC', i));
        }		//for
    }		//loadNAIC_L3


    function changeNAIC() {

        //var evt = parent.MenuWin.getEvent();
        //var source = parent.MenuWin.getEventSource(evt);
        var ddNAIC1 = document.getElementById('ddNAIC1');
        var ddNAIC2 = document.getElementById('ddNAIC2');
        var ddNAIC3 = document.getElementById('ddNAIC3');
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);


        if (source.id == 'ddNAIC1') {
            clearDD(ddNAIC2);
            clearDD(ddNAIC3);
            loadNAIC_L2(ddNAIC1.selectedIndex);
            if (ddNAIC2.options.length > 0) {
                if ($(ddNAIC2.options[0]).text() == 'NONE') {
                    clearDD(ddNAIC3);
                    loadNAIC_L3(ddNAIC2.selectedIndex);
                }
            }
            else {
            }
        }
        else if (source.id == 'ddNAIC2') {
            clearDD(ddNAIC3);
            loadNAIC_L3(ddNAIC2.selectedIndex);
        }
        DisplayMailingRad();
        loadpage();
    }		//changeNAIC
    function loadpage() {

        try {
            var iFrameID = parent.window.frames['ifrmDocwin'];

            $(iFrameID).height($(iFrameID).contents().find("html").height() + 70);
        }
        catch (ee) {
            var iFrameID1 = parent.document.getElementById('ifrmDocwin');

            iFrameID1.height = (iFrameID1.contentWindow.document.body.scrollHeight + 70) + "px";

        }



    } // binoy
    function changeOrgType() {
        ClearErrors();
        $('#divVoluntaryInfo').css('display', 'block');
        $('#rowIndName').css('display', 'none');
        $('#rowEntityName').css('display', '');

        var txtEntityName = document.getElementById('txtEntityName');
        var txtFirstName = document.getElementById('txtFirstName');
        var txtLastName = document.getElementById('txtLastName');
        var txtMIName = document.getElementById('txtMIName');
        var ddOrgType = document.getElementById('ddOrgType');
        var ddRace = document.getElementById('ddRace');
        var txtRaceOther = document.getElementById('txtRaceOther');
        var ddGender = document.getElementById('ddGender');

        var TaxTypeCode = $("#ddTaxIDType option:selected").attr('CODE');
        var OrgType = $("#ddOrgType option:selected").attr('CODE');

        //2=SSN
        //60=Individual
        if (TaxTypeCode == '2' && (OrgType == '60' || OrgType == '161')) {
            $('#divVoluntaryInfo').css('display', 'block');
            $('#rowIndName').css('display', '');
            $('#rowIndName').attr('visibility', 'visible');
            $('#rowEntityName').css('display', 'none');


            /*
            $('#reqBusAreaCode').css('display','none'); 
            $('#reqHomeAreaCode').css('display', 'none');
            SUMAN 28/12/2012....
            display none will cause UI area collapse thus crating UI issue
            using visibility hidden  to solve the isssue
            */
            $('#reqBusAreaCode').css('visibility', 'hidden');
            $('#reqHomeAreaCode').css('visibility', 'visible');
            /*----------------------------------*/

            var sEntityName = txtEntityName.value;
            if (sEntityName != 0) {
                sEntityName = sEntityName.split('*');
                txtLastName.value = sEntityName[0];
                if (sEntityName[1]) {
                    txtFirstName.value = sEntityName[1];
                }		//if
                if (sEntityName[2]) {
                    txtMIName.value = sEntityName[2].substr(0, 1);
                }
                txtEntityName.value = '';
            }		//if
            if ($("#ddOrgType option:selected").attr('CODE') == '60') {			//60 = Individual
                vbFindNAIC('99999');
            }		//if
        }
        else {


            $('#divVoluntaryInfo').css('display', 'none');


            //display none will not help here and cause UI issue
            $('#reqHomeAreaCode').css('visibility', 'hidden');
            $('#reqBusAreaCode').css('visibility', 'visible');

            SetDDList(ddRace, '', '9', null);
            txtRaceOther.value = '';
            SetDDList(ddGender, '', '9', null);
        }		//if

        var lsOfficerGif = 'officer_opt.gif';
        var lsOrgTypeCode = ' 140 11 163 162 '; 	//Corp, Partnership, LLC Corp, LLC Partnership
        if (lsOrgTypeCode.search(' ' + $("#ddOrgType option:selected").attr('CODE') + ' ') != '-1' &&
                parent.sNew == true) {
            //EGOVWEB-24 - Added 1 Line
            bOfficersRequired = true;

            //parent.NavWin.document.imgPartners.src = '../Images/officer_tbd.gif';
            //parent.NavWin.document.imgPartners.title = 'Required';

            //$(parent.NavWin.document).find('#imgPartners').first().attr('title', 'Required');//sanghamitra
            //$(parent.NavWin.document).find('#imgPartners').first().attr('src', '../Images/officer_tbd.gif');//sanghamitra
        } else {
            //EGOVWEB-24 - Added 1 Line
            bOfficersRequired = false;
            //parent.NavWin.document.imgPartners.src = '../Images/officer_opt.gif';
            //parent.NavWin.document.imgPartners.title = '';

            //$(parent.NavWin.document).find('#imgPartners').first().attr('title', '');//sanghamitra
            //$(parent.NavWin.document).find('#imgPartners').first().attr('src', '../Images/officer_opt.gif');//sanghamitra
        }		//if

        DisplayMailingRad();

        //Individual
    }		//changeOrgType

    function clearDD(obj) {
        obj.options.length = 1;
        //obj.options[0].innerText = '';
        $(obj.options[0]).text('');
    }

    function checkDisabled() {
        //var evt = parent.MenuWin.getEvent(this);
        var evt = window.event || arguments.callee.caller.arguments[0];
        var source = parent.getEventSource(evt);

        if ($(source).attr('class') == 'inpDisabled') {
            return evt.returnValue = false;
        }
    }

    function ValidateStartDate() {
        var s, d = new Date();
        s = (d.getMonth() + 1) + '/';
        s += d.getDate() + '/';
        s += (d.getYear() - 2);

        return (s)
    }		//ValidateStartDate

    function DisplayMailingRad() {
        //	sMailingAdd = false
        if (parent.sNew == false) {
            return;
        }

        var ddOrgType = document.getElementById('ddOrgType');
        var OrgType = $("#ddOrgType option:selected").attr('CODE');
        var NAIC3val = $("#ddNAIC3 option:selected").attr('CODE');
        var radMailingAdd_1 = document.getElementById('radMailingAdd_1');
        var radMailingAdd_2 = document.getElementById('radMailingAdd_2');
        var radMailingAdd2_1 = document.getElementById('radMailingAdd2_1');
        var radMailingAdd2_2 = document.getElementById('radMailingAdd2_2');

        //if ($('#rowMailingAdd').css('display') == 'block') {
        //if ($(ddOrgType.options[ddOrgType.selectedIndex]).attr('CODE')  == '999' ||			//999 = Select
        //		$(ddNAIC3.options[ddNAIC3.selectedIndex]).attr('CODE') == null ||
        //		$(ddNAIC3.options[ddNAIC3.selectedIndex]).attr('CODE')  == '99999') {		//99999 = Non Busines


        if (OrgType == undefined || OrgType == '999' ||			//999 = Select
                NAIC3val == undefined || NAIC3val == null ||
                NAIC3val == '99999') {		//99999 = Non Busines

            $('#rowMailingAdd').css('visibility', 'hidden');
            $('#rowMailingAdd').css('display', 'none');
            //rowMailingAdd.style.visibility = 'hidden';

            //suman -----------------------
            //radMailingAdd_1.checked = false;
            //radMailingAdd_2.checked = false;
            radMailingAdd_1.checked = false;
            radMailingAdd_2.checked = false;
            //----------------------------------
            /*EGOVWEB-22			rowMailingAdd1.style.display = 'none'
                        rowMailingAdd1.style.visibility = 'hidden'
                        rowMailingAdd1.disabled = true
                        radMailingAdd1_1.checked = false
                        radMailingAdd1_2.checked = false	*/
            $('#rowMailingAdd2').css('visibility', 'hidden');
            $('#rowMailingAdd2').css('display', 'none');
            //rowMailingAdd2.style.visibility = 'hidden';

            radMailingAdd2_1.checked = false;
            radMailingAdd2_2.checked = false;
        }
        else {

            //EHD Radio Issue
            //EGOVWEB-22
            //EGOVWEB-22			ValidateProf()
            //$('#rowMailingAdd').css('visibility = 'visible';
            $('#rowMailingAdd').removeAttr('disabled');
            $('#rowMailingAdd').css('visibility', 'visible');
            $('#rowMailingAdd').css('display', '');
            /*EGOVWEB-22				rowMailingAdd1.style.display = 'block'
                            rowMailingAdd1.style.visibility = 'visible'
                            rowMailingAdd1.disabled = false	*/

            $('#rowMailingAdd2').css('visibility', 'visible');
            $('#rowMailingAdd2').css('display', '');
            //rowMailingAdd2.style.display = 'block';
            //rowMailingAdd2.style.visibility = 'visible';

            $('#rowMailingAdd2').removeAttr('disabled');
            //rowMailingAdd2.disabled = false;		
            radMailingAdd2_1.checked = false;
            radMailingAdd2_2.checked = false;
            /*/EGOVWEB-22			if (radMailingAdd_2.checked == true)	{
                            rowMailingAdd1.style.display = 'none'
                            rowMailingAdd1.style.visibility = 'hidden'
                            rowMailingAdd1.disabled = true
                            radMailingAdd1_1.checked = false
                            radMailingAdd1_2.checked = false
                            rowMailingAdd2.style.display = 'block'
                            rowMailingAdd2.style.visibility = 'visible'
                            rowMailingAdd2.disabled = false
                        }		//if	*/
        }		//if
        //EGOVWEB-22		changeMailingAdd()
        //}		//if
    }		//DisplayMailingRad

    function changeMailingAdd() {
        //EGOVWEB-28	sMailingAdd = false
        bAddrRequired = false;
        var radMailingAdd_1 = document.getElementById('radMailingAdd_1');
        var radMailingAdd_2 = document.getElementById('radMailingAdd_2');
        var txtBusZip = document.getElementById('txtBusZip');

        if ($('#rowMailingAdd').css('visibility') == 'visible') {
            if ($('#rowMailingAdd').is(':disabled') == false || $('#rowMailingAdd').is(':disabled') == false) {
                if (radMailingAdd_1.checked == true) {
                    radMailingAdd_2.checked = false;
                    //EGOVWEB-28 Add address to address tab
                    //EGOVWEB-28				sMailingAdd = true
                    if (sMailingAdd == -1) {
                        CreateAltAddr();
                    }		//if
                    //EGOVWEB-71 Change second question
                    var sAddType = ' 08 17 18 19 ';	//Phila or vicinity
                    if (sAddType.search(txtBusZip.value.substr(0, 2)) != '-1') {
                        $('#lblQuestion2').html('Do you have any <span style="color:red">additional</span> business locations in Philadelphia or its vicinity?');
                    }
                    else {
                        $('#lblQuestion2').html('Do you have any business locations in Philadelphia or its vicinity?');
                    }		//if
                    //EGOVWEB-28 Remove address from address tab if created from true statement
                }
                else {
                    if (sMailingAdd != -1) {
                        parent.$x.ispXmlRemoveNode(parent.$g.xmlAccount, 'ACCTTEMPLATE', 0, 'NAME_ADDRESS', sMailingAdd);
                        sMailingAdd = -1;
                        CreateAddressTable();
                    }		//if
                }		//if
                if (radMailingAdd_2.checked == true) {
                    // SUMAN  experimental change for registration address error
                    //alert('iAltAddressIdx : ' + iAltAddressIdx);
                    //this line will force user to put address if radio btn no is selected on row 1
                    bAddrRequired = true;
                    //suman --------------------------------------------------
                    if (iAltAddressIdx == '') {
                        bAddrRequired = true;
                    }		//if
                    //EGOVWEB-71 Change second question
                    $('#lblQuestion2').html('Do you have any business locations in Philadelphia or its vicinity?');
                }		//if
                if (radMailingAdd2_1.checked == true) {
                    // 				parent.NavWin.imgAddresses.src = '../Images/address_tbd.gif'
                    //				parent.NavWin.imgAddresses.title = 'Required'
                    bAddrRequired = true;
                }
                else {
                    //				parent.NavWin.imgAddresses.src = '../Images/address_opt.gif'
                    //				parent.NavWin.imgAddresses.title = ''
                    //EGOVWEB-22				bAddrRequired = false		
                }		//if
            }
            else {
                //			parent.NavWin.imgAddresses.src = '../Images/address_opt.gif'
                //			parent.NavWin.imgAddresses.title = ''
                //EGOVWEB-22			bAddrRequired = false
            }		//if
        }		//if
    }		//changeMailingAdd

    function ProfileDisplayDropdowns(lYesNo) {
        var lLocked;
        if (lYesNo == true) {
            lYesNo = 'inline';
            lLocked = false;
        } else {
            lYesNo = 'none';
            lLocked = true;
        }		//if

        $('#AcctProfile').find('INPUT').each(function () {
            //		AcctProfile.getElementsByTagName('SELECT').item(k).style.display = lYesNo
        });

        $('#ddBusState').css('display', lYesNo);
        $('#ddNAIC1').css('display', lYesNo);
        $('#ddNAIC2').css('display', lYesNo);
        $('#ddNAIC3').css('display', lYesNo);

        //ddRace.disabled = lLocked;
        if (lLocked == false) {
            $('#ddRace').removeAttr('disabled');
            $('#ddGender').removeAttr('disabled');
        }
        else {
            $('#ddRace').attr('disabled', lLocked);
            $('#ddGender').attr('disabled', lLocked);
        }
        //ddGender.disabled = lLocked;

        $('#AcctProfile').find('INPUT').each(function () {
            lLocked == false ? $(this).removeAttr('disabled') : $(this).attr('disabled', lLocked);

            //$(this).eq(k).attr('disabled', lLocked);
            //AcctProfile.getElementsByTagName('INPUT').item(k).readOnly = lLocked
        });
    }


    function AC_ProfileDisabled(bDisabled) {
        parent.focus();
        if (parent.sNew == true) {
            //		ddTaxIDType.disabled = bDisabled		//always disabled
            //		txtIdNumber.disabled = bDisabled		//always disabled
            if (bDisabled == true) {
                $('#ddOrgType').attr('disabled', bDisabled);
                $('#txtBusStartDate').attr('disabled', bDisabled);
                $('#ddNAIC1').attr('disabled', bDisabled);
                $('#ddNAIC2').attr('disabled', bDisabled);
                $('#ddNAIC3').attr('disabled', bDisabled);
            }
            else {
                $('#ddOrgType').removeAttr('disabled');
                $('#txtBusStartDate').removeAttr('disabled');
                $('#ddNAIC1').removeAttr('disabled');
                $('#ddNAIC2').removeAttr('disabled');
                $('#ddNAIC3').removeAttr('disabled');
            }

            if ($('#divVoluntaryInfo').css('display') == 'block') {
                bDisabled == true ? $('#ddRace').attr('disabled', bDisabled) : $('#ddRace').removeAttr('disabled');
                bDisabled == true ? $('#txtRaceOther').attr('disabled', bDisabled) : $('#txtRaceOther').removeAttr('disabled');
                bDisabled == true ? $('#ddGender').attr('disabled', bDisabled) : $('#ddGender').removeAttr('disabled');

            }		//if
        }		//if	

        if (bDisabled == true) {
            $('#ddBusState').css('visibility', 'hidden');
            $('ddNAIC1').css('visibility', 'hidden');
            $('#ddNAIC2').css('visibility', 'hidden');
            $('#ddNAIC3').css('visibility', 'hidden');

            //ddNAIC1.style.visibility = 'hidden';
            //ddNAIC2.style.visibility = 'hidden';
            //ddNAIC3.style.visibility = 'hidden';
        } else {
            $('#ddBusState').css('visibility', 'visible');
            $('ddNAIC1').css('visibility', 'visible');
            $('#ddNAIC2').css('visibility', 'visible');
            $('#ddNAIC3').css('visibility', 'visible');

            //ddBusState.style.visibility = 'visible';
            //ddNAIC1.style.visibility = 'visible';
            //ddNAIC2.style.visibility = 'visible';
            //ddNAIC3.style.visibility = 'visible';
        }		//if

        if ($('#rowEntityName').css('display') == 'block') {
            bDisabled == true ? $('#txtEntityName').attr('disabled', bDisabled) : $('#txtEntityName').removeAttr('disabled');
            //txtBusAreaCode.disabled = bDisabled;
            bDisabled == true ? $('#txtBusAreaCode').attr('disabled', bDisabled) : $('#txtBusAreaCode').removeAttr('disabled');
            //txtBusPhone1.disabled = bDisabled;
            bDisabled == true ? $('#txtBusPhone1').attr('disabled', bDisabled) : $('#txtBusPhone1').removeAttr('disabled');
            //txtBusPhone2.disabled = bDisabled;
            bDisabled == true ? $('#txtBusPhone2').attr('disabled', bDisabled) : $('#txtBusPhone2').removeAttr('disabled');
            //txtBusAreaCode.disabled = bDisabled;
            bDisabled == true ? $('#txtBusAreaCode').attr('disabled', bDisabled) : $('#txtBusAreaCode').removeAttr('disabled');
            //txtBusPhone1.disabled = bDisabled;
            bDisabled == true ? $('#txtBusPhone1').attr('disabled', bDisabled) : $('#txtBusPhone1').removeAttr('disabled');
            //txtBusPhone2.disabled = bDisabled;
            bDisabled == true ? $('#txtBusPhone2').attr('disabled', bDisabled) : $('#txtBusPhone2').removeAttr('disabled');
            //txtBusPhoneExt.disabled = bDisabled;
            bDisabled == true ? $('#txtBusPhoneExt').attr('disabled', bDisabled) : $('#txtBusPhoneExt').removeAttr('disabled');
        }
        else {
            //txtFirstName.disabled = bDisabled;
            bDisabled == true ? $('#txtFirstName').attr('disabled', bDisabled) : $('#txtFirstName').removeAttr('disabled');

            //txtLastName.disabled = bDisabled;
            bDisabled == true ? $('#txtLastName').attr('disabled', bDisabled) : $('#txtLastName').removeAttr('disabled');

            //txtMIName.disabled = bDisabled;
            bDisabled == true ? $('#txtMIName').attr('disabled', bDisabled) : $('#txtMIName').removeAttr('disabled');

            //txtHomeAreaCode.disabled = bDisabled;
            bDisabled == true ? $('#txtHomeAreaCode').attr('disabled', bDisabled) : $('#txtHomeAreaCode').removeAttr('disabled');

            //txtHomePhone1.disabled = bDisabled;
            bDisabled == true ? $('#txtHomePhone1').attr('disabled', bDisabled) : $('#txtHomePhone1').removeAttr('disabled');

            //txtHomePhone2.disabled = bDisabled;
            bDisabled == true ? $('#txtHomePhone2').attr('disabled', bDisabled) : $('#txtHomePhone2').removeAttr('disabled');

            //txtHomeAreaCode.disabled = bDisabled;
            bDisabled == true ? $('#txtHomeAreaCode').attr('disabled', bDisabled) : $('#txtHomeAreaCode').removeAttr('disabled');

            //txtHomePhone1.disabled = bDisabled;
            bDisabled == true ? $('#txtHomePhone1').attr('disabled', bDisabled) : $('#txtHomePhone1').removeAttr('disabled');

            //txtHomePhone2.disabled = bDisabled;
            bDisabled == true ? $('#txtHomePhone2').attr('disabled', bDisabled) : $('#txtHomePhone2').removeAttr('disabled');
        }		//if

        //txtTradeName.disabled = bDisabled;
        bDisabled == true ? $('#txtTradeName').attr('disabled', bDisabled) : $('#txtTradeName').removeAttr('disabled');

        //txtBusAddress1.disabled = bDisabled;
        bDisabled == true ? $('#txtBusAddress1').attr('disabled', bDisabled) : $('#txtBusAddress1').removeAttr('disabled');

        //txtBusAddress2.disabled = bDisabled;
        bDisabled == true ? $('#txtBusAddress2').attr('disabled', bDisabled) : $('#txtBusAddress2').removeAttr('disabled');

        //txtBusCity.disabled = bDisabled;
        bDisabled == true ? $('#txtBusCity').attr('disabled', bDisabled) : $('#txtBusCity').removeAttr('disabled');

        //ddBusState.disabled = bDisabled;
        bDisabled == true ? $('#ddBusState').attr('disabled', bDisabled) : $('#ddBusState').removeAttr('disabled');

        //txtBusZip.disabled = bDisabled;
        bDisabled == true ? $('#txtBusZip').attr('disabled', bDisabled) : $('#txtBusZip').removeAttr('disabled');

        //txtBusZipExt.disabled = bDisabled;
        bDisabled == true ? $('#txtBusZipExt').attr('disabled', bDisabled) : $('#txtBusZipExt').removeAttr('disabled');

        //txtFaxAreaCode.disabled = bDisabled;
        bDisabled == true ? $('#txtFaxAreaCode').attr('disabled', bDisabled) : $('#txtFaxAreaCode').removeAttr('disabled');

        //txtFaxPhone1.disabled = bDisabled;
        bDisabled == true ? $('#txtFaxPhone1').attr('disabled', bDisabled) : $('#txtFaxPhone1').removeAttr('disabled');

        //txtFaxPhone2.disabled = bDisabled;
        bDisabled == true ? $('#txtFaxPhone2').attr('disabled', bDisabled) : $('#txtFaxPhone2').removeAttr('disabled');

        //txtEmail.disabled = bDisabled;
        bDisabled == true ? $('#txtEmail').attr('disabled', bDisabled) : $('#txtEmail').removeAttr('disabled');
    }		//AC_ProfileDisabled

    function AC_ProfileChangePopulate() {
        //EHD - 2008.12.01 - Added for the Code1 Addition
        //EGOVWEB-82
        var txtBusAddress1 = document.getElementById('txtBusAddress1');
        var txtBusCity = document.getElementById('txtBusCity');
        var ddBusState = document.getElementById('ddBusState');
        var txtBusZip = document.getElementById('txtBusZip');
        var txtBusZipExt = document.getElementById('txtBusZipExt');

        txtBusAddress1.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address1', '', 0) + " " + parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address2', '', 0)
        //	txtBusAddress2.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Address2', '', 0)
        txtBusCity.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'City', '', 0).substring(0, 20)
        SetDDList(ddBusState, '', parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'State', '', 0), null)
        txtBusZip.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Zip', '', 0)
        txtBusZipExt.value = parent.$x.ispXmlGetFieldVal(xmlCode1Return, 'Zip4', '', 0)
    }		//ProfileAddressChangePopulate

    function Profile_Print(bPrint) {
        if (bPrint == true) {
            $('#AcctProfile').css('display', 'block');
            $('#divVoluntaryInfo').css('display', 'block');
            $('#PrintProfileHdr').css('display', 'block');
            $('#ProfileNextMessage').css('display', 'none');
            $('#lblEntNameMessage').html('');
            $('#lblIndNameMessage').html('');
            changeOrgType()
        } else {
            //		AcctProfile.style.display = 'none'
            $('#PrintProfileHdr').css('display', 'none');
            $('#ProfileNextMessage').css('display', 'block');
            $('#lblEntNameMessage').html(' (Entity Name cannot be changed on-line)');
            $('#lblIndNameMessage').html(' (Individual Name cannot be changed on-line)');
            changeOrgType()
        }		//if
    }		//Print_Profile

</script>


<div class="container-fluid no-padding">
    <div class="block3">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 col-md-12">
                    <div class="surround_padding">
                        <div class="tabs_section">
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs"  style="float: right; margin-right:3px;" role="tablist">
                                <li role="presentation"><a onclick="ShowForm('AcctProfile');">Profile</a></li>
                                <li role="presentation"><a onclick="ShowForm('AcctTaxes');">TAX Type</a></li>
                                <li role="presentation"><a onclick="ShowForm('AcctAddresses');">Address</a></li>
                                <li role="presentation"><a onclick="ShowForm('AcctPartners');">Officer </a></li>
                            </ul>
                            <div class="clearfix"></div>

                            <!-- Tab panes -->
                            <%--      <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist" style="float:right;">
                    <li><a onclick="ShowForm('AcctProfile');">Profile</a></li>
                    <li><a onclick="ShowForm('AcctTaxes');">TAX Type</a></li>
                    <li><a onclick="ShowForm('AcctAddresses');">Address</a></li>
                    <li><a onclick="ShowForm('AcctPartners');">Officer </a></li>
                </ul>
                 <div class="clearfix"></div>
                      <!-- Tab panes -->   --%>

                            <div class="tab-content customtabs">
                                <div style="display: none;" id="AcctProfile" role="tabpanel" class="tab-pane active">
                                    <h2>Tax Payer Information  |   <span>Profile</span>  </h2>
                                    <div class="inner_white-panel">
                                        <div class="contentsection">
                                            <h4><a href="#" target="_self">Click here</a> for more information on completing this screen. Please review this instructions before completing this Application. </h4>
                                            <br>
                                            <div class="row">
                                                <div class="col-lg-8 col-lg-offset-1 no-padding-left">
                                                    <form class="form-horizontal addressee_form">

                                                        <div class="form-group">

                                                            <label class="col-sm-3 control-label text-left-custom">Entity Identifire : </label>

                                                            <div class="col-sm-3 below_margin01">

                                                                <select id="ddTaxIDType" class="form-control"></select>


                                                            </div>
                                                            <div class="col-sm-6">
                                                                <input class="form-control input-sm" id="txtIdNumber" align="right" maxlength="12" size="14" name="txtIdNumber"
                                                                    onchange="ValidateProf()">
                                                            </div>

                                                        </div>

                                                        <div class="form-group">

                                                            <label class="col-sm-3 control-label text-left-custom">Organization Type * : </label>

                                                            <div class="col-sm-9">
                                                                <select id="ddOrgType" class="form-control"
                                                                    onchange="changeOrgType();ValidateProf()">
                                                                </select>


                                                            </div>


                                                        </div>


                                                        <div class="form-group" id="rowEntityName">

                                                            <label class="col-sm-3 control-label text-left-custom">Entity Name* :</label>

                                                            <div class="col-sm-9">
                                                                <input id="txtEntityName" maxlength="40" size="48" class="form-control input-sm" name="txtEntityName" onchange="ValidateProf()">

                                                                <span class="small_span">(Entity Name cannot be changed on-line)</span>

                                                            </div>

                                                        </div>

                                                        <div class="form-group" id="rowIndName" style="display: none;">

                                                            <label class="col-sm-3 control-label text-left-custom">First, Middle, Last Name* :</label>

                                                            <div class="col-sm-2 below_margin01">
                                                                <input class="form-control input-sm" id="txtFirstName" maxlength="19" size="23" onchange="ValidateProf()">
                                                            </div>
                                                            <div class="col-sm-2 below_margin01">
                                                                <input class="form-control input-sm" id="txtMIName" maxlength="1" size="1" onchange="ValidateProf()">
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <input class="form-control input-sm" id="txtLastName" maxlength="20" size="24" onchange="ValidateProf()">
                                                                <span class="here_alert additional_margin_span">(Individual Name cannot be changed on-line)</span>

                                                            </div>

                                                        </div>


                                                        <div class="form-group">

                                                            <label class="col-sm-3 control-label text-left-custom">Trade Name : </label>

                                                            <div class="col-sm-9">
                                                                <input id="txtTradeName" class="form-control input-sm" maxlength="40" size="48"
                                                                    onchange="ValidateProf()">
                                                            </div>
                                                        </div>


                                                        <div class="form-group">

                                                            <label class="col-sm-3 control-label text-left-custom">Mailing Address* : </label>

                                                            <div class="col-sm-9">
                                                                <input id="txtBusAddress1" class="form-control input-sm" maxlength="30" size="35"
                                                                    onchange="ValidateProf()">
                                                            </div>

                                                        </div>

                                                        <div id="rowBusAddress2" style="display: none;" class="form-group">

                                                            <label></label>

                                                            <div class="col-sm-9">
                                                                <input class="form-control input-sm" id="txtBusAddress2" maxlength="30" size="35"
                                                                    onchange="ValidateProf()">
                                                            </div>
                                                        </div>


                                                        <div class="form-group">

                                                            <label class="col-sm-3 control-label text-left-custom">City / State / Zip* : </label>

                                                            <div class="col-sm-2 below_margin01">

                                                                <input class="form-control input-sm" id="txtBusCity" maxlength="20" size="25"
                                                                    onchange="ValidateProf()">
                                                            </div>
                                                            <div class="col-sm-2 below_margin01">
                                                                <select class="form-control" id="ddBusState" name="ddBusState" onchange="ValidateProf()">
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-2 below_margin01">
                                                                <input class="form-control input-sm" id="txtBusZip" maxlength="5" size="6"
                                                                    onchange="ValidateProf()">
                                                            </div>
                                                            <div class="col-sm-2">
                                                                <input class="form-control input-sm" id="txtBusZipExt" maxlength="4" size="5"
                                                                    onchange="ValidateProf()">
                                                            </div>

                                                        </div>


                                                        <div class="form-group">

                                                            <label class="col-sm-3 control-label text-left-custom">Work Phone* : </label>

                                                            <div class="col-sm-2 below_margin01">
                                                                <input class="form-control input-sm" id="txtBusAreaCode" maxlength="3" size="4"
                                                                    onchange="ValidateProf()">
                                                            </div>
                                                            <div class="col-sm-2 below_margin01">

                                                                <input class="form-control input-sm" id="txtBusPhone1" maxlength="3" size="4"
                                                                    onchange="ValidateProf()">
                                                            </div>
                                                            <div class="col-sm-2 below_margin01">
                                                                <input class="form-control input-sm" id="txtBusPhone2" name="txtBusPhone2" maxlength="4" size="5"
                                                                    onchange="ValidateProf()">
                                                            </div>

                                                            <div class="col-sm-3 customwidth_input">
                                                                <span class="small_span2">Ext:</span>
                                                                <input class="form-control input-sm" id="txtBusPhoneExt" name="txtBusPhoneExt" maxlength="5" size="6" onchange="ValidateProf()">
                                                            </div>
                                                        </div>



                                                        <div class="form-group">

                                                            <label class="col-sm-3 control-label text-left-custom">Fax : </label>

                                                            <div class="col-sm-3 below_margin01">
                                                                <input class="form-control input-sm" id="txtFaxAreaCode" maxlength="3" size="4" name="txtFaxAreaCode"
                                                                    onchange="ValidateProf()">
                                                            </div>
                                                            <div class="col-sm-3 below_margin01">
                                                                <input class="form-control input-sm" id="txtFaxPhone1" maxlength="3" name="txtFaxPhone1" size="4"
                                                                    onchange="ValidateProf()">
                                                            </div>
                                                            <div class="col-sm-3 below_margin01">
                                                                <input class="form-control input-sm" id="txtFaxPhone2" maxlength="4" size="5" name="txtFaxPhone2"
                                                                    onchange="ValidateProf()">
                                                            </div>

                                                        </div>


                                                        <div class="form-group">

                                                            <label class="col-sm-3 control-label text-left-custom">Home Phone : </label>

                                                            <div class="col-sm-3 below_margin01">

                                                                <input class="form-control input-sm" id="txtHomeAreaCode" name="txtHomeAreaCode" maxlength="3" size="4"
                                                                    onchange="ValidateProf()">
                                                            </div>
                                                            <div class="col-sm-3 below_margin01">
                                                                <input class="form-control input-sm" id="txtHomePhone1" name="txtHomePhone1" maxlength="3" size="4"
                                                                    onchange="ValidateProf()">
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <input class="form-control input-sm" id="txtHomePhone2" name="txtHomePhone2" maxlength="4" size="5"
                                                                    onchange="ValidateProf()">
                                                            </div>

                                                        </div>


                                                        <div class="form-group">

                                                            <label class="col-sm-3 control-label text-left-custom">Email Address* : </label>

                                                            <div class="col-sm-9">
                                                                <input id="txtEmail" maxlength="40" size="48" name="txtEmail" onchange="ValidateProf()" class="form-control input-sm" style="text-transform: none">
                                                            </div>

                                                        </div>


                                                        <div class="form-group">

                                                            <label class="col-sm-3 control-label text-left-custom">Philadelphia Start Date* : </label>

                                                            <div class="col-sm-9">
                                                                <input class="form-control input-sm" id="txtBusStartDate" maxlength="10" size="12"
                                                                    onchange="ValidateDate();ValidateProf()" onblur="">( mm / dd / yyyy )                       
                                        
                                                            </div>

                                                        </div>

                                                        <div class="form-group">

                                                            <label class="col-sm-3 control-label text-left-custom">Type of Business* : </label>

                                                            <div class="col-sm-3 below_margin01">
                                                                <select class="form-control" id="ddNAIC1" onchange="changeNAIC();ValidateProf()">
                                                                    <option selected></option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-3 below_margin01">
                                                                <select class="form-control" id="ddNAIC2" onchange="changeNAIC();ValidateProf()">
                                                                    <option selected></option>
                                                                </select>
                                                            </div>
                                                            <div class="col-sm-3 below_margin01">
                                                                <select class="form-control" id="ddNAIC3" onchange="changeNAIC();ValidateProf()">
                                                                    <option selected></option>
                                                                </select>

                                                            </div>
                                                        </div>
                                                        <div class="row">

                                                            <div class="col-lg-12">


                                                                <div class="form-horizontal addressee_form">
                                                                    <div class="form-group" id="rowMailingAdd" style="display: none; visibility: hidden">



                                                                        <div class="col-sm-10">
                                                                            <div class="checkbox">
                                                                                <label>*</label>
                                                                                <label>
                                                                                    <input value="Yes" type="radio" id="radMailingAdd_1" name="rowMailingAdd" onclick="changeMailingAdd(); ValidateProf()">Yes
                            
			            <input value="No" type="radio" id="radMailingAdd_2" name="rowMailingAdd" onclick="changeMailingAdd(); ValidateProf()">No 
                                                                                </label>
                                                                            </div>
                                                                            <h4>Is the mailing address the same as the business location?</h4>

                                                                        </div>


                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">

                                                            <div class="col-lg-12">


                                                                <div class="form-horizontal addressee_form">
                                                                    <div class="form-group" id="rowMailingAdd2" style="display: none; visibility: hidden">


                                                                        <div class="col-sm-10">

                                                                            <div class="checkbox">
                                                                                <label>*</label>
                                                                                <label>
                                                                                    <input value="Yes" type="radio" id="radMailingAdd2_1" name="rowMailingAdd2"
                                                                                        onclick="changeMailingAdd(); ValidateProf()">Yes
                            
			                            <input value="No" type="radio" id="radMailingAdd2_2" name="rowMailingAdd2"
                                            onclick="changeMailingAdd(); ValidateProf()">No
                                                                                </label>
                                                                            </div>
                                                                            <h4>Do you have any business locations in Philadelphia or its vicinity?</h4>

                                                                        </div>


                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <%-- table start--%>
                                                        <div class="row">

                                                            <div class="col-lg-12">

                                                                <div class="table-responsive" id="divVoluntaryInfo" style="display: none;">

                                                                    <table class="table table-condensed table-striped custom_table02 no_margin_top">

                                                                        <thead>
                                                                            <tr>
                                                                                <th width="100%" class="text-left">Optional Information </th>
                                                                            </tr>
                                                                        </thead>

                                                                        <tbody>

                                                                            <tr>
                                                                                <td>

                                                                                    <div class="form-horizontal addressee_form">

                                                                                        <div class="form-group no-margin">

                                                                                            <div class="col-lg-4">

                                                                                                <label class="col-sm-3 control-label" for="inputEmail3">Race/Ethnicity:</label>
                                                                                                <div class="col-sm-9">
                                                                                                    <select id="ddRace" class="form-control" onchange="ValidateProf()">
                                                                                                        <option selected></option>
                                                                                                    </select>
                                                                                                </div>

                                                                                            </div>

                                                                                            <div class="col-lg-4">

                                                                                                <label class="col-sm-3 control-label" for="inputEmail3">If others :</label>
                                                                                                <div class="col-sm-9">
                                                                                                    <input id="txtRaceOther" class="form-control" onchange="ValidateProf()" size="10">
                                                                                                </div>


                                                                                            </div>

                                                                                            <div class="col-lg-4">

                                                                                                <label class="col-sm-3 control-label" for="inputEmail3">Sex :</label>
                                                                                                <div class="col-sm-9">
                                                                                                    <select id="ddGender" class="form-control" onchange="ValidateProf()">
                                                                                                        <option selected></option>
                                                                                                    </select>
                                                                                                </div>

                                                                                            </div>

                                                                                        </div>

                                                                                    </div>

                                                                                </td>

                                                                            </tr>

                                                                        </tbody>
                                                                    </table>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%-- table end--%>
                                                        <h4 id="ProfileNextMessage" class="text-left-custom">Click on the Tax Type 
		            button to continue the registration process.</h4>

                                                        <div class="form-group" id="divbtnSubmit" style="display: block">
                                                            <div class="col-sm-offset-3 col-sm-9  text-right">
                                                                <%--<button type="submit" class="btn btn-default submit_button">Sign in</button>--%>
                                                                <a class="btn btn-default submit_button" onclick="DoSubmit()" id="imgSubmit">Submit</a>
                                                            </div>
                                                        </div>

                                                    </form>
                                                </div>

                                                <div class="clearfix"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>



                                <%Html.RenderAction("Taxes", "Acct"); %>

                                <%Html.RenderAction("Addresses", "Acct"); %>

                                <%Html.RenderAction("Partners_Officers", "Acct"); %>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>
