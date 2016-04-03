



import UIKit

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rootNaviationController : UINavigationController?
    var alertView : UIAlertView?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.backgroundColor = UIColor.whiteColor()
        
        if (NSUserDefaults.standardUserDefaults().valueForKey("SBLoggedIn") != nil) {
            
            loadHomeRootController()
            
        } else {
            
            loadLogInRootController()
            
        }
        
        // Observer the touch event
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "applicationDidTimeout:",
                                                         name: kSBApplicationDidTimeoutNotification,
                                                         object: nil)
        
        // Remove the Date Key while App Launch
        NSUserDefaults.standardUserDefaults().removeObjectForKey("SB_Date_Key")
        
        return true
    }
    
    func loadHomeRootController () {
        
        rootNaviationController = UINavigationController (rootViewController: SBHomeViewController())
        self.window?.rootViewController = rootNaviationController
        self.window?.makeKeyAndVisible()


    }
    
    func loadLogInRootController () {
     
        rootNaviationController = UINavigationController (rootViewController: SBLogInViewController())
        self.window?.rootViewController = rootNaviationController
        self.window?.makeKeyAndVisible()
        

    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        // Get Stored Time Stamp
        getIdleTimeInMinutes()
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if (NSUserDefaults.standardUserDefaults().valueForKey("SBLoggedIn") != nil) {
            let sbTimeOut : SBTimeOut = UIApplication.sharedApplication() as! SBTimeOut
            sbTimeOut.resetIdleTimer()
        }

    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK:  Application Timeout Method
    func getIdleTimeInMinutes () {
        
        let getStoredDate : NSDate? = NSUserDefaults.standardUserDefaults().objectForKey("SB_Date_Key") as? NSDate
        
        if ((getStoredDate) != nil) {
            
            let timeOutMinutes : NSTimeInterval = kSBApplicationTimeoutInMinutes * 60
            let diff : NSTimeInterval = NSDate ().timeIntervalSinceDate(getStoredDate!)
            
            
            if (diff >= timeOutMinutes){
                
                NSNotificationCenter.defaultCenter().postNotificationName(kSBApplicationDidTimeoutNotification,
                                                                          object: nil)
            }
            
        }

    }
    
    func applicationDidTimeout (notification : NSNotification) {
        
        if (NSUserDefaults.standardUserDefaults().valueForKey("SBLoggedIn") != nil) {
            
            alertView = UIAlertView ()
            alertView?.title = "LoggedOut!"
            alertView?.message = "Sorry!!!, You have been logged out due to inactivity. Please LogIn to continue"
            alertView?.delegate = nil
            alertView?.show()
            
            self.performSelector("performRootViewController"
                , withObject: nil,
                  afterDelay: 5.0)
            
            NSUserDefaults.standardUserDefaults().removeObjectForKey("SBLoggedIn")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("SB_Date_Key")

        }

    }
    
    func performRootViewController () {
        
        alertView?.dismissWithClickedButtonIndex(0, animated: true)
        loadLogInRootController()
        
    }
    
}

