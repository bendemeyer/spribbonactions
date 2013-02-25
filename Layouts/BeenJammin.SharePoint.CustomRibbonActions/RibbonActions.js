window.jqueryNoConflict = false;

function getTop(dlgHeight) {
    var windowHeight;
    if (!window.innerWidth) {
        if (!(document.documentElement.clientWidth == 0)) {
            windowHeight = document.documentElement.clientHeight;
        }
        else {
            windowHeight = document.body.clientHeight;
        }
    }
    else {
        windowHeight = window.innerHeight;
    }
    return (Math.floor(windowHeight / 2)) - (Math.floor(dlgHeight / 2));
}

//This function opens up the Anchor name dialog window
function InsertAnchor() {
    anchorSelectedText = getSelectedText();
    anchorSelectedText = anchorSelectedText.toString();
    var options = SP.UI.$create_DialogOptions();
    options.args = getSelectedText();
    options.title = "Please enter the anchor name";
    options.width = 400;
    options.height = 200;
    options.y = getTop(200);
    options.url = "/_layouts/BeenJammin.SharePoint.CustomRibbonActions/AnchorDialog.aspx";
    options.dialogReturnValueCallback = Function.createDelegate(null, AnchorCloseCallback);
    SP.UI.ModalDialog.showModalDialog(options);

}

//This function inserts the anchor tag into the current RTE field.
function AnchorCloseCallback(result, target) {
    if (result === SP.UI.DialogResult.OK) {
        var range = RTE.Cursor.get_range();
        range.deleteContent();
        var selection = range.parentElement();
        var anchor = selection.ownerDocument.createElement("ins");
        //anchor.innerHTML = "<img src=/_layouts/images/wab16.gif alt='image' /> " + target +" ";
        anchor.innerHTML = "<img src=/_layouts/images/wab16.gif alt='image' class='anchorImage' />" + anchorSelectedText;
        //anchor.innerHTML = target;
        //anchor.name = target;
        //anchor.id = target.replace(/\W/g, "") || target;
        anchor.id = target;
        anchor.className = "pageAnchor";
        anchor.style.textDecoration = "none";
        range.insertNode(anchor);
        RTE.Cursor.get_range().moveToNode(anchor);
        RTE.Cursor.update()

    }
}


//This function gets a listing of all the anchor tags that are in the current RTE field.
function InsertAnchorLink() {
    var selectedField = RTE.Canvas.currentEditableRegion();
    var anchorTags = selectedField.getElementsByTagName("ins");
    var anchorList = "";
    //This loop creates an Array that we pass into the dialog window
    for (i = 0; i < anchorTags.length; i++) {
        if (anchorTags[i].id && (anchorTags[i].id.length > 0))
            anchorList = anchorList + anchorTags[i].id + ",";
    }
    anchorList = anchorList.substring(0, anchorList.length - 2);
    var options = SP.UI.$create_DialogOptions();
    var selectedText = getSelectedText();

    options.title = "Please select an anchor";
    options.width = 400;
    options.height = 200;
    options.y = getTop(200);

    options.args =
    {
        selectedText: selectedText,
        anchorList: anchorList
    };
    options.url = "/_layouts/BeenJammin.SharePoint.CustomRibbonActions/AnchorLinkDialog.aspx";
    options.dialogReturnValueCallback = Function.createDelegate(null, AnchorLinkCloseCallback);
    SP.UI.ModalDialog.showModalDialog(options);

}

//This functions gets the anchor link name returned and formats an href to the selected anchor.
function AnchorLinkCloseCallback(result, target) {
    if (result === SP.UI.DialogResult.OK) {

        var anchorlinkArray = target.split("|");

        if (anchorlinkArray.toString() > "") {
            var anchorlinkHref = anchorlinkArray[0];
            var anchorlinkName = anchorlinkArray[1];
        }

        var range = RTE.Cursor.get_range();
        range.deleteContent();
        var selection = range.parentElement();
        if (!selection) {
            return;
        }

        var anchor = selection.ownerDocument.createElement("a");
        anchor.className = "anchorlink";
        anchor.href = "#" + anchorlinkHref;
        var anchorText = selection.ownerDocument.createTextNode(anchorlinkName);
        anchor.appendChild(anchorText);
        range.insertNode(anchor);
        RTE.Cursor.get_range().moveToNode(anchor);
        RTE.Cursor.update();

    }
}

//This function opens up the email name dialog window
function InsertEmailLink() {
    var options = SP.UI.$create_DialogOptions();
    options.args = getSelectedText();
    options.title = "Please enter the email information";
    options.width = 400;
    options.height = 200;
    options.y = getTop(200);
    options.url = "/_layouts/BeenJammin.SharePoint.CustomRibbonActions/EmailLinkDialog.aspx";
    options.dialogReturnValueCallback = Function.createDelegate(null, EmailLinkCloseCallback);
    SP.UI.ModalDialog.showModalDialog(options);

}

//This function inserts the email tag into the current RTE field.
function EmailLinkCloseCallback(result, target) {
    if (result === SP.UI.DialogResult.OK) {
        //There are two arguements passed in
        // 1 - the email address
        // 2 - the href for doing the email
        var emailArray = target.split("|");

        if (emailArray.toString() > "") {
            var emailAddress = emailArray[0];
            var emailHref = emailArray[1];
        }
        var range = RTE.Cursor.get_range();
        range.deleteContent();
        var selection = range.parentElement();
        if (!selection) {
            return;
        }
        var email = selection.ownerDocument.createElement("a");
        email.href = emailHref;
        var emailText = selection.ownerDocument.createTextNode(emailAddress);
        email.appendChild(emailText);
        range.insertNode(email);
        RTE.Cursor.get_range().moveToNode(email);
        RTE.Cursor.update();

    }
}

//This function inserts a line element into the current RTE
function InsertLine() {
    var range = RTE.Cursor.get_range();
    range.deleteContent();
    var selection = range.parentElement();
    if (!selection) {
        return;
    }
    var line = selection.ownerDocument.createElement('hr');
    range.insertNode(line);
    RTE.Cursor.get_range().moveToNode(line);
    RTE.Cursor.update();
}

//This function opens up the special characters dialog
function InsertSpecialCharacter() {
    var options = SP.UI.$create_DialogOptions();
    options.title = "Please select the special character";
    options.width = 500;
    options.height = 300;
    options.y = getTop(300);
    options.url = "/_layouts/BeenJammin.SharePoint.CustomRibbonActions/SpecialCharacters.aspx";
    options.dialogReturnValueCallback = Function.createDelegate(null, SpecialCharacterCloseCallback);
    SP.UI.ModalDialog.showModalDialog(options);

}

//This function inserts the returned special character into the current RTE.
function SpecialCharacterCloseCallback(result, target) {
    if (result === SP.UI.DialogResult.OK) {
        var range = RTE.Cursor.get_range();
        var selection = range.parentElement();
        var textblock = selection.ownerDocument.createTextNode(target);
        range.insertNode(textblock);
        RTE.Cursor.get_range().moveToNode(textblock);
        RTE.Cursor.update();
    }
}

//this function is used for youtube emded
function InsertVideo() {
    var options = SP.UI.$create_DialogOptions();
    options.title = "Enter Video Url and Caption.";
    options.width = 400;
    options.height = 200;
    options.y = getTop(200);
    options.args = getSelectedText();
    options.url = "/_layouts/BeenJammin.SharePoint.CustomRibbonActions/YoutubeEmbedVideo.aspx";
    options.dialogReturnValueCallback = Function.createDelegate(null, VideoCloseCallback);
    SP.UI.ModalDialog.showModalDialog(options);
}

function VideoCloseCallback(result, target) {
    if (result === SP.UI.DialogResult.OK) {

        var linkArray = target.split("|");
        if (linkArray.toString() > "") {
            var linkHref = linkArray[0];
            var caption = linkArray[1];
        }
        var range = RTE.Cursor.get_range();
        range.deleteContent();
        var selection = range.parentElement();
        if (!selection) {
            return;
        }
        //document.write("<script language='javascript' src='/js/youTubeEmbed.js'></script>");
        var fullContainer = selection.ownerDocument.createElement("div");
        fullContainer.className = "youtubeVideoContainer"
        var videodiv = selection.ownerDocument.createElement("div");
        videodiv.className = "youtubeVideoLink";
        var captiondiv = selection.ownerDocument.createElement("div");
        captiondiv.className = "youtubeVideoCaption";
        var captiontext = selection.ownerDocument.createTextNode(caption);
        var textblock = selection.ownerDocument.createTextNode(linkHref);
        captiondiv.appendChild(captiontext);
        videodiv.appendChild(textblock);
        //videodiv.appendChild(captionspan);
        range.insertNode(fullContainer);
        fullContainer.appendChild(videodiv)

        if (caption && caption.length)
            fullContainer.appendChild(captiondiv);

        RTE.Cursor.get_range().moveToNode(videodiv);
        RTE.Cursor.update();
    }
}

//Paste Plain Text
//This function gets the html in the current RTE field.
function PPT() {

    // The RTE.Canvas functions are javascript functions that come with SharePoint.
    // These functions can be found in C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\14\TEMPLATE\LAYOUTS\SP.UI.RTE.Publishing.debug.js & SP.UI.RTE.debug
    //var storageFieldId = RTE.Canvas.currentEditableRegion();
    // var rteFieldText = RTE.Canvas.getEditableRegionHtml(storageFieldId, true);
    var options = SP.UI.$create_DialogOptions();
    options.title = "Paste Plain Text";
    options.width = 700;
    options.height = 550;
    options.y = getTop(550);
    //options.args = rteFieldText;
    options.url = "/_layouts/BeenJammin.SharePoint.CustomRibbonActions/PPT.aspx";
    options.dialogReturnValueCallback = Function.createDelegate(null, PPTCloseCallback);
    SP.UI.ModalDialog.showModalDialog(options);
}

//This inserts the returned html into the current RTE field.
function PPTCloseCallback(result, target) {
    if (result === SP.UI.DialogResult.OK) {
        var range = RTE.Cursor.get_range();
        range.deleteContent();
        var selection = range.parentElement();
        if (!selection) {
            return;
        }

        //Here we take the returned value from the dialog and replace any instance of 2 consecutive line breaks with a unique comination of characters
        var PPT = target.replace(/[\r\n][\r\n]/g, "|/@/|");
        PPT = PPT.replace(/[\r\n]/g, "<br />");

        //Here we split returned value at the points where the unique comination of characters we inserted above appear
        //This creates an array in which every element is the content of a paragraph
        var paragraphsContent = PPT.split('|/@/|');
        var totalParagraphs = paragraphsContent.length - 1;

        //Here we create the array that will hold the DOM paragraph nodes
        //We then fill those nodes with the content from the array above
        var paragraphNode = new Array();
        paragraphNode[totalParagraphs] = selection.ownerDocument.createElement("p");
        paragraphNode[totalParagraphs].innerHTML = paragraphsContent[totalParagraphs];

        //Insert the last paragraph from the array into the RTE
        range.insertNode(paragraphNode[totalParagraphs]);

        //This loop starts with the last remaining item in our array, and inserts it ahead of the element that was just inserted
        //It will do this until all array elements have been added, starting from the end and working backward
        var remainingParagraphs = totalParagraphs - 1;
        for (i = remainingParagraphs; i >= 0; i--) {
            paragraphNode[i] = selection.ownerDocument.createElement("p");
            paragraphNode[i].innerHTML = paragraphsContent[i];
            paragraphNode[i + 1].parentNode.insertBefore(paragraphNode[i], paragraphNode[i + 1]);

            //This line is for IE.
            //For some reason, IE thinks it's necessary to add an empty P element after all of the elements we insert
            //This tests if the element we just inserted is immediately followed by an empty P element
            //If it is, that empty element will be removed.
            if ((paragraphNode[i].nextSibling.innerHTML == '&#160;') || (paragraphNode[i].nextSibling.innerHTML == '&nbsp;') || (paragraphNode[i].nextSibling.innerHTML == '')) {
                paragraphNode[i].parentNode.removeChild(paragraphNode[i].nextSibling);
            }
        }

        RTE.Cursor.get_range().moveToNode(paragraphNode[totalParagraphs]);
        RTE.Cursor.update();
    }
}

//This function gets the selected text and passes it to the audio link window.
function InsertAudio() {

    var options = SP.UI.$create_DialogOptions();
    options.title = "Please input a text and address";
    options.width = 400;
    options.height = 200;
    options.y = getTop(200);
    options.args = getSelectedText();
    options.url = "/_layouts/BeenJammin.SharePoint.CustomRibbonActions/EmbededAudio.aspx";
    options.dialogReturnValueCallback = Function.createDelegate(null, LinkCloseCallback);
    SP.UI.ModalDialog.showModalDialog(options);

}

//This functions gets the audio link information and passes it into the RTE
function LinkCloseCallback(result, target) {
    if (result === SP.UI.DialogResult.OK) {
        //There are two arguements passed in
        // 1 - the name of the link
        // 2 - the link
        var linkArray = target.split("|@|");

        if (linkArray.toString() > "") {
            var linkName = linkArray[0];
            var linkHref = linkArray[1];
            var linkArtist = linkArray[2];
        }

        var range = RTE.Cursor.get_range();
        range.deleteContent();
        var selection = range.parentElement();
        if (!selection) {
            return;
        }

        var audioParagraph = selection.ownerDocument.createElement("p");

        var link = selection.ownerDocument.createElement("a");
        link.className = "audioLink";
        link.target = "_blank";
        link.href = linkHref;
        if (linkArtist && linkArtist != '') {
            link.title = linkArtist;
        }

        var linkText = selection.ownerDocument.createTextNode(linkName);
        link.appendChild(linkText);
        audioParagraph.appendChild(link);

        range.insertNode(audioParagraph);
        RTE.Cursor.get_range().moveToNode(audioParagraph);
        RTE.Cursor.update();
    }
}

// This function opens a dialog box to insert embedable content
function InsertEmbedContent(code, caption, index) {
    var myArgs = { "code": code, "caption": caption, "index": index };
    var options = SP.UI.$create_DialogOptions();
    options.args = myArgs;
    options.title = "Embed";
    options.width = 700;
    options.height = 480;
    options.y = getTop(600);
    options.url = "/_layouts/BeenJammin.SharePoint.CustomRibbonActions/GenericEmbed.aspx";
    options.dialogReturnValueCallback = Function.createDelegate(null, EmbedCloseCallback);
    SP.UI.ModalDialog.showModalDialog(options);
}

function EmbedCloseCallback(result, target) {
    if (result === SP.UI.DialogResult.OK) {
        var escapedEmbed = escape(target.code);
        var embedCaption = target.caption;
        if (target.newEmbed) {
            var range = RTE.Cursor.get_range();
            range.deleteContent();
            var selection = range.parentElement();
            if (!selection) {
                return;
            }

            var embedContainer = selection.ownerDocument.createElement("div");
            embedContainer.className = "embedOuterContainer";

            var embedEditView = selection.ownerDocument.createElement("div");
            embedEditView.className = "embedEditModeView";

            var embedEditViewP = selection.ownerDocument.createElement("p");
            embedEditViewP.className = "embedEditText";
            embedEditViewP.innerHTML = "This section contains dynamic content that cannot be displayed in edit mode. Click the button below to edit this content.";
            embedEditView.appendChild(embedEditViewP);

            var embedEditButton = selection.ownerDocument.createElement("input");
            embedEditButton.type = "button";
            embedEditButton.className = "embedEditButton";
            embedEditButton.value = "Edit Content";
            embedEditView.appendChild(embedEditButton);
            embedContainer.appendChild(embedEditView);

            var embedEscapedContent = selection.ownerDocument.createElement("div");
            embedEscapedContent.className = "embedEscapedContent";
            embedEscapedContent.style.display = "none";
            embedEscapedContent.innerHTML = escapedEmbed;
            embedContainer.appendChild(embedEscapedContent);

            if (embedCaption) {
                var embedCaptionDiv = selection.ownerDocument.createElement("div");
                embedCaptionDiv.className = "embedCaption";
                embedCaptionDiv.innerHTML = embedCaption;
                embedContainer.appendChild(embedCaptionDiv);
            }

            range.insertNode(embedContainer);
            RTE.Cursor.get_range().moveToNode(embedContainer);
            RTE.Cursor.update();
        }
        else {
            (function ($) {
                var targetDiv = $("div.embedOuterContainer")[target.index];
                $(targetDiv).children(".embedEscapedContent").html(escapedEmbed);
                if ((embedCaption) && ($(targetDiv).children(".embedCaption").length > 0)) {
                    $(targetDiv).children(".embedCaption").html(embedCaption);
                }
                else if (embedCaption) {
                    $(targetDiv).append("<div class='embedCaption'>" + embedCaption + "</div>");
                }
                else if ($(targetDiv).children(".embedCaption").length > 0) {
                    $(targetDiv).children(".embedCaption").remove();
                }
            })(jQuery);
        }
    }
}

// This is a helper function for
// creating HTML tags with JS
function BeenJamminBuildTag(options) {
    var tag = document.createElement(options.tagName);

    if (options.cssClass)
        tag.setAttribute('class', options.cssClass);

    if (options.text)
        tag.appendChild(document.createTextNode(options.text));

    for (var attr in options.attributes) {
        tag.setAttribute(attr, options.attributes[attr]);
    }

    return tag;
}

// This function is used to get the selected text on the page.
function getSelectedText() {
    var txt = '';
    if (window.getSelection) {
        txt = window.getSelection();
    }
    else if (document.getSelection) // FireFox
    {
        txt = document.getSelection() + "";
    }
    else if (document.selection)  // IE 6/7
    {
        txt = document.selection.createRange().text;
    }
    return txt;

}

/* -------- This function checks if jQuery is loaded. If it isn't, it adds a script to load it. --------- */

function checkForAndLoadjQuery() {
    if (document.readyState === "complete") {
        if (typeof jQuery == 'undefined') {
            window.jqueryNoConflict = true;
            var jQueryScriptLink = document.createElement("script");
            jQueryScriptLink.type = "text/javascript";
            jQueryScriptLink.src = "http://code.jquery.com/jquery-latest.min.js";
            document.getElementsByTagName("body")[0].appendChild(jQueryScriptLink);
        }
    }
    else {
        setTimeout('checkForAndLoadjQuery()', 300);
    }
}

/*--------- These add links to our custom stylesheets to the document head ---------*/

function AddAllModesStyleSheet() {
    var customStylesheetLink = document.createElement("link");
    customStylesheetLink.type = "text/css";
    customStylesheetLink.rel = "stylesheet";
    customStylesheetLink.href = "/_layouts/BeenJammin.SharePoint.CustomRibbonActions/customRibbonActionsStyle.css";
    document.getElementsByTagName("head")[0].appendChild(customStylesheetLink);
}

function AddEditModeStyleSheet() {
    var editModeStylesheetLink = document.createElement("link");
    editModeStylesheetLink.type = "text/css";
    editModeStylesheetLink.rel = "stylesheet";
    editModeStylesheetLink.href = "/_layouts/BeenJammin.SharePoint.CustomRibbonActions/editModeStyle.css";
    document.getElementsByTagName("head")[0].appendChild(editModeStylesheetLink);
}

/*---------- This code is not directly attached to Ribbon Funcitonality.
It is meant for managing content on every page.             -----------*/


//Hide images that denote anchor tags. Use this when not in edit mode.
function hideAnchorImages() {
    (function ($) {
        $(document).ready(function () {
            $('img.anchorImage').remove();
        });
    })(jQuery);
}

//Replace youtube HTML generated by the ribbon action with actual embed code. Use this when not in edit mode.
function youtubeLinkReplace() {
    (function ($) {
        var videoClass = '.youtubeVideoLink';
        var iframeTag = '<iframe width="100%" height="100%" src="{PROTOCOL}//www.youtube.com/embed/{VIDEO_ID}" frameborder="0" allowfullscreen></iframe>';

        videoContainers = $(videoClass);
        videoContainers.each(function () {
            var videoContainer = $(this);

            var parentDiv = $(videoContainer).parent();
            var parentWidth = parentDiv.width();
            if (parentWidth > 640) {
                parentWidth = 640;
            }
            var videoWidth = parentWidth;
            var videoHeight = (parentWidth * (9 / 16)) + 24;
            $(videoContainer).css("width", videoWidth + "px");
            $(videoContainer).css("height", videoHeight + "px");

            if (parentWidth == 640) {
                $(videoContainer).css("margin", "0 auto");

                var nextSibling = $(videoContainer).next();
                if (nextSibling.attr("class") == "youtubeVideoCaption") {
                    var captionPaddingLeft = nextSibling.css("paddingLeft");
                    captionPaddingLeft = captionPaddingLeft.replace('px', '');
                    captionPaddingLeft = parseInt(captionPaddingLeft);
                    var captionPaddingRight = nextSibling.css("paddingRight");
                    captionPaddingRight = captionPaddingRight.replace('px', '');
                    captionPaddingRight = parseInt(captionPaddingRight);
                    var captionPadding = captionPaddingLeft + captionPaddingRight;
                    var captionWidth = videoWidth - captionPadding;
                    nextSibling.css("width", captionWidth + "px");
                    nextSibling.css("margin", "0 auto");
                }
            }

            var videoUrl = $(videoContainer).text();
            if (videoUrl.length) {
                var id = getIdFromUrl(videoUrl);
                videoTag = iframeTag.replace(/\{VIDEO_ID\}/g, id).replace(/\{PROTOCOL\}/g, window.location.protocol);
                videoContainer.html(videoTag);
            }
        });
    })(jQuery);
}

function getIdFromUrl(url) {
    return (url.toLowerCase().indexOf('youtube.com') > -1) ? getIdFromFullUrl(url) : getIdFromShortUrl(url);
}

function getIdFromFullUrl(url) {
    return url.replace(/.*v=([^\&]*)(.*)/, "$1");
}

function getIdFromShortUrl(url) {
    if (url.indexOf('/') > -1) {
        var parts = url.split('/');
        return parts.length ? parts[parts.length - 1] : '';
    }
    else {
        return url;
    }
}

function getInternetExplorerVersion() {
    var rv = -1; // Return value assumes failure.
    if (navigator.appName == 'Microsoft Internet Explorer') {
        var ua = navigator.userAgent;
        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat(RegExp.$1);
    }
    return rv;
}

//replace audio HTML generated by ribbon action with actual embed code. Use this when not in edit mode.
function replaceAudioLinkWithEmbed() {
    (function ($) {
        audioEmbedCount = 1;
        $("a.audioLink").parent("p").each(function () {
            var audioURL = $(this).children("a.audioLink").attr("href");
            var audioTitle = $(this).children("a.audioLink").text();
            var audioArtist = $(this).children("a.audioLink").attr("title");
            if (audioTitle && audioTitle != '') {
                audioTitleURL = '&titles=' + audioTitle;
            }
            else {
                audioTitleURL = '';
            }
            if (audioArtist && audioArtist != '') {
                audioArtistURL = '&artists=' + audioArtist;
            }
            else {
                audioArtistURL = '';
            }

            var fullObjectHTML = "";

            if (getInternetExplorerVersion() != -1 && getInternetExplorerVersion() < 9) {
                fullObjectHTML = '<embed id="audioPlayer_' + audioEmbedCount + '" src="/_layouts/BeenJammin.SharePoint.CustomRibbonActions/player.swf" Flashvars="soundFile=' + audioURL + audioTitleURL + audioArtistURL + '&animation=yes&playerID=audioplayer_' + audioEmbedCount + '" type="application/x-shockwave-flash" allowscriptaccess="always" width="100%" height="24"></embed>';
            }

            else if ((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i)) || (navigator.userAgent.match(/iPad/i))) {
                if (audioArtist && audioArtist != '') {
                    fullObjectHTML = '<div style="margin-bottom:10px;"><b>' + audioArtist + ' &mdash; ' + audioTitle + ':</b></div>';
                }
                else {
                    fullObjectHTML = '<div style="margin-bottom:10px;"><b>' + audioTitle + ':</b></div>';
                }
                fullObjectHTML += '<div><audio controls="controls" style="width:100%"><source src="' + audioURL + '" type="audio/mpeg" /></audio></div>';
            }

            else {
                var objectStart = '<object width="100%" height="24" type="application/x-shockwave-flash" name="audioplayer_' + audioEmbedCount + '" style="outline:none;" data="/_layouts/BeenJammin.SharePoint.CustomRibbonActions/player.swf" id="audioplayer_' + audioEmbedCount + '">';
                var paramWmode = '<param name="wmode" value="opaque" />';
                var paramMenu = '<param name="menu" value="false" />';
                var paramFlashvars = '<param name="flashvars" value="soundFile=' + audioURL + audioTitleURL + audioArtistURL + '&animation=yes&playerID=audioplayer_' + audioEmbedCount + '" />';
                var paramMovie = '<param name="movie" value="/_layouts/BeenJammin.SharePoint.CustomRibbonActions/player.swf" />';
                var objectEnd = '</object>';

                fullObjectHTML = objectStart + paramWmode + paramMenu + paramFlashvars + paramMovie + objectEnd;
            }

            $(this).html('');
            $(this).html(fullObjectHTML);
            audioEmbedCount++;
        });
    })(jQuery);
}

//Call the pre-filled embed dialog when the Edit Content button is clicked
function embedEditButtonClick() {
    (function ($) {
        if (typeof $().on != "undefined") {
            $("body").on("click", ".embedEditButton", function () {
                var parentContainer = $(this).parent(".embedEditModeView").parent(".embedOuterContainer");
                var index = $(".embedOuterContainer").index(parentContainer);
                var code = $(parentContainer).children(".embedEscapedContent").html();
                if ($(parentContainer).children(".embedCaption").length > 0) {
                    var caption = $(parentContainer).children(".embedCaption").html();
                    InsertEmbedContent(code, caption, index);
                }
                else {
                    InsertEmbedContent(code, undefined, index);
                }
            });
        }
        else if (typeof $().delegate != "undefined") {
            $("body").delegate(".embedEditButton", "click", function () {
                var parentContainer = $(this).parent(".embedEditModeView").parent(".embedOuterContainer");
                var index = $(".embedOuterContainer").index(parentContainer);
                var code = $(parentContainer).children(".embedEscapedContent").html();
                if ($(parentContainer).children(".embedCaption").length > 0) {
                    var caption = $(parentContainer).children(".embedCaption").html();
                    InsertEmbedContent(code, caption, index);
                }
                else {
                    InsertEmbedContent(code, undefined, index);
                }
            });
        }
        else {
            $(".embedEditButton").live("click", function () {
                var parentContainer = $(this).parent(".embedEditModeView").parent(".embedOuterContainer");
                var index = $(".embedOuterContainer").index(parentContainer);
                var code = $(parentContainer).children(".embedEscapedContent").html();
                if ($(parentContainer).children(".embedCaption").length > 0) {
                    var caption = $(parentContainer).children(".embedCaption").html();
                    InsertEmbedContent(code, caption, index);
                }
                else {
                    InsertEmbedContent(code, undefined, index);
                }
            });
        }
    })(jQuery);
}

function replaceEmbedContainerWithCode() {
    (function ($) {
        $(".embedOuterContainer").each(function () {
            var embedCode = unescape($(this).children(".embedEscapedContent").html());
            var caption = false;
            if ($(this).children(".embedCaption").length > 0) {
                var embedCaption = $(this).children(".embedCaption").html();
                caption = true;
            }
            var finalHtml = "<span class='embedInnerContainer'>" + embedCode + "</span>";
            if (caption) {
                finalHtml += "<div class='embedCaptionContainer'><div class='embedCaption'>" + embedCaption + "</div></div>";
            }
            $(this).html(finalHtml);
        });
        $(".embedCaptionContainer").each(function () {
            var embedWidth = $(this).prev().width();
            $(this).css("width", embedWidth + "px");
        });
    })(jQuery);
}

/*---------- Insert any functions that need to run after jQuery loads in the appropriate function below -----------*/

//Run these in edit and display modes
function AllModeFunctions() {
    AddAllModesStyleSheet();
}

//Run these in display mode
function DisplayModeFunctions() {
    hideAnchorImages();
    youtubeLinkReplace();
    replaceAudioLinkWithEmbed();
    replaceEmbedContainerWithCode();
}

//Run these in edit mode
function EditModeFunctions() {
    embedEditButtonClick();
    AddEditModeStyleSheet();
}

//Calls functions specified above
function jQueryDependencies() {
    (function ($) {
        AllModeFunctions();
        if (typeof g_disableCheckoutInEditMode != 'undefined') {
            //Run in display mode
            if (!g_disableCheckoutInEditMode) {
                DisplayModeFunctions();
            }
            //Run in edit mode
            else if (g_disableCheckoutInEditMode) {
                EditModeFunctions();
            }
        }
        //Fallback run in display mode
        else if ($("body[spellcheck]").length < 1) {
            DisplayModeFunctions();
        }
        //Fallback run in edit mode
        else if ($("body[spellcheck]").length == 1) {
            EditModeFunctions();
        }
    })(jQuery);
}

//This function calls the jQuery dependencies on document ready
function runAfterjQueryLoads() {
    if (typeof jQuery == 'undefined') {
        setTimeout('runAfterjQueryLoads()', 100);
    }
    else {
        if (window.jqueryNoConflict) {
            jQuery.noConflict();
        }
        if (jQuery.isReady) {
            jQueryDependencies();
        }
        else {
            jQuery(document).ready(function () {
                jQueryDependencies();
            });
        }
    }
}

/*----------- This section contains the code that is executed as soon as the script is loaded --------------*/

checkForAndLoadjQuery();
runAfterjQueryLoads();