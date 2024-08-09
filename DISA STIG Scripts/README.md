# <p align="center"> DISA STIG Scripts </p>

These scripts are to check and fix based on STIG requirements, now not all STIG requirements can be fixed via command line and some require configuration profiles pushed via a MDM. I did not include those configuration profiles as they posted on https://public.cyber.mil/stigs/. Please reach out for any recommendations or issues.
<br />
<br />
Each Script will have variables that need to be adjusted to generate logs locally on the machine, please adjust accordingly to your needs.
<br />
<br />
I've included the import DoD Certifcates script in here too, this will help import the required DoD certifcates into the system keychain
<br />

## <p align="center"> STIG Scripts </p>
<br />

### <p align="center"> [Sonoma STIG Checker](https://github.com/cocopuff2u/Mac-Scripts/blob/130024b9664872bddc16938225adc5fd6af0d194/DISA%20STIG%20Scripts/MacOS%2014%20Sonoma%20V2R1%20STIG%20CHECKER.sh) </p> 
<p align="center"> Script checks the required DISA STIGS against the machines current settings and logs the information for the admin. The logs are located in the /var/log/* folder unless changed in the script.</p>
<br />

<p align="center"> Terminal Log Output </p>
<p align="center">
<img src="https://github.com/cocopuff2u/Mac-Scripts/blob/130024b9664872bddc16938225adc5fd6af0d194/DISA%20STIG%20Scripts/images/check_terminal_log.png">
</p>

<p align="center"> Command Log Output</p>
<p align="center">*Great for checklists* </p>
<p align="center">
<img src="https://github.com/cocopuff2u/Mac-Scripts/blob/130024b9664872bddc16938225adc5fd6af0d194/DISA%20STIG%20Scripts/images/Example_Command_output_log.png">
</p>

<p align="center"> Passed Log Output </p>
<p align="center">
<img src="https://github.com/cocopuff2u/Mac-Scripts/blob/130024b9664872bddc16938225adc5fd6af0d194/DISA%20STIG%20Scripts/images/Example_Passed_STIG_log.png">
</p>

<p align="center"> Failed Log Output </p>
<p align="center">
<img src="https://github.com/cocopuff2u/Mac-Scripts/blob/130024b9664872bddc16938225adc5fd6af0d194/DISA%20STIG%20Scripts/images/Example_Failed_STIG_Log.png">
</p>


