#!/usr/bin/env bash

DESTFILE="/Library/Preferences/com.gppolicycheck.plist"

display_usage_and_exit()
{
    echo "Usage: $0"
    echo "Performs GP Policy Add"

    exit 1
}

error_and_exit()
{
    logger -p error "GP Policy Add: failed to save json file $DESTFILE. Exception occured: $1. Error: $?"
    exit 1
}

while getopts ":h:" options; do         
    case $options in
        *)
        display_usage_and_exit
        ;;
    esac
done

if [ "$EUID" -ne 0 ]; then 
    echo "Re-running as sudo (You may be required to enter a password)"
    sudo /usr/bin/env bash $0 $@
    exit
fi

echo "Generating $DESTFILE"
DESTFILE_DIR=$(dirname "$DESTFILE")
mkdir -p "$DESTFILE_DIR" || error_and_exit "Unable to create directory $DESTFILE_DIR"

cat <<EOM > "$DESTFILE"
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1">
<dict>
	<key>policycheck</key>
	<string>NIWC_RDTE</string>
</dict>
</plist>
EOM

if [ $? -ne 0 ]; then
    error_and_exit "Unable to save file $DESTFILE: $?"
fi

logger -p warning "GP Policy Add: succeeded to save json file $DESTFILE"
