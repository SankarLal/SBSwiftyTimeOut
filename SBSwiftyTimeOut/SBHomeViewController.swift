



import UIKit

class SBHomeViewController: UIViewController, UIWebViewDelegate {
    
    var webView : UIWebView?
    var barBtn_Rewind : UIBarButtonItem?
    var barBtn_Stop : UIBarButtonItem?
    var barBtn_FastForward : UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "SBHOME";
        self.view.backgroundColor = UIColor.white;
        self.navigationItem.hidesBackButton = true
        
        setUpUserInterface()
    }
    
    //MARK: SetUp User Interface
    func setUpUserInterface () {
        
        webView = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 44))
        webView!.delegate = self
        webView!.loadRequest(URLRequest.init(url: URL.init(string: "https://github.com/SankarLal?tab=repositories")!))
        self.view.addSubview(webView!)
        
        let toolBar : UIToolbar = UIToolbar.init(frame: CGRect.init(x: 0, y: self.view.frame.size.height - 44, width: self.view.frame.size.width, height: 44))
        self.view.addSubview(toolBar)
        
        let flexiableItem : UIBarButtonItem = UIBarButtonItem (barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        barBtn_Rewind = UIBarButtonItem (image: UIImage(named: "Back"), style : UIBarButtonItemStyle.plain, target: self, action:#selector(self.peformRewindBarButton))
        
        barBtn_Stop = UIBarButtonItem (barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(self.peformStopBarButton))
        
        let barBtn_Refresh : UIBarButtonItem = UIBarButtonItem (barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(self.peformRefreshBarButton))
        
        barBtn_FastForward = UIBarButtonItem (image: UIImage(named: "Forward"), style : UIBarButtonItemStyle.plain, target: self, action:#selector(self.peformFastForwardBarButton))
        
        let items : NSArray = [
            barBtn_Rewind!,
            flexiableItem,
            barBtn_Stop!,
            flexiableItem,
            barBtn_Refresh,
            flexiableItem,
            barBtn_FastForward!
        ]
        
        toolBar.setItems(items as? [UIBarButtonItem], animated: false)
        
        updateToolBarItems()
        
    }
    
    //MARK: ToolBar Button Actoins
    @objc func peformRewindBarButton () {
        webView?.goBack()
    }
    
    @objc func peformStopBarButton () {
        webView?.stopLoading()
    }
    
    @objc func peformRefreshBarButton () {
        webView?.reload()
    }
    
    @objc func peformFastForwardBarButton () {
        webView?.goForward()
    }
    
   // MARK: Update ToolBar Items
    func updateToolBarItems () {
        
        barBtn_Rewind!.isEnabled = webView!.canGoBack
        barBtn_Stop!.isEnabled = webView!.isLoading
        barBtn_FastForward!.isEnabled = webView!.canGoForward

    }
    
    //MARK: WebView Delegate Functions
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        // starting the load, show the activity indicator in the status bar
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        updateToolBarItems ()
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // finished loading, hide the activity indicator in the status bar
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        updateToolBarItems ()

    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        // load error, hide the activity indicator in the status bar
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        updateToolBarItems ()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
