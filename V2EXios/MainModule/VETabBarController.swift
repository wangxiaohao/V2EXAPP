//
//  VETabBarController.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/20.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit

class VETabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [addNavigaiItermController(vc: ViewRoute.hotVc)]
        let titles = ["热门","最新","我的"]
        let images = ["tabbar-tweet"]
        for (index,iterm) in (self.tabBar.items?.enumerated())!{
            iterm.title = titles[index]
            iterm.image = UIImage(named: images[index])?.withRenderingMode(.alwaysOriginal)
            iterm.selectedImage = UIImage(named: images[index] + "-selected")?.withRenderingMode(.alwaysOriginal)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNavigaiItermController(vc:UIViewController) -> UINavigationController {
        let navigationVc = UINavigationController(rootViewController: vc)
        return navigationVc
    }

}
