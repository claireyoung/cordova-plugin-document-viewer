Changes from Original Github Project
============================

The Cordova Document Viewer Plugin is very full featured, so I just made a few modifications. First, I wanted the interface to allow users to jump to a specific page, and second, I wanted the ability to return the current page upon closing the PDF viewer.

For the basic installation instructions without the additional features in my fork, please refer to https://github.com/sitewaerts/cordova-plugin-document-viewer

### Plugin's Purpose
The purpose of the plugin is to create an platform independent javascript
interface for [Cordova][cordova] based mobile applications to view different
document types by using native viewer components.

## Overview
1. [Installation](#installation)
2. [Using the plugin](#using-the-plugin)

## Installation ##

From master:
```bash
# ~~ from master branch ~~
cordova plugin add https://github.com/claireyoung/cordova-plugin-document-viewer.git
```

## Using the plugin ##

Please refer to https://github.com/sitewaerts/cordova-plugin-document-viewer for their installation instructions. The following reflects only the differences that this fork has.

#### options ####

Notice the additional options.page.number - this allows the pdf to be opened at a specific page. If options.page is not specified, then the default page opened is page 1.

```js
options: {
	title: STRING,
	documentView : {
		closeLabel : STRING
	},
	navigationView : {
		closeLabel : STRING
	},
	email : {
		enabled : BOOLEAN
	},
	print : {
		enabled : BOOLEAN
	},
	openWith : {
		enabled : BOOLEAN
	},
	bookmarks : {
		enabled : BOOLEAN
	},
	search : {
		enabled : BOOLEAN
	},
    page: {
        number: 35  // start page number
    }
}
```

### Open a Document File ###
```js
SitewaertsDocumentViewer.viewDocument(
    url, mimeType, options, onShow, onClose, onMissingApp, onError);
```

#### onClose ####

The modification made from the original plugin is that a "result" object is passed, containing the last page number that the user was on.

```js
function(result){
  window.console.log('document closed on page ', result.pageNumber);
  //e.g. remove temp files
}
```

## Credits ##

based on https://github.com/sitewaerts/cordova-plugin-document-viewer

based on https://github.com/vfr/Reader

based on https://github.com/mindstorm/CDVPDFViewer

based on https://mozilla.github.io/pdf.js/

inspired by https://github.com/pebois/phonegap-plugin-PDFViewer

inspired by https://msdn.microsoft.com/en-us/library/windows/apps/dn263105.aspx


[cordova]: https://cordova.apache.org
[CLI]: http://cordova.apache.org/docs/en/edge/guide_cli_index.md.html#The%20Command-line%20Interface
[PGB]: http://docs.build.phonegap.com/en_US/index.html
[CDV_plugin]: http://plugins.cordova.io/#/package/de.sitewaerts.cordova.documentviewer
[PDFJS]: https://mozilla.github.io/pdf.js/
[Windows.Data.Pdf.PdfDocument]: https://msdn.microsoft.com/en-us/library/windows/apps/windows.data.pdf.pdfdocument
