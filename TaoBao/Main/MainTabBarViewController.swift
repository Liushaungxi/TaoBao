//
//  MainTabBarViewController.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/11.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    let item1 = UITabBarItem(title: "首页", image: #imageLiteral(resourceName: "首页"), tag: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.red
        let vc1 = HomePageTableViewController()
        var nav1 = UINavigationController()
        nav1.navigationBar.isTranslucent = false
        nav1 = UINavigationController(rootViewController: vc1)
        nav1.tabBarItem = item1
        
        let vc2 = UIViewController()
        let nav2 = UINavigationController(rootViewController: vc2)
        let item2 = UITabBarItem(title: "微淘", image: #imageLiteral(resourceName: "首页"), tag: 1)
        nav2.tabBarItem = item2
        
        let vc3 = UIViewController()
        let nav3 = UINavigationController(rootViewController: vc3)
        let item3 = UITabBarItem(title: "消息", image: #imageLiteral(resourceName: "首页"), tag: 2)
        nav3.tabBarItem = item3
        
        let vc4 = UIViewController()
        let nav4 = UINavigationController(rootViewController: vc4)
        let item4 = UITabBarItem(title: "购物车", image: #imageLiteral(resourceName: "首页"), tag: 3)
        nav4.tabBarItem = item4
        
        let vc5 = UIViewController()
        let nav5 = UINavigationController(rootViewController: vc5)
        let item5 = UITabBarItem(title: "我的淘宝", image: #imageLiteral(resourceName: "首页"), tag: 4)
        nav5.tabBarItem = item5
        self.viewControllers = [nav1,nav2,nav3,nav4,nav5]
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == item1{
            mainVc.button.isHidden = false
        }else{
            mainVc.button.isHidden = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
