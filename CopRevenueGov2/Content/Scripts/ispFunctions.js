


    var conBgBusy = ''
    var conBgNotBusy = '#ffffff';

    function ispSetFocus(oControl) {

        if (oControl.disabled == false) {
            oControl.focus();
        }
    }

    function ispResetObj(obj) {
        var i, lAlign;

        for (i = 0; i != obj.length; i++) {
            if ($(obj[i]).css('textAlign') == 'right') {
                $(obj[i]).attr('class', 'inpNormal');
                $(obj[i]).css('textAlign', 'right');
            } else {
                $(obj[i]).attr('class', 'inpNormal');
            }

            if (obj[i].type == 'select-one') {
                obj[i].selectedIndex = 0;
            } else if (obj[i].type == 'radio' || obj[i].type == 'checkbox') {
                obj[i].checked = false;
                $(obj[i]).attr('class', '');
            } else {
                obj[i].value = '';
            }
        }

        if (obj[0].type != 'select-one' && obj[0].disabled == false) {
            obj[0].focus();
        }
    }

    function ispDisableObj(blnMode, obj) {
        var i

        if (blnMode == true) {
            blnMode = false;
        } else {
            blnMode = true;
        }

        for (i = 0; i != obj.length; i++) {
            obj[i].disabled = blnMode

            if (obj[i].type != 'radio' && obj[i].type != 'checkbox') {
                if (blnMode == false) {
                    $(obj[i]).attr('class', 'inpNormal');
                } else {
                    $(obj[i]).attr('class', 'inpDisabled');
                }
            }
        }

        if (blnMode == false) {
            obj[0].focus()
        }
    }
//manoranjan calling for all form only
    function ispSetInputErr_Form(ErrorArray) {

        var evt = window.event || arguments.callee.caller.caller.arguments[0] || arguments.callee.caller.caller.caller.arguments[0];

        var source = null;
        if (evt != undefined && evt != null) {
            source = evt.target || evt.srcElement;
        }


        var i;
        var currObj;
        var returnMessage = '';
        var rcElementlS;
        var lSrcElement;
        var styleClassName = new Array();

        var ispNORMAL = 0;
        var ispERROR = 1;
        var ispDISABLED = 2;
        styleClassName[ispNORMAL] = 'inpNormal form-control input-sm pull-right';
        styleClassName[ispERROR] = 'inpError form-control input-sm pull-right';
        styleClassName[ispDISABLED] = 'inpDisabled';


        if (evt && (evt.type == 'change' || evt.type == 'click')) {

            if (source.type == 'button') {
                lSrcElement = '';
            } else {
                lSrcElement = source.id;
            }
        } else {
            lSrcElement = '';
        }



        for (i = 0; i != ErrorArray.length; i++) {
            if (ErrorArray[i]) {
                if (lSrcElement == '' && $(ErrorArray[i][0]).attr('class') == styleClassName[ispDISABLED]) {
                    //Skip disabled elements
                } else if (lSrcElement == '' && $(ErrorArray[i][0]).attr('class') != styleClassName[ispERROR]) {
                    // ispTrim(ErrorArray[i][0]);//Sangha
                    if (eval(ErrorArray[i][1])) {
                        $(ErrorArray[i][0]).attr('class', styleClassName[ispERROR]);
                        $(ErrorArray[i][0]).attr('errNo', i);
                        if (returnMessage == '') {
                            returnMessage = ErrorArray[i][2];
                        }
                    } else {
                        $(ErrorArray[i][0]).attr('class', styleClassName[ispNORMAL]);
                        $(ErrorArray[i][0]).attr('errNo', '');
                    }
                    // OnChange event of a field fired only check that field [lSrcElement]
                }
                else {
                    if (lSrcElement == ErrorArray[i][0].id) {

                        //  ispTrim(ErrorArray[i][0]);//Sangha

                        if (eval(ErrorArray[i][1])) {
                            $(ErrorArray[i][0]).attr('class', styleClassName[ispERROR]);
                            $(ErrorArray[i][0]).attr('errNo', i);
                            if (returnMessage == '') {
                                returnMessage = ErrorArray[i][2];
                            }
                            break;
                        } else {
                            $(ErrorArray[i][0]).attr('class', styleClassName[ispNORMAL]);
                            $(ErrorArray[i][0]).attr('errNo', '');
                        }
                    }
                    if ($(ErrorArray[i][0]).attr('class') == styleClassName[ispERROR]) {
                        if (returnMessage == '' && $(ErrorArray[i][0]).attr('errNo') == i.toString()) {
                            returnMessage = ErrorArray[i][2];
                        }
                    }
                }
            }
            if (ErrorArray[i][0].type == 'radio' || ErrorArray[i][0].type == 'checkbox') {
                $(ErrorArray[i][0]).attr('class', '');
            }
        }

        return returnMessage;
    }

    function ispSetInputErr(ErrorArray) {       
        
        var evt = window.event || arguments.callee.caller.caller.arguments[0] || arguments.callee.caller.caller.caller.arguments[0];

        var source = null;
        if (evt != undefined && evt != null) {
            source = evt.target || evt.srcElement;
        }


        var i;
        var currObj;
        var returnMessage = '';
        var rcElementlS;
        var lSrcElement;
        var styleClassName = new Array();

        var ispNORMAL = 0;
        var ispERROR = 1;
        var ispDISABLED = 2;
        styleClassName[ispNORMAL] = 'inpNormal form-control input-sm';
        styleClassName[ispERROR] = 'inpError form-control input-sm';
        styleClassName[ispDISABLED] = 'inpDisabled';


        if (evt && (evt.type == 'change' || evt.type == 'click')) {

            if (source.type == 'button') {
                lSrcElement = '';
            } else {
                lSrcElement = source.id;
                if (source.id == 'taxtype') {
                    lSrcElement = '';
                }
                if (source.id == 'Address') {
                    lSrcElement = '';
                }
                if (source.id == 'Officer') {
                    lSrcElement = '';
                }
            }
        } else {
            lSrcElement = '';
        }



        for (i = 0; i != ErrorArray.length; i++) {
            if (ErrorArray[i]) {
                if (lSrcElement == '' && $(ErrorArray[i][0]).attr('class') == styleClassName[ispDISABLED]) {
                    //Skip disabled elements
                } else if (lSrcElement == '' && $(ErrorArray[i][0]).attr('class') != styleClassName[ispERROR]) {
                   // ispTrim(ErrorArray[i][0]);//Sangha
                    if (eval(ErrorArray[i][1])) {
                        $(ErrorArray[i][0]).attr('class', styleClassName[ispERROR]);
                        $(ErrorArray[i][0]).attr('errNo', i);
                        if (returnMessage == '') {
                            returnMessage = ErrorArray[i][2];
                        }
                    } else {
                        $(ErrorArray[i][0]).attr('class', styleClassName[ispNORMAL]);
                        $(ErrorArray[i][0]).attr('errNo', '');
                    }
                    // OnChange event of a field fired only check that field [lSrcElement]
                }
                else {
                    if (lSrcElement == ErrorArray[i][0].id) {

                      //  ispTrim(ErrorArray[i][0]);//Sangha

                        if (eval(ErrorArray[i][1])) {
                            $(ErrorArray[i][0]).attr('class', styleClassName[ispERROR]);
                            $(ErrorArray[i][0]).attr('errNo', i);
                            if (returnMessage == '') {
                                returnMessage = ErrorArray[i][2];
                            }
                            break;
                        } else {
                            $(ErrorArray[i][0]).attr('class', styleClassName[ispNORMAL]);
                            $(ErrorArray[i][0]).attr('errNo', '');
                        }
                    }
                    if ($(ErrorArray[i][0]).attr('class') == styleClassName[ispERROR]) {
                        if (returnMessage == '' && $(ErrorArray[i][0]).attr('errNo') == i.toString()) {
                            returnMessage = ErrorArray[i][2];
                        }
                    }
                }
            }
            if (ErrorArray[i][0].type == 'radio' || ErrorArray[i][0].type == 'checkbox') {
                $(ErrorArray[i][0]).attr('class', '');
            }
        }

        return returnMessage;
    }

// only for password field
    function ispSetInputErr_pwd(ErrorArray) {

        var evt = window.event || arguments.callee.caller.caller.arguments[0] || arguments.callee.caller.caller.caller.arguments[0];

        var source = null;
        if (evt != undefined && evt != null) {
            source = evt.target || evt.srcElement;
        }


        var i;
        var currObj;
        var returnMessage = '';
        var rcElementlS;
        var lSrcElement;
        var styleClassName = new Array();

        var ispNORMAL = 0;
        var ispERROR = 1;
        var ispDISABLED = 2;
        styleClassName[ispNORMAL] = 'inpNormal form-control input-sm';
        styleClassName[ispERROR] = 'inpErrorPwd form-control input-sm';
        styleClassName[ispDISABLED] = 'inpDisabled';


        if (evt && (evt.type == 'change' || evt.type == 'click')) {

            if (source.type == 'button') {
                lSrcElement = '';
            } else {
                lSrcElement = source.id;
            }
        } else {
            lSrcElement = '';
        }



        for (i = 0; i != ErrorArray.length; i++) {
            if (ErrorArray[i]) {
                if (lSrcElement == '' && $(ErrorArray[i][0]).attr('class') == styleClassName[ispDISABLED]) {
                    //Skip disabled elements
                } else if (lSrcElement == '' && $(ErrorArray[i][0]).attr('class') != styleClassName[ispERROR]) {
                    // ispTrim(ErrorArray[i][0]);//Sangha
                    if (eval(ErrorArray[i][1])) {
                        $(ErrorArray[i][0]).attr('class', styleClassName[ispERROR]);
                        $(ErrorArray[i][0]).attr('errNo', i);
                        if (returnMessage == '') {
                            returnMessage = ErrorArray[i][2];
                        }
                    } else {
                        $(ErrorArray[i][0]).attr('class', styleClassName[ispNORMAL]);
                        $(ErrorArray[i][0]).attr('errNo', '');
                    }
                    // OnChange event of a field fired only check that field [lSrcElement]
                }
                else {
                    if (lSrcElement == ErrorArray[i][0].id) {

                        //  ispTrim(ErrorArray[i][0]);//Sangha

                        if (eval(ErrorArray[i][1])) {
                            $(ErrorArray[i][0]).attr('class', styleClassName[ispERROR]);
                            $(ErrorArray[i][0]).attr('errNo', i);
                            if (returnMessage == '') {
                                returnMessage = ErrorArray[i][2];
                            }
                            break;
                        } else {
                            $(ErrorArray[i][0]).attr('class', styleClassName[ispNORMAL]);
                            $(ErrorArray[i][0]).attr('errNo', '');
                        }
                    }
                    if ($(ErrorArray[i][0]).attr('class') == styleClassName[ispERROR]) {
                        if (returnMessage == '' && $(ErrorArray[i][0]).attr('errNo') == i.toString()) {
                            returnMessage = ErrorArray[i][2];
                        }
                    }
                }
            }
            if (ErrorArray[i][0].type == 'radio' || ErrorArray[i][0].type == 'checkbox') {
                $(ErrorArray[i][0]).attr('class', '');
            }
        }

        return returnMessage;
    }
    function ispSetProcessing(strMsg) {
        //suman -------------------------------
        var lbl = $(parent.NavWin.document).find('#lblProcessing').first();
        conBgBusy = lbl.css("backgroundColor");
        lbl.css('display', 'block');

        if (strMsg == '') {
            lbl.text('Processing Please Wait');
        } else {
            lbl.text(strMsg);
        }

        $(parent.NavWin.document).css('background', conBgBusy);
        $(parent.NavWin.document).css('background', conBgNotBusy);


        $(parent.NavWin.document).find('#btn1').first().attr('class', 'layHidden');
        $(parent.NavWin.document).find('#btn2').first().attr('class', 'layHidden');
        $(parent.NavWin.document).find('#btn3').first().attr('class', 'layHidden');
        $(parent.NavWin.document).find('#btn4').first().attr('class', 'layHidden');
        $(parent.NavWin.document).find('#btn5').first().attr('class', 'layHidden');

        ispSetFocus(lbl);
        //--------------------------------------
    }

    function ispClearProcessing() {
        //suman -----------------------------------------------------
        var lbl = $(parent.NavWin.document).find('#lblProcessing').first();

        if ($(lbl).css('display') == 'block') {
            $(lbl).css('display', 'none');

            $(parent.NavWin.document).css('background', conBgNotBusy);

            $(parent.NavWin.document).find('#btn1').first().attr('class', 'layVisible');
            $(parent.NavWin.document).find('#btn2').first().attr('class', 'layVisible');
            $(parent.NavWin.document).find('#btn3').first().attr('class', 'layVisible');
            $(parent.NavWin.document).find('#btn4').first().attr('class', 'layVisible');
            $(parent.NavWin.document).find('#btn5').first().attr('class', 'layVisible');
        }
    }
   
    function ispCallXMLForm(objRequestXml, oReplyXml, strAspPage, strMsg, IeCopyXmlToClipBoard) {
        try {
          
            if (IeCopyXmlToClipBoard && IeCopyXmlToClipBoard == true) {
                if (parent.$g.isXMLDOM()) {
                    clipboardData.setData('Text', objRequestXml.xml.xml);
                    alert(' Before HTTP request: XML copied to internet explorer\'s clip board. Now before hit OK, paste on a editor to get XML');
                }
            }
            else {
            }
        }
        catch (e) {
            alert(e);
        }

        var oMsg = parent.$g.getXmlHttpRequestObj();
        var strMessage = '';     
        oMsg.open("POST", strAspPage, false);

        oMsg.setRequestHeader("Content-Type", "text/xml-SOAP");       
        if (parent.$g.isXMLDOM()) {
            oMsg.send(objRequestXml.xml.xml);
        }
        else {
            oMsg.send(objRequestXml.xml);
        }
        var parse_errorcode = 0;
        try {
        
            oReplyXml.loadXML(oMsg.responseText);

            if (IeCopyXmlToClipBoard && IeCopyXmlToClipBoard == true) {
                if (parent.$g.isXMLDOM()) {
                    clipboardData.setData('Text', oReplyXml.xml.xml);
                    alert(' After HTTP response: XML copied to internet explorer\'s clip board. Now before hit OK, paste on a editor to get XML');
                }
            }
            else {
            }

        }
        catch (expression) {
            parse_errorcode = 1;
        }
        if (parse_errorcode != 0) {
            strMessage = "REPLY XML Parse";
            parent.$x.ispXmlSetFieldVal(oReplyXml, 'ispFunctions.js', 'ERROR_INFO PROGRAM', '', 0)
            parent.$x.ispXmlSetFieldVal(oReplyXml, strMessage, 'ERROR_INFO MESSAGE', '', 0)
        } else {

            if (strMessage == '') {

                return true;
            } else {
                return false;
            }
        }

    }

    function ispStandAlone(lFunction) {
        if (parent.DocWin) {
        } else {
            eval(lFunction)
        }
    }

    function ispLoadZipCode(objDDZip, ShowCode) {
        var iCount = parent.$x.ispXmlGetRecCount(parent.$g.xmlStatezip, "STATE", 'n');

        var strInnerText = 'DESC';

        if (ShowCode == true) {
            strInnerText = 'CODE';
        }

        objDDZip.options.length = iCount;
        for (i = 0; i < iCount; i++) {

            try {
                $(objDDZip.options[i]).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlStatezip, strInnerText, '', i));
                $(objDDZip.options[i]).attr('CODE', parent.$x.ispXmlGetFieldVal(parent.$g.xmlStatezip, 'CODE', '', i))
                $(objDDZip.options[i]).attr('MaxZip', parent.$x.ispXmlGetFieldVal(parent.$g.xmlStatezip, 'MAXZIP', '', i));
                $(objDDZip.options[i]).attr('MinZip', parent.$x.ispXmlGetFieldVal(parent.$g.xmlStatezip, 'MINZIP', '', i));
            }
            catch (expression) {
                alert('ispLoadZipCode :' + expression + " at : " + i);
            }
        }
    }

    function ispLoadCounty(objDD, xmlCounty) {
        var iCount = parent.$x.ispXmlGetRecCount(xmlCounty, 'DDOWN', 'n');

        objDD.options.length = iCount;


        for (i = 0; i < iCount; i++) {
            $(objDD.options[i]).text(parent.$x.ispXmlGetFieldVal(xmlCounty, 'DDOWN', 'DSC', i));
            $(objDD.options[i]).attr('value', parent.$x.ispXmlGetFieldVal(xmlCounty, 'DDOWN', 'DSC', i));
            $(objDD.options[i]).attr('ID', parent.$x.ispXmlGetFieldVal(xmlCounty, 'DDOWN', 'ID', i));
        }
    }

    function ispDateCompare(objOldDate, objNewDate) {

        var strOldDate = Date.parse(objOldDate)
        if (isNaN(strOldDate)) {
            return false;
        }

        var strNewDate = Date.parse(objNewDate)
        if (isNaN(strNewDate)) {
            return false;
        }
        if (strOldDate >= strNewDate) {
            return true;
        }

        return false;
    }

    function ispValidateDate(obj) {
       
        var objDate = obj

        while (objDate.lastIndexOf(' ') != -1) {
            objDate = objDate.replace(' ', '/');
        }
        while (objDate.lastIndexOf('.') != -1) {
            objDate = objDate.replace('.', '/');
        }

        if (isNaN(Date.parse(objDate))) {
            return false;
        }
        if (IspIsDate(objDate)) {
        } else {
            return false;
        }

        var objDt = new Date(Date.parse(objDate))

        var sMonth = objDt.getMonth() + 1;
        if (sMonth < 10) {
            sMonth = "0" + sMonth;
        }

        var sDate = objDt.getDate();
        if (sDate < 10) {
            sDate = "0" + sDate;
        }

        var sYear = objDt.getYear()
        if (sYear < 49) {
            if (sYear.toString().length == 1) {
                sYear = "200" + sYear;
            } else {
                sYear = "20" + sYear;
            }
        } else {
            sYear = objDt.getFullYear();
        }

        return sMonth + '/' + sDate + '/' + sYear;

    }

    function ispChangeDate(strDate, strNumber, strMDY) {

        if (isNaN(Date.parse(strDate))) {
            return false;
        }

        var objDt = new Date(Date.parse(strDate));

        if (strMDY == "M") {
            objDt.setMonth(strNumber);
        } else if (strMDY == "D") {
            objDt.setDate(strNumber);
        } else if (strMDY == "Y") {
            strNumber = eval(objDt.getFullYear() + strNumber);
            objDt.setFullYear(strNumber);
        } else {
            return 'Invalid Function Passed ' + strDate + ' ' + strNumber + ' ' + strMDY;
        }

        return (objDt.getMonth() + 1) + '/' + objDt.getDate() + '/' + objDt.getFullYear();
    }

    function ispSetTextLength(obj, len) {
        debugger;
        if (obj.value.length < len) {
            // do nothing
        } else {
            //alert(event.keyCode)
            if (event.keyCode == 8 || event.keyCode == 9) {
                // BACKSPACE TAB
            } else if (event.keyCode > 32 && event.keyCode < 41) {
                // do nothing
            } else if (event.keyCode > 44 && event.keyCode < 47) {
                // do nothing
            } else {
                event.returnValue = false;
            }
        }
    }

    function isDisabled(obj) {
        var x = $(obj).is(':disabled');

        return x;
    }

    function SetCtrlDisabled(obj) {
        if (isDisabled(obj)) {
            $(obj).attr('disabled', 'disable');
        }
    }

    function ispValidZipCode(objZipFld, objStateCbo, arrValid, idx, bPlus4) {
        
        var iMaxZip, iMinZip, iZipLen, errMsg = new Array();       
        iMinZip = $(objStateCbo.options[objStateCbo.selectedIndex]).attr('MinZip');
        iMaxZip = $(objStateCbo.options[objStateCbo.selectedIndex]).attr('MaxZip');
        //iMinZip = $(objStateCbo + " option:selected").attr('MinZip');
        //iMaxZip = $(objStateCbo + " option:selected").attr('MaxZip');
        errMsg[0] = 'Zip not numeric-range ' + iMinZip + ' - ' + iMaxZip;
        errMsg[1] = 'Zip required-range ' + iMinZip + ' - ' + iMaxZip + '(Invalid Zip Code)';
       
        errMsg[2] = 'Zip invalid-range ' + iMinZip + ' - ' + iMaxZip;
        errMsg[3] = 'Zip+4 not numeric';
        errMsg[4] = 'Zip+4 must be 4 digits';

        if (bPlus4) {
            if (isNaN(objZipFld.value)) {
                arrValid[idx][2] = errMsg[3];
                return true;
            }
            if (objZipFld.value.length > 0 && objZipFld.value.length < 4) {
                arrValid[idx][2] = errMsg[4];
                return true
            }
        } else {
            if (isNaN(objZipFld.value)) {
                arrValid[idx][2] = errMsg[0];
                return true;
            }
            if (objZipFld.value.length != 5) {
                arrValid[idx][2] = errMsg[1];
                return true;
            }
            if (objZipFld.value.substr(0, 3) < iMinZip || objZipFld.value.substr(0, 3) > iMaxZip) {
                arrValid[idx][2] = errMsg[2];
                return true
            }
        }
        return false;
    }

    function SetDDList(obj, Items, valu, intDefault) {

        if (intDefault == undefined || undefined == null) {
            intDefault = 0;
        }

        if (typeof (Items) == undefined || Items == null) {
            Items = '';
        }
        //----------------------------------------------------
        if (Items == '') {
            Items = 'CODE';
        }

        if (valu == '') {
            if (intDefault < 11) {
                obj.selectedIndex = intDefault;
            } else {
                obj.selectedIndex = 0;
            }
        }
        else {

            for (var i = 0; i != obj.length; i++) {

                if (valu == 'innerText') {
                    if ($(obj.options[i]).text() == valu) {
                        obj.selectedIndex = i;
                        return true;
                    }
                }
                else if ($(obj.options[i]).text() == valu) {
                    obj.selectedIndex = i;
                    return true;
                }
                else {
                    try {
                        if ($(obj.options[i]).attr(Items) == valu) {
                            obj.selectedIndex = i;
                            return true;
                        }
                    }
                    catch (e) {
                        alert('setddlist, Name:' + e.name + ' Description: ' + e.description);
                    }
                }
            }
        }
    }
    /// This function only for frmdate and todate textbox
    function ispSetInputErr1(ErrorArray) {

        var evt = window.event || arguments.callee.caller.caller.arguments[0] || arguments.callee.caller.caller.caller.arguments[0];

        var source = null;
        if (evt != undefined && evt != null) {
            source = evt.target || evt.srcElement;
        }


        var i;
        var currObj;
        var returnMessage = '';
        var rcElementlS;
        var lSrcElement;
        var styleClassName = new Array();

        var ispNORMAL = 0;
        var ispERROR = 1;
        var ispDISABLED = 2;
        styleClassName[ispNORMAL] = 'inpNormal inpNormal_custom date-input date-field-design';
        styleClassName[ispERROR] = 'inpError inpNormal_custom date-input date-field-design';
        styleClassName[ispDISABLED] = 'inpDisabled';


        if (evt && (evt.type == 'change' || evt.type == 'click')) {

            if (source.type == 'button') {
                lSrcElement = '';
            } else {
                lSrcElement = source.id;
            }
        } else {
            lSrcElement = '';
        }



        for (i = 0; i != ErrorArray.length; i++) {
            if (ErrorArray[i]) {
                if (lSrcElement == '' && $(ErrorArray[i][0]).attr('class') == styleClassName[ispDISABLED]) {
                    //Skip disabled elements
                } else if (lSrcElement == '' && $(ErrorArray[i][0]).attr('class') != styleClassName[ispERROR]) {
                    // ispTrim(ErrorArray[i][0]);//Sangha
                    if (eval(ErrorArray[i][1])) { 
                        $(ErrorArray[i][0]).attr('class', styleClassName[ispERROR]);
                        $(ErrorArray[i][0]).attr('errNo', i);
                        if (returnMessage == '') {
                            returnMessage = ErrorArray[i][2];
                        }
                    } else {
                        $(ErrorArray[i][0]).attr('class', styleClassName[ispNORMAL]);
                        $(ErrorArray[i][0]).attr('errNo', '');
                    }
                    // OnChange event of a field fired only check that field [lSrcElement]
                }
                else {
                    if (lSrcElement == ErrorArray[i][0].id) {

                        //  ispTrim(ErrorArray[i][0]);//Sangha

                        if (eval(ErrorArray[i][1])) {
                            $(ErrorArray[i][0]).attr('class', styleClassName[ispERROR]);
                            $(ErrorArray[i][0]).attr('errNo', i);
                            if (returnMessage == '') {
                                returnMessage = ErrorArray[i][2];
                            }
                            break;
                        } else {
                            $(ErrorArray[i][0]).attr('class', styleClassName[ispNORMAL]);
                            $(ErrorArray[i][0]).attr('errNo', '');
                        }
                    }
                    if ($(ErrorArray[i][0]).attr('class') == styleClassName[ispERROR]) {
                        if (returnMessage == '' && $(ErrorArray[i][0]).attr('errNo') == i.toString()) {
                            returnMessage = ErrorArray[i][2];
                        }
                    }
                }
            }
            if (ErrorArray[i][0].type == 'radio' || ErrorArray[i][0].type == 'checkbox') {
                $(ErrorArray[i][0]).attr('class', '');
            }
        }

        return returnMessage;
    }//added by manoranjan
    function RemoveFormatting(obj) {
        while (obj.value.lastIndexOf(',') != -1) {
            obj.value = obj.value.replace(',', '');
        }
        while (obj.value.lastIndexOf('.') != -1) {
            obj.value = obj.value.replace('.', '');
        }
        while (obj.value.lastIndexOf('$') != -1) {
            obj.value = obj.value.replace('$', '');
        }
    }

    function ispSetFocus(obj) {
        if (obj) {
            if (isDisabled(obj) == false) {
                try {
                    obj.focus();
                }
                catch (exception) {
                    var msg = exception.description + '\n\n' +
                        'Error setting Focus \n' +
                        'obj.id = ' + obj.id;
                    parent.$x.ispException('ispSetFocus', msg, '', '1');
                }
            }
        }
    }

    function ispAlignRight(obj) {
        $(obj).css('text-align', 'right');
    }

    function ispTrim(obj) {

        var intPos = obj.value.indexOf(' ');

        while (intPos == 0) {
            obj.value = obj.value.replace(' ', '');
            intPos = obj.value.indexOf(' ');
        }

        intPos = obj.value.lastIndexOf(' ');

        while (intPos == obj.value.length - 1 && intPos != -1) {
            obj.value = obj.value.slice(0, intPos);
            intPos = obj.value.lastIndexOf(' ');
        }
    }

    function ispZeroFill(obj, intLen) {
        if (isNaN(obj.value) == false) {
            while (obj.value.length < intLen) {
                obj.value = '0' + obj.value;
            }
        }
    }

    function ispLoadXML(objRequestXml, oReplyXml, strAspPage) {
        var oMsg = parent.$g.getXmlHttpRequestObj();
        var err = null;
        oMsg.open("POST", strAspPage, false)
        oMsg.setRequestHeader("MethodName", "enterOrder")
        oMsg.setRequestHeader("MessageType", "Call")
        oMsg.setRequestHeader("Content-Type", "text/xml-SOAP")

        try {
            objRequestXml = $.parseXml("<root><Make>Y</Make></root>");
        }
        catch (expression) {
            err = expression;
        }


        if (err) {
            strMessage = "REQUEST XML Parse: reason=" + err + " -- line=" + "N//A" + " -- errorCode=" + "N//A" + " -- srcText=" + "N//A";
            alert("ispLoadXML Error : " + strMessage);
            return false;
        }
        oMsg.send(objRequestXml);

        oReplyXml = $.parseXml(oMsg.responseText);
    }

    function LoadGenericDD(objXML, objDD, Node, ShowCode, DisplayItem) {

        var sDisplayItem = '';
        if (DisplayItem) {
            sDisplayItem = DisplayItem;
        }

        var strValueField = 'DESC';
        var strCodeField = 'CODE';

        if (ShowCode == true) {
            strValueField = strCodeField;
        }

        var i = 0;
        var len = $(objXML.xml).find(Node).size();

        if (len > 0) {
            objDD.options.length = len;
            $(objXML.xml).find(Node).each(function () {
                var node_attr_text = '';
                //suman
                //depending on 'sDisplayItem' function should add extra filter on xml for proper data population
                if (sDisplayItem != '') {
                    var node_attr = $(this).attr('DISPLAY_ITEM');

                    //suman
                    //In javascript it is always easy to work with blank string than undefined or null
                    //so fill this variable only if not null or undefined
                    if (node_attr) {
                        node_attr_text = node_attr;
                    }
                    //alert('node_attr_text : ' + node_attr_text);
                }

                if (sDisplayItem == '' || sDisplayItem == node_attr_text.match(sDisplayItem)) {

                    var display = $(this).attr(strValueField);
                    var code = $(this).attr(strCodeField);

                    $(objDD.options[i]).text(display);
                    $(objDD.options[i]).attr('CODE', code);
                }
                //SUMAN 
                //this variable should add count even if that item is blank for if block avobe
                //there is a block below which will then read entire ddl collection and remove blank items
                i = i + 1;

            });
        }

        for (i = 0; i < len; i++) {
            if ($(objDD.options[i]).text() == '') {
                objDD.remove(i);
                i = i - 1;
                len = len - 1;
            }
        }
    }

    function ispFormatMoney(strValue, intCents) {
        //SUMAN
        if (strValue == undefined || strValue == null || strValue == '') {
            strValue = 0;
        }
        //for INCOMING VALUE IS POSITIVE CURRENCY THEN THE FORMAT IS  : $1,000.00, FOR(-) IT WILL BE  : ($1,000.00)
        //SO  IF STRING CONTAINS  $,(,), <,>  SIGN THEN IT IS EXPECTED  TO BE A CURRENCY 
        var filtr_val = strValue.toString().replace('$', '');
        filtr_val = filtr_val.replace('(', '');
        filtr_val = filtr_val.replace(')', '');
        filtr_val = filtr_val.replace(/,/g, '');

        var r = 0;
        if ($.isNumeric(filtr_val)) {
            r = accounting.formatMoney(strValue, {
                symbol: '$',
                precision: intCents,
                thousand: ',',
                format: {
                    pos: '%s%v',
                    neg: '(%s%v)',
                    zero: '%s0'
                }
            });
        }
        else {

            r = strValue;
        }
        return r;
    }

    function ispStripMoney(strValue) {
        //SUMAN
        if (strValue == undefined || strValue == null || strValue == '') {
            strValue = 0;
        }

        var filtr_val = strValue.toString().replace('$', '');
        filtr_val = filtr_val.replace('(', '');
        filtr_val = filtr_val.replace(')', '');
        filtr_val = filtr_val.replace(/,/g, '');

        var r = 0;
        if ($.isNumeric(filtr_val)) {
            r = accounting.formatMoney(strValue, {
                symbol: '$',
                precision: 2,
                thousand: '',
                format: {
                    pos: '%s%v',
                    neg: '-%s%v',
                    zero: '%s.00'
                }

            });
        }
        else {
            r = strValue;
        }

        return r;
    }

    function ispFormatPeriod(sPeriod, sType) {
        
       // sType = D(display); //for Incoming Format YYYYMMDD;		Outgoing Format MM/DD/YYYY
       // sType = M(mainframe); //for Incoming Format MM/DD/YYYY;		Outgoing Format YYYYMMDD
        if (sType == 'D') {
            
            return sPeriod.substr(4, 2) + '/' + sPeriod.substr(6, 2) + '/' + sPeriod.substr(0, 4);
        } else {
            return sPeriod.substr(6, 4) + sPeriod.substr(0, 2) + sPeriod.substr(3, 2);
        }
    }

    function ispRemoveMoney(sAmount) {
        var org = sAmount;
        if (sAmount == undefined || sAmount == null) {
            return 0.00;
        }

        sAmount = accounting.unformat(sAmount);

        //sAmount = sAmount.toString();
        //sAmount = sAmount.replace('$', '')
        //sAmount = sAmount.replace(',', '')
        //sAmount = sAmount.replace(')', '');
        //sAmount = sAmount.replace('(', '');
        //sAmount = sAmount.replace('%', '');
        //sAmount = sAmount.replace('-', '');
        if (isNaN(sAmount) || sAmount == '') {
            sAmount = 0.00
        }
        else {
        }

        return parseFloat(sAmount)
    }

    function IspIsDate(obj) {
        try {
            var dt = new Date(obj);
            return true;
        }
        catch (expression) {
            return false;
        }
    }

    function ispValue(strVal) {
        //EHD 2007.01.09 v4.2.10 Removed the 'CDbl' from following line 'IsNumeric(CDbl(strVal))'

        if (strVal != null && strVal != 'undefined' && strVal != '') {
            strVal = strVal.replace(/,/g, '').replace('$', '').replace('(', '').replace(')', '');
        }

        if ($.isNumeric(strVal)) {
            return true;
        }
        else {
            return false;
        }
    }

    function ispNegativeNumber(strVal) {

        var r = false;
        //EHD 2007.01.09 v4.2.10 Removed the 'CDbl' from following line 'IsNumeric(CDbl(strVal))'
        if (ispValue(strVal)) {
            if (strVal != null && strVal != 'undefined' && strVal != '') {
                strVal = ispRemoveMoney(strVal);
            }
            if (parseFloat(strVal) > -1) {
                r = true;
            }
        }
        return r;
    }

    function formatCurrency(strValue, upto) { // Chayan 
        strValue = isNaN(strValue) || strValue === '' || strValue === null ? 0.00 : strValue;
        return parseFloat(strValue).toFixed(upto);
    }

    function ispStripCurrency(strVal) { //Chayan

        if (strVal == '') {
            strVal = 0;
        }

        var r = 0;

        if ($.isNumeric(strVal)) {
            //accounting.toFixed(strValue,intCents)

            r = formatCurrency(strVal, 2).replace(',', '');
            //r= accounting.formatMoney(strValue, '$',intCents );
        }
        else {
            r = strVal.replace(',', '');
        }
        return r;
    }

    function stripCurrency(value) {
        var num = ispStripMoney(value);
        return num;
    }



