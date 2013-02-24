<%@ Assembly Name="BeenJammin.SharePoint.CustomRibbonActions, Version=1.0.0.0, Culture=neutral, PublicKeyToken=e98fc8e60f10d203" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmailLinkDialog.aspx.cs" Inherits="BeenJammin.SharePoint.CustomRibbonActions.Layouts.BeenJammin.SharePoint.CustomRibbonActions.EmailLinkDialog" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
<script type="text/javascript">

    // This function runs after the window on load event.
    _spBodyOnLoadFunctionNames.push("loadText");

    //User has cancelled the operation
    function BtnEmailCancel_Click() {
        SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.cancel, 'Cancel');
    }

    //This functions returns the email, subject and body for the email
    function BtnEmailCreateOk_Click() {
        var emailAddress = document.getElementById('emailAddress').value
        var emailText = document.getElementById('emailText').value

        //make sure an email address was entered
        if (isBlank(emailAddress)) {
            alert("An email address is a required Field");
            return false;
        }

        //If the text field is blank then just use the email address as the text
        if (isBlank(emailText)) {
            emailText = emailAddress;
        }

        //The emailText is split out because it will be referred to individually in the calling javascript
        //which is in RibbonActions.js
        var emailString = emailText + "|" + "mailto:" + emailAddress
        SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.OK, emailString);
    }

    //This function loads the initial text
    function loadText() {
        document.getElementById('emailText').value = window.frameElement.dialogArgs;
    }


    // This function checks to make sure a value has been entered.
    function isBlank(str) { return (!str || /^\s*$/.test(str)); } 

</script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<span>Text to Display</span><br />
<input id="emailText" type="text" style="WIDTH:100%" /><br />
<span> Email Address</span><br />
<input id="emailAddress" type="text" style="WIDTH:100%"/><br />
<input type="button" value="OK" onclick="BtnEmailCreateOk_Click()" />
<input type="button" value="Cancel" onclick="BtnEmailCancel_Click()" />
</asp:Content>




<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Anchor Name
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Anchor Name
</asp:Content>
