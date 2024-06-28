//
//  WebViewBrowser.swift
//  MyAssignment
//
//  Created by pthakare on 27/06/24.
//

import UIKit
import WebKit

class WebViewBrowser : UIViewController, WKUIDelegate {
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet var webView: WKWebView!
    
    @IBOutlet var btnForward: UIBarButtonItem!
    @IBOutlet var btnBackward: UIBarButtonItem!
    @IBOutlet var btnStop: UIBarButtonItem!
    @IBOutlet var btnReload: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        webView.uiDelegate = self
    }
    
    private func setupWebView(){
        
        webView.allowsBackForwardNavigationGestures = true
       btnForward.isEnabled = false
//        btnBackward.isEnabled = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.addObserver(self, forKeyPath: "URL" , options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "canGoBack", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "canGoForward", options: .new, context: nil)
        
        loadWebview()
    }
    
    private func loadWebview(){
        
        guard let url = URL(string: Constants.webURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        self.webView.load(request)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "canGoBack" {
//            if self.webView.canGoBack{
//                self.btnBackward.isEnabled = true
//            }else{
//                self.btnBackward.isEnabled = false
//            }
        }
        if keyPath == "canGoForward" {
            if self.webView.canGoForward{
                self.btnForward.isEnabled = true
            }else{
                self.btnForward.isEnabled = false
            }
        }
    }
    
    @objc func dismissView(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
       dismissView()
    }
    
    @IBAction func goBackward(_ sender: UIBarButtonItem) {
        if self.webView.canGoBack {
            webView.goBack()
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        if self.webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func stopLoading(_ sender: UIBarButtonItem) {
        webView.isUserInteractionEnabled = true
        btnStop.isEnabled = false
        webView.stopLoading()
    }
    
    @IBAction func reloading(_ sender: UIBarButtonItem) {
        self.btnStop.isEnabled = true
        self.webView.reload()
    }
}

