<%@ Assembly Name="BeenJammin.SharePoint.CustomRibbonActions, Version=1.0.0.0, Culture=neutral, PublicKeyToken=e98fc8e60f10d203" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YoutubeEmbedVideo.aspx.cs" Inherits="BeenJammin.SharePoint.CustomRibbonActions.Layouts.BeenJammin.SharePoint.CustomRibbonActions.YoutubeEmbedVideo" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
<script type="text/javascript">

    // This function runs after the window on load event.
    _spBodyOnLoadFunctionNames.push("loadText");

    //User has cancelled the operation
    function BtnLinkCancel_Click() {
        SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.cancel, 'Cancel');
    }

    //This functions returns the link name and link href
    function BtnLinkCreateOk_Click() {

        var linkHref = document.getElementById('linkHref').value
        var caption = document.getElementById('caption').value

        //make sure an href was entered
        if (isBlank(linkHref)) {
            alert("An address is a required Field");
            return false;
        }


        //The name is split out because it will be referred to individually in the calling javascript
        //which is in RibbonActions.js
        var linkString = linkHref + "|" + caption
        SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.OK, linkString);
    }

    //This function loads the initial text
    function loadText() {
        document.getElementById('linkHref').value = window.frameElement.dialogArgs;
        //document.getElementById('linkHref').value = "http://";
    }

    //This function checks for the presence of a value.
    function isBlank(str) { return (!str || /^\s*$/.test(str)); } 

</script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<span>Video Url</span><br />
<input id="linkHref" type="text" style="WIDTH:100%" /><br />
<span>Caption</span><br />
<input id="caption" type="text" style="width:100%" /><br />
<input type="button" value="OK" onclick="BtnLinkCreateOk_Click()" />
<input type="button" value="Cancel" onclick="BtnLinkCancel_Click()" />
</asp:Content>




<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Youtube Embed Video
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Youtube Embed Video
</asp:Content>
