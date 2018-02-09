<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>
    <title></title>
    <script language="javascript" type="text/javascript">
        var arrPage1Err = new Array();

        function LocatePrimaryAddr() {
            var iMaxIdx = parent.$x.ispXmlGetRecCount(parent.$g.xmlAccount, 'NAME_ADDRESS', '');

            for (idx = 0; idx < iMaxIdx; i++) {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS_TYPE', '', idx) == '60') {
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS RELATIONSHIP_CODE', '', idx) == '0') {
                        return idx;
                    } //if
                } else {

                    return 0;
                } //if
            } //for
        } //locatePrimaryAddr


      

        function chkCorpMembers_onclick() { //Determine if questions 3 & 4 of Worksheet K are needed or if Worksheet D will be used instead
            if (chkCorpMembers.checked) { //Companay has Corporate Members
                $('#CorpMembers_1').css('visibility', 'hidden');
                $('#CorpMembers_1').css('display', 'none'); 
                $('#CorpMembers_2').css('visibility', 'hidden'); 
                $('#CorpMembers_2').css('display', 'none');
                hasCorpMembers = true;
            } else { //Company does not have Corporate Members
                $('#CorpMembers_1').css('visibility', 'visible');
                $('#CorpMembers_1').css('display', 'block'); 
                $('#CorpMembers_2').css('visibility', 'visible'); 
                $('#CorpMembers_2').css('display', 'block'); 
                hasCorpMembers = false;
            }
            PerformCalcs("WrkK");
        } //chkCorpMembers_onclick()

        //Begin Calculations
        function PrepForMath(numString) {//Removes $ and , from the string and forces the string into a number
            var temp;
            temp = numString;

            return ispRemoveMoney(temp);

        }//PrepForMath

        function splitField(value, start, end) {

            if (value.length != 0) {
                return value.substr(start, end);
            } else {
                return '';
            }
        }	//splitField

        function CalcWrkS(schd) {
            //Added EHD 10/27/2014 - Statutory Income added in 2014
            var s1, s2, s3, s4, s5
            if (IsC1FilledIn()) {
                s1 = PrepForMath($('#lblBPT_SchD_7').text()); 
                if (schd.toUpperCase() == 'A') {
                    s2 = PrepForMath($('#lblBPT_SchA_9').text()); //Current year Income (Loss) 
                } else {
                    s2 = PrepForMath($('#lblBPT_SchB_9').text());
                }
                if (s2 < 0) {
                    s2 = 0;
                } 	//if
                s3 = PrepForMath($('#lblBPT_SchD_6').text());
                if (s3 == 0) {
                    s5 = 0;
                } else {
                    if (s2 < s3) {
                        s4 = (s2 / s3).toFixed(6);
                    } else {
                        s4 = 1.0000
                    } 	//if
                    s5 = s1 * s4;
                } 	//if
            } else {
                s5 = 0
            }		//if

            if (schd.toUpperCase() == 'A') {
                $('#lblBPT_SchA_10').text(ispFormatMoney(s5, 0)); //Satutury Exclution
            } else {
                $('#lblBPT_SchB_10').text(ispFormatMoney(s5, 0));
            }		//if
        } 	//CalcWrkS

        function IsC1FilledIn() {
            var isValid = false
            if (parseFloat($('#lblBPT_SchC1_8C').text()) != 0 || parseFloat($('#lblBPT_SchC1_9C').text()) != 0 || parseFloat($('#lblBPT_SchC1_10C').text()) != 0) {
                isValid = true
            }		//if
            return isValid
        } 	//IsC1FilledIn
        //End Calculations
    </script>
    
</head>

</html>
