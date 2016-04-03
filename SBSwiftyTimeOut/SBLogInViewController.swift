


import UIKit

class SBLogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "SBLOGIN";
        self.view.backgroundColor = UIColor.whiteColor();
        
        let logInButton = UIButton (frame: CGRectMake(10, self.view.frame.size.height / 2 - 30, self.view.frame.size.width - 20, 60))
        logInButton.setTitle("SBLOGIN", forState: .Normal)
        logInButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        logInButton.backgroundColor = UIColor.purpleColor()
        logInButton.addTarget(self, action: "performLoginButton", forControlEvents: .TouchUpInside)
        self.view.addSubview(logInButton)

    }

    func performLoginButton () {
        
        NSUserDefaults.standardUserDefaults().setObject("YES", forKey: "SBLoggedIn")
        
        self.navigationController?.pushViewController(SBHomeViewController(), animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
