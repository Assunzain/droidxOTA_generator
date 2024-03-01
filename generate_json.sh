#!/bin/bash
#put script in DroidX-UIsource folder, make executable (chmod +x file.sh) and run it (./file.sh)

#modify values below
#leave blank if not used
maintainer="AssunZain"
oem="asus"
device="X01AD" 
devicename="Asus Zenfone Max M2" 
zip="droidx-2.0-20240219-0945-OFFICIAL-X01AD-Vanilla.zip"
forum=""
gapps=""
recovery=""
telegram=""

# Don't modify from here
script_path="`dirname \"$0\"`"
zip_name=out/target/product/$device/$zip
buildprop=out/target/product/$device/system/build.prop

if [ -f $script_path/$device.json ]; then
  rm $script_path/$device.json
fi

linenr=`grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
timestamp=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
zip_only=`basename "$zip_name"`
sha256=`sha256sum "$zip_name" | cut -d' ' -f1`
size=`stat -c "%s" "$zip_name"`
echo '{
  "response": [
    {
        "maintainer": "'$maintainer'",
        "oem": "'$oem'",
        "device": "'$devicename'",
        "filename": "'$zip_only'",
        "download": "https://sourceforge.net/projects/droidxui-releases/files/'$device'/'$v_max'.x/'$zip_only'/download",
        "timestamp": '$timestamp',
        "sha256": "'$sha256'",
        "size": '$size',
        "forum": "'$forum'",
        "gapps": "'$gapps'",
        "telegram": "'$telegram'"
    }
  ]
}' >> $device.json
