<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
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


        function ShowPage1(iPage, iWrk) {
            $('#AppMessage').css('visibility', 'hidden');
            $('#InstructionText').css('visibility', 'hidden');

            $('#NPT').css('visibility', "visible");
            $('#NPT').css('display', "block");

            $('#NPT_Page1').css('visibility', "hidden");
            $('#NPT_Page1').css('display', "none");
            $('#NPT_WrkA').css('visibility', "hidden");
            $('#NPT_WrkA').css('display', "none");
            $('#NPT_WrkB').css('visibility', "hidden");
            $('#NPT_WrkB').css('display', "none");
            $('#NPT_WrkC').css('visibility', "hidden");
            $('#NPT_WrkC').css('display', "none");
            $('#NPT_WrkD').css('visibility', "hidden");
            $('#NPT_WrkD').css('display', "none");
            $('#NPT_WrkE').css('visibility', "hidden");
            $('#NPT_WrkE').css('display', "none");
            $('#NPT_WrkK').css('visibility', "hidden");
            $('#NPT_WrkK').css('display', "none");
            $('#NPT_Page4').css('visibility', "hidden");
            $('#NPT_Page4').css('display', "none");

            switch (iPage) {
                case "Page1":


                    $('#AppMessage').css('visibility', "visible");
                    $('#InstructionText').css('visibility', "visible");

                    $('#NPT_Page1').css('visibility', "visible");
                    $('#NPT_Page1').css('display', "block");

                    $(btnNPTSubmit).removeAttr('disabled');
                    FieldLock(false);

                    switch (iWrk) {
                        case "WrkA":
                            $('#txtNPT1').focus();
                            break;
                        case "WrkB":
                            $('#txtNPT3').focus();
                            break;
                        case "WrkC":
                            $('#txtNPT11').focus();
                            break;
                        case "WrkD":
                            $('#txtPercentage').focus();
                            break;
                        case "WrkE":
                            $('#txtNPT6b').focus();
                            break;
                        case "WrkK":
                            $('#txtNPT6b').focus();
                            break;
                    } //switch
                    //DisplayNetIncome()
                    break;

                case "WrkA":


                    $('#NPT_WrkA').css('visibility', "visible");
                    $('#NPT_WrkA').css('display', "block");

                    $('#btnNPTSubmit').attr('disabled', 'disable');
                    break;

                case "WrkB":


                    $('#NPT_WrkB').css('visibility', "visible");
                    $('#NPT_WrkB').css('display', "block");

                    $('#btnNPTSubmit').attr('disabled', 'disable');
                    break;

                case "WrkC":


                    $('#NPT_WrkC').css('visibility', "visible");
                    $('#NPT_WrkC').css('display', "block");

                    $('#btnNPTSubmit').attr('disabled', 'disable');
                    break

                case "WrkD":
                    
                    $('#NPT_WrkD').css('visibility', "visible");
                    $('#NPT_WrkD').css('display', "block");

                    $('#btnNPTSubmit').attr('disabled', 'disable');
                    break

                case "WrkE":

                    $('#NPT_WrkE').css('visibility', "visible");
                    $('#NPT_WrkE').css('display', "block");

                    $('#btnNPTSubmit').attr('disabled', 'disable');
                    break

                case "WrkK":


                    $('#NPT_WrkK').css('visibility', "visible");
                    $('#NPT_WrkK').css('display', "block");

                    $('#btnNPTSubmit').attr('disabled', 'disable');
                    break

                case "Page4":


                    $('#NPT_Page4').css('visibility', "visible");
                    $('#NPT_Page4').css('display', "block");

                    $('#btnNPTSubmit').attr('disabled', 'disable');
                    break
            } //switch
            $(parent.AppError).text('');
            PerformCalcs(iPage);

            LoadError(iPage);
            ValidateWorksheet(iPage);
        } //ShowPage

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


        function PrepForMath(numString) { //Removes $ and , from the string and forces the string into a number
            var temp;
            temp = numString;

            return ispRemoveMoney(temp);

        } //PrepForMath

        function splitField(value, start, end) {

            if (value.length != 0) {
                return value.substr(start, end);
            } else {
                return '';
            }
        } //splitField
        //End Calculations
    </script>