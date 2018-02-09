<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<CopRevenueGov2.Models.SessionMutiuserTestModel>" %>

<!DOCTYPE html>

<html>
<head>
    <title>
        headSessionMutiUserTest
    </title>
</head>
<body>
    <div>
        <p>
            User ID :  <%= COPSession.UserID %>
            
        </p>

        <%
            using (Html.BeginForm("Submit", "Test", FormMethod.Post))
            {    
        %>

        <p>
            Your Value : <%  Html.EditorFor(mdl => mdl.txt_user_id, new { type = "text" }); %>
            Sample : <% Html.Editor("txt_abcd"); %>
            <input type="text" name="txt_user_id" id="txt_user_id" />
        </p>

        <p>
            <input type="submit" value="Press me oh yeah" />
        </p>
                    
        <% } %>


        <p> FILE CREATE TEST ... </p>

        <%
        using (Html.BeginForm("File", "Test", FormMethod.Post))
        {    
        %>
            <p>
                <input type="submit" value="Press me to create DEBUG FILES" />
            </p>                    
        <% 
        } 
        %>
            
    </div>
</body>
</html>
