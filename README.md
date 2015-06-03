# VoodooHDA repacked pkg

This is a repacked version of original VoodooHDA pkg(`VoodooHDA_V286_MAV.pkg`).

Everything that extracted from pkg goes into `Contents` folder.

## Changes

* Enable fixes in `VoodooHDA.kext/Contents/Info.plist`

```xml
<key>VoodooHDAEnableHalfMicVolumeFix</key>
<false/>
<key>VoodooHDAEnableHalfVolumeFix</key>
<false/>
<key>VoodooHDAEnableMuteFix</key>
<true/>
<key>VoodooHDAEnableVolumeChangeFix</key>
<true/>
```

* Remove `VoodooHdaSettingsLoader.app`,`AppleHDA.kext`


## Scripts for repacking pkg file

```sh
# unpack pkg
pkgutil --expand VoodooHDA_V286_MAV.pkg <your-dir>

# pack pkg
pkgutil --flatten . <your-pkg-file>
# tips: don't put the output file or directory 
# under same folder to avoid some error

#############START EDITING PAYLOAD#############

cd Contents/VoodooHDAMAV.pkg
# ...
# create a folder `Payload-folder` for `Payload` and 
# move `Payload` under `Payload-folder` and then extract `Payload`
# ...
cat Payload | gunzip -dc | cpio -i
rm Payload

# ...
# edit your file
# ...
# repacked `Payload` under `Payload-folder`
find . | cpio -o | gzip -c > Payload

# generate new `Bom` file
mkbom Payload-folder

#############END EDITING PAYLOAD#############

# ...
# edit other files you want
# ...

# pack pkg
pkgutil --flatten . <your-pkg-file>
```


## Troubleshooting `pkg` install problems

* use `installer` to install `pkg`, e.g. `sudo installer -verbose -package <your-pkg> -target /`
* check installer log file--`/var/log/install.log`
* use `lsbom` to check your bom file
* kext require the owner to be `root:wheel` in order to be loaded, and the ownership is recorded in `Payload`, so make sure the ownership of kext files is `root:wheel` in `Payload`


## Original Credits

* [VoodooHDA on sourceforge by autumnrain and slice2009](http://sourceforge.net/projects/voodoohda)


## Other Resources

* [VoodooHDA 2.8.5 for Mavericks (Slice + AnV) (Signed!) on insanelymac](http://www.insanelymac.com/forum/topic/297207-voodoohda-285-for-mavericks-slice-anv-signed/)


## Reference

* [`pkgutil` man page by apple](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/pkgutil.1.html)
* [`installer` man page by apple](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man8/installer.8.html#//apple_ref/doc/man/8/installer)
* [`mkbom` man page by apple](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man8/mkbom.8.html#//apple_ref/doc/man/8/mkbom)
* [`lsbom` man page by apple](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man8/lsbom.8.html)
* [how to unpack and pack pkg file on stackoverflow](http://stackoverflow.com/questions/11298855/how-unpack-and-pack-pkg-file)
