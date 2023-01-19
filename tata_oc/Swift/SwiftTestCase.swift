//
//  SwiftTestCase.swift
//  tata_oc
//
//  Created by yongming on 2021/8/27.
//  Copyright © 2021 yongming. All rights reserved.
//

import UIKit
/// Swift测试用例
class TonglinVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var testCaseModels : NSArray = ["UI-个人页布局测试"]
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testCaseModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let name = testCaseModels[indexPath.row]
        cell?.textLabel?.text = name as? String
        return cell!
    }
    
    // MARK: - UITableViewDelegagte
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row) {
        case 0:
            let vc = YMProfileDemoViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("the default case")
        }
    }
    
    // MARK: - Life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.updateUI()
        animation2()
        animation1()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Private
    private func updateUI() {
        edgesForExtendedLayout = UIRectEdge.init()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(rightButtonDidClicked))
        addTestcaseEntrance()
    }
    
    @objc func rightButtonDidClicked() {
        let vc:TestVC = TestVC()
        vc.title = "测试VC转场"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addTestcaseEntrance() {
        let tableView = UITableView()
        tableView.backgroundColor = .lightGray
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.left.top()?.right()?.equalTo()(0)
            make?.height.equalTo()(200)
        }
    }
    
    // MARK: - Animation test
    func animation1() {

        let r = CAReplicatorLayer()
        r.bounds = CGRect(x:0.0, y:0.0, width:60.0, height: 60.0)
        r.position = view.center
        r.backgroundColor = UIColor.white.cgColor
        view.layer.addSublayer(r)
        
        let bar = CALayer()
        bar.bounds = CGRect(x:0, y:0, width: 8, height: 40)
        bar.position = CGPoint(x:10, y:75)
        bar.cornerRadius = 2
        bar.backgroundColor = UIColor.red.cgColor
        r.addSublayer(bar)
        
        let move = CABasicAnimation(keyPath: "position.y")
        move.toValue = bar.position.y - 35
        move.duration = 0.5
        move.autoreverses = true
        move.repeatCount =  Float.infinity
        bar.add(move, forKey: nil)
        
        r.instanceCount = 5
        r.instanceTransform = CATransform3DMakeTranslation(10, 0, 0)
        r.instanceDelay = 0.33
        r.masksToBounds = true
    }
    
    func animation2() {
        let r = CAReplicatorLayer()
        r.bounds = CGRect(x: 0,y: 0,width: 200,height: 200)
        r.cornerRadius = 10
        r.backgroundColor = UIColor(white: 0, alpha: 0.75).cgColor
        r.position = view.center
        view.layer.addSublayer(r)
        
        let dot = CALayer()
        dot.bounds = CGRect(x: 0, y: 0, width: 14, height: 14)
        dot.position = CGPoint(x: 100, y: 40)
        dot.backgroundColor = UIColor(white: 0.8, alpha: 1.0).cgColor
        dot.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        dot.borderWidth = 1
        dot.cornerRadius = 7
        r.addSublayer(dot)
        
        let nDot:Int = 15
        r.instanceCount = nDot
        let angle = CGFloat(2.0 * .pi) / CGFloat(nDot)
        r.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        let duration: CFTimeInterval = 1.5
        let shrink = CABasicAnimation(keyPath: "transform.scale")
        shrink.fromValue = 1
        shrink.toValue = 0.1
        shrink.duration = duration
        shrink.repeatCount = Float.infinity
        dot.add(shrink, forKey: nil)
        
        r.instanceDelay = duration / Double(nDot)
        dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
    }
    
    func animation3() {
        let r = CAReplicatorLayer()
        r.bounds = view.bounds
        r.backgroundColor = UIColor(white:0.0, alpha:0.75).cgColor
        r.position = view.center
        view.layer.addSublayer(r)
        
        let dot = CALayer()
        dot.bounds = CGRect(x:0.0, y:0.0, width:10.0, height:10.0)
        dot.backgroundColor = UIColor(white:0.8, alpha:1.0).cgColor
        dot.borderColor = UIColor(white:1.0, alpha:1.0).cgColor
        dot.borderWidth = 1.0
        dot.cornerRadius = 5.0
        dot.shouldRasterize = true
        dot.rasterizationScale = UIScreen.main.scale

        r.addSublayer(dot)
        
        let move = CAKeyframeAnimation(keyPath:"position")
        move.path = rw()
        move.repeatCount = Float.infinity
        move.duration = 4.0
        dot.add(move, forKey: nil)
        
        r.instanceCount = 20
        r.instanceDelay = 0.1
        r.instanceColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0).cgColor
        r.instanceGreenOffset = -0.03
    }
    
    func rw() -> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 31.5, y: 71.5))
        bezierPath.addLine(to: CGPoint(x: 31.5, y: 23.5))
        bezierPath.addCurve(to: CGPoint(x: 58.5, y: 38.5), controlPoint1: CGPoint(x: 31.5, y: 23.5), controlPoint2: CGPoint(x: 62.46, y: 18.69))
        bezierPath.addCurve(to: CGPoint(x: 53.5, y: 45.5), controlPoint1: CGPoint(x: 57.5, y: 43.5), controlPoint2: CGPoint(x: 53.5, y: 45.5))
        bezierPath.addLine(to: CGPoint(x: 43.5, y: 48.5))
        bezierPath.addLine(to: CGPoint(x: 53.5, y: 66.5))
        bezierPath.addLine(to: CGPoint(x: 62.5, y: 51.5))
        bezierPath.addLine(to: CGPoint(x: 70.5, y: 66.5))
        bezierPath.addLine(to: CGPoint(x: 86.5, y: 23.5))
        bezierPath.addLine(to: CGPoint(x: 86.5, y: 78.5))
        bezierPath.addLine(to: CGPoint(x: 31.5, y: 78.5))
        bezierPath.addLine(to: CGPoint(x: 31.5, y: 71.5))
        bezierPath.close()

        var t = CGAffineTransform(scaleX: 3.0, y: 3.0)
        return bezierPath.cgPath.copy(using: &t)!
    }
}
