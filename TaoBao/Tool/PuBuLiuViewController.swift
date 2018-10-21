//
//  PuBuLiuViewController.swift
//  TaoBao
//
//  Created by liushungxi on 2018/10/19.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
//使用
//let vc = PuBuLiuViewController(imgs: [UIImage(named: "a01")!,UIImage(named: "a02")!,UIImage(named: "a03")!,UIImage(named: "a01")!,UIImage(named: "a03")!,UIImage(named: "a02")!], queueNum: 2, viewHeight: 40, cell: HomePageYouLikeCollectionViewCell.self)
//let str = ["1","2","3","4","5","5","5"]
//vc.cell0 = {(cell,indexPath)in
//    let cells = cell.self as! HomePageYouLikeCollectionViewCell
//    cells.contentLabel.text = str[indexPath.row]
//}
class PuBuLiuViewController: UIViewController {
    var width: CGFloat!
    var images: Array<UIImage>!
    var collectionView:UICollectionView!
    var maskView: UIView!
    var cellRect: CGRect!
    var changeRect: CGRect!
    var didCellBlock:((IndexPath)->Void)?
    var cells:UICollectionViewCell.Type!
    var cell0:((UICollectionViewCell,IndexPath)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    init(imgs:[UIImage],queueNum: Int,viewHeight: CGFloat,cell:UICollectionViewCell.Type) {
        super.init(nibName: nil, bundle: nil)
        cells = cell
        waterfallCollectionView(imgs:imgs,queueNum: queueNum, viewHeight: viewHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //滑动隐藏导航栏
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.panGestureRecognizer.velocity(in: scrollView).y
        if y < -5{
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }else if y > 5{
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    private func waterfallCollectionView(imgs:[UIImage],queueNum:Int,viewHeight:CGFloat) {
        let layout = WaterCollectionViewLayout()
        layout.queueNum = queueNum
        layout.viewHeight = viewHeight
        images = imgs
        layout.setSize = {
            return self.images
        }
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.registerCell(cell: cells.self)
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
}
protocol UIcollectionViewCellReUse {}

extension UIcollectionViewCellReUse {
    static func reuseFrom(collectionView:UICollectionView, indexPath:IndexPath) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(self)", for: indexPath)
        return cell as! Self
    }
    
}
extension UICollectionViewCell:UIcollectionViewCellReUse {}

extension PuBuLiuViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK: --UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cells.reuseFrom(collectionView: collectionView, indexPath: indexPath)
        cell0?(cell,indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didCellBlock?(indexPath)
    }
}

class WaterCollectionViewLayout: UICollectionViewLayout {
    
    //来控制cell的大小
    var setSize:()->(Array<UIImage>) = { return []}
    //图片下面视图的高度
    var viewHeight:CGFloat = 0
    var queueNum: Int = 2 //列数，默认为两列
    var hs: Array<CGFloat>!
    private var totalNum: Int!
    private var layoutAttributes: Array<UICollectionViewLayoutAttributes>!
    override func prepare() {
        super.prepare()
        hs = []
        for _ in 0..<queueNum {
            hs.append(5)
        }
        totalNum = collectionView?.numberOfItems(inSection: 0)
        layoutAttributes = []
        var indexpath: NSIndexPath!
        for index in 0..<totalNum {
            indexpath = NSIndexPath(row: index, section: 0)
            let attributes = layoutAttributesForItem(at: indexpath as IndexPath)
            layoutAttributes.append(attributes!)
        }
    }
    private let gap:CGFloat = 5//间隔，缝隙大小
    private var width:CGFloat!
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        width = (collectionView!.bounds.size.width-gap*(CGFloat(queueNum)-1))/CGFloat(queueNum)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let sizes = setSize()
        attributes.size = CGSize(width: width, height: (sizes[indexPath.row].size.height*width/sizes[indexPath.row].size.width)+viewHeight)
        var nub:CGFloat = 0
        var h:CGFloat = 0
        (nub,h) = minH(hhs: hs)
        attributes.center = CGPoint(x:(nub+0.5)*(gap+width), y:h+(width/attributes.size.width*attributes.size.height+gap)/2)
        hs[Int(nub)] = h+width/attributes.size.width*attributes.size.height+gap
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }

    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: (collectionView?.bounds.width)!, height: maxH(hhs: hs))
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    
    private func minH(hhs:Array<CGFloat>)->(CGFloat,CGFloat){
        var num = 0
        var min = hhs[0]
        for i in 1..<hhs.count{
            if min>hhs[i] {
                min = hhs[i]
                num = i
            }
        }
        return (CGFloat(num),min)
    }
    func maxH(hhs:Array<CGFloat>)->CGFloat{
        var max = hhs[0]
        for i in 1..<hhs.count{
            if max<hhs[i] {
                max = hhs[i]
            }
        }
        return max
    }
}
class WaterButton: UIButton {
    
    var wImage:UIImage!{
        didSet{
            wImageView.image = wImage
        }
    }
    private var wImageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        wImageView = UIImageView(frame:bounds)
        addSubview(wImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        wImageView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
