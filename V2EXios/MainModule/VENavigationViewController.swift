//
//  VENavigationViewController.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/23.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit

class VENavigationViewController: UINavigationController,NavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        customBarTintColorAndTitle()
        self.viewControllers = [ViewRoute.HotVC]
        self.navigationBar.tintColor = UIColor.white

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
