# User Password Tester via SwiftDialog

Leverages `SwiftDialog` and Jamf Pro Scripts to easily display an engaging end-user messages to test the current logged in users password.
<br />
<br />
This was originally designed for an enviroments that requires full SmartCard enforcement without a way to remind the users to test/remember the local password, this gives the user an easy prompt to test the password, while not using up the FailedLoginCount limit.

## Requirements
[SwiftDialog](https://github.com/swiftDialog/swiftDialog)
<br />
[Jamf Pro](https://www.jamf.com/) or a Mobile Device Management System

### Initial Window
![First Window](images/firstwindow.png)


### Failed Window
![Failed Window "User Failed Password Attempt"](images/failedwindow.png)


### Successful Window
![Success Window "User Entered Correct Password"](images/successwindow.png)

