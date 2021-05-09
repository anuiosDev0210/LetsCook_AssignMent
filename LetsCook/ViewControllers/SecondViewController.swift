//
//  SecondViewController.swift
//  LetsCook
//
//  Created by Anu Agrawal on 5/9/21.
//

import UIKit
import WebKit

class SecondViewController: UIViewController, WKNavigationDelegate {

    var url:URL?
    var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    //MARK:- WebView
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
   
}
