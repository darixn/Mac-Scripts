#!/bin/zsh
#set -x 
####################################################################################################
#
# # Trellix Loop Update Selection
#
# Purpose: Loop Trellix Updates 5 or 20 times with swiftdialog prompt
# 
# https://github.com/cocopuff2u
#
####################################################################################################
#
#   History
#
#  1.0 03/01/24 Original
#
#
####################################################################################################


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Pre-flight Check: Validate / install swiftDialog
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function dialogInstall() {

    # Get the URL of the latest PKG From the Dialog GitHub repo
    dialogURL=$(curl -L --silent --fail "https://api.github.com/repos/swiftDialog/swiftDialog/releases/latest" | awk -F '"' "/browser_download_url/ && /pkg\"/ { print \$4; exit }")

    # Expected Team ID of the downloaded PKG
    expectedDialogTeamID="PWA5E9TQ59"

    updateScriptLog "SELF HEAL: Installing swiftDialog..."

    # Create temporary working directory
    workDirectory=$( /usr/bin/basename "$0" )
    tempDirectory=$( /usr/bin/mktemp -d "/private/tmp/$workDirectory.XXXXXX" )

    # Download the installer package
    /usr/bin/curl --location --silent "$dialogURL" -o "$tempDirectory/Dialog.pkg"

    # Verify the download
    teamID=$(/usr/sbin/spctl -a -vv -t install "$tempDirectory/Dialog.pkg" 2>&1 | awk '/origin=/ {print $NF }' | tr -d '()')

    # Install the package if Team ID validates
    if [[ "$expectedDialogTeamID" == "$teamID" ]]; then

        /usr/sbin/installer -pkg "$tempDirectory/Dialog.pkg" -target /
        sleep 2
        dialogVersion=$( /usr/local/bin/dialog --version )
        updateScriptLog "SELF HEAL: swiftDialog version ${dialogVersion} installed; proceeding..."

    else

        # Display a so-called "simple" dialog if Team ID fails to validate
        osascript -e 'display dialog "Please advise your Support Representative of the following error:\r\r• Dialog Team ID verification failed\r\r" with title "Self Heal Your Mac: Error" buttons {"Close"} with icon caution' & exit 0

    fi

    # Remove the temporary working directory when done
    /bin/rm -Rf "$tempDirectory"

}

function dialogCheck() {

    # Check for Dialog and install if not found
    if [ ! -e "/Library/Application Support/Dialog/Dialog.app" ]; then

        updateScriptLog "SELF HEAL: swiftDialog not found. Installing..."
        dialogInstall

    else

        dialogVersion=$(/usr/local/bin/dialog --version)
        if [[ "${dialogVersion}" < "${swiftDialogMinimumRequiredVersion}" ]]; then
            
            updateScriptLog "SELF HEAL: swiftDialog version ${dialogVersion} found but swiftDialog ${swiftDialogMinimumRequiredVersion} or newer is required; updating..."
            dialogInstall
            
        else

        updateScriptLog "SELF HEAL: swiftDialog version ${dialogVersion} found; proceeding..."

        fi
    
    fi

}

dialogCheck

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Flight: Prompts users to select 5 Loop or 20 loop of Trellix Updates
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Path to our dialog binary
dialogPath='/usr/local/bin/dialog'
# Path to our dialog command file
dialogCommandFile=$(mktemp /var/tmp/exampleDialog.XXXXX)
#Note: This can be BASE64, a Local File or a URL
icon="/Applications/Trellix Endpoint Security for Mac.app/Contents/Resources/McAfee_Locked.png"
#"Window Title"
titleloop="Trellix Update In Progress"
title="Trellix Loop Utility"
#"Window Message"
descriptionloop="May take a few minutes"
description="Choose the number of loops for executing Trellix updates"

#Help Message
helpmessage="If you need to kill this script 

Sudo killall Dialog
"

#"Button1"
button1="5 Loops"
#"Button2"
button2="20 Loops"

$dialogPath \
--title $title \
--message $description \
--ontop \
--mini \
--commandfile "$dialogCommandFile" \
--icon $icon \
--button1 \
--button1text $button2 \
--button2 \
--button2text $button1 \
--helpmessage $helpmessage \

if [ $? -eq 2 ]; then
  # Set the number of iterations
  iterations=5
else
  # Set the number of iterations
  iterations=20
fi


# An array containing the list of items to progress through
itemsToProgress=()

# Populate the array with elements containing loop count
for ((i=1; i<=iterations; i++)); do
itemsToProgress+=("Looping Trellix Updates: $i/$iterations")
done

# Print the elements of the array
for element in "${itemsToProgress[@]}"; do
echo "$element"
done

# This function sends a command to our command file, and sleeps briefly to avoid race conditions
function dialog_command()
{
echo "$@" >> "$dialogCommandFile"
sleep 0.1
}

# Calling our initial dialog window. The & is crucial so that our script progresses.
# ${#itemsToProgress[@]} is equal to the number of items in our array
$dialogPath \
--title $title \
--message $descriptionloop  \
--ontop \
--mini \
--commandfile "$dialogCommandFile" \
--progress ${#itemsToProgress[@]} \
--icon $icon \
--button1 \
&

# Display the bouncy bounce for 2 seconds
sleep 2

# Iterate through our array
# For each item we've outlined
for 2 in "${itemsToProgress[@]}"; do
dialog_command "progress: increment"
dialog_command "progresstext: $2"
  echo "Script looping count: $2"
  /Library/McAfee/agent/bin/cmdagent -c &>/dev/null
  sleep 5
  /Library/McAfee/agent/bin/cmdagent -e &>/dev/null
  sleep 5
  /Library/McAfee/agent/bin/cmdagent -p &>/dev/null
  sleep 5
  /Library/McAfee/agent/bin/cmdagent -f &>/dev/null
  sleep 5
done

# Close our dialog window
dialog_command "quit:"
echo "Completed the loop, SwiftDialog closed"

# Delete our command file
rm "$dialogCommandFile"

exit 0
