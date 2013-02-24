<%@ Assembly Name="BeenJammin.SharePoint.CustomRibbonActions, Version=1.0.0.0, Culture=neutral, PublicKeyToken=e98fc8e60f10d203" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GenericEmbed.aspx.cs" Inherits="BeenJammin.SharePoint.CustomRibbonActions.Layouts.BeenJammin.SharePoint.CustomRibbonActions.Embed" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content id="PageHead" contentplaceholderid="PlaceHolderAdditionalPageHead" runat="server">
        <meta name="robots" content="noindex, nofollow"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<!--<script type="text/javascript">
    if (SP.UI.DialogResult !== undefined) {
        document.write("<script src='/_layouts/SP.UI.Dialog.js' type='text/javascript'></script>");
    }
</script>-->

<script type="text/javascript">
    _spBodyOnLoadFunctionNames.push("loadText");

    var myArgs = window.frameElement.dialogArgs;
    //User has cancelled the operation
    function BtnCancel_Click() {
        SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.cancel, 'Cancel');
    }
    //This functions returns the text that was entered
    function BtnEmbedOk_Click() {
        var target = new Object();
        target.code = document.getElementById('EmbedContent').value;
        var captionText = document.getElementById('EmbedCaption').value;
        if (captionText != "") {
            target.caption = captionText;
        }
        else {
            target.caption = false;
        }
        if (typeof myArgs.index !== "undefined") {
            target.index = myArgs.index;
        }
        target.newEmbed = (typeof myArgs.index === "undefined");
        SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.OK, target);
    }
    function loadText() {
        if (typeof myArgs.code !== "undefined") {
            document.getElementById('EmbedContent').value = unescape(myArgs.code);
        }
        if (typeof myArgs.caption !== "undefined") {
            document.getElementById('EmbedCaption').value = myArgs.caption;
        }
    }
    </script>
    </asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<span>Please paste your embed or other code into this textbox:</span><br />
<textarea id="EmbedContent" rows="15" cols="80"></textarea>
<br />
<br />
<span>If you would like a caption for your embedded content, please enter it into this textbox:</span><br />
<textarea id="EmbedCaption" rows="7" cols="80"></textarea><br />
<input type="button" value="Insert Content" onclick="BtnEmbedOk_Click()" />
<input type="button" value="Cancel" onclick="BtnCancel_Click()" />
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Embed
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Embed
</asp:Content>
