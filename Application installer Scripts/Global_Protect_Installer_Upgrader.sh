#/bin/sh
####################################################################################################
#
# # Global Protect Installer/Upgrader
#
# Purpose: Download from local server and install, or compare to server and upgrade to newest
# 
# https://github.com/cocopuff2u
#
####################################################################################################
#
#   History
#
#  1.0 8/07/23 Forescout Connector to /tmp on the host and installs GlobalProtect, then wipes the temp folder
#
#  1.1 10/24/24 - Added the the ability to compare the local with the server version and upgrade if needed
#
####################################################################################################



####################################################################################################
#
# Variables
#
####################################################################################################

# Global Protect URL to verify current version
GP_pkg_url=("https://URL.com/global-protect/msi/GlobalProtect.pkg")
GP_pkg_url_live=("https://URL.com")

# Script Log Location
scriptLog="${4:-"/var/tmp/org.COMPANYT.GPAutoupdater.log"}"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Client-side Logging
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

if [[ ! -f "${scriptLog}" ]]; then
    touch "${scriptLog}"
fi

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Client-side Script Logging Function
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function updateScriptLog() {
    echo -e "$( date +%Y-%m-%d\ %H:%M:%S ) - ${1}" | tee -a "${scriptLog}"
}

updateScriptLog "GPAutoUpdater: Starting the script"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Get current user
CURRENT_USER=`ls -l /dev/console | awk '{ print $3 }'`

# Create a temporary directory to expand the package
gp_temp_dir=$(mktemp -d)

# Replace 'path/to/your/file.txt' with the actual path of the file you want to check
GP_file_path="/Applications/GlobalProtect.app/"

# Download the PKG file to the temporary directory
gp_pkg_file="$gp_temp_dir/GlobalProtect.pkg"

# Curl file but if URL is unreachable show in the logs
http_status_code=$(curl -s -o /dev/null -w "%{http_code}" "$GP_pkg_url_live")

# Confirm URL is live
if [ "$http_status_code" -eq 200 ]; then
    updateScriptLog "GPAutoUpdater: url looks live for $GP_pkg_url_live"
    updateScriptLog "GPAutoUpdater: attempting to download file from $GP_pkg_url"
    # Download PKG File from URL
    if curl "$GP_pkg_url" -o "$gp_pkg_file" ; then
        updateScriptLog "GPAutoUpdater: downloaded file from $GP_pkg_url_live"
        else
        updateScriptLog "GPAutoUpdater: Unable to download file from $GP_pkg_url_live"
        updateScriptLog "GPAutoUpdater: Script Exited"
        exit 1
    fi
else 
    updateScriptLog "GPAutoUpdater: URL $GP_pkg_url_live is not reachable"
    updateScriptLog "GPAutoUpdater: Script Exited"
    exit 1
fi

# Expand the package into the temporary directory
updateScriptLog "GPAutoUpdater: Expanding the packge into a temporary directory for comparison" 
pkgutil --expand "$gp_pkg_file" "$gp_temp_dir/expanded_package"

# Find and extract the version information from the server
gp_downloaded_version_info=$(cat "$gp_temp_dir/expanded_package/Distribution" | grep -o '<bundle CFBundleShortVersionString="[^"]*"' | head -n 1 | awk -F '"' '{print $2}')
gp_downloaded_version_info_hyphen=$(echo $gp_downloaded_version_info | sed 's/-//g' )

#Find local version information
gp_verison_info=$(defaults read /Applications/GlobalProtect.app/Contents/Info.plist CFBundleShortVersionString)
gp_version_info_hyphen=$($gp_version_info | sed 's/-//g')

if [ -d "$GP_file_path" ]; then
updateScriptLog "GPAutoUpdater: Local GP Version - $gp_verison_info"
updateScriptLog "GPAutoUpdater: Server GP Version - $gp_downloaded_version_info"
    if [[ "$gp_downloaded_version_info_hyphen" < "$gp_version_info_hyphen" ]]; then
        # Your action(s) here if the server version is newer
        updateScriptLog "GPAutoUpdater: Upgrading from GP Version $gp_version_info to Server GP Version $gp_downloaded_version_info"

        #Installing SecureConnector as a Daemon/Dissolvable w/ visible/invisible menu bar icon
        sudo installer -pkg $gp_pkg_file -target /

        #unload system from starting right after boot, causes a hang on the service
        sudo -u "$CURRENT_USER" launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*

        sleep 3
        #reload system from starting right after boot, fixing the hang
        sudo -u "$CURRENT_USER" launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*
        else
        updateScriptLog "GPAutoUpdater: $gp_verison_info and Server GP Version: $gp_downloaded_version_info match or not greater"
    fi

else
updateScriptLog "GPAutoUpdater: Server GP Version - $gp_downloaded_version_info"
updateScriptLog "GPAutoUpdater: Local GP not present on the device"
updateScriptLog "GPAutoUpdater: Installing"
#Installing SecureConnector as a Daemon/Dissolvable w/ visible/invisible menu bar icon
sudo installer -pkg $gp_pkg_file -target /

#unload system from starting right after boot, causes a hang on the service
sudo -u "$CURRENT_USER" launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*

sleep 3
#reload system from starting right after boot, fixing the hang
sudo -u "$CURRENT_USER" launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*
fi

# Clean up the temporary directory
updateScriptLog "GPAutoUpdater: Cleaning up the files"
rm -rf "$gp_temp_dir"

updateScriptLog "GPAutoUpdater: Script Complete"
exit 0
