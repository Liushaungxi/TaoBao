//
//  MainViewController.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/11.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
var mainScreen_wight = UIScreen.main.bounds.width
var mainScreen_height = UIScreen.main.bounds.height
class MainViewController: UIViewController {

    let button = UIButton(type: .custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        addMyChidVc(MainTabBarViewController(), box: view)
        button.adjustsImageWhenHighlighted = false
        button.setImage(#imageLiteral(resourceName: "taobao"), for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalToSuperview()
            }
            make.width.equalTo(mainScreen_wight/5)
            make.height.equalTo(45)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
