//
//  MBProgressHUDExtension.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/21.
//  Copyright © 2017年 haowang. All rights reserved.
//

import Foundation

import MBProgressHUD
extension MBProgressHUD {
    
    class func showMessagetoView(_ message:String) {
        let view  = UIApplication.shared.windows.last
        
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.labelText = message
        
        hud?.removeFromSuperViewOnHide = true
        hud?.dimBackground = true
    }
    
    
    class func hideHUDForView(_ view : UIView) {
        
        self.hide(for: view, animated: false)
    }
    
    class func hideHUD() {
        let view  = UIApplication.shared.windows.last
        
        self.hideHUDForView(view!)
    }
    
    
    
    class func showLoading() {
        MBProgressHUD.showloadingWithText(text: nil)
    }
    
    class func showloadingWithText(text:String?){
        let view  = UIApplication.shared.windows.last
        let hud  = MBProgressHUD.showAdded(to: view, animated: true )
        hud?.labelText = text
        hud?.isUserInteractionEnabled = false
        hud?.mode = MBProgressHUDMode.indeterminate
        hud?.removeFromSuperViewOnHide = true
    }
    //显示异常
    class func showText(_ text : String) {
        
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        lable.numberOfLines = 2
        lable.text = text
        lable.textColor = UIColor.white
        lable.textAlignment = .center
        lable.lineBreakMode = .byWordWrapping
        lable.font = UIFont.systemFont(ofSize: 14)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 14),NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        let lableSixe =  (text as NSString).boundingRect(with: CGSize.init(width: 250, height: 999), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
        
        lable.frame = CGRect(x: 0, y: 0, width: lableSixe.width, height: lableSixe.height)
        let view  = UIApplication.shared.windows.last
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        
        hud?.removeFromSuperViewOnHide = true
        hud?.mode = MBProgressHUDMode.customView
        hud?.customView = lable
        hud?.hide(true, afterDelay: 1.5)
    }
    
}
