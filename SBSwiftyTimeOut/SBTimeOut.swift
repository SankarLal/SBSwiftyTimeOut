



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

    var _idleTimer : Timer?
    
    
    override func sendEvent(_ event: UIEvent)
    {
        
        super.sendEvent(event)
        
        // Check to see if there was a touch event
        let allTouches = event.allTouches
        
        for touch in allTouches!.enumerated() {
            
            if touch.element.phase != .began  {
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
        
        _idleTimer = Timer.scheduledTimer(timeInterval: timeout,
                                                            target: self,
                                                            selector: #selector(self.idleTimerExceeded),
                                                            userInfo: nil,
                                                            repeats: false)
        
        // Set Current Time
        UserDefaults.standard.set(NSDate(), forKey: "SB_Date_Key")
        
    }
    
   @objc func idleTimerExceeded () {
        
        /* Post a notification so anyone who subscribes to it can be notified when
         * the application times out */
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kSBApplicationDidTimeoutNotification),
                                                                  object: nil)
        

    }
    
}
