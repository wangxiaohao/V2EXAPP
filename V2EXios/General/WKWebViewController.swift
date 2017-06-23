//
//  WKWebViewController.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/21.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit
import WebKit
class WKWebViewController: UIViewController {
    var wkview : WKWebView!
    fileprivate let viewModel : WKViewModel
     var progressView : UIProgressView!
    
    init(WithViewModel : WKViewModel) {
        self.viewModel = WithViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        addSubView()
        self.wkview.load(viewModel.request)
        
        // Do any additional setup after loading the view.
    }
    func addSubView(){
       let progressView = UIProgressView(progressViewStyle: .default)
        progressView.frame =  CGRect(x: 0, y: 0, width: SCREEN_WIDH, height: 2)
        progressView.progress = 0.1
        self.view.addSubview(progressView)
        self.progressView = progressView
        
        wkview = WKWebView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDH, height: SCREEN_HEIGHT - 44))
        self.view.insertSubview(wkview, belowSubview: progressView)
        wkview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        let toolBar = WKToolBar(frame: CGRect(x: 0, y: SCREEN_HEIGHT -  44 - 44 , width: SCREEN_WIDH, height: 44))
        self.view.addSubview(toolBar)
        toolBar.isHidden = viewModel.isHidden
        toolBar.butSinal.observeValues({
           [weak self]  type in
            switch type {
            case .goAhead:
               _ =  (self?.wkview.canGoForward)! ? self?.wkview.goForward() : nil
                
            case .goBack:
                 _ = (self?.wkview.canGoBack)! ? self?.wkview.goBack() : nil
            case .reload:
               _ =  self?.wkview.reload()

            }
        })

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            self.progressView.alpha = 1.0
            self.progressView.setProgress(Float(self.wkview.estimatedProgress), animated: true)
            if self.wkview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0.0
                }, completion: { finished in
                    self.progressView.progress = 0.0
                })
            }
        }
        
    }
    deinit {
        self.wkview.removeObserver(self, forKeyPath: "estimatedProgress")
        self.wkview.navigationDelegate = nil
        self.wkview.uiDelegate = nil
    }
}
extension WKWebViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
}
