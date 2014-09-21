#!/bin/bash
bad_files="$(grep -L -r "autoconnect=false" /etc/NetworkManager/system-connections/)"

IFS=$(echo -en "\n\b") # make foor loops work if we have new lines

for file in $bad_files; do
    echo "Fixing $file";
    sed -i 's/\[connection\]/\[connection\]\nautoconnect=false/' $file
done

bad_files="$(grep -L -r "autoconnect=false" /etc/NetworkManager/system-connections/)"

if [ -n "$bad_files" ]; then
    echo "Failed to fix up some connections!"
    exit 1
fi;
