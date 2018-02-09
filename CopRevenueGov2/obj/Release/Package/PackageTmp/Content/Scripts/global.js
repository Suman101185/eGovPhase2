
function global() {
    var me = this;

    this.xmlStatezip = null;
    this.xmlOrgType = null;
    this.xmlNAIC = null;
    this.xmlEntityType = null;
    this.xmlAccount = null;
    this.xmlTemplate = null;
    this.xmlEthnicity = null;
    this.xmlSex = null;
    this.xmlAddressType = null;
    this.xmlRelationships = null;
    this.xmlData = null;
    this.xmlWage = null;
    this.xmlWageTemplate = null;
    this.xmlSchool = null;
    this.xmlSchoolTemplate = null;
    this.xmlBPTez = null;
    this.xmlBPTezTemplate = null;
    this.xmlBPTez_2014 = null;
    this.xmlBPTezTemplate_2014 = null;
    this.xmlBPTez_2015 = null;
    this.xmlBPTezTemplate_2015 = null;
    this.xmlBPTez_2016 = null;
    this.xmlBPTezTemplate_2016 = null;

    this.xmlBPTlf_2015 = null;
    this.xmlBPTlfTemplate_2015 = null;
    this.xmlNPT_2015 = null;
    this.xmlNPTTemplate_2015 = null;
    this.xmlNPT = null;
    this.xmlNPTTemplate = null;
    this.xmlERN = null;
    this.xmlERNTemplate = null;
    this.xmlPayCoupon = null;
    this.xmlBPTlf = null;
    this.xmlBPTlfTemplate = null;
    this.xmlBPTlf_2014 = null;
    this.xmlBPTlfTemplate_2014 = null;
    this.xmlTobacco = null;
    this.xmlTobaccoTemplate = null;
    this.xmlUO = null;
    this.xmlUOTemplate = null;
    this.xmlEntitytypeCoupon = null;
    this.xmlCC = null;
    this.xmloAcctBalance = null;
    this.xmloAcctBalanceDelimited = null;
    this.xmlEmail = null;
    this.oUOList = null;
    this.oUOForm = null;
    this.oUOFormNew = null;
    this.xmlCC = null;
    this.xmlCCTemplate = null;
    this.xmlLcf = null;
    this.xmlLiquor = null;
    this.xmlLiquorTemplate = null;

    function _gMCxmlDocument() {
        this.xml = null;

        _gMCxmlDocument.prototype.loadXML = function (value) {
            var __t = typeof value;
            if (__t == "object"){
                // do nothing special,  it must already parsed.
                this.xml = value;
            } else if (__t == "string") {
                // it must be parsed
                this.xml = $.parseXML(value);
            } else {
                alert('$g : load XML : parameter object type is not supported.')
            }

            if (me.isXMLDOM()) {

                try {
                    xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                    if (xmlDoc) {
                        xmlDoc.loadXML(me.XMLToString(this));
                        this.xml = xmlDoc;
                    }
                }
                catch (err) {
                }
            }
        };

        _gMCxmlDocument.prototype.toString = function(){
            return me.XMLToString(this);
        };

        return this;

    }

    function _gCHttpRequest() {
        var req = null;

        try {
            //if IE then it will cause no error else it will throw error and then we can go for XMLHttpRequest
            try {
                req = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (er) {
                //do nothing
            }

            if (req) {
                // ok req is ready
            }
            else if (window.XMLHttpRequest) {
                req = new XMLHttpRequest();
            }
        }
        catch (err) {
            alert('$g : creating http request : XMLHttpRequest type is not supported.');
        }

        return req;
    }

    global.prototype.getXmlDocObj = function () {
        var xmldomobj = new _gMCxmlDocument();
        return xmldomobj
    };

    global.prototype.getXmlHttpRequestObj = function () {
        var htreq= new _gCHttpRequest();
        return htreq
    };

    global.prototype.isXMLDOM = function () {

        var ie = false;
        var xmlDoc = null;
        try {
            xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
            if (xmlDoc) {
                ie = true;
                xmlDoc = null;
            }
        }
        catch (err) {
        }
        return ie;
    };

    global.prototype.XMLToString = function (xmlReturn) {

        var xmlstring;

        xmlReturn = xmlReturn.xml;
        if (xmlReturn == undefined) {
            alert('$g : Xml to string : parameter object type is not supported.');
            return '';
        }

        if (xmlReturn.xml!= undefined) {
            xmlstring = xmlReturn.xml;
        }
        else {
            xmlstring = new XMLSerializer().serializeToString(xmlReturn);
        }
        return xmlstring;
    };

    global.prototype.loadXmlAsync = function (url, ResponseFunction) {
        $.ajax({
            type: "GET",
            cache: false,
            url: url,
            dataType: "xml",
            beforeSend: beforSend,
            success: ResponseFunction,
            error: xmlSyncjCallErroe
        });
    }

    global.prototype.loadXmlSync = function (url, ResponseFunction) {
        $.ajax({
            type: "GET",
            cache: false,
            url: url,
            dataType: "xml",
            async: false,
            beforeSend: beforSend,
            success: ResponseFunction,
            error: xmlSyncjCallErroe
        });
    }

    function beforSend(jqXHR, settings) {
        jqXHR.url = settings.url;//jqxhr is jquery request object
    }

    function xmlSyncjCallErroe(jqXHR, settings) {
        alert("$g : ajax call error : " + jqXHR.url);
    }

    global.prototype.loadXmls = function () {

        try {
            me.loadXmlSync("XML/OrgType", parseXml_xmlOrgType);
            me.loadXmlSync("XML/Statezip", parseXml_xmlStatezip);
            me.loadXmlSync("XML/NAIC", parseXml_xmlNAIC);
            me.loadXmlSync("XML/EntityType", parseXml_xmlEntityType);
            me.loadXmlSync("XML/AcctTemplate", parseXml_xmlAccount);
            me.loadXmlSync("XML/AcctTemplate", parseXml_xmlTemplate);
            me.loadXmlSync("XML/Ethnicity", parseXml_xmlEthnicity);
            me.loadXmlSync("XML/Sex", parseXml_xmlSex);
            me.loadXmlSync("XML/AddressType", parseXml_xmlAddressType);
            me.loadXmlSync("XML/Relationship", parseXml_xmlRelationships);
            me.loadXmlSync("XML/Output", parseXml_xmlData);
            me.loadXmlSync("XML/WageReturn", parseXml_xmlWage);
            me.loadXmlSync("XML/WageReturn", parseXml_xmlWageTemplate);
            me.loadXmlSync("XML/SchoolReturn", parseXml_xmlSchool);
            me.loadXmlSync("XML/SchoolReturn", parseXml_xmlSchoolTemplate);
            me.loadXmlSync("XML/BPTezReturn", parseXml_xmlBPTez);
            me.loadXmlSync("XML/BPTezReturn", parseXml_xmlBPTezTemplate);
            me.loadXmlSync("XML/BPTezReturn_2014", parseXml_xmlBPTez_2014);
            me.loadXmlSync("XML/BPTezReturn_2014", parseXml_xmlBPTezTemplate_2014);
            me.loadXmlSync("XML/BPTezReturn_2015", parseXml_xmlBPTez_2015);
            me.loadXmlSync("XML/BPTezReturn_2015", parseXml_xmlBPTezTemplate_2015);
            me.loadXmlSync("XML/BPTezReturn_2016", parseXml_xmlBPTez_2016);
            me.loadXmlSync("XML/BPTezReturn_2016", parseXml_xmlBPTezTemplate_2016);

            me.loadXmlSync("XML/BPTlfReturn_2015", parseXml_xmlBPTlf_2015);
            me.loadXmlSync("XML/BPTlfReturn_2015", parseXml_xmlBPTlfTemplate_2015);
            me.loadXmlSync("XML/NPTReturn", parseXml_xmlNPT);
            me.loadXmlSync("XML/NPTReturn", parseXml_xmlNPTTemplate);
            me.loadXmlSync("XML/ERNReturn", parseXml_xmlERN);
            me.loadXmlSync("XML/NPTReturn", parseXml_xmlERNTemplate);
            me.loadXmlSync("XML/PayCoupon", parseXml_xmlPayCoupon);
            me.loadXmlSync("XML/BPTlfReturn", parseXml_xmlBPTlf);
            me.loadXmlSync("XML/BPTlfReturn", parseXml_xmlBPTlfTemplate);

            me.loadXmlSync("XML/BPTlfReturn_2014", parseXml_xmlBPTlf_2014);
            me.loadXmlSync("XML/BPTlfReturn_2014", parseXml_xmlBPTlfTemplate_2014);

            me.loadXmlSync("XML/NPTReturn_2015", parseXml_xmlNPT_2015);
            me.loadXmlSync("XML/NPTReturn_2015", parseXml_xmlNPTTemplate_2015);
            
            me.loadXmlSync("XML/TobaccoReturn", parseXml_xmlTobacco);
            me.loadXmlSync("XML/TobaccoReturn", parseXml_xmlTobaccoTemplate);
            me.loadXmlSync("XML/UOReturn", parseXml_xmlUO);
            me.loadXmlSync("XML/UOReturn", parseXml_xmlUOTemplate);
            me.loadXmlSync("XML/EntityTypeCoupon", parseXml_xmlEntityTypeCouponTemplate);
            me.loadXmlSync("XML/CCBilling", parseXml_xmlCCBilling);
            me.loadXmlSync("XML/DelinquentForm", parseXml_xmloAcctBalance);
            me.loadXmlSync("XML/DelinquentForm", parseXml_xmloAcctBalanceDelimited);
            me.loadXmlSync("XML/email", parseXml_xmlEmail);
            me.loadXmlSync("XML/UOList", parseXml_xmlUOList);
            me.loadXmlSync("XML/UOForm", parseXml_xmlUOForm);
            me.loadXmlSync("XML/UOFormNew", parseXml_xmlUOFormNew);
            me.loadXmlSync("XML/CCBilling", parseXml_xmlCC);
            me.loadXmlSync("XML/CCBilling", parseXml_xmlCCTemplate);
            me.loadXmlSync("XML/LossCarryForward", parseXml_xmlLcf);
            me.loadXmlSync("XML/LiquorReturn", parseXml_xmlLiquor);
            me.loadXmlSync("XML/LiquorReturn", parseXml_xmlLiquorTemplate);
        } catch (expression) {
            alert("$g : loadXmls : " + expression)
        }
    };

    function parseXml_xmlCCBilling(xml) {
        if (me.xmlCC == null) {
            me.xmlCC = me.getXmlDocObj();
        }
        me.xmlCC.loadXML(xml);
    }
    function parseXml_xmloAcctBalance(xml) {
        if (me.xmloAcctBalance == null) {
            me.xmloAcctBalance = me.getXmlDocObj();
        }
        me.xmloAcctBalance.loadXML(xml);
    }
    function parseXml_xmloAcctBalanceDelimited(xml) {
        if (me.xmloAcctBalanceDelimited == null) {
            me.xmloAcctBalanceDelimited = me.getXmlDocObj();
        }
        me.xmloAcctBalanceDelimited.loadXML(xml);
    }
    function parseXml_xmlStatezip(xml) {
        if (me.xmlStatezip == null) {
            me.xmlStatezip = me.getXmlDocObj();
        }
        me.xmlStatezip.loadXML(xml);
    }
    function parseXml_xmlOrgType(xml) {
        if (me.xmlOrgType == null) {
            me.xmlOrgType = me.getXmlDocObj();
        }
        me.xmlOrgType.loadXML(xml);
    }
    function parseXml_xmlNAIC(xml) {
        if (me.xmlNAIC == null) {
            me.xmlNAIC = me.getXmlDocObj();
        }
        me.xmlNAIC.loadXML(xml);
    }
    function parseXml_xmlEntityType(xml) {
        if (me.xmlEntityType == null) {
            me.xmlEntityType = me.getXmlDocObj();
        }
        me.xmlEntityType.loadXML(xml);
    }
    function parseXml_xmlAccount(xml) {
        if (me.xmlAccount == null) {
            me.xmlAccount = me.getXmlDocObj();
        }
        me.xmlAccount.loadXML(xml);
    }
    function parseXml_xmlTemplate(xml) {
        if (me.xmlTemplate == null) {
            me.xmlTemplate = me.getXmlDocObj();
        }
        me.xmlTemplate.loadXML(xml);
    }
    function parseXml_xmlEthnicity(xml) {
        if (me.xmlEthnicity == null) {
            me.xmlEthnicity = me.getXmlDocObj();
        }
        me.xmlEthnicity.loadXML(xml);
    }
    function parseXml_xmlSex(xml) {
        if (me.xmlSex == null) {
            me.xmlSex = me.getXmlDocObj();
        }
        me.xmlSex.loadXML(xml);
    }
    function parseXml_xmlAddressType(xml) {
        if (me.xmlAddressType == null) {
            me.xmlAddressType = me.getXmlDocObj();
        }
        me.xmlAddressType.loadXML(xml);
    }
    function parseXml_xmlRelationships(xml) {
        if (me.xmlRelationships == null) {
            me.xmlRelationships = me.getXmlDocObj();
        }
        me.xmlRelationships.loadXML(xml);
    }
    function parseXml_xmlData(xml) {
        if (me.xmlData == null) {
            me.xmlData = me.getXmlDocObj();
        }
        me.xmlData.loadXML(xml);
    }
    function parseXml_xmlWage(xml) {
        if (me.xmlWage == null) {
            me.xmlWage = me.getXmlDocObj();
        }
        me.xmlWage.loadXML(xml);
    }
    function parseXml_xmlWageTemplate(xml) {
        if (me.xmlWageTemplate == null) {
            me.xmlWageTemplate = me.getXmlDocObj();
        }
        me.xmlWageTemplate.loadXML(xml);
    }
    function parseXml_xmlBPTez_2015(xml) {
        if (me.xmlBPTez_2015 == null) {
            me.xmlBPTez_2015 = me.getXmlDocObj();
        }
        me.xmlBPTez_2015.loadXML(xml);
    }
    function parseXml_xmlBPTezTemplate_2015(xml) {
        if (me.xmlBPTezTemplate_2015 == null) {
            me.xmlBPTezTemplate_2015 = me.getXmlDocObj();
        }
        me.xmlBPTezTemplate_2015.loadXML(xml);
    }

    function parseXml_xmlBPTez_2016(xml) {
        if (me.xmlBPTez_2016 == null) {
            me.xmlBPTez_2016 = me.getXmlDocObj();
        }
        me.xmlBPTez_2016.loadXML(xml);
    }
    function parseXml_xmlBPTezTemplate_2016(xml) {
        if (me.xmlBPTezTemplate_2016 == null) {
            me.xmlBPTezTemplate_2016 = me.getXmlDocObj();
        }
        me.xmlBPTezTemplate_2016.loadXML(xml);
    }
    function parseXml_xmlSchool(xml) {
        if (me.xmlSchool == null) {
            me.xmlSchool = me.getXmlDocObj();
        }
        me.xmlSchool.loadXML(xml);
    }
    function parseXml_xmlSchoolTemplate(xml) {
        if (me.xmlSchoolTemplate == null) {
            me.xmlSchoolTemplate = me.getXmlDocObj();
        }
        me.xmlSchoolTemplate.loadXML(xml);
    }
    function parseXml_xmlBPTez(xml) {
        if (me.xmlBPTez == null) {
            me.xmlBPTez = me.getXmlDocObj();
        }
        me.xmlBPTez.loadXML(xml);
    }
    function parseXml_xmlBPTezTemplate(xml) {
        if (me.xmlBPTezTemplate == null) {
            me.xmlBPTezTemplate = me.getXmlDocObj();
        }
        me.xmlBPTezTemplate.loadXML(xml);
    }
    function parseXml_xmlBPTez_2014(xml) {
        if (me.xmlBPTez_2014 == null) {
            me.xmlBPTez_2014 = me.getXmlDocObj();
        }
        me.xmlBPTez_2014.loadXML(xml);
    }
    function parseXml_xmlBPTezTemplate_2014(xml) {
        if (me.xmlBPTezTemplate_2014 == null) {
            me.xmlBPTezTemplate_2014 = me.getXmlDocObj();
        }
        me.xmlBPTezTemplate_2014.loadXML(xml);
    }
    function parseXml_xmlNPT(xml) {
        if (me.xmlNPT == null) {
            me.xmlNPT = me.getXmlDocObj();
        }
        me.xmlNPT.loadXML(xml);
    }
    function parseXml_xmlNPTTemplate(xml) {
        if (me.xmlNPT == null) {
            me.xmlNPT = me.getXmlDocObj();
        }
        me.xmlNPT.loadXML(xml);
    }
    function parseXml_xmlERN(xml) {
        if (me.xmlNPT == null) {
            me.xmlNPT = me.getXmlDocObj();
        }
        me.xmlNPT.loadXML(xml);
    }
    function parseXml_xmlERNTemplate(xml) {
        if (me.xmlNPTTemplate == null) {
            me.xmlNPTTemplate = me.getXmlDocObj();
        }
        me.xmlNPTTemplate.loadXML(xml);
    }
    function parseXml_xmlPayCoupon(xml) {
        if (me.xmlPayCoupon == null) {
            me.xmlPayCoupon = me.getXmlDocObj();
        }
        me.xmlPayCoupon.loadXML(xml);
    }
    function parseXml_xmlBPTlf(xml) {
        if (me.xmlBPTlf == null) {
            me.xmlBPTlf = me.getXmlDocObj();
        }
        me.xmlBPTlf.loadXML(xml);
    }
    function parseXml_xmlBPTlfTemplate(xml) {
        if (me.xmlBPTlfTemplate == null) {
            me.xmlBPTlfTemplate = me.getXmlDocObj();
        }
        me.xmlBPTlfTemplate.loadXML(xml);
    }
    function parseXml_xmlBPTlf_2014(xml) {
        if (me.xmlBPTlf_2014 == null) {
            me.xmlBPTlf_2014 = me.getXmlDocObj();
        }
        me.xmlBPTlf_2014.loadXML(xml);
    }
    function parseXml_xmlBPTlfTemplate_2014(xml) {
        if (me.xmlBPTlfTemplate_2014 == null) {
            me.xmlBPTlfTemplate_2014 = me.getXmlDocObj();
        }
        me.xmlBPTlfTemplate_2014.loadXML(xml);
    }
    function parseXml_xmlBPTlf_2015(xml) {      
        if (me.xmlBPTlf_2015 == null) {
            me.xmlBPTlf_2015 = me.getXmlDocObj();
        }
        me.xmlBPTlf_2015.loadXML(xml);
    }
    function parseXml_xmlBPTlfTemplate_2015(xml) {
        if (me.xmlBPTlfTemplate_2015 == null) {
            me.xmlBPTlfTemplate_2015 = me.getXmlDocObj();
        }
        me.xmlBPTlfTemplate_2015.loadXML(xml);
    }
    function parseXml_xmlTobacco(xml) {
        if (me.xmlTobacco == null) {
            me.xmlTobacco = me.getXmlDocObj();
        }
        me.xmlTobacco.loadXML(xml);
    }
    function parseXml_xmlTobaccoTemplate(xml) {
        if (me.xmlTobaccoTemplate == null) {
            me.xmlTobaccoTemplate = me.getXmlDocObj();
        }
        me.xmlTobaccoTemplate.loadXML(xml);
    }
    function parseXml_xmlUO(xml) {
        if (me.xmlUO == null) {
            me.xmlUO = me.getXmlDocObj();
        }
        me.xmlUO.loadXML(xml);
    }
    function parseXml_xmlUOTemplate(xml) {
        if (me.xmlUOTemplate == null) {
            me.xmlUOTemplate = me.getXmlDocObj();
        }
        me.xmlUOTemplate.loadXML(xml);
    }
    function parseXml_xmlEntityTypeCouponTemplate(xml) {
        if (me.xmlEntitytypeCoupon == null) {
            me.xmlEntitytypeCoupon = me.getXmlDocObj();
        }
        me.xmlEntitytypeCoupon.loadXML(xml);
    }
    function parseXml_xmlEmail(xml) {
        if (me.xmlEmail == null) {
            me.xmlEmail = me.getXmlDocObj();
        }
        me.xmlEmail.loadXML(xml);
    }
    function parseXml_xmlUOList(xml) {
        if (me.oUOList == null) {
            me.oUOList = me.getXmlDocObj();
        }
        me.oUOList.loadXML(xml);
    }
    function parseXml_xmlUOForm(xml) {
        if (me.oUOForm == null) {
            me.oUOForm = me.getXmlDocObj();
        }
        me.oUOForm.loadXML(xml);
    }
    function parseXml_xmlUOFormNew(xml) {
        if (me.oUOFormNew == null) {
            me.oUOFormNew = me.getXmlDocObj();
        }
        me.oUOFormNew.loadXML(xml);
    }
    function parseXml_xmlCC(xml) {
        if (me.xmlCC == null) {
            me.xmlCC = me.getXmlDocObj();
        }
        me.xmlCC.loadXML(xml);
    }
    function parseXml_xmlCCTemplate(xml) {
        if (me.xmlCCTemplate == null) {
            me.xmlCCTemplate = me.getXmlDocObj();
        }
        me.xmlCCTemplate.loadXML(xml);
    }
    function parseXml_xmlLcf(xml) {
        if (me.xmlLcf == null) {
            me.xmlLcf = me.getXmlDocObj();
        }
        me.xmlLcf.loadXML(xml);
    }
    function parseXml_xmlLiquor(xml) {
        if (me.xmlLiquor == null) {
            me.xmlLiquor = me.getXmlDocObj();
        }
        me.xmlLiquor.loadXML(xml);
    }
    function parseXml_xmlLiquorTemplate(xml) {
        if (me.xmlLiquorTemplate == null) {
            me.xmlLiquorTemplate = me.getXmlDocObj();
        }
        me.xmlLiquorTemplate.loadXML(xml);
    }

    function parseXml_xmlNPT_2015(xml) {
        if (me.xmlNPT_2015 == null) {
            me.xmlNPT_2015 = me.getXmlDocObj();
        }
        me.xmlNPT_2015.loadXML(xml);
    }
    function parseXml_xmlNPTTemplate_2015(xml) {
        if (me.xmlNPTTemplate_2015 == null) {
            me.xmlNPTTemplate_2015 = me.getXmlDocObj();
        }
        me.xmlNPTTemplate_2015.loadXML(xml);
    }

    return me;
}

//var $g = new global();
