//
//  VETabBarController.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/20.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit


//未启用
class VETabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.black
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor.white
        self.viewControllers = [addNavigaiItermController(vc: ViewRoute.HotVC)]
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
        navigationVc.navigationBar.tintColor = UIColor.white
        return navigationVc
    }

}
