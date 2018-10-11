//
//  CycleADView.swift
//  CycleADView
//
//  Created by lyonse on 16/12/27.
//  Copyright © 2016年 lyonse. All rights reserved.
//

import UIKit
@objc protocol CycleADViewDelegate:NSObjectProtocol {
    func cycleADViewImageNumber() -> Int
    func cycleADView(imageIndex:Int,_ imageView:UIImageView)
    @objc optional func cycleADView(imageTitleIndex:Int) -> String?
    @objc optional func cycleADView(imageClickedIndex:Int)
}

class LCycleADView: UIView,UIScrollViewDelegate {

    private let mainScrollView = UIScrollView()
    private let leftImageView = UIImageView()
    private let centerImageView = UIImageView()
    private let rightImageView = UIImageView()
    
    private let titleLable = UILabel()
    private let pageIndicator = UIPageControl()
    
    private var currentIndex = 0 {
        willSet {
            pageIndicator.currentPage = newValue
        }
    }
    private var numberOfImage = 0 {
        willSet {
            pageIndicator.numberOfPages = newValue
        }
    }
    var scrollTimeInterval:TimeInterval = 3
    var shouldAutoScroll:Bool = true
    weak var cycleDelegate:CycleADViewDelegate?
    private weak var scrollTimer:Timer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseConfig()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseConfig()
    }
    
    private func baseConfig() {
        addSubview(mainScrollView)
        mainScrollView.backgroundColor = UIColor.white
        mainScrollView.addSubview(leftImageView)
        mainScrollView.addSubview(centerImageView)
        mainScrollView.addSubview(rightImageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.clickedAction))
        centerImageView.isUserInteractionEnabled = true
        centerImageView.addGestureRecognizer(tap)
        
        mainScrollView.isPagingEnabled = true
        mainScrollView.bounces = false
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.isDirectionalLockEnabled = true
        
        mainScrollView.delegate = self
        
        addSubview(titleLable)
        addSubview(pageIndicator)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainScrollView.frame = bounds
        mainScrollView.contentSize.width = bounds.width * 3
        mainScrollView.contentSize.height = bounds.height
        
        leftImageView.frame = bounds
        centerImageView.frame = bounds
        rightImageView.frame = bounds
        
        centerImageView.frame.origin.x = bounds.width
        rightImageView.frame.origin.x = bounds.width * 2
        
        mainScrollView.contentOffset.x = bounds.width
        mainScrollView.contentOffset.y = 0
        mainScrollView.contentInset = UIEdgeInsets.zero
        
        pageIndicator.frame = bounds
        pageIndicator.frame.size.height = 10
        pageIndicator.pageIndicatorTintColor = UIColor.lightGray
        pageIndicator.currentPageIndicatorTintColor = UIColor.white
        
        titleLable.frame = bounds
        titleLable.frame.origin.y = bounds.height - 20
        titleLable.frame.size.height = 20
        titleLable.backgroundColor = UIColor(white: 0, alpha: 0.3)
        titleLable.textColor = UIColor.white
        titleLable.textAlignment = NSTextAlignment.center
        titleLable.font = UIFont.systemFont(ofSize: 14)
        titleLable.isHidden = true
        
        firstConfig()
        if shouldAutoScroll {
            start()
        }
    }
    
    private func firstConfig() {
        if scrollTimer != nil {
            scrollTimer.invalidate()
        }
        
        mainScrollView.contentOffset.x = bounds.width
        mainScrollView.contentOffset.y = 0
        currentIndex = 0
        numberOfImage = 0
        
        mainScrollView.isScrollEnabled = false
        centerImageView.isUserInteractionEnabled = false
        centerImageView.image = nil
        titleLable.isHidden = true
    }
    
    func start() {
        if delayItem != nil {
            delayItem.cancel()
        }
        if scrollTimer != nil {
            scrollTimer.invalidate()
        }
        if cycleDelegate == nil {
            return
        }
        numberOfImage = cycleDelegate!.cycleADViewImageNumber()
        if numberOfImage > 0 {
            mainScrollView.isScrollEnabled = true
            centerImageView.isUserInteractionEnabled = true
            titleLable.isHidden = false
            delayItem = DispatchWorkItem(block: { [weak self] in
                self?.scrollTimer.fireDate = NSDate.distantPast
            })
            setContent()
            startAutoScroll()
        }
    }
    
    @objc func clickedAction() {
        cycleDelegate?.cycleADView?(imageClickedIndex: currentIndex)
    }
    
    private func getLeftNumber(indexNow:Int) -> Int {
        return indexNow - 1 < 0 ? numberOfImage - 1 : indexNow - 1
    }
    
    private func getRightNumber(indexNow:Int) -> Int {
        return indexNow + 1 >= numberOfImage ? 0 : indexNow + 1
    }
    private func setContent() {
        setImages()
        setImageTitle()
    }
    
    private func setImages() {
        cycleDelegate?.cycleADView(imageIndex: currentIndex, centerImageView)
        cycleDelegate?.cycleADView(imageIndex: getLeftNumber(indexNow: currentIndex), leftImageView)
        cycleDelegate?.cycleADView(imageIndex: getRightNumber(indexNow: currentIndex), rightImageView)
    }
    
    private func setImageTitle() {
        titleLable.text = cycleDelegate?.cycleADView?(imageTitleIndex: currentIndex)
    }
    
    private func moveToCenter() {
        let newNum = cycleDelegate?.cycleADViewImageNumber() ?? 0
        if newNum != numberOfImage {
            start()
            return
        }
        if mainScrollView.contentOffset.x == bounds.width * 2 {
            currentIndex = getRightNumber(indexNow: currentIndex)
        }
        else if mainScrollView.contentOffset.x == 0 {
            currentIndex = getLeftNumber(indexNow: currentIndex)
        }
        mainScrollView.contentOffset.x = bounds.width
        mainScrollView.contentOffset.y = 0
        
        setContent()
    }
    
    private func moveToRight() {
//        let point = CGPoint(x: bounds.width * 2, y: 0)
//        mainScrollView.setContentOffset(point, animated: false)// 影响page点的动画显示
        UIView.animate(withDuration: 0.3, animations: {
            self.mainScrollView.contentOffset.x = self.bounds.width * 2
            self.mainScrollView.contentOffset.y = 0
        })
    }
    
    private func startAutoScroll() {
        scrollTimer = Timer.scheduledTimer(timeInterval: scrollTimeInterval, target: self, selector: #selector(self.scrollAction), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAction() {
        if self.superview == nil || self.cycleDelegate == nil {
            self.scrollTimer.invalidate()
            return
        }
        self.moveToRight()
        self.moveToCenter()
    }
    
    deinit {
        print("cycleview dead!")
    }
    
    private var delayItem:DispatchWorkItem!
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        moveToCenter()
        delayItem = DispatchWorkItem(block: { [weak self] in
            self?.scrollTimer.fireDate = NSDate.distantPast
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + scrollTimeInterval, execute: delayItem)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delayItem.cancel()
        scrollTimer.fireDate = NSDate.distantFuture
    }
}
