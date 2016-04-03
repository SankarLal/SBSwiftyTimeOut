



import UIKit


// # of minutes before application times out
let kSBApplicationTimeoutInMinutes : Double = 1

// Notification that gets sent when the timeout occurs
let kSBApplicationDidTimeoutNotification = "SBApplicationDidTimeout"

/**
 * This is a subclass of UIApplication with the sendEvent: method
 * overridden in order to catch all touch events.
 */


class SBTimeOut: UIApplication {

    var _idleTimer : NSTimer?
    
    
    override func sendEvent(event: UIEvent)
    {
        
        super.sendEvent(event)
        
        // Check to see if there was a touch event
        let allTouches = event.allTouches()
        
        for touch in allTouches!.enumerate() {
            
            if touch.element.phase != .Began  {
                resetIdleTimer()
                break
            }
        }

    }
    
    /**
     * Resets the idle timer to its initial state. This method gets called
     * every time there is a touch on the screen.  It should also be called
     * when the user correctly enters their pin to access the application.
     */
    
    func resetIdleTimer () {
        
        if (_idleTimer != nil) {
          
            _idleTimer?.invalidate()
            _idleTimer = nil
            
        }
        // Schedule a timer to fire in kSBApplicationTimeoutInMinutes * 60
        let timeout = kSBApplicationTimeoutInMinutes * 60
        
        _idleTimer = NSTimer.scheduledTimerWithTimeInterval(timeout,
                                                            target: self,
                                                            selector: "idleTimerExceeded",
                                                            userInfo: nil,
                                                            repeats: false)
        
        // Set Current Time
        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "SB_Date_Key")
        
    }
    
    func idleTimerExceeded () {
        
        /* Post a notification so anyone who subscribes to it can be notified when
         * the application times out */
        
        NSNotificationCenter.defaultCenter().postNotificationName(kSBApplicationDidTimeoutNotification,
                                                                  object: nil)
        

    }
    
}
