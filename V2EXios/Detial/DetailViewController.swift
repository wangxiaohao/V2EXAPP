//
//  DetailViewController.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/21.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
class DetailViewController: UIViewController,NavigationDelegate {
    fileprivate var viewModel : DetailViewModel
    fileprivate var tableView : UITableView
    init(WithViewModel:DetailViewModel) {
        self.viewModel = WithViewModel
        self.tableView = UITableView(frame: CGRect(x:0,y:0,width:SCREEN_WIDH,height:SCREEN_HEIGHT), style: .plain)
        
        super.init(nibName: nil , bundle: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        self.view.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        setTableViewHeder()
        customBarTintColorAndTitle()
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setTableViewHeder(){
        let view = DetailHeaderView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDH, height: 100))
        
        view.model = viewModel.model
        self.tableView.tableHeaderView = view
        
        view.hetightSignal
            .observe(on: UIScheduler())
            .observeValues {
                [weak self] height in
                let view = self?.tableView.tableHeaderView
                view?.frame.size.height = height
                self?.tableView.beginUpdates()
                self?.tableView.tableHeaderView = view
                self?.tableView.endUpdates()
        }
    }
}
extension DetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
      return UITableViewCell()
    }
}
