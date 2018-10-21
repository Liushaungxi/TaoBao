//
//  BasePopView.swift
//  AutoAlliance
//
//  Created by lyonse on 17/2/15.
//  Copyright © 2017年 lyonse. All rights reserved.
//

import UIKit
import SnapKit

class BasePopView:UIViewController {
    var showWindow:UIWindow!
    var coverView:UIView!
    var emptyView:UIView!
    var fatherView:UIView!
    func initMyViews() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        fatherView = UIView()
        fatherView.backgroundColor = UIColor.clear
        view.addSubview(fatherView)
        
        coverView = UIView()
        coverView.backgroundColor = UIColor.clear
        fatherView.addSubview(coverView)
        
        emptyView = UIView()
        emptyView.backgroundColor = UIColor.clear
        fatherView.addSubview(emptyView)
        
        fatherView.snp.makeConstraints { (make) in
            if #available(iOS 11, *), DeviceIsX() {
                make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
            } else {
                make.edges.equalToSuperview()
            }
        }
    }
    
    func showUp() -> Void {
        let window = UIWindow()
        window.backgroundColor = UIColor.clear
        window.windowLevel = UIWindow.Level.alert
        showWindow = window
        showWindow.rootViewController = self
        
        DispatchQueue.main.async {
            self.showWindow.makeKeyAndVisible()
        }

        
    }
    
    func showIn(_ tempView:UIView) {
        tempView.addSubview(view)
        view.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    @objc func hide() -> Void {
        guard showWindow != nil else {
            view.removeFromSuperview()
            return
        }
        DispatchQueue.main.async {
            self.showWindow?.windowLevel = UIWindow.Level.normal
            self.showWindow?.resignKey()
            if let hasWindow = UIApplication.shared.delegate?.window {
                hasWindow?.makeKeyAndVisible()
            }
            self.showWindow?.removeFromSuperview()
            self.showWindow = nil

        }
        
    }
    
    func addMyAnimateBottom() {
        var newCenter = coverView.center
        newCenter.y += coverView.bounds.height
        let positAnimate = CABasicAnimation(keyPath: "position")
        positAnimate.duration = 0.2
        positAnimate.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        positAnimate.fromValue = newCenter
        positAnimate.toValue = coverView.center
        coverView.layer.add(positAnimate, forKey: "positAnimateBottom")
    }
    
    func addMyAnimateRight() {
        var newCenter = coverView.center
        newCenter.x += coverView.bounds.width
        let positAnimate = CABasicAnimation(keyPath: "position")
        positAnimate.fromValue = newCenter
        positAnimate.toValue = coverView.center
        positAnimate.duration = 0.3
        coverView.layer.add(positAnimate, forKey: "positAnimateRight")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initMyViews()
        addGes()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initMyViews()
        addGes()
    }
    
    func addGes() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hide))
        emptyView.addGestureRecognizer(tap)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        hide()
    }
}
