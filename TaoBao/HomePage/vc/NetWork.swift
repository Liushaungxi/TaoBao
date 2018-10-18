//
//  NetWork.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/15.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
class KfNewsCellData:handy{
    var newType1 = false //最新
    var title1 = ""
    var newType2 = false //最热
    var title2 = ""
    var img = Files()
}
class KfLunBoCellData:handy{
    var img = Files()
}
class KfNavigationCellData:handy{
    var img = Files()
    var name = ""
}
class Files:handy{
    var updatedAt:updatedAt?
    var createdAt:createdAt?
    var url = ""
    var key = ""
}
class createdAt:handy {
    var __type = ""
    var iso = ""
}
class updatedAt:handy {
    var __type = ""
    var iso = ""
}
class KfSnapCellData:handy{
    var supers = ""
    var title = ""
    var sbutitle = ""
    var smallImg = Files()
    var bigImg = Files()
}
class KfTitleCell:handy{
    var title = ""
    var titleImg = Files()
    var leftImg = Files()
    var leftText = ""
    var rightImg = Files()
    var rightText = ""
    var threeImg = Files()
    var threeText = ""
}
class KfLiveStreamingCellData:handy{
    var img = Files()
    var title = ""
    var subtitle = ""
}
class KfGoodStorCellData:handy{
    var img1 = Files()
    var img2 = Files()
    var img3 = Files()
    var title = ""
    var subtitle = ""
}
