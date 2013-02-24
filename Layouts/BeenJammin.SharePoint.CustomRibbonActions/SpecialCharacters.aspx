<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SpecialCharacters.aspx.cs" Inherits="BeenJammin.SharePoint.CustomRibbonActions.Layouts.BeenJammin.SharePoint.CustomRibbonActions.SpecialCharacters" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
        <meta name="robots" content="noindex, nofollow"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<style type="text/css">
				.Hand
				{
					cursor: pointer ;
					cursor: hand ;
				}
				.Sample { font-size: 24px; }
				.Grid { font-size: 14px; }
		</style>

    	<script type="text/javascript">

		    var oSample;
            
		    //This is fired when the mouse is over a special character
            function over(td) {
                // Initializes the display field.
		        oSample = document.getElementById("SampleTD");
		        
                if (!oSample)
		            return;
		        oSample.innerHTML = td.innerHTML;
		        td.className = 'LightBackground SpecialCharsOver Hand Grid';
		    }

            //This is fired when the mouse moves out of a special character
		    function out(td) {
		        if (!oSample)
		            return;
		        oSample.innerHTML = "&nbsp;";
		        td.className = 'DarkBackground SpecialCharsOut Hand Grid';
		    }

		    //This function returns the special character that was clicked by the user
            function SelectSpecial_Click() { 
                var form = document.forms.<%SPHttpUtility.NoEncode(Form.ClientID,Response.Output);%>; 
                SP.UI.ModalDialog.commonModalDialogClose(SP.UI.DialogResult.OK, oSample.innerHTML); 
            } 

		</script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">

<body onload="setDefaults()" style="overflow: hidden">
		<table cellpadding="0" cellspacing="0" width="100%" height="100%">
			<tr>
				<td width="100%">
					<table cellpadding="1" cellspacing="1" align="center" border="0" width="100%" height="100%">
						<script type="text/javascript">
						    var aChars = ["!", "&quot;", "#", "$", "%", "&amp;", "\\'", "(", ")", "*", "+", "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ";", "&lt;", "=", "&gt;", "?", "@", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "]", "^", "_", "`", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "{", "|", "}", "~", "&euro;", "&lsquo;", "&rsquo;", "&rsquo;", "&ldquo;", "&rdquo;", "&ndash;", "&mdash;", "&iexcl;", "&cent;", "&pound;", "&curren;", "&yen;", "&brvbar;", "&sect;", "&uml;", "&copy;", "&ordf;", "&laquo;", "&not;", "&reg;", "&macr;", "&deg;", "&plusmn;", "&sup2;", "&sup3;", "&acute;", "&micro;", "&para;", "&middot;", "&cedil;", "&sup1;", "&ordm;", "&raquo;", "&frac14;", "&frac12;", "&frac34;", "&iquest;", "&Agrave;", "&Aacute;", "&Acirc;", "&Atilde;", "&Auml;", "&Aring;", "&AElig;", "&Ccedil;", "&Egrave;", "&Eacute;", "&Ecirc;", "&Euml;", "&Igrave;", "&Iacute;", "&Icirc;", "&Iuml;", "&ETH;", "&Ntilde;", "&Ograve;", "&Oacute;", "&Ocirc;", "&Otilde;", "&Ouml;", "&times;", "&Oslash;", "&Ugrave;", "&Uacute;", "&Ucirc;", "&Uuml;", "&Yacute;", "&THORN;", "&szlig;", "&agrave;", "&aacute;", "&acirc;", "&atilde;", "&auml;", "&aring;", "&aelig;", "&ccedil;", "&egrave;", "&eacute;", "&ecirc;", "&euml;", "&igrave;", "&iacute;", "&icirc;", "&iuml;", "&eth;", "&ntilde;", "&ograve;", "&oacute;", "&ocirc;", "&otilde;", "&ouml;", "&divide;", "&oslash;", "&ugrave;", "&uacute;", "&ucirc;", "&uuml;", "&uuml;", "&yacute;", "&thorn;", "&yuml;", "&OElig;", "&oelig;", "&#372;", "&#374", "&#373", "&#375;", "&sbquo;", "&#8219;", "&bdquo;", "&hellip;", "&trade;", "&#9658;", "&bull;", "&rarr;", "&rArr;", "&hArr;", "&diams;", "&asymp;", "&#286;", "&#287;"];

						    var cols = 20;

						    var i = 0;
						    while (i < aChars.length) {
						        document.write("<TR>");
						        for (var j = 0; j < cols; j++) {
						            if (aChars[i]) {
						                document.write('<TD width="1%" class="DarkBackground SpecialCharsOut Hand Grid" align="center" onclick="SelectSpecial_Click(\'' + aChars[i].replace(/&/g, "&amp;") + '\')" onmouseover="over(this)" onmouseout="out(this)">');
						                document.write(aChars[i]);
						            }
						            else
						                document.write("<TD class='DarkBackground SpecialCharsOut'>&nbsp;");
						            document.write("<\/TD>");
						            i++;
						        }
						        document.write("<\/TR>");
						    }
						</script>
					</table>
				</td>
				<td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td valign="top">
					<table width="40" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td id="SampleTD" width="40" height="40" align="center" class="DarkBackground SpecialCharsOut Sample">&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Application Page
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
My Application Page
</asp:Content>