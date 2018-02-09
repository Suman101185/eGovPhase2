<%@ Page Language="C#" AutoEventWireup="true" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head>
    <title></title>
     <script id="clientEventHandlersJS" language="javascript" type="text/javascript">
         function Captcha() {
             //document.getElementById('txtInput').focus();
             var alpha = new Array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z');

             var i, j;

             for (i = 0; i < 6; i++) {
                 var a = alpha[Math.floor(Math.random() * alpha.length)];
                 var b = alpha[Math.floor(Math.random() * alpha.length)];
                 var c = alpha[Math.floor(Math.random() * alpha.length)];
                 var d = alpha[Math.floor(Math.random() * alpha.length)];
                 var e = alpha[Math.floor(Math.random() * alpha.length)];
                 var f = alpha[Math.floor(Math.random() * alpha.length)];
                 var g = alpha[Math.floor(Math.random() * alpha.length)];
             }
             var code = a + ' ' + b + ' ' + ' ' + c + ' ' + d + ' ' + e + ' ' + f + ' ' + g;
             document.getElementById("mainCaptcha").value = code;
             //document.getElementById("mainCaptcha_1099").value = code;


         }



         function ValidCaptcha() {
             var string1 = removeSpaces(document.getElementById('mainCaptcha').value);
             var string2 = removeSpaces(document.getElementById('txtInput').value);
             if (string1 == string2) {
                 $("#myModal_W2").css("display", "block");
                 $("#divCaptha_W2").css("display", "none");
                 
             }
             else {
                 alert('Invalid Captcha!');
                 return false;
             }
         }
         function removeSpaces(string) {
             return string.split(' ').join('');
         }
         function ClickHelp(sLink) {
             window.open(sLink)
         }
         </script>
</head>
<body >
    <div class="modal" id="divCaptha_W2">
       
   <div class="modal-dialog" style="margin-top:0px; width: 100%; height:100%;">
      <div class="modal-content" style="height:535px;">
        <div class="modal-header" style="background:#1B3C69; height:50px; border-radius:7px 7px 0 0;">
             <p style="float:left; font-size:18px; color:#B1F1FF;">W2 file upload</p>
          <button type="button" class="close" onclick="CloseModal()" style="color:#fff; opacity:1; font-size:15px; margin-top:2px;"><span style="color:#fff;">Close X</span></button>
    </div>
          <div class="modal-body" style="border: 1px solid #1B3C69; margin: 50px auto 0;  padding: 36px 36px 60px; width: 90%; text-align:center;">
              <a style="text-align:center; color: #16396A; font: bold 17px/25px Verdana;cursor:pointer" onclick="ClickHelp('https://beta.phila.gov/documents/2016-w-2-submission-instructions/')">Click for  W2 Instructions</a>
        <table style="height:200px;width:200px; margin:40px auto 0;">
            <tr>
                             <td width="25%"></td>
                            <td width="50%">
                                 <input type="text" readonly="true" id="mainCaptcha" style="font-weight:bold;font-size:20px;color:red;border:1px solid #808080; text-align:center; padding:10px 0; margin-top:10px;" />
                                
                            </td>
                             <td colspan="2" width="25%">

                                  <input class="submit_button" type="button" id="refresh_w2" value="Refresh" onclick="Captcha();" />
                             </td>
                        </tr>

                        <tr>
                            <td width="5%"></td>
           <td width="70%">
            <input type="text" id="txtInput" style="border: 1px solid #808080; padding: 12px 0; width: 100%; border-radius:4px;" placeholder="Please enter the captcha"/>    
          </td>
            <td colspan="2" width="25%"></td>
         </tr>
         <tr>
              
          <td width="70%" colspan="4" style="text-align:center;">
            <input id="Button1_W2" class="submit_button" type="button" value="Submit" style="height:40px;" onclick="ValidCaptcha();"/>
          </td>
            
        </tr>
        </table>
    
    </div>
          </div>
            
            </div>
          <div class="clearfix"></div>
        </div>

    <div class="modal" id="myModal_W2">
	<div class="modal-dialog" style="margin-top:0px; width:100%;">
      <div class="modal-content">
       <div class="modal-header" style="background:#1B3C69; height:50px; border-radius:7px 7px 0 0;">
           <p style="float:left; font-size:18px; color:#B1F1FF;">W2 file upload</p>
          <button type="button" class="close" style="color:#fff; opacity:1; font-size:15px; margin-top:2px;" onclick="CloseModal_W2()">Close X</button> 
           </div>
          <div class="modal-body" style="border: 1px solid #1B3C69; margin: 50px auto 50px;  padding: 36px 36px 40px; width: 90%; text-align:center;">  
             <%--tanu-%>

        </div>
        <div class="modal-body">
          <div class="col-md-12 login-section">
          <h4>Captcha</h4>
              <%--<img src="../Content/images/captcha-img.png" alt="modal-img" />--%>
              
             <%-- ================================Modal for W2 start=========================================--%>
              <% Html.RenderAction("UploadFile", "Login"); %>
             <%-- ============================Modal for W2 end=============================================--%>
              </div>
          </div>
            <div class="clearfix"></div>
            </div>
          </div>
      
            
    
</body>
</html>
