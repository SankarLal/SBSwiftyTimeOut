



import UIKit

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rootNaviationController : UINavigationController?
    var alertView : UIAlertView?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        if (UserDefaults.standard.value(forKey: "SBLoggedIn") != nil) {
            
            loadHomeRootController()
            
        } else {
            
            loadLogInRootController()
            
        }
        
        // Observer the touch event
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.applicationDidTimeout(notification:)),
                                                         name: NSNotification.Name(rawValue: kSBApplicationDidTimeoutNotification),
                                                         object: nil)
        
        // Remove the Date Key while App Launch
        UserDefaults.standard.removeObject(forKey: "SB_Date_Key")
        
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
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        // Get Stored Time Stamp
        getIdleTimeInMinutes()
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if (UserDefaults.standard.value(forKey: "SBLoggedIn") != nil) {
            let sbTimeOut : SBTimeOut = UIApplication.shared as! SBTimeOut
            sbTimeOut.resetIdleTimer()
        }

    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
    
}

