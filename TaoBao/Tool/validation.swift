//
//  validation.swift
//  多线程
//
//  Created by liushungxi on 2018/8/16.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit

extension String{
    //1. 验证电话号码
    func isPhoneNumber()->Bool{
        let phone = "^((1[34578][0-9]{9})|((0\\d{2}-\\d{8})|(0\\d{3}-\\d{7,8})|(0\\d{10,11}))|(((400)-(\\d{3})-(\\d{4}))|((400)-(\\d{4})-(\\d{3}))|((400)-(\\d{5})-(\\d{2}))|(400\\d{7}))|(((800)-(\\d{3})-(\\d{4}))|((800)-(\\d{4})-(\\d{3}))|((800)-(\\d{5})-(\\d{2}))|(800\\d{7})))$"
        let refextePhone = NSPredicate(format:"SELF MATCHES %@", phone)
        if refextePhone.evaluate(with:self) == true{
            return true
        }
        return false
    }
    //2.移动电话
    func isMobilePhone()->Bool{
        let mobilePhone = "^((1[34578][0-9]{9})|((0\\d{2}-\\d{8})|(0\\d{3}-\\d{7,8})|(0\\d{10,11}))$"
        let refexMobilePhone = NSPredicate(format:"SELF MATCHES %@", mobilePhone)
        if refexMobilePhone.evaluate(with:self) == true{return true}
        return false
    }
    //  3.   车牌号验证
    func isValidCarNo() ->Bool{
        let carRegex = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
        let carTest = NSPredicate(format:"SELF MATCHES %@", carRegex)
        return carTest.evaluate(with:self)
    }
    
    
    
    //    4. 邮政编码
    func isValidPostalcode() ->Bool{
        let postalCodeRegex = "^[0-8]\\d{5}(?!\\d)$"
        let postalCodeTest = NSPredicate(format:"SELF MATCHES %@", postalCodeRegex)
        return postalCodeTest.evaluate(with:self)
        
    }
    
    //    5.价格
    func isPrice() ->Bool{
        let postalCodeRegex = "^\\d+(\\.\\d+)?$"
        let postalCodeTest = NSPredicate(format:"SELF MATCHES %@", postalCodeRegex)
        return postalCodeTest.evaluate(with:self)
    }
    
    //     6.数字和字母
    var isBarCode:Bool{
        let emailRegex = "^[A-Za-z0-9]+$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    //       7.数字
    var isNumber:Bool{
        let emailRegex = "^[0-9]*$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    //       7.数字和小数点
    var isNumberDian:Bool{
        let emailRegex = "^[0-9.]*$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    //    8.Email validation
    var isEmail:Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
        
    }
    
    //    9.验证密码是否符合规则 8-20位字符，必须包含字母和数字，字母区分大小写
    var isPwdConformRule:Bool{
        let match = "(^(?=.*[0-9])(?=.*[a-zA-Z])(.{8,20})$)"
        return NSPredicate(format: "SELF MATCHES %@", match).evaluate(with: self)
    }
    
    //    10. Email validation
//    var isPhoneNumbers:Bool{
//        let phoneRegex = "^((1[34578][0-9]{9})|((0\\d{2}-\\d{8})|(0\\d{3}-\\d{7,8})|(0\\d{10,11}))|(((400)-(\\d{3})-(\\d{4}))|((400)-(\\d{4})-(\\d{3}))|((400)-(\\d{5})-(\\d{2}))|(400\\d{7}))|(((800)-(\\d{3})-(\\d{4}))|((800)-(\\d{4})-(\\d{3}))|((800)-(\\d{5})-(\\d{2}))|(800\\d{7})))$"
//        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
////    }
    
    //    11.是否是汉字
    var isCarlisence:Bool{
        let carlisence = "^([\\u4e00-\\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{5})$"
        return NSPredicate(format: "SELF MATCHES %@", carlisence).evaluate(with: self)
    }
    
    //    12.中文判断
    var isNickName:Bool{
        let nickNameReg = "^([\\u4E00-\\u9FA5]{2,30}$)"
        return NSPredicate(format: "SELF MATCHES %@",nickNameReg).evaluate(with: self)
    }
    
    //13.名字(汉字字母数字)
    var isName:Bool{
        let nameReg = "^([\\u4E00-\\u9FA5A-Za-z0-9_]{2,10}$)"
        return NSPredicate(format: "SELF MATCHES %@",nameReg).evaluate(with: self)
    }
    
    //    14.是否存在特殊字符
    var isHaveSpecialCharacter:Bool{
        let nameReg = "^([\\u4E00-\\u9FA5A-Za-z0-9]*$)"
        return NSPredicate(format: "SELF MATCHES %@",nameReg).evaluate(with: self)
    }
    
    //    15.验证是否有非字母和数字之外的字符
    var isTaxNumber:Bool{
        let taxNumber = "^[A-Za-z0-9]+$"
        return NSPredicate(format: "SELF MATCHES %@", taxNumber).evaluate(with: self)
    }
    
    //    16.验证是否有非字母数字下划线@之外的字符
    var isEmailCharacter:Bool{
        let taxNumber = "^[a-zA-Z0-9_@.]*$"
        return NSPredicate(format: "SELF MATCHES %@", taxNumber).evaluate(with: self)
    }
    
    //    19.价格
//    func isPrice() ->Bool{
//        let price = "^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))|(\\.[0-9]+)|[0-9]*[1-9][0-9]*\\.$"
//        return NSPredicate(format: "SELF MATCHES %@", price).evaluate(with: self)
//    }
    
    //    20.身份证号
    func isIDCardNum() ->Bool{
        let idCard = "(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$)"
        return NSPredicate(format: "SELF MATCHES %@", idCard).evaluate(with: self)
    }
}





