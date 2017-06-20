
//
//  HostViewController.swift
//  V2EXios
//
//  Created by 王浩 on 2017/6/20.
//  Copyright © 2017年 haowang. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result
import ReactiveSwift
class HotViewController: UIViewController {
    fileprivate lazy var viewModel : HotViewModel = {
        return HotViewModel()
    }()
    fileprivate lazy var cellIdentifier = "HotTopicsTableViewCell"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "最热主题"
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        // Do any additional setup after loading the view.
        observerSignal()
        viewModel.requestData()
    }
    func observerSignal(){
        viewModel.reloadSignal
            .observe(on: UIScheduler())
            .observeValues({
                [weak self] reload in
                reload ? self?.tableView.reloadData() : nil
            })
    }
}
extension HotViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellFor(tablView: tableView, indexpath: indexPath, WithIdentifier: cellIdentifier)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

