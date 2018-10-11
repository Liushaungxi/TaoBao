//
//  BaseTextView.swift
//  KneeRehabilitation
//
//  Created by lyonse on 2018/5/4.
//  Copyright © 2018年 lyonse. All rights reserved.
//

import UIKit

class BaseTextView: UITextView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addSubview(placeHolderLabel)
        font = UIFont.systemFont(ofSize: 14)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(placeHolderLabel)
        font = UIFont.systemFont(ofSize: 14)
    }
    
    var placeHolderLabel = UILabel()
    
    @IBInspectable var placeholder:String = "请输入..."//@IBInspectable 属性必须指名类型:String, 不然sb中不显示
    func config() {
        placeHolderLabel.font = font
        placeHolderLabel.text = placeholder
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.sizeToFit()
        setValue(placeHolderLabel, forKey: "_placeholderLabel")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        config()
    }
}
