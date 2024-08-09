# <p align="center"> DISA STIG Scripts </p>

These scripts are to check and fix based on STIG requirements, now not all STIG requirements can be fixed via command line and some require configuration profiles pushed via a MDM. I did not include those configuration profiles as they posted on https://public.cyber.mil/stigs/. Please reach out for any recommendations or issues.
<br />
<br />
Each Script will have variables that need to be adjusted to generate logs locally on the machine, please adjust accordingly to your needs.
<br />
<br />
I've included the import DoD Certifcates script in here too, this will help import the required DoD certifcates into the system keychain
<br />
### <p align="center"> <ins> Executing Scripts</ins> </p>

```
sudo bash "PATH/MacOS 14 Sonoma V2R1 STIG CHECKER.sh"
```
<br />
* <strong>Note:</strong> The file path will depend on where you downloaded the file. For example, if it was saved to the Downloads folder in your home directory, the command would look like this:

```
sudo bash "~/downloads/MacOS 14 Sonoma V2R1 STIG CHECKER.sh"
``` 

## <p align="center"> [Sonoma STIG Checker](https://github.com/cocopuff2u/Mac-Scripts/blob/130024b9664872bddc16938225adc5fd6af0d194/DISA%20STIG%20Scripts/MacOS%2014%20Sonoma%20V2R1%20STIG%20CHECKER.sh) </p> 
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

## <p align="center"> [Sonoma STIG Fixer](https://github.com/cocopuff2u/Mac-Scripts/blob/1c495c72ff1970292f19b3427a9d5323cfff658e/DISA%20STIG%20Scripts/MacOS%2014%20Sonoma%20V2R1%20STIG%20FIXER.sh) </p> 
<p align="center"> Script checks the required DISA STIGS against the machines current settings and fixes based on the required STIG fix. Keep in mind not all STIGs can be fixed via command, some require MDM configuration profiles</p>
<br />

<p align="center"> Terminal Output </p>
<p align="center">
<img src="https://github.com/cocopuff2u/Mac-Scripts/blob/19c94b71ecbfbbd43fe66bdcbfd4aad0b257702c/DISA%20STIG%20Scripts/images/Example_terminal_fixer_log.png">
</p>

<p align="center"> Fixer Command Log Output </p>
<p align="center">
<img src="https://github.com/cocopuff2u/Mac-Scripts/blob/c8cb3bbcebf59154d79bc9836d8b991324fd2f6e/DISA%20STIG%20Scripts/images/Example_Fixer_Command_output_log.png">
</p>
