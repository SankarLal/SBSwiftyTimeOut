


import UIKit

class SBLogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "SBLOGIN";
        self.view.backgroundColor = UIColor.white;
        
        let logInButton = UIButton.init(frame: CGRect.init(x: 10, y: self.view.frame.size.height / 2 - 30, width: self.view.frame.size.width - 20, height: 60))
        logInButton.setTitle("SBLOGIN", for: .normal)
        logInButton.setTitleColor(UIColor.white, for: .normal)
        logInButton.backgroundColor = UIColor.purple
        logInButton.addTarget(self, action: #selector(self.performLoginButton), for: .touchUpInside)
        self.view.addSubview(logInButton)

    }

    @objc func performLoginButton () {
        
        UserDefaults.standard.set("YES", forKey: "SBLoggedIn")
        
        self.navigationController?.pushViewController(SBHomeViewController(), animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
