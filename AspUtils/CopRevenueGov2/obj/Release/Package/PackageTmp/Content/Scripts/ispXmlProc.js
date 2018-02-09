
/*

MS DOM XML parser can read through root nodes
For example 
<ACCT>
<ELM><ELM>
</ACCT>
MS parser :ACCT\ELM will find EML node
jquery DOM finds nodes after root, in this case we need to pass just EML as xpath
to solve this  issue we need to write few methods to identify and remove root tags from xpath if present
*/

    function XMLToString(xmlReturn) {
        var xmlstring;

        xmlReturn = $(xmlReturn.xml).get(0);
        if (xmlReturn == undefined) {
            //alert('XML Object undefined');
            return '';
        }

        if (window.ActiveXObject) {
            var IE_fc = new ActiveXObject("Microsoft.XMLDOM");
            IE_fc.async = false;

            if (xmlReturn.xml == undefined) {
                alert('IE xml parse error');
            }
            else {
                xmlstring = xmlReturn.xml;
            }        
        }
        else {
            xmlstring = new XMLSerializer().serializeToString(xmlReturn);
        }
        return xmlstring;
    }

    function XMLToString_Delinquent(xmlReturn)
    {
		    var xmlstring ;
		    if(window.ActiveXObject){
			    var IE_fc = new ActiveXObject("Microsoft.XMLDOM");
			    IE_fc.async = false;
			    //try to get dom from jquery
			    //alert(xmlReturn.xml.xml);
			    var dx = xmlReturn.xml.xml; // $(xmlReturn.xml).clone(true).get(0);
			    //alert(dx);
			    try{
				    //var oString = xmlReturn.xml;
				    //alert(oString);
				    IE_fc.loadXML(dx.nodeValue);
			    }
			    catch(ex){
				    alert('IE xml parse error');
			    }
			    xmlstring = IE_fc.xml;
		    }
		    else{
			    xmlstring = new XMLSerializer().serializeToString(xmlReturn.xml);
		    }

	    return xmlstring;
    }

    function isRoot(X, name) {

        var n;
        var x = $(X.xml)[0].tagName;

        if (x == undefined) {
            n = X.xml.documentElement.tagName;
        }
        else {
            n = x;
        }

        if (n == undefined){
		    alert('still root is undefined');
            return false;
	    }

        if (n == name) {
            return true;
        }

        return false;

    }

    function removeRoot(X, xpath){
        var ar = xpath.split(' ');
        if(ar.length > 0){
            if(isRoot(X, ar[0]) == true){

             var newpath = ':first';
                var m = parent.MenuWin.getXmlDocObj();
                m.xml = $(X.xml).find(':first').eq(0);
                if (isRoot(m, ar[0])) {
                    
                }
                else {
                    newpath = '';
                }

                for(i=1; i< ar.length; i++){
                    newpath = newpath  + ' ' + ar[i];
				}
                return $.trim(newpath);
            }
        }
        return xpath;
    }

    function ispXmlGetFieldVal(oXML, sElement, sAttrib, iRecordNo) {
        try {
            if (iRecordNo == undefined || iRecordNo == null){ 
				iRecordNo = 0; 
			}

            if (sElement == undefined ||  sElement == null || sElement == ''){ 
				sElement = null; 
			}

            if (sAttrib == undefined || sAttrib == null || sAttrib == ''){ 
				sAttrib = null; 
			}

            if (sElement == null) {
                return 'Missing sElement value...';
            }

			//remove root from xpath
			 sElement = removeRoot(oXML, sElement);

            if (sElement == '') {
				//blank mean it is a root node. So we need not to find a child tag or record no
                if (sAttrib !== null) {
                    var xmlval = $(oXML.xml).attr(sAttrib);
                    return xmlval;
                } 	
                var res = $(oXML.xml).text();
                return res;
			}
			else{
                if (sAttrib !== null) {
                    var xmlval = $(oXML.xml).find(sElement).eq(iRecordNo).attr(sAttrib);
                    return xmlval;
                } 	
                var res = $(oXML.xml).find(sElement).eq(iRecordNo).text();

                return $.trim(res);
            } 
        }
        catch (exception) {
            var msg = exception.description + '\n\n' +
				'sElement= ' + sElement + '\n' +
				'sAttrib= ' + sAttrib + '\n' +
				'iRecordNo= ' + iRecordNo + '\n';

            ispException('ispXmlGetFieldVal', msg, oXML, '1');
        }
		
    } 	

    function ispXmlSetFieldVal(oXML, sValue, sElement, sAttrib, iRecordNo) {
        try {

            if (iRecordNo == undefined || iRecordNo == null){ 
				iRecordNo = 0; 
			}

            if (sElement == undefined ||  sElement == null || sElement == ''){ 
				sElement = null; 
			}

            if (sAttrib == undefined || sAttrib == null || sAttrib == ''){ 
				sAttrib = null; 
			}

            if (sElement == null) {
                return 'Missing sElement value...';
            }

			//remove root from xpath
			sElement = removeRoot(oXML, sElement);

            if (sElement == '') {
				if (sAttrib !== null) {
					   $(oXML.xml).attr(sAttrib, sValue);
					return;
				}
				else{
					$(oXML.xml).text(sValue);
					return;
				}
			}
			else{
				if (sAttrib !== null) {
					   $(oXML.xml).find(sElement).eq(iRecordNo).attr(sAttrib, sValue);
					return;
				}
				else{
					$(oXML.xml).find(sElement).eq(iRecordNo).text(sValue);
					return;
				}
			}
        }
        catch (exception) {
            alert('ispXmlSetFieldVal : ' + exception);
            var msg = exception.description + '\n\n' +
				'sElement= ' + sElement + '\n' +
				'sAttrib= ' + sAttrib + '\n' +
				'sValue= ' + sValue + '\n';

            ispException('ispXmlSetFieldVal', msg, oXML, '2');
        }
    } 	

    function ispXmlGetRecordXml(oXML, sElement, iRecordNo) {
        try {
			/*
			This method is used to collect xml fragments to make some modifications
			which will be either append or replaced with original xml doc.
			our current system passes docs as ref. so any change on fragment will change original doc.
			to preserve appropriate flow we need to clone a node to make a copy without ref with original doc.
			*/

            if (iRecordNo == undefined || iRecordNo == null){ 
				iRecordNo = 0; 
			}

            if (sElement == undefined ||  sElement == null || sElement == ''){ 
				sElement = null; 
			}

            if (sElement == null) {
                return 'Missing sElement value...';
            }

			//return $(oXML.xml).find(sElement).eq(iRecordNo).clone(true);

			sElement = removeRoot(oXML, sElement);

            if (sElement == '') {
				return $(oXML.xml).clone(true);	
				alert('sElement true');
			}
			else{
				return $(oXML.xml).find(sElement).eq(iRecordNo).clone(true);
			}			
        }
        catch (exception) {
            var msg = exception.description + '\n\n' +
				'sElement= ' + sElement + '\n' +
				'iRecordNo= ' + iRecordNo + '\n';

            ispException('ispXmlGetRecordXml', msg, oXML, '3');
        }
    }

    function ispXmlGetRecCount(oXML, sElement, bAttrib) {
        //-------------------- Suman 11-12-2012 ----------------------------------
        try {
			

            if (sElement == undefined ||  sElement == null || sElement == ''){ 
				sElement = null; 
			}

            if (bAttrib == undefined || bAttrib == null || bAttrib.toUpperCase() != 'Y') {
                bAttrib = null;
            }

            if (sElement == null) {
                return 'Missing sElement value...';
            }

            if (bAttrib != null) {
				
                var res = $(oXML.xml).find(sElement).eq(0).get(0).attributes.length;

                return res;
             }

           var pets = $(oXML.xml).find(sElement).size();
		   return pets;
            
        }
        catch (exception) {
			
            var msg = exception.description + '\n\n' +	'sElement= ' + sElement + '\n' + 'bAttrib= ' + bAttrib + '\n';

            ispException('ispXmlGetRecCount', msg, oXML, '4');
        }
        //-------------------- end----------------------------------

    }

    function ispXmlAddBlankRecs(oXML, sElement, iRecNos) {

		/*
		This method will create a copy of sElement node <iRecNos> times in xml doc
		NOTE: append can not possible for root
		*/

		sElement = removeRoot(oXML, sElement);

		if (sElement == '') {
			//it is a root level node, abort the function.
			return;
		}

        var olXML, iLength, i;
	
        

        //olXML.async = false;
        olXML = ispXmlGetRecordXml(oXML,sElement,0);
        iLength = ispXmlGetRecCount(oXML,sElement);

		// suman
		//append can not possible on root

        for(i = 0; i <= iRecNos; i++) {
            //oXML.documentElement.selectNodes("//*/" + sElement).item((iLength + i) //-1).parentNode.appendChild(olXML.documentElement.cloneNode(true));
			
			$(oXML.xml).find(sElementTo).eq((iLength + i) -1).parent().append(olXML);

        } 	
    } 	

    function ispXmlReplaceNode(oXmlTo, sElementTo, iRecNoTo, oXmlFrom, sElementFrom, iRecNoFrom) {

		var from_node;

        try {
            //var oldChild = oXmlTo.documentElement.selectNodes("//" + sElementTo).item(iRecNoTo)
            //var newChild = oXmlFrom.documentElement.selectNodes("//" + sElementFrom).item(iRecNoFrom).cloneNode(true)

		    if (sElementTo == undefined ||  sElementTo == null || sElementTo == ''){ 
				sElementTo = null; 
			}

			
			if (sElementTo) {
				sElementTo = removeRoot(oXmlTo, sElementTo);
				if (sElementTo == '') {
					//root node can not be replaced
					sElementTo = null;
				}
			}

			if (sElementTo == null) {
                return 'Missing sElementTo value...';
            }



		    if (sElementFrom == undefined ||  sElementFrom == null || sElementFrom == ''){ 
				sElementFrom = null; 
			}
		
			if (sElementFrom) {
				sElementFrom = removeRoot(oXmlFrom, sElementFrom);
				if (sElementFrom == '') {
					
					from_node = $(oXmlFrom.xml);
				}
				else{
					from_node = $(oXmlFrom.xml).find(sElementFrom).eq(iRecNoFrom);
				}
			}

			if(from_node){
				$(oXmlTo.xml).find(sElementTo).eq(iRecNoTo).replaceWith(from_node);   
			}
  
        }
        catch (exception) {
			alert('inner ' + exception);
            var msg = exception.description + '\n\n' +
				'oXmlTo= ' + oXmlTo.xml + '\n' +
				'sElementTo= ' + sElementTo + '\n' +
				'iRecNoTo= ' + iRecNoTo + '\n' +
				'oXmlFrom= ' + oXmlFrom.xml + '\n' +
				'sElementFrom= ' + sElementFrom + '\n' +
				'iRecNoFrom= ' + iRecNoFrom + '\n';

            ispException('ispXmlReplaceNode', msg, oXmlTo, '5');
        }

    }

    function ispAppendNodeXml(oXmlTo, sElementTo, iRecNoTo, oXmlFrom, sElementFrom, iRecNoFrom) {

		var from_node;
		var to_node;

        try {


		    if (sElementTo == undefined ||  sElementTo == null || sElementTo == ''){ 
				sElementTo = null; 
			}

			if (sElementTo == null) {
                return 'Missing sElementTo value...';
            }
			
			if (sElementTo) {
				sElementTo = removeRoot(oXmlTo, sElementTo);
				if (sElementTo == '') {
					to_node = $(oXmlTo.xml);
				}
				else{
					to_node = $(oXmlTo.xml).find(sElementTo).eq(iRecNoTo);
				}
			}





		    if (sElementFrom == undefined ||  sElementFrom == null || sElementFrom == ''){ 
				sElementFrom = null; 
			}

			if (sElementFrom == null) {
                sElementFrom = sElementTo;
            }

			if (iRecNoFrom == undefined ||  iRecNoFrom == null || iRecNoFrom < 0 ){ 
				iRecNoFrom = 0;
			}
		
			if (sElementFrom) {
				sElementFrom = removeRoot(oXmlFrom, sElementFrom);
				if (sElementFrom == '') {
					
					from_node = $(oXmlFrom.xml);
				}
				else{
					from_node = $(oXmlFrom.xml).find(sElementFrom).eq(iRecNoFrom);
				}
			}

			if(from_node && to_node){
				to_node.append(from_node);   
			}      
						
        }

        catch (exception) {
			/*
            var msg = exception.description + '\n\n' +
				'oXmlTo= ' + oXmlTo.xml + '\n' +
				'sElementTo= ' + sElementTo + '\n' +
				'iRecNoTo= ' + iRecNoTo + '\n' +
				'oXmlFrom= ' + oXmlFrom.xml + '\n' +
				'sElementFrom= ' + sElementFrom + '\n' +
				'iRecNoFrom= ' + iRecNoFrom + '\n';
				*/
				var msg = exception.description + '\n\n' +
				'oXmlTo= ' + oXmlTo.xml + '\n' +
				'sElementTo= ' + sElementTo + '\n' +
				'iRecNoTo= ' + iRecNoTo + '\n' +
				'oXmlFrom= ' + oXmlFrom.xml + '\n' +
				'sElementFrom= ' + sElementFrom + '\n' +
				'iRecNoFrom= ' + iRecNoFrom + '\n';

            ispException('ispAppendNodeXml', msg, oXmlTo, '6');
        }

    }

    function ispXmlRemoveNode(oXml, sParentElement, iParentNo, sChildElement, iChildNo) {

		var nodeToRemove;
		var parent_node;

        try {

		    if (sParentElement == undefined ||  sParentElement == null || sParentElement == ''){ 
				sParentElement = null; 
			}

			if (sParentElement == null) {
                return 'Missing sParentElement value...';
            }
			
			if (sParentElement) {
				sParentElement = removeRoot(oXml, sParentElement);
				if (sParentElement == '') {
					parent_node = $(oXml.xml);
				}
				else{
					parent_node = $(oXml.xml).find(sParentElement).eq(iParentNo);
				}
			}

			if(parent_node){
			}
			else{
				return 'sParentElement undefined ...';
			}

		    if (sChildElement == undefined ||  sChildElement == null || sChildElement == ''){ 
				sChildElement = null; 
			}

			if (iChildNo == undefined ||  iChildNo == null || iChildNo < 0 ){ 
				iChildNo = 0;
			}
		
			if (sChildElement) {
			}
			else{
                return 'Missing sChildElement value...';
            }

			if (sChildElement) {
				var parent_node_obj = parent.MenuWin.getXmlDocObj();
				parent_node_obj.xml = parent_node;
				sChildElement = removeRoot(parent_node_obj, sChildElement);

				if (sChildElement == '') {
					
					nodeToRemove = $(parent_node);
				}
				else{
					nodeToRemove = $(parent_node).find(sChildElement).eq(iChildNo);
				}
			}


			if(nodeToRemove){
				nodeToRemove.remove();
			}
			else{
				return 'sChildElement undefined ...';
			}
        }
        catch (exception) {
			
            var msg = exception.description + '\n\n' +
				'oXml= ' + oXml.xml + '\n' +
				'sParentElement= ' + sParentElement + '\n' +
				'iParentNo= ' + iParentNo + '\n' +
				'sChildElement= ' + sChildElement.xml + '\n' +
				'iChildNo= ' + iChildNo + '\n';

            ispException('ispXmlRemoveNode', msg, oXml, '7');
        }
    }

    function ispCreateException(sFunction, msgText, sXml, msgNum) {
        this.messageNumber = msgNum;
        this.messageText = msgText;
        this.sXml = sXml;
        this.functionName = sFunction;
    }

    function ispException(sFunction, msgText, oXml, msgNum)
	{
		//alert(sFunction + ' ' +  msgText);
        var exceptionObj = new ispCreateException(sFunction, msgText, oXml, msgNum);
        var oErr =  parent.MenuWin.getXmlDocObj();

        if (parent.MenuWin.strDebug == 'Y') {
            var str1 = "<NA><EMAILERR><TEXT>" + msgText + "</TEXT>" + "<FUNCTION>" + sFunction + "</FUNCTION>" + "<NUM>" + msgNum + "</NUM></EMAILERR></NA>";


            oErr.xml = $.parseXML(str1);

            if (oXml)
			{
                if (ispXmlGetRecCount(oXml, "EMAILERR", 'n') == 0) {
                    ispAppendNodeXml(oXml, oXml.documentElement.nodeName, 0, oErr, "EMAILERR", 0);
                } else {
                ispXmlReplaceNode(oXml, "EMAILERR", 0, oErr, "EMAILERR", 0);
                }
                parent.MenuWin.oMail = oXml;
            } else {
            parent.MenuWin.oMail = oErr;
            }
            ispCallXMLForm(parent.MenuWin.oMail, parent.MenuWin.oMail, '../Email/EmailErr');
        }
		
    }

