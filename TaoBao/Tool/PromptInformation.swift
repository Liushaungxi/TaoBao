//
//  PromptInformation.swift
//  KOA
//
//  Created by liushungxi on 2018/7/20.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
import PKHUD
func successInformation(_ complete:(()->Void)?=nil) {
    DispatchQueue.main.async {
        HUD.flash(.success, delay: 0.5)
        complete != nil ? delay(0.5, closure: complete!) : ()
    }
}
func errorInformaton(_ msg:String?,_ complete:(()->Void)?=nil) {
    DispatchQueue.main.async {
        HUD.show(.label(msg))
        HUD.hide(afterDelay: 1)
        complete != nil ? delay(1, closure: complete!) : ()
    }
}
func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
