# SBSwiftyTimeOut
SBSwiftyTimeOut detects when an app goes idle/inactive (no touches) and sends a time out notification when app is in Foreground State, Suspended State and Background State which is developed in Swift 4.

For Objective C click [here][sbtimeout-url]

<img src="https://raw.githubusercontent.com/sankarlal/sbSwiftyTimeOut/master/Screen%20Shots/LogoutScreen.png" alt="SBSwiftyTimeOut Screenshot" />

## Configuration

Comment Or Delete the `@UIApplicationMain` in AppDelegate then add `main.swift` file.

Adding main.swift file,

1. Create New File
2. Choose Swift File
3. Keep name as main.swift

Add `SBTimeOut` Class into `main.m` Class

```objective-c

import Foundation
import UIKit

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(SBTimeOut.self),
    NSStringFromClass(AppDelegate.self)
)


```

Change TimeOut time in "SBTimeOut" Class

```objective-c

let kSBApplicationTimeoutInMinutes : Double = 1

```

For Background And Suspended State - AppDelegate 

```objective-c

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        // Get Stored Time Stamp
        getIdleTimeInMinutes()
        
    }

    //MARK:  Application Timeout Method
    func getIdleTimeInMinutes () {
        
        let getStoredDate : NSDate? = UserDefaults.standard.object(forKey: "SB_Date_Key") as? NSDate
        
        if ((getStoredDate) != nil) {
            
            let timeOutMinutes : TimeInterval = kSBApplicationTimeoutInMinutes * 60
            let diff : TimeInterval = NSDate ().timeIntervalSince(getStoredDate! as Date)
            
            
            if (diff >= timeOutMinutes){
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kSBApplicationDidTimeoutNotification),
                                                                          object: nil)
            }
            
        }
    }


```
Add Time Out Notification Observer in `didFinishLaunchingWithOptions` - AppDelegate 

```objective-c

        // Observer the touch event
               NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.applicationDidTimeout(notification:)),
                                                         name: NSNotification.Name(rawValue: kSBApplicationDidTimeoutNotification),
                                                         object: nil)


```

LogOut Functionality - AppDelegate 

```objective-c

    @objc func applicationDidTimeout (notification : NSNotification) {
        
        if (UserDefaults.standard.value(forKey: "SBLoggedIn") != nil) {
            
            alertView = UIAlertView ()
            alertView?.title = "LoggedOut!"
            alertView?.message = "Sorry!!!, You have been logged out due to inactivity. Please LogIn to continue"
            alertView?.delegate = nil
            alertView?.show()
            
            self.perform(#selector(self.performRootViewController)
                , with: nil,
                  afterDelay: 5.0)
            
            UserDefaults.standard.removeObject(forKey: "SBLoggedIn")
            UserDefaults.standard.removeObject(forKey: "SB_Date_Key")

        }
    }
    
    @objc func performRootViewController () {
        alertView?.dismiss(withClickedButtonIndex: 0, animated: true)
        loadLogInRootController()
    }
```

[sbtimeout-url]: https://github.com/SankarLal/SBTimeOut/

## Contact
sankarlal20@gmail.com

## License

SBSwiftyTimeOut is available under the MIT license.

Copyright © 2016 SBSwiftyTimeOut

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
