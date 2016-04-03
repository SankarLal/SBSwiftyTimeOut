



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
        self.view.backgroundColor = UIColor.whiteColor();
        self.navigationItem.hidesBackButton = true
        
        setUpUserInterface()
    }
    
    //MARK: SetUp User Interface
    func setUpUserInterface () {
        
        webView = UIWebView (frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44))
        webView!.delegate = self
        webView!.loadRequest(NSURLRequest(URL: NSURL(string: "https://github.com/SankarLal?tab=repositories")!))
        self.view.addSubview(webView!)
        
        
        let toolBar : UIToolbar = UIToolbar (frame: CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44))
        self.view.addSubview(toolBar)
        
        let flexiableItem : UIBarButtonItem = UIBarButtonItem (barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        barBtn_Rewind = UIBarButtonItem (image: UIImage(named: "Back"), style : UIBarButtonItemStyle.Plain, target: self, action:"peformRewindBarButton")
        
        barBtn_Stop = UIBarButtonItem (barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "peformStopBarButton")
        
        let barBtn_Refresh : UIBarButtonItem = UIBarButtonItem (barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "peformRefreshBarButton")
        
        barBtn_FastForward = UIBarButtonItem (image: UIImage(named: "Forward"), style : UIBarButtonItemStyle.Plain, target: self, action:"peformFastForwardBarButton")
        
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
    func peformRewindBarButton () {
        webView?.goBack()
    }
    
    func peformStopBarButton () {
        webView?.stopLoading()
    }
    
    func peformRefreshBarButton () {
        webView?.reload()
    }
    
    func peformFastForwardBarButton () {
        webView?.goForward()
    }
    
   // MARK: Update ToolBar Items
    func updateToolBarItems () {
        
        barBtn_Rewind!.enabled = webView!.canGoBack
        barBtn_Stop!.enabled = webView!.loading
        barBtn_FastForward!.enabled = webView!.canGoForward

    }
    
    //MARK: WebView Delegate Functions
    func webViewDidStartLoad(webView: UIWebView) {
        
        // starting the load, show the activity indicator in the status bar
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        updateToolBarItems ()
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // finished loading, hide the activity indicator in the status bar
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        updateToolBarItems ()

    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        // load error, hide the activity indicator in the status bar
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        updateToolBarItems ()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
