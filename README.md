## About this project:

This project creates several new ribbon actions for SharePoint 2010. They are available when editing a full rich HTML text field. The most useful of these tools is probably the comprehensive embed function. Note that this project uses jQuery. If you are not already using jQuery on your SharePoint site, this project will load it from an external source when necessary, and then run jQuery.noConflict() to prevent interfering with any other 3rd party JS libraries you may be using.

Each of these actions is packaged as a separate feature within this solution, making it easy to activate only one custom action, or any selection of your choosing.

* **Paste Plain Text - Format Text tab, Clipboard group**

  This action pops up a dialog box into which the user can paste text copied from any source. All formatting will be removed, and line breaks will be replaced with paragraph and break tags where appropriate. This helps avoid problems with pasting formatted text from Word or other sources, and does a better job of interpreting whether to use paragraph or break tags than the built in paste as plain function does, especially when using a non-IE browser.
    
* **Insert Line - Insert tab, Additional group**

  This action inserts a horizontal line (&lt;hr&gt;) wherever the cursor is in the current text field.
    
* **Special Character - Insert tab, Additional group**
    
  Pops up a dialog box displaying a table full of special characters. Clicking on a character causes it to be inserted at the location of the cursor in the current text field.

* **Audio Embed - Insert tab, Media group**

  This option pops up a dialog box that prompts for three fields: audio file URL (mp3 is the only fully supported option, other file types may meet with sporadic success), audio title, and audio artist. Only the first field is necessary. Once the fields have been filled out and submitted, the audio will be inserted into the current text field. While in edit mode, the audio will appear only as an audio icon next to a URL. However, once the item is saved and viewed in display mode it will be converted to a Flash embed (using the WordPress Flash audio player) that will play the audio file. Additionally, if the page containing the embed is viewed from an iOS device the audio will be inserted using an HTML 5 player instead of Flash.
    
* **YouTube Embed - Insert tab, Media group**

  Pops up a dialog which prompts for a YouTube URL and an optional caption. Similar to the audio embed, this will appear only as an icon and URL while in edit mode. Once the item is saved and viewed in display mode, it will show an embedded YouTube video, formatted as widescreen at 100% the width of its parent container.
    
* **Embed - Insert tab, Media group**

  Probably the best feature in the bunch, this button pops up a dialog box with two multiline text fields. The first is for an embed code, the second for an optional caption. Any embed code at all can be placed in the first box, and it will be preserved from SharePoint's usual issues with stripping dynamic content out of text fields.

  In edit mode, the content will be rendered as a simple placeholder box. This includes an "Edit Content" button that when clicked pulls back the original embed dialog, pre-populated with the current embed code and caption. It can then be easily edited and re-inserted, effectively updating the embeded content.

  In display mode, the content will be rendered exactly as expected, centered within its parent container. Any HTML tags can be placed inside this embed container and transition perfectly into display mode. This includes any HTML tags that SharePoint would usually strip out, including <object>, <embed>, <iframe>, <script>, and <style> tags.
    
* **Create and Link to Anchor - Insert tab, Links group**

  Consists of two separate buttons, "Create Anchor" and "Link to Anchor." The first one creates an anchor item in the text, and assigns it a user-provided ID. The second item provides the opportunity to link to any anchor item in the text, pre-populating a dropdown selection of all available anchor items.
    
* **Email - Insert tab, Links group**

  A simple function, inserts a "mailto:" link to an email address.
