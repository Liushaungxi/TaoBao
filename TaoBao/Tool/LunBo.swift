//
//  LunBo.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/11.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit

class LunBo: UIView,UIScrollViewDelegate {

    var scrollView = UIScrollView()
    var images = [#imageLiteral(resourceName: "a01"),#imageLiteral(resourceName: "a02"),#imageLiteral(resourceName: "a03"),#imageLiteral(resourceName: "a02")]
    let imageView1 = UIImageView()
    let imageView2 = UIImageView()
    let imageView3 = UIImageView()
    var index = 0
    let mainWight = UIScreen.main.bounds.width
    let liView = UIView()
    var hight:CGFloat = 250
    var buttons = [UIButton]()
    let buttonsView = UIView()
    var buttonIndex = 0
    func initView(tempHight:CGFloat){
        hight = tempHight
        index = images.count * 2
        
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.height.equalTo(hight)
            make.width.equalTo(mainWight)
        }
        liView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        
        scrollView.delegate = self
        scrollView.addSubview(imageView1)
        scrollView.addSubview(imageView2)
        scrollView.addSubview(imageView3)
        imageView1.frame = CGRect(x: 0, y: 0, width: mainWight, height: hight)
        imageView2.frame = CGRect(x: mainWight * 1, y: 0, width: mainWight, height: hight)
        imageView3.frame = CGRect(x: mainWight * 2, y: 0, width: mainWight, height: hight)
        
        scrollView.contentSize = CGSize(width: mainWight * CGFloat(images.count), height: hight)
        scrollView.isPagingEnabled = true
        scrollView.contentOffset.x = mainWight
        
        self.addSubview(liView)
        liView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(hight-30)
            make.width.equalTo(mainWight)
            make.height.equalTo(30)
        }
        for index in 0..<images.count {
            let tempButton = UIButton(type: .custom)
            tempButton.backgroundColor = UIColor.white
            tempButton.tag = index + 1
            tempButton.addTarget(self, action: #selector(clickButton(_ :)), for: UIControlEvents.touchUpInside)
            tempButton.layer.cornerRadius = 5
            buttons.append(tempButton)
        }
        liView.addSubview(buttonsView)
        buttonsView.snp.makeConstraints { (make) in
            make.height.equalTo(10)
            make.width.equalTo(20*buttons.count)
            make.center.equalTo(liView)
            //            make.left.top.equalToSuperview()
        }
        for (index,button) in buttons.enumerated() {
            buttonsView.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.width.height.equalTo(10)
                make.top.equalToSuperview()
                make.left.equalTo(20*index)
            }
        }
        
        imageChange()
        lunBoTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.current.add(lunBoTimer, forMode: .commonModes)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    @objc func clickButton(_ sender:UIButton){
        buttonIndex = sender.tag - 1
        index = buttonIndex + images.count
        
        imageChange()
    }
    func imageChange() {
        if scrollView.contentOffset.x > mainWight{
            index += 1
            buttonIndex += 1
            if buttonIndex == images.count{
                buttonIndex = 0
            }
        }
        else if scrollView.contentOffset.x < mainWight{
            if index == images.count{
                index = images.count * 2
            }
            index -= 1
            buttonIndex -= 1
            if buttonIndex == -1{
                buttonIndex = images.count - 1
            }
        }
        imageView1.image = images[(index - 1)%images.count]
        imageView2.image = images[index%images.count]
        imageView3.image = images[(index + 1)%images.count]
        for button in buttons {
            button.backgroundColor = UIColor.white
        }
        buttons[buttonIndex].backgroundColor = UIColor.red
        scrollView.contentOffset.x = mainWight
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        imageChange()
        lunBoTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.current.add(lunBoTimer, forMode: .commonModes)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let queue = DispatchQueue(label: "timeQueue")
    var lunBoTimer = Timer()
    @objc func timerAction(){
        UIView.animate(withDuration: 0.5) {
            self.scrollView.contentOffset.x = self.mainWight*2
        }
        imageChange()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lunBoTimer.invalidate()
    }
    deinit {
        lunBoTimer.invalidate()
    }
}
