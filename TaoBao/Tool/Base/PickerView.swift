//
//  PickerView.swift
//  SchoolWorkers
//
//  Created by wcp on 17/8/8.
//  Copyright © 2017年 wcp. All rights reserved.
//

import UIKit

class PickerView:  BasePopView {
    
    var pickerView :UIPickerView!
    var button:UIButton!
    var cancelButton:UIButton!
    var data:Array<(String, String)> = []
    var dataBlock:((String, String) ->Void )?
    override func initMyViews() {
        super.initMyViews()
        
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        coverView.addSubview(pickerView)
        
        button = UIButton(type: .custom)
        button.setTitle("确定",for:.normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action:#selector(self.getPickerViewValue),
                         for: .touchUpInside)
        coverView.addSubview(button)
        
        cancelButton = UIButton(type: .custom)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.addTarget(self, action: #selector(self.hide), for: .touchUpInside)
        coverView.addSubview(cancelButton)
        coverView.backgroundColor = UIColor.white
        addMyLayout()
        
    }
    func addMyLayout()
    {
        pickerView.snp.makeConstraints{ (maker) in
            maker.top.equalToSuperview()
            maker.right.equalToSuperview()
            maker.left.equalToSuperview()
            maker.height.equalTo(180)
        }
        button.snp.makeConstraints{ (maker) in
            maker.bottom.equalToSuperview()
            maker.right.equalToSuperview()
            maker.left.equalTo(cancelButton.snp.right)
            maker.top.equalTo(pickerView.snp.bottom)
            maker.width.equalTo(cancelButton.snp.width)
            maker.height.equalTo(45)
        }
        cancelButton.snp.makeConstraints{ (maker) in
            maker.bottom.equalToSuperview()
            maker.left.equalToSuperview()
            maker.top.equalTo(pickerView.snp.bottom)
            maker.height.equalTo(45)
        }
        coverView.snp.makeConstraints { (maker) in
            maker.right.left.bottom.equalToSuperview()
            maker.top.equalTo(emptyView.snp.bottom)
        }
        emptyView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addMyAnimateBottom()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
}
extension PickerView:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return data[row].1
    }
    
    @objc func getPickerViewValue(){
        let message = data[pickerView.selectedRow(inComponent: 0)]
        dataBlock?(message.0, message.1)
        self.hide()
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}
