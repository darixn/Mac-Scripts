# Password Expiring Warning Script (with OSAScript)

Leverages `SwiftDialog` and Jamf Pro Scripts to easily displays a simple window encouraging the end-user change the password for there account before the expired date. If the user decides to change it, it will open the system preference change password window
<br />
<br />
Note: Currently set for the password to change every 60 days and the user to be notified after 30 days are remaining, with jamf checking daily
<br />
<br />
- Customizable Max days
- Customizable Notify days

## Requirements 
[SwiftDialog](https://github.com/swiftDialog/swiftDialog)
<br />
[Jamf Pro](https://www.jamf.com/) or a Mobile Device Management System
<br />



### Initial Window
<img src="https://github.com/cocopuff2u/Jamf-Scripts/blob/e180c6ff51823ef44a81a8d22f471d1d95888035/Password%20Expiring%20Warning/images/firstwindow.png">


### Self Service Window
<img src="https://github.com/cocopuff2u/Jamf-Scripts/blob/9bb2ea4cc5f0a96f64a3c8e837a33aa357551718/Password%20Expiring%20Warning/images/selfservicewindow.png">
