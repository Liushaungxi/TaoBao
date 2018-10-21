//
//  BaseBottomButtonViewController.swift
//  KOA
//
//  Created by liushungxi on 2018/8/6.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit

class BaseBottomButtonViewController: UIViewController {

    let viewBox = UIView()
    let bottonButton = UIButton(type: UIButton.ButtonType.custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bottonButton)
        bottonButton.backgroundColor = UIColor.white
        bottonButton.layer.borderWidth = 1
        bottonButton.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        bottonButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        self.view.addSubview(viewBox)
        viewBox.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(bottonButton.snp.top)
        }
        bottonButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        
    }
    @objc func clickButton(){
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
