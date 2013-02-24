<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnchorLinkDialog.aspx.cs" Inherits="BeenJammin.SharePoint.CustomRibbonActions.Layouts.BeenJammin.SharePoint.CustomRibbonActions.AnchorLinkDialog" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
        <meta name="robots" content="noindex, nofollow"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>



        <script type="text/javascript">

            //This function runs after the window onload event.
            _spBodyOnLoadFunctionNames.push("loadAnchors");


            //User has cancelled the operation
            function BtnAnchorCancel_Click() {
                SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.cancel, 'Cancel');
            }



            //This functions returns the anchor name that was entered
            function BtnAnchorCreateOk_Click() {
                var anchorName = document.getElementById('anchorList').options[document.getElementById('anchorList').selectedIndex].value
                var anchorlinkName = document.getElementById('anchorlinkName').value


                //if no name has been supplied then use the href as the name
                if (isBlank(anchorlinkName)) {
                    anchorlinkName = anchorName
                }


                var anchorlinkString = anchorName + "|" + anchorlinkName
                SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.OK, anchorlinkString);
            }

            //This function loads the initial text that was passed into the window.
            function loadText() {
                document.getElementById('anchorlinkName').value = window.frameElement.dialogArgs.selectedText;
            }

            //This function checks for the presence of a value.
            function isBlank(str) { return (!str || /^\s*$/.test(str)); }

            // This function loads the anchor names that were passed into this window.
            function loadAnchors() {
                loadText();
                var anchorArgs = window.frameElement.dialogArgs.anchorList;
                var anchorArray = anchorArgs.split(",");

                if (anchorArray.toString() > "") {

                    for (var loop = 0; loop < anchorArray.length; loop++) {
                        var tempOpt = new Option(anchorArray[loop], anchorArray[loop]);
                        document.getElementById('anchorList').options.add(tempOpt);
                    }
                }
                //no anchors were passed so we will just close the window and tell the user.
                else {
                    alert("No anchors are defined for the selected field");
                }


            }
        
	</script>

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
<span>Text to Display</span><br />
 <input id="anchorlinkName" name="anchorlinkName" type="text" style="WIDTH:100%"/><br />
<select name='anchorList' id='anchorList'></select>
<input type="button" value="OK" onclick="BtnAnchorCreateOk_Click()" />
<input type="button" value="Cancel" onclick="BtnAnchorCancel_Click()" />

</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Application Page
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
My Application Page
</asp:Content>
