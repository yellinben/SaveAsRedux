SaveAsRedux
===

Return the classic "Save As" command to Auto Save apps in Lion/10.7. 

It's a SIMBL plugin, but uses only public APIs. So it's only slightly hacky. Shouldn't conflict with Auto Save/Duplicate functionality. No promises though.

## To Use
* Install [SIMBL](http://www.culater.net/software/SIMBL/SIMBL.php)
* Build SaveAsRedux
* Copy SaveAsRedux.bundle to /Library/Application Support/SIMBL/Plugins/

## Customize

Currently SaveAsRedux loads in all applications, but only installs the "Save As…" menu item if it doesn't already exist. You can customize this by modifying SaveAsRedux-info.plist.

Check out this SIMBL [tutorial](http://code.google.com/p/simbl/wiki/Tutorial) for more info.

## License

This project is licensed under the MIT License.