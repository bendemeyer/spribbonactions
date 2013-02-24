<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PPT.aspx.cs" Inherits="BeenJammin.SharePoint.CustomRibbonActions.Layouts.BeenJammin.SharePoint.CustomRibbonActions.PPT" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content id="PageHead" contentplaceholderid="PlaceHolderAdditionalPageHead" runat="server">
        <meta name="robots" content="noindex, nofollow"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<script type="text/javascript">
    //User has cancelled the operation
    function BtnCancel_Click() {
        SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.cancel, 'Cancel');
    }
    //This functions returns the text that was entered
    function BtnPPTOk_Click() {
        var PPT = document.getElementById('PstPlnText').value

        //PPT = "<p>" + PPT + "</p>";
        //PPT = PPT.replace(/[\r\n][\r\n]/g, "</p><p>");
        //PPT = PPT.replace("<br/><br/>", "</p><p>");
        //PPT = PPT.replace(/[\r\n]/g, "<br />");

        SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.OK, PPT);

    } 
    </script>
    </asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<span>Please paste inside the following box using the keyboard(<strong>Ctrl+V</strong>) and hit <strong>Convert to plain text.</strong></span><br />

<!--<input id="PstPlnText" type="text" style="WIDTH:100%"/>-->
<textarea id="PstPlnText" rows="20" cols="60"></textarea>
<br />

<input type="button" value="Convert to plain text" onclick="BtnPPTOk_Click()" />
<input type="button" value="Cancel" onclick="BtnCancel_Click()" />
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Convert Plain Text  
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
Convert Plain Text
</asp:Content>