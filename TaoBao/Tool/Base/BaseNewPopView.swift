//
//  BasePopView.swift
//  AutoAlliance
//
//  Created by lyonse on 17/2/15.
//  Copyright © 2017年 lyonse. All rights reserved.
//

import UIKit
import SnapKit

class BaseNewPopView:UIViewController {
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
    
    enum ScrollInDirectionEnum {
        case left
        case right
        case top
        case bottom
    }
    var scrollInDirection = ScrollInDirectionEnum.bottom
    var enableScrollAnimate = true
    func addMyAnimate() {
        var newCenter = coverView.center
        
        switch scrollInDirection {
        case .bottom:
            newCenter.y += coverView.bounds.height
        case .top:
            newCenter.y -= coverView.bounds.height
        case .left:
            newCenter.x -= coverView.bounds.width
        case .right:
            newCenter.x += coverView.bounds.width
        }
        
        let positAnimate = CABasicAnimation(keyPath: "position")
        positAnimate.duration = 0.2
        positAnimate.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        positAnimate.fromValue = newCenter
        positAnimate.toValue = coverView.center
        coverView.layer.add(positAnimate, forKey: "positAnimate")
    }
    
    var contentPercent = 0.8 {
        didSet {
            setContent()
        }
    }
    var contentBaseOn = false {
        didSet {
            setContent()
        }
    }
    func setContent() {
        coverView.snp.removeConstraints()
        emptyView.snp.removeConstraints()
        switch scrollInDirection {
        case .bottom:
            coverView.snp.makeConstraints({ (make) in
                make.left.bottom.right.equalToSuperview()
                if contentBaseOn {
                    make.top.equalTo(emptyView.snp.bottom)
                    return
                }
                make.height.equalToSuperview().multipliedBy(contentPercent)
            })
            emptyView.snp.makeConstraints({ (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(1 - contentPercent)
            })
        case .top:
            coverView.snp.makeConstraints({ (make) in
                make.left.top.right.equalToSuperview()
                if contentBaseOn {
                    make.bottom.equalTo(emptyView.snp.top)
                    return
                }
                make.height.equalToSuperview().multipliedBy(contentPercent)
            })
            emptyView.snp.makeConstraints({ (make) in
                make.left.right.bottom.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(1 - contentPercent)
            })
        case .left:
            coverView.snp.makeConstraints({ (make) in
                make.left.top.bottom.equalToSuperview()
                if contentBaseOn {
                    make.right.equalTo(emptyView.snp.left)
                    return
                }
                make.width.equalToSuperview().multipliedBy(contentPercent)
            })
            emptyView.snp.makeConstraints({ (make) in
                make.top.right.bottom.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(1 - contentPercent)
            })
        case .right:
            coverView.snp.makeConstraints({ (make) in
                make.right.top.bottom.equalToSuperview()
                if contentBaseOn {
                    make.left.equalTo(emptyView.snp.right)
                    return
                }
                make.width.equalToSuperview().multipliedBy(contentPercent)
            })
            emptyView.snp.makeConstraints({ (make) in
                make.top.left.bottom.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(1 - contentPercent)
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMyViews()
        addGes()
        setContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if enableScrollAnimate {
            addMyAnimate()
        }
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
