//
//  YMProfileDemoViewController.swift
//  tata_oc
//
//  Created by yongming on 2021/10/20.
//  Copyright © 2021 yongming. All rights reserved.
//

import UIKit

class YMProfileHeaderCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let home = UIView()
        home.backgroundColor = .green
        contentView.addSubview(home)
        home.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.edges.equalTo()(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class YMProfileDemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    
    deinit {
        print("profile deinit...")
    }
    

    // MARK: - Private
    func updateUI() {
        title = "个人页测试"
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        
        let home = UIView()
        home.backgroundColor = .red
        view.addSubview(home)
        home.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.top().right().equalTo()(0)
            make?.height.equalTo()(200)
        }
        
        let t = UITableView(frame: .zero, style: .plain)
        t.dataSource = self
        t.delegate = self
        t.backgroundColor = .blue
        t.register(YMProfileHeaderCell.self, forCellReuseIdentifier: "header")
        t.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(t)
        t.mas_makeConstraints { (make : MASConstraintMaker?) in
            make?.edges.equalTo()(view)
        }
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 200
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        let cellname = (indexPath.section == 0) ? "header" : "cell"
        cell = tableView.dequeueReusableCell(withIdentifier: cellname)
        
        cell?.textLabel?.text = String(format: "item%d", indexPath.row+1)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 1) {
            return "main header"
        }
        return ""
    }
}
