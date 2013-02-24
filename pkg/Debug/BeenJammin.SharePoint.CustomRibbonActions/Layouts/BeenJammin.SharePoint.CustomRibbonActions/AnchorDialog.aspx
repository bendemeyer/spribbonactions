<%@ Assembly Name="BeenJammin.SharePoint.CustomRibbonActions, Version=1.0.0.0, Culture=neutral, PublicKeyToken=e98fc8e60f10d203" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnchorDialog.aspx.cs" Inherits="BeenJammin.SharePoint.CustomRibbonActions.Layouts.BeenJammin.SharePoint.CustomRibbonActions.AnchorDialog" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
<script type="text/javascript">

    //This function fires after the window onload event.
    _spBodyOnLoadFunctionNames.push("loadText");

    //User has cancelled the operation
    function BtnAnchorCancel_Click() {
        SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.cancel, 'Cancel');
    }

    //This functions returns the anchor name that was entered
    function BtnAnchorCreateOk_Click() {
        var anchorName = document.getElementById('anchorText').value
        SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.OK, anchorName);
    }

    //This function loads the initial text that was passed into the window.
    function loadText() {
        document.getElementById('anchorText').value = window.frameElement.dialogArgs;
    }

</script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<span>Anchor Title:</span><br />
<input id="anchorText" type="text" style="WIDTH:100%"/><br />
<input type="button" value="OK" onclick="BtnAnchorCreateOk_Click()" />
<input type="button" value="Cancel" onclick="BtnAnchorCancel_Click()" />
</asp:Content>




<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Anchor Name
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Anchor Name
</asp:Content>
