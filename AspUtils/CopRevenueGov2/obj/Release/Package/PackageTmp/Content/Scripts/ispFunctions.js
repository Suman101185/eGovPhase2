
    //var conBgBusy = ''
    var conBgNotBusy = '#ffffff';

    function ispSetFocus(oControl) {

        if (oControl.disabled == false) {
            oControl.focus();
        } 	//if
    } 	//ispSetFocus


    function ispResetObj(obj) {
        var i, lAlign;

        for (i = 0; i != obj.length; i++) {
            if ($(obj[i]).css('textAlign') == 'right') {
                $(obj[i]).attr('class', 'inpNormal');
                $(obj[i]).css('textAlign', 'right');
            } else {
            $(obj[i]).attr('class','inpNormal');
            } 	//if

            if (obj[i].type == 'select-one') {
                obj[i].selectedIndex = 0;
            } else if (obj[i].type == 'radio' || obj[i].type == 'checkbox') {
            obj[i].checked = false;
            $(obj[i]).attr('class','');
            } else {
            obj[i].value = '';
            } 	//if
        } 	//for
        //alert(obj[0].style.visibility)
        if (obj[0].type != 'select-one' && obj[0].disabled == false) {
            obj[0].focus();
        } 	//if
    } 	//ResetObj


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
        } 	//for

        if (blnMode == false) {
            obj[0].focus()
        } 	//if
    } 	//ispDisableObj


    function ispSetInputErr(ErrorArray) {

        var evt = window.event || arguments.callee.caller.caller.arguments[0] || arguments.callee.caller.caller.caller.arguments[0];

	var source=null;
	if(evt != undefined && evt != null){
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
        styleClassName[ispNORMAL] = 'inpNormal';
        styleClassName[ispERROR] = 'inpError';
        styleClassName[ispDISABLED] = 'inpDisabled';

        /*
        var i, currObj, returnMessage, lSrcElement, styleClassName = new Array();
        currObj = false;
        returnMessage = '';

        ispNORMAL = 0;
        ispERROR = 1;
        ispDISABLED = 2;

        styleClassName[ispNORMAL] = 'inpNormal';
        styleClassName[ispERROR] = 'inpError';
        styleClassName[ispDISABLED] = 'inpDisabled';
        */

        if (evt && (evt.type == 'change' || evt.type == 'click')) {

            if (source.type == 'button') {
                lSrcElement = '';
            } else {
                lSrcElement = source.id;
            } 	//if
        } else {
            lSrcElement = '';
        }



        for (i = 0; i != ErrorArray.length; i++) {
            if (ErrorArray[i]) {		//check index exists
                // Check all fields in array not kicked off by the OnChange event of the field
                //			if (lSrcElement == '' && ErrorArray[i][0].className == styleClassName[ispNORMAL]) {
//alert(ErrorArray[i][i]);
                if (lSrcElement == '' && $(ErrorArray[i][0]).attr('class') == styleClassName[ispDISABLED]) {
                    //Skip disabled elements
                } else if (lSrcElement == '' && $(ErrorArray[i][0]).attr('class') != styleClassName[ispERROR]) {
                    ispTrim(ErrorArray[i][0]);
                    if (eval(ErrorArray[i][1])) {
                        $(ErrorArray[i][0]).attr('class', styleClassName[ispERROR]);
                        $(ErrorArray[i][0]).attr('errNo',  i);
                        if (returnMessage == '') {
                            returnMessage = ErrorArray[i][2];
                        } 	//if
                    } else {
                        $(ErrorArray[i][0]).attr('class',styleClassName[ispNORMAL]);
                        $(ErrorArray[i][0]).attr('errNo','');
                    } 	//if
                    // OnChange event of a field fired only check that field [lSrcElement]
                }
				else {
                    if (lSrcElement == ErrorArray[i][0].id) {
                        ispTrim(ErrorArray[i][0]);

                        if (eval(ErrorArray[i][1])) {
                            $(ErrorArray[i][0]).attr('class', styleClassName[ispERROR]);
                            $(ErrorArray[i][0]).attr('errNo', i);
                            if (returnMessage == '') {
                                returnMessage = ErrorArray[i][2];
                            } 	//if
                            break
                        } else {
                            $(ErrorArray[i][0]).attr('class', styleClassName[ispNORMAL]);
                            $(ErrorArray[i][0]).attr('errNo','');
                        } 	//if
                    } 	//if
                    if ($(ErrorArray[i][0]).attr('class') == styleClassName[ispERROR]) {
                        if (returnMessage == '' && $(ErrorArray[i][0]).attr('errNo') == i.toString()) {
                            returnMessage = ErrorArray[i][2];
                        } 	//if
                    } 	//if
                } 	//if
            } 	//if - check index exists
            if (ErrorArray[i][0].type == 'radio' || ErrorArray[i][0].type == 'checkbox') {
                $(ErrorArray[i][0]).attr('class', '');
            } 	//if 
        } 	//for
        //alert(returnMessage);
        return returnMessage;
    } 	//ispSetInputErr1


    function ispSetInputErr1(ErrorArray) {
        var i, j, currObj, returnMessage, lastEvalObj, tmpObj, currEval, tmpCurrObj, lSrcElement;
        currObj = false;
        currEval = false;
        tmpCurrObj = false;
        returnMessage = '';
        lastEvalObj = '';
        //window.status = ''
        if (event) {
            lSrcElement = event.srcElement;
        } else {
        lSrcElement = '';
        } 	//if event

        for (i = 0; i != ErrorArray.length; i++) {
            if (ErrorArray[i][0].length) {		//check for multi controls
                for (j = 0; j != ErrorArray[i][0].length; j++) {
                    if (tmpCurrObj == false && lSrcElement == ErrorArray[i][0][j]) {		//Eval multiple controls
                        tmpCurrObj = true;
                        currObj = true;
                        j = 0
                    } 	//if
                    //window.status = window.status + ' M-' + ErrorArray[i][0][j].id
                    if (tmpCurrObj == true) {
                        if (eval(ErrorArray[i][1])) {
                            currEval = true;
                        } else {
                        currEval = false;
                        } 	//if
                        if (currEval == true) {
                            ErrorArray[i][0][j].visited = true;
                            ErrorArray[i][0][j].className = 'inpError';
                        } else {
                        ErrorArray[i][0][j].visited = false;
                            ErrorArray[i][0][j].className = 'inpNormal';
                        } //if
                    } 	//if
                } 	//for
                tmpCurrObj = false
                if (currObj == true && currEval == true) {
                    break
                } 	//if
            } else {
                if (lSrcElement == ErrorArray[i][0]) {		//Eval a single control
                    if (eval(ErrorArray[i][1])) {
                        //window.status = window.status + ' S-' + ErrorArray[i][0].id
                        ErrorArray[i][0].visited = true;
                        ErrorArray[i][0].className = 'inpError';
                    } else {
                    ErrorArray[i][0].visited = false;
                        ErrorArray[i][0].className = 'inpNormal';
                    } //if
                    currObj = true
                    break
                } 	//if
            } 	//if
        } 	//for

        if (currObj == false) {		//enter any except thru input field
            for (i = 0; i != ErrorArray.length; i++) {
                if (ErrorArray[i][0].length) {		//check for multi controls
                    for (j = 0; j != ErrorArray[i][0].length; j++) {
                        if (eval(ErrorArray[i][1])) {
                            //window.status = window.status + ' NM-' + ErrorArray[i][0][j].id
                            lastEvalObj = ErrorArray[i][0][j];
                            ErrorArray[i][0][j].visited = true;
                            ErrorArray[i][0][j].className = 'inpError';
                            if (returnMessage == '') {
                                returnMessage = ErrorArray[i][2];
                            } 	//if
                        } else {
                        ErrorArray[i][0][j].className = 'inpNormal';
                        } 	//if
                    } 	//for
                } else {
                    if (lastEvalObj != ErrorArray[i][0]) {
                        lastEvalObj = ''
                        if (eval(ErrorArray[i][1])) {
                            lastEvalObj = ErrorArray[i][0];
                            //window.status = window.status + ' NS-' + ErrorArray[i][0].id
                            ErrorArray[i][0].visited = true;
                            ErrorArray[i][0].className = 'inpError';
                            if (returnMessage == '') {
                                returnMessage = ErrorArray[i][2];
                            } 	//if
                        } else {
                        ErrorArray[i][0].className = 'inpNormal';
                        } 	//if
                    } 	//if
                } 	//if
            } 	//for
            if (ErrorArray[0][0].length && ErrorArray[0][0].disabled == false) {
                ErrorArray[0][0][0].focus();
            } else {
                if (ErrorArray[0][0].disabled == false) {
                    ErrorArray[0][0].focus();
                }
            } 	//if
        } else {
            for (i = 0; i != ErrorArray.length; i++) {
                if (ErrorArray[i][0].length) {		//check for multi controls
                    for (j = 0; j != ErrorArray[i][0].length; j++) {
                        //window.status = window.status + ' CM-' + ErrorArray[i][0].id
                        if (ErrorArray[i][0][j].visited == true) {		//Eval multiple controls
                            if (eval(ErrorArray[i][1])) {
                                returnMessage = ErrorArray[i][2];
                                break
                            } 	//if
                        } 	//if
                    } 	//for
                    if (returnMessage != '') {
                        break
                    } 	//if
                } else {
                    //window.status = window.status + ' CS-' + ErrorArray[i][0].id
                    if (ErrorArray[i][0].visited == true) {
                        if (eval(ErrorArray[i][1])) {
                            returnMessage = ErrorArray[i][2];
                            break
                        } 	//if
                    } 	//if
                } 	//if
            } 	//for
        } 	//if

        return returnMessage

    } 	//ispSetInputErr

    function ispSetProcessing(strMsg) {
        //suman -------------------------------
    var lbl = $(parent.NavWin.document).find('#lblProcessing').first();
        //conBgBusy = parent.NavWin.lblBusy.currentStyle.backgroundColor
        $(lbl).css('display','block');

        if (strMsg == '') {
            $(lbl).text('Processing Please Wait');
            //parent.NavWin.lblProcessing.innerText = 'Processing Please Wait';
        } else {
        //parent.NavWin.lblProcessing.innerText = strMsg;
        $(lbl).text(strMsg);
        }
        //parent.DocWin.document.bgColor = conBgBusy
        $(parent.NavWin.document).css('background','#fffff1');
        //parent.NavWin.document.bgColor = conBgNotBusy;
        $(parent.NavWin.document).css('background', conBgNotBusy);


//        parent.NavWin.btn1.className = 'layHidden';
//        parent.NavWin.btn2.className = 'layHidden';
//        parent.NavWin.btn3.className = 'layHidden';
//        parent.NavWin.btn4.className = 'layHidden';
//        parent.NavWin.btn5.className = 'layHidden';


        $(parent.NavWin.document).find('#btn1').first().attr('class', 'layHidden');
        $(parent.NavWin.document).find('#btn2').first().attr('class', 'layHidden');
        $(parent.NavWin.document).find('#btn3').first().attr('class', 'layHidden');
        $(parent.NavWin.document).find('#btn4').first().attr('class', 'layHidden');
        $(parent.NavWin.document).find('#btn5').first().attr('class', 'layHidden');


        // ispSetFocus($(parent.NavWin.lblProcessing));
        ispSetFocus(lbl);
        //--------------------------------------
    }


    function ispClearProcessing() {
    //suman -----------------------------------------------------
        var lbl = $(parent.NavWin.document).find('#lblProcessing').first();

        if ($(lbl).css('display') == 'block') {
            $(lbl).css('display', 'none');
            //parent.DocWin.document.bgColor = conBgNotBusy
            $(parent.NavWin.document).css('background',conBgNotBusy);


//            parent.NavWin.btn1.className = 'layVisible';
//            parent.NavWin.btn2.className = 'layVisible';
//            parent.NavWin.btn3.className = 'layVisible';
//            parent.NavWin.btn4.className = 'layVisible';
//            parent.NavWin.btn5.className = 'layVisible';

            $(parent.NavWin.document).find('#btn1').first().attr('class', 'layVisible');
            $(parent.NavWin.document).find('#btn2').first().attr('class', 'layVisible');
            $(parent.NavWin.document).find('#btn3').first().attr('class', 'layVisible');
            $(parent.NavWin.document).find('#btn4').first().attr('class', 'layVisible');
            $(parent.NavWin.document).find('#btn5').first().attr('class', 'layVisible');
        }
    }


    function getXmlHttpRequestObj() {
        var req = null;
        if (window.ActiveXObject) {
            req = new ActiveXObject("Microsoft.XMLHTTP");
        }
		else if (window.XMLHttpRequest) {
            req = new XMLHttpRequest();
        }
        return req;
    }

    function ispCallXMLForm(objRequestXml, oReplyXml, strAspPage, strMsg, IeCopyXmlToClipBoard) {
try{
	if(IeCopyXmlToClipBoard && IeCopyXmlToClipBoard==true){
	if(window.ActiveXObject){
		clipboardData.setData ('Text', objRequestXml.xml.xml);
		alert(' Before HTTP request: XML copied to internet explorer\'s clip board. Now before hit OK, paste on a editor to get XML');
		}
	}
	else{
	}
	}
	catch(e){
	alert(e);
	}
	
        var oMsg = getXmlHttpRequestObj();
        var strMessage = '';
        //oReplyXml.loadXML(parent.MenuWin.xmlData.xml)
        //oReplyXml.loadXML(objRequestXml.xml)
        //return true

        oMsg.open("POST", strAspPage, false);
        //	oMsg.setRequestHeader("MethodName", "enterOrder")
        //	oMsg.setRequestHeader("MessageType", "Call")

        oMsg.setRequestHeader("Content-Type", "text/xml-SOAP");
        /* Suman ------------------------------------
            browsers can set content-length automatically, 
            more of this today's browsers don't allow JavaScript to set length for security issue
        */
        //oMsg.setRequestHeader("Content-length", $(objRequestXml).size());

        //	AppError.innerText = ""

        //suman - disable code ---------------------------
        //        if (objRequestXml.parseError.errorCode != 0) {
        //            strMessage = "REQUEST Parser Error: reason=" + objRequestXml.parseError.reason + " -- line=" + objRequestXml.parseError.line + " -- errorCode=" + objRequestXml.parseError.errorCode + " -- srcText=" + objRequestXml.parseError.srcText
        //            ispXmlSetFieldVal(oReplyXml, 'ispFunctions.js.htm', 'ERROR_INFO PROGRAM', '', 0)
        //            ispXmlSetFieldVal(oReplyXml, strMessage, 'ERROR_INFO MESSAGE', '', 0)
        //            //		alert("Sending Error " + strMessage)
        //            return false;
        //        } 	
        //---------------------------------------------------

        //if
        //alert(objRequestXml.xml)
        //	oMsg.send(objRequestXml.XMLDocument)
        oMsg.send(objRequestXml.xml);
        //clipboardData.setData('Text', oMsg.responseText)
       // alert(oMsg.responseText);
        var parse_errorcode = 0;
        try {

            oReplyXml.xml = $.parseXML(oMsg.responseText);
			
			if(IeCopyXmlToClipBoard && IeCopyXmlToClipBoard==true){
			if(window.ActiveXObject){
				clipboardData.setData ('Text', oReplyXml.xml.xml);
				alert(' After HTTP response: XML copied to internet explorer\'s clip board. Now before hit OK, paste on a editor to get XML');
				}
			}
			else{
			}
			//alert('1');
//alert((new XMLSerializer()).serializeToString(oReplyXml));
        }
        catch (expression) {
            parse_errorcode = 1;
        }
        //return true;
        //alert("'" + oMsg.responseText + "' - " + strAspPage)
        //alert(oReplyXml.xml)

        //if (oReplyXml.parseError.errorCode != 0) {
        if (parse_errorcode != 0) {

            //strMessage = "REPLY XML Parse:  reason=" + oReplyXml.parseError.reason + " -- line=" + oReplyXml.parseError.line + " -- errorCode=" + oReplyXml.parseError.errorCode + " -- srcText=" + oReplyXml.parseError.srcText;
            strMessage = "REPLY XML Parse";
            //		if ("<%Response.write(Session("ENVIRONMENT"))%>" != "P" || 
            //				"<%Response.write(Session("ENVIRONMENT"))%>" != "S"){
            //		if (oMsg.responseText == ''){
            //			strMessage = "REPLY Data empty"
            ispXmlSetFieldVal(oReplyXml, 'ispFunctions.js.htm', 'ERROR_INFO PROGRAM', '', 0)
            ispXmlSetFieldVal(oReplyXml, strMessage, 'ERROR_INFO MESSAGE', '', 0)
            //				alert('Parsing Error...\n' + oReplyXml.parseError.errorCode + '\n' +
            //						oReplyXml.parseError.reason + '\n' + oMsg.responseText)
            //				oReplyXml.loadXML("<ROOT><ERROR><SYS-MSG>Error in called module</SYS-MSG><SYS-ERR></SYS-ERR><RTN-CODE>9999</RTN-CODE></ERROR></ROOT>")

            //		}		//if
        } else {
            /*		Commented out by EHD

            if (ispXmlGetRecCount(oReplyXml, 'ERROR', '') == 1) {
            strMessage = ispXmlGetFieldVal(oReplyXml,'ERROR','',0)
            } else {
           strMessage = ispXmlGetFieldVal(oReplyXml,'RETURNCODE','',0)
            }		//if
            */
            //strMessage = 0
		// alert((new XMLSerializer()).serializeToString(oReplyXml));
            if (strMessage == '') {

                return true;
            } else {
                return false;
            } 	//if
        }

    } 	//CallXMLForm


	function ispCallXMLForm_Temp2(objRequestXml, oReplyXml, strAspPage, strMsg) {

        var oMsg = getXmlHttpRequestObj();
        var strMessage = '';
        //oReplyXml.loadXML(parent.MenuWin.xmlData.xml)
        //oReplyXml.loadXML(objRequestXml.xml)
        //return true

        oMsg.open("POST", strAspPage, false);
        //	oMsg.setRequestHeader("MethodName", "enterOrder")
        //	oMsg.setRequestHeader("MessageType", "Call")

        oMsg.setRequestHeader("Content-Type", "text/xml-SOAP");
        /* Suman ------------------------------------
            browsers can set content-length automatically, 
            more of this today's browsers don't allow JavaScript to set length for security issue
        */
        //oMsg.setRequestHeader("Content-length", $(objRequestXml).size());

        //	AppError.innerText = ""

        //suman - disable code ---------------------------
        //        if (objRequestXml.parseError.errorCode != 0) {
        //            strMessage = "REQUEST Parser Error: reason=" + objRequestXml.parseError.reason + " -- line=" + objRequestXml.parseError.line + " -- errorCode=" + objRequestXml.parseError.errorCode + " -- srcText=" + objRequestXml.parseError.srcText
        //            ispXmlSetFieldVal(oReplyXml, 'ispFunctions.js.htm', 'ERROR_INFO PROGRAM', '', 0)
        //            ispXmlSetFieldVal(oReplyXml, strMessage, 'ERROR_INFO MESSAGE', '', 0)
        //            //		alert("Sending Error " + strMessage)
        //            return false;
        //        } 	
        //---------------------------------------------------

        //if
        //alert(objRequestXml.xml)
        //	oMsg.send(objRequestXml.XMLDocument)
        oMsg.send(objRequestXml);
        //clipboardData.setData('Text', oMsg.responseText)
        //alert(oMsg.responseText);
        var parse_errorcode = 0;
        try {

            oReplyXml = $.parseXML(oMsg.responseText);

        }
        catch (expression) {
            parse_errorcode = 1;
        }
        //return true;
        //alert("'" + oMsg.responseText + "' - " + strAspPage)
        //alert(oReplyXml.xml)

        //if (oReplyXml.parseError.errorCode != 0) {
        if (parse_errorcode != 0) {

            //strMessage = "REPLY XML Parse:  reason=" + oReplyXml.parseError.reason + " -- line=" + oReplyXml.parseError.line + " -- errorCode=" + oReplyXml.parseError.errorCode + " -- srcText=" + oReplyXml.parseError.srcText;
            strMessage = "REPLY XML Parse";
            //		if ("<%Response.write(Session("ENVIRONMENT"))%>" != "P" || 
            //				"<%Response.write(Session("ENVIRONMENT"))%>" != "S"){
            //		if (oMsg.responseText == ''){
            //			strMessage = "REPLY Data empty"
            ispXmlSetFieldVal(oReplyXml, 'ispFunctions.js.htm', 'ERROR_INFO PROGRAM', '', 0)
            ispXmlSetFieldVal(oReplyXml, strMessage, 'ERROR_INFO MESSAGE', '', 0)
            //				alert('Parsing Error...\n' + oReplyXml.parseError.errorCode + '\n' +
            //						oReplyXml.parseError.reason + '\n' + oMsg.responseText)
            //				oReplyXml.loadXML("<ROOT><ERROR><SYS-MSG>Error in called module</SYS-MSG><SYS-ERR></SYS-ERR><RTN-CODE>9999</RTN-CODE></ERROR></ROOT>")

            //		}		//if
        } else {
            /*		Commented out by EHD

            if (ispXmlGetRecCount(oReplyXml, 'ERROR', '') == 1) {
            strMessage = ispXmlGetFieldVal(oReplyXml,'ERROR','',0)
            } else {
           strMessage = ispXmlGetFieldVal(oReplyXml,'RETURNCODE','',0)
            }		//if
            */
            //strMessage = 0
		// alert((new XMLSerializer()).serializeToString(oReplyXml));
            if (strMessage == '') {

                return true;
            } else {
                return false;
            } 	//if
        }

    } 	//CallXMLForm

function ispCallXMLForm_Temp(objRequestXml, oReplyXml, strAspPage, strMsg) {

        var oMsg = getXmlHttpRequestObj();
        var strMessage = '';
        //oReplyXml.loadXML(parent.MenuWin.xmlData.xml)
        //oReplyXml.loadXML(objRequestXml.xml)
        //return true

        oMsg.open("POST", strAspPage, false);
        //	oMsg.setRequestHeader("MethodName", "enterOrder")
        //	oMsg.setRequestHeader("MessageType", "Call")

        oMsg.setRequestHeader("Content-Type", "text/xml-SOAP");
        /* Suman ------------------------------------
            browsers can set content-length automatically, 
            more of this today's browsers don't allow JavaScript to set length for security issue
        */
        //oMsg.setRequestHeader("Content-length", $(objRequestXml).size());

        //	AppError.innerText = ""

        //suman - disable code ---------------------------
        //        if (objRequestXml.parseError.errorCode != 0) {
        //            strMessage = "REQUEST Parser Error: reason=" + objRequestXml.parseError.reason + " -- line=" + objRequestXml.parseError.line + " -- errorCode=" + objRequestXml.parseError.errorCode + " -- srcText=" + objRequestXml.parseError.srcText
        //            ispXmlSetFieldVal(oReplyXml, 'ispFunctions.js.htm', 'ERROR_INFO PROGRAM', '', 0)
        //            ispXmlSetFieldVal(oReplyXml, strMessage, 'ERROR_INFO MESSAGE', '', 0)
        //            //		alert("Sending Error " + strMessage)
        //            return false;
        //        } 	
        //---------------------------------------------------

        //if
        //alert(objRequestXml.xml)
        //	oMsg.send(objRequestXml.XMLDocument)
        oMsg.send(objRequestXml);
        //clipboardData.setData('Text', oMsg.responseText)
        //alert(oMsg.responseText);
        var parse_errorcode = 0;
        try {

            oReplyXml = $.parseXML(oMsg.responseText);

        }
        catch (expression) {
            parse_errorcode = 1;
        }
        //return true;
        //alert("'" + oMsg.responseText + "' - " + strAspPage)
        //alert(oReplyXml.xml)

        //if (oReplyXml.parseError.errorCode != 0) {
        if (parse_errorcode != 0) {

            //strMessage = "REPLY XML Parse:  reason=" + oReplyXml.parseError.reason + " -- line=" + oReplyXml.parseError.line + " -- errorCode=" + oReplyXml.parseError.errorCode + " -- srcText=" + oReplyXml.parseError.srcText;
            strMessage = "REPLY XML Parse";
            //		if ("<%Response.write(Session("ENVIRONMENT"))%>" != "P" || 
            //				"<%Response.write(Session("ENVIRONMENT"))%>" != "S"){
            //		if (oMsg.responseText == ''){
            //			strMessage = "REPLY Data empty"
            ispXmlSetFieldVal(oReplyXml, 'ispFunctions.js.htm', 'ERROR_INFO PROGRAM', '', 0)
            ispXmlSetFieldVal(oReplyXml, strMessage, 'ERROR_INFO MESSAGE', '', 0)
            //				alert('Parsing Error...\n' + oReplyXml.parseError.errorCode + '\n' +
            //						oReplyXml.parseError.reason + '\n' + oMsg.responseText)
            //				oReplyXml.loadXML("<ROOT><ERROR><SYS-MSG>Error in called module</SYS-MSG><SYS-ERR></SYS-ERR><RTN-CODE>9999</RTN-CODE></ERROR></ROOT>")

            //		}		//if
        } else {
            /*		Commented out by EHD

            if (ispXmlGetRecCount(oReplyXml, 'ERROR', '') == 1) {
            strMessage = ispXmlGetFieldVal(oReplyXml,'ERROR','',0)
            } else {
           strMessage = ispXmlGetFieldVal(oReplyXml,'RETURNCODE','',0)
            }		//if
            */
            //strMessage = 0
		// alert((new XMLSerializer()).serializeToString(oReplyXml));
            if (strMessage == '') {

                return true;
            } else {
                return false;
            } 	//if
        }

    } 	//CallXMLForm

    //Use for Delinquent Payments - Marking payments
    function ispCallXMLForm1(objRequestXml, oReplyXml, strAspPage, strMsg) {
        var oMsg = new XMLHttpRequest()
        var strMessage = ''

        oMsg.open("POST", strAspPage, false)
        oMsg.setRequestHeader("Content-Type", "text/xml")		//text/plain application/x-www-form-urlencoded")
        oMsg.setRequestHeader("Content-length", objRequestXml.xml.length);
        oMsg.setRequestHeader("Connection", "close")

        /*if (objRequestXml.parseError.errorCode != 0) {
            strMessage = "REQUEST Parser Error: reason=" + objRequestXml.parseError.reason + " -- line=" + objRequestXml.parseError.line + " -- errorCode=" + objRequestXml.parseError.errorCode + " -- srcText=" + objRequestXml.parseError.srcText
            ispXmlSetFieldVal(oReplyXml, 'ispFunctions.js.htm', 'ERROR_INFO/PROGRAM', '', 0)
            ispXmlSetFieldVal(oReplyXml, strMessage, 'ERROR_INFO/MESSAGE', '', 0)
            //		alert("Sending Error " + strMessage)
            return false;
        } 	//if*/

        //	return
        //	oMsg.send(objRequestXml.XMLDocument)
        //alert(objRequestXml.xml)
        oMsg.send(objRequestXml)	//(objRequestXml)
        //	oMsg.status
        //	clipboardData.setData('Text', oMsg.status + '   ' + oMsg.statusText)
        //	oReplyXml = oMsg.responseText
        //	alert(oMsg.responseText)
        //return
        oReplyXml.loadXML(oMsg.responseText)
        //return true;
        //alert("'" + oMsg.responseText + "' - " + strAspPage)
        if (oMsg.status != '200') {
            alert('ispCallXMLForm1 : ' + oMsg.status + ':    ' + oMsg.statusText)
        } 	//Error

        if (oReplyXml.parseError.errorCode != 0) {
            strMessage = "REPLY XML Parse:  reason=" + oReplyXml.parseError.reason + " -- line=" + oReplyXml.parseError.line + " -- errorCode=" + oReplyXml.parseError.errorCode + " -- srcText=" + oReplyXml.parseError.srcText
            //		if ("<%Response.write(Session("ENVIRONMENT"))%>" != "P" || 
            //				"<%Response.write(Session("ENVIRONMENT"))%>" != "S"){
            //		if (oMsg.responseText == ''){
            //			strMessage = "REPLY Data empty"
            ispXmlSetFieldVal(oReplyXml, 'ispFunctions.js.htm', 'ERROR_INFO PROGRAM', '', 0)
            ispXmlSetFieldVal(oReplyXml, strMessage, 'ERROR_INFO MESSAGE', '', 0)
            //				alert('Parsing Error...\n' + oReplyXml.parseError.errorCode + '\n' +
            //						oReplyXml.parseError.reason + '\n' + oMsg.responseText)
            //				oReplyXml.loadXML("<ROOT><ERROR><SYS-MSG>Error in called module</SYS-MSG><SYS-ERR></SYS-ERR><RTN-CODE>9999</RTN-CODE></ERROR></ROOT>")

            //		}		//if
        } else {
            /*		Commented out by EHD
            if (ispXmlGetRecCount(oReplyXml, 'ERROR', '') == 1) {
            strMessage = ispXmlGetFieldVal(oReplyXml,'ERROR','',0)
            } else {
            strMessage = ispXmlGetFieldVal(oReplyXml,'RETURNCODE','',0)
            }		//if
            */
            //strMessage = 0		
            if (strMessage == '') {
                return true;
            } else {
                return false;
            } 	//if
        }
    } 	//CallXMLForm1

    function ispStandAlone(lFunction) {
        if (parent.DocWin) {
        } else {
            eval(lFunction)
        } 	//if
    }

    function ispLoadZipCode(objDDZip, ShowCode) {
        var iCount = ispXmlGetRecCount(parent.MenuWin.xmlStatezip, "STATE", 'n');

        var strInnerText = 'DESC';

        if (ShowCode == true) {
            strInnerText = 'CODE';
        }
        
        objDDZip.options.length = iCount;
        for (i = 0; i < iCount; i++) {

            try {
                $(objDDZip.options[i]).text(ispXmlGetFieldVal(parent.MenuWin.xmlStatezip, strInnerText, '', i));
                $(objDDZip.options[i]).attr('CODE', ispXmlGetFieldVal(parent.MenuWin.xmlStatezip, 'CODE', '', i))
                $(objDDZip.options[i]).attr('MaxZip',ispXmlGetFieldVal(parent.MenuWin.xmlStatezip, 'MAXZIP', '', i));
                $(objDDZip.options[i]).attr('MinZip',ispXmlGetFieldVal(parent.MenuWin.xmlStatezip, 'MINZIP', '', i));
            }
            catch (expression) {
                alert('ispLoadZipCode :' + expression + " at : " + i);
            }            
        }

        //return objDDZip.innerText
    }

    function ispLoadCounty(objDD, xmlCounty) {
        var iCount = ispXmlGetRecCount(xmlCounty, 'DDOWN', 'n');

        objDD.options.length = iCount;
        //  objDD.options(0).innerText = ""
        //  objDD.options(0).CODE = ""

        for (i = 0; i < iCount; i++) {
            $(objDD.options[i]).text(ispXmlGetFieldVal(xmlCounty, 'DDOWN', 'DSC', i));
            $(objDD.options[i]).attr('value', ispXmlGetFieldVal(xmlCounty, 'DDOWN', 'DSC', i));
            $(objDD.options[i]).attr('ID',ispXmlGetFieldVal(xmlCounty, 'DDOWN', 'ID', i));
        } 	//for
    } 	//ispLoadCounty

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
            } 	//if
        } else {
        sYear = objDt.getFullYear();
        } 	//if

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




function isDisabled(obj){
	var x = $(obj).is(':disabled');
	/*if(x == undefined || x== ''){
		return false;
	}*/
	return x;
}

function SetCtrlDisabled(obj){
	if(isDisabled(obj)){
		$(obj).attr('disabled', 'disable');
	}
}

    function ispValidZipCode(objZipFld, objStateCbo, arrValid, idx, bPlus4) {
        var iMaxZip, iMinZip, iZipLen, errMsg = new Array();

        iMinZip = $(objStateCbo.options[objStateCbo.selectedIndex]).attr('MinZip');
        iMaxZip = $(objStateCbo.options[objStateCbo.selectedIndex]).attr('MaxZip');

        errMsg[0] = 'Zip Not Numeric-Range ' + iMinZip + ' - ' + iMaxZip;
        errMsg[1] = 'Zip Required-Range ' + iMinZip + ' - ' + iMaxZip;
        errMsg[2] = 'Zip Invalid-Range ' + iMinZip + ' - ' + iMaxZip;
        errMsg[3] = 'Zip+4 Not Numeric';
        errMsg[4] = 'Zip+4 Must Be 4 Digits';

        if (bPlus4) {
            if (isNaN(objZipFld.value)) {
                arrValid[idx][2] = errMsg[3];
                return true;
            } 	//if
            if (objZipFld.value.length > 0 && objZipFld.value.length < 4) {
                arrValid[idx][2] = errMsg[4];
                return true
            } 	//if
        } else {
            if (isNaN(objZipFld.value)) {
                arrValid[idx][2] = errMsg[0];
                return true;
            } 	//if
            if (objZipFld.value.length != 5) {
                arrValid[idx][2] = errMsg[1];
                return true;
            } 	//if
            if (objZipFld.value.substr(0, 3) < iMinZip || objZipFld.value.substr(0, 3) > iMaxZip) {
                arrValid[idx][2] = errMsg[2];
                return true
            } 	//if
        } 	//if
        return false;
    } 	//ispValidZipCode


    function SetDDList(obj, Items, valu, intDefault) {
        
		if(intDefault==  undefined || undefined==null){
			intDefault= 0;
		}

        if (typeof(Items) == undefined || Items == null) {
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
				//suman------------------------------------------
				/*
				for (var i = 0; i != obj.length; i++) {
					
					if ($(obj.options[i]).attr(Items)== valu) {
						obj.selectedIndex = i;
						return true;
					} 	
				}
				*/
				//------------------------------------------

				 if(valu == 'innerText'){
					if($(obj.options[i]).text() == valu){
						obj.selectedIndex = i;
						return true;
					}
				 }
				 else if ($(obj.options[i]).text() == valu) {
					obj.selectedIndex = i;
					return true;
				}
				else {
					try{          
						if ($(obj.options[i]).attr(Items)== valu) {
						obj.selectedIndex = i;
						return true;
						}			
					}
					catch (e){
						alert('setddlist, Name:' + e.name  + ' Description: ' + e.description);
					}
				}
			} 	
		}
	}


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

    } //RemoveFormatting


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
                    ispException('ispSetFocus', msg, '', '1');
                }
            }
        }

    } //ispSetFocus


    function ispAlignRight(obj) {
        $(obj).css('text-align', 'right');
    } //ispAlignRight


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
    } //ispTrim

    function ispZeroFill(obj, intLen) {

        if (isNaN(obj.value) == false) {
            while (obj.value.length < intLen) {
                obj.value = '0' + obj.value;
            }
        }

    } //ispZeroFill


    function ispLoadXML(objRequestXml, oReplyXml, strAspPage) {
        var oMsg = getXmlHttpRequestObj();
        var err=null;
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

//        if (objRequestXml.parseError.errorCode != 0) {
//            strMessage = "REQUEST XML Parse: reason=" + objRequestXml.parseError.reason + " -- line=" + objRequestXml.parseError.line + " -- errorCode=" + objRequestXml.parseError.errorCode + " -- srcText=" + objRequestXml.parseError.srcText
//            alert("Error " + strMessage)
//            return false;
//        } 	//if

        if (err) {
            strMessage = "REQUEST XML Parse: reason=" + err + " -- line=" + "N//A" + " -- errorCode=" + "N//A" + " -- srcText=" + "N//A";
            alert("ispLoadXML Error : " + strMessage);
            return false;
        }
        //oMsg.send(objRequestXml.XMLDocument)
        oMsg.send(objRequestXml);

        //oReplyXml.loadXML(oMsg.responseText)

        oReplyXml = $.parseXml(oMsg.responseText);
    } 	//CallXMLForm

    function LoadGenericDD(objXML, objDD, Node, ShowCode, DisplayItem) {

//        var iCount = ispXmlGetRecCount(objXML, Node, 'n')
//        var strInnerText = 'DESC'
       var sDisplayItem = '';
       if (DisplayItem) {
            sDisplayItem = DisplayItem;
        } 	


//        if (ShowCode == true) {
//            strInnerText = 'CODE'
//        }

//        objDD.options.length = iCount
//        for (i = 0; i < iCount; i++) {
//            if (sDisplayItem == '' || sDisplayItem == ispXmlGetFieldVal(objXML, Node, "DISPLAY_ITEM", i).match(sDisplayItem)) {
//                objDD.options(i).innerText = ispXmlGetFieldVal(objXML, Node, strInnerText, i)
//                objDD.options(i).CODE = ispXmlGetFieldVal(objXML, Node, "CODE", i)
//            } 	//if
//        }

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
				if(sDisplayItem != ''){
					var node_attr = $(this).attr('DISPLAY_ITEM');

					//suman
					//In javascript it is always easy to work with blank string than undefined or null
					//so fill this variable only if not null or undefined
					if(node_attr){
						node_attr_text = node_attr;
					}
					//alert('node_attr_text : ' + node_attr_text);
				}

                if (sDisplayItem == '' || sDisplayItem == node_attr_text.match(sDisplayItem))  {
               
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
		

            //	for (i = 0; i < iCount; i++) {
            //		if (sDisplayItem == '' || sDisplayItem == ispXmlGetFieldVal(objXML, Node, "DISPLAY_ITEM", i).match(sDisplayItem)) {
            //            var text = ispXmlGetFieldVal(objXML, Node, strInnerText ,i); 
            //            var value = ispXmlGetFieldVal(objXML, Node, "CODE", i);
            //			/*objDD.options[i].innerText = ispXmlGetFieldVal(objXML, Node, strInnerText ,i); 
            //			objDD.options[i].CODE = ispXmlGetFieldVal(objXML, Node, "CODE", i);
            //            */
            //            //suman -----------------------------------------------------------------
            //            objDD.options[i].text = text;
            //			objDD.options[i].value = value;
            //            //end--------------------------------------------------------------------
            //		}		//if
            //	}		//for

		for (i = 0; i < len; i++) {
			if ($(objDD.options[i]).text() == '') {
				objDD.remove(i);
				i = i - 1;
				len = len - 1;
			} 	//if
		}
	} 
    
		
function ispFormatMoney(strValue, intCents){ 
//SUMAN
	if(strValue == undefined || strValue==null || strValue == '' ){
		strValue = 0;
	}
	//IF INCOMING VALUE IS POSITIVE CURRENCY THEN THE FORMAT IS  : $1,000.00, FOR(-) IT WILL BE  : ($1,000.00)
	//SO  IF STRING CONTAINS  $,(,), <,>  SIGN THEN IT IS EXPECTED  TO BE A CURRENCY 
	var filtr_val = strValue.toString().replace('$','');
	filtr_val = filtr_val.replace('(','');
	filtr_val = filtr_val.replace(')','');
	filtr_val = filtr_val.replace(/,/g,'');
	
	var r=0; 
	if($.isNumeric(filtr_val)){ 
		r = accounting.formatMoney(strValue, {
			symbol : '$',
			precision: intCents, 
			thousand : ',',
			format:{
				pos: '%s%v',
				neg: '(%s%v)',
				zero: '%s0'
			}			
		});
	}
	else{
	
		r = strValue;
	} 
	return r;
}

function ispStripMoney(strValue){ 
//SUMAN
	if(strValue == undefined || strValue==null || strValue == '' ){
		strValue = 0;
	}

	var filtr_val = strValue.toString().replace('$','');
	filtr_val = filtr_val.replace('(','');
	filtr_val = filtr_val.replace(')','');
	filtr_val = filtr_val.replace(/,/g,'');
	
	var r=0;
	if($.isNumeric(filtr_val)){
		r = accounting.formatMoney(strValue, {
			symbol : '$',
			precision: 2, 
			thousand : '',
			format:{
				pos: '%s%v',
				neg: '-%s%v',
				zero: '%s.00'
			}
			
			});
	}
	else{
		r = strValue;
} 

	return r;
}

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
	var org = sAmount;
	if (sAmount == undefined || sAmount == null) {
		return 0.00; 
	}	//if

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


function IspIsDate(obj){
	try
	{
		var dt = new Date(obj);
		return true;
	}
	catch (expression)
	{
		return false;
	}
	/*
	if(IsDate(obj)){ 
		IspIsDate = true;
	}
	else{
		IspIsDate = false;
	}
	*/
}
function ispValue(strVal){
	//EHD 2007.01.09 v4.2.10 Removed the 'CDbl' from following line 'IsNumeric(CDbl(strVal))'

	/*if(strVal != null && strVal != 'undefined' && strVal != '')
	{
		strVal = strVal.replace(',', '').replace('$', '').replace('(','').replace(')','');
	}*/

	if(strVal != null && strVal != 'undefined' && strVal != ''){
		strVal = ispRemoveMoney(strVal);
	}

	if($.isNumeric(strVal)){
		return true;
	}
	else{
		return false;
	}
}


function ispNegativeNumber(strVal){

	var r = false;
//EHD 2007.01.09 v4.2.10 Removed the 'CDbl' from following line 'IsNumeric(CDbl(strVal))'
	if(ispValue(strVal)){
		if(strVal != null && strVal != 'undefined' && strVal != '')
		{
			strVal = ispRemoveMoney(strVal);
		}
		if(parseFloat(strVal) > -1){
			r = true;
		}
	}
	return r;
	//return true;
}


function formatCurrency(strValue,upto) // Chayan 
{
	strValue = isNaN(strValue) || strValue === '' || strValue === null ? 0.00 : strValue; 
	return parseFloat(strValue).toFixed(upto);
}
function ispStripCurrency(strVal) //Chayan
{
	if(strVal == '' ){
		strVal = 0;
	}

	var r=0;

	if($.isNumeric(strVal)){
//accounting.toFixed(strValue,intCents)
		
		r = formatCurrency(strVal,2).replace(',', '');
		//r= accounting.formatMoney(strValue, '$',intCents );
	}
	else{
		r = strVal.replace(',', '');
	} 
	return r;
}

function stripCurrency(value){
	var num = ispStripMoney(value);
	return num;
}


