//
//  GlobalVariable.swift
//  注册
//
//  Created by liushungxi on 2018/7/17.
//  Copyright © 2018年 liushungxi. All rights reserved.
//

import UIKit
import MJRefresh
import AVFoundation
import DZNEmptyDataSet
import SwiftyUserDefaults
import Alamofire
import IQKeyboardManager
import HandyJSON
class handy: NSObject,HandyJSON {
    required override init(){}
}
//注册cell
extension UITableView{
    func registerCell(cell:UITableViewCell.Type){
        let nib = UINib.init(nibName: "\(cell)", bundle: nil)
        self.register(nib, forCellReuseIdentifier: "\(cell)")
    }
}
//注册cell
extension UICollectionView{
    func registerCell(cell:UICollectionViewCell.Type){
        let nib = UINib.init(nibName: "\(cell)", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: "\(cell)")
    }
}
//字典为空不append
extension Dictionary{
    mutating func upDataNotValue(_ value: Value?, forKey:Key){
        if value == nil{
            return
        }
        updateValue(value!, forKey: forKey)
    }
}
//通过kf用String下载图片
extension String{
    func url() -> URL {
        let temp = "http://192.168.1.220:8080" + self
        return URL.init(string: temp)!
    }
}
let color = UIColor.init(red: 23/255, green: 191/255, blue: 147/255, alpha: 1)
//今天的时间
func todayTime() -> Int{
    let now = NSDate()
    let timeInterval:TimeInterval = now.timeIntervalSince1970
    let timeStamp = Int(timeInterval)
    return timeStamp
}
//把图片转化为Data,并压缩
extension UIImage{
    var JPGData:Data{
        let newImage = UIImage(cgImage: self.cgImage!)
        let data:Data = UIImageJPEGRepresentation(newImage, 0.7)!
        return data
    }
}
extension Double{
    //保留小数
    var reserve1f:String{
        return String(format: "%.1f", self)
    }
    var reserve2f:String{
        return String(format: "%.2f", self)
    }
    var reserve3f:String{
        return String(format: "%.3f", self)
    }
    var reserve4f:String{
        return String(format: "%.4f", self)
    }
}
extension Int64{
    var mothDay:String{
        let timeSta:TimeInterval = TimeInterval(Int(self) / 1000)
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="MM-dd"
        return dfmatter.string(from: date as Date)
    }
}
extension String{
    //把时间戳转化为年月日
    var time:String{
        let timeSta:TimeInterval = TimeInterval(Int(self)! / 1000)
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy年MM月dd日"
        return dfmatter.string(from: date as Date)
    }
    var YMDHMS:String{
        let timeSta:TimeInterval = TimeInterval(Int(self)! / 1000)
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }
    //把时间戳转化为月日
    var mothDay:String{
        let timeSta:TimeInterval = TimeInterval(Int(self)! / 1000)
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="MM-dd"
        return dfmatter.string(from: date as Date)
    }
    //把时间戳转化为距今周/日/小时
    var weeksAgo:String{
        let currentTime = Date().timeIntervalSince1970
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(Int(self)! / 1000)
        //时间差
        let reduceTime : TimeInterval = currentTime - timeSta
        let temp = Double(reduceTime/60/60/24/7)
        return temp.reserve1f
    }
    var daysAgo:String{
        let currentTime = Date().timeIntervalSince1970
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(Int(self)! / 1000)
        //时间差
        let reduceTime : TimeInterval = currentTime - timeSta
        let temp = Double(reduceTime/60/60/24)
        return temp.reserve1f
    }
    var hoursAgo:String{
        let currentTime = Date().timeIntervalSince1970
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(Int(self)! / 1000)
        //时间差
        let reduceTime : TimeInterval = currentTime - timeSta
        let temp = Double(reduceTime/60/60)
        return temp.reserve1f
    }
}
extension Array{
    var toJSON:String?{
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            return String(data: data, encoding: String.Encoding.utf8)
        }
        catch {
            print("format Array to json string error")
            return nil
        }
    }
}
extension UIViewController{
    //添加子视图
    func addMyChidVc(_ vc:UIViewController, box:UIView) {
        vc.willMove(toParentViewController: self)
        box.addSubview(vc.view)
        vc.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.addChildViewController(vc)
        vc.didMove(toParentViewController: self)
    }
    func addMyChidVCs(_ vc:UIViewController, box:UIView,i:Int) {
        vc.willMove(toParentViewController: self)
        box.addSubview(vc.view)
        vc.view.snp.makeConstraints { (make) in
            make.bottom.top.equalToSuperview()
            make.left.equalToSuperview().offset(UIScreen.main.bounds.width * CGFloat(i))
            make.right.lessThanOrEqualToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height)
            make.width.equalTo(UIScreen.main.bounds.width)
            //make.height.equalTo(200)
        }
        self.addChildViewController(vc)
        vc.didMove(toParentViewController: self)
    }
    //页面跳转
    func puchVC(vc:UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func popVC(){
        self.navigationController?.popViewController(animated: true)
    }
    func popVCs(vcs:Int){
        let thisView = navigationController?.viewControllers[vcs]
        navigationController?.popToViewController(thisView!, animated: true)
    }
    func presentVc(vc:UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    func disMiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
//重设根视图
func rootVc(vc:UIViewController) {
    UIApplication.shared.delegate?.window??.rootViewController = vc
}
//富文本,文本加图片
func richText(string:String,image:UIImage) -> NSMutableAttributedString {
    let question = NSMutableAttributedString()
    let content1 = NSAttributedString(string: string)
    
    let img = NSTextAttachment()
    img.image = image
    img.bounds = CGRect(x: 0, y: -4, width: 22, height: 22)
    question.append(content1)
    question.append(NSAttributedString(attachment: img))

    return question
}
//刷新
extension UITableViewController{
    func MJ_header(temp:@escaping (()->Void)){
        let header = MJRefreshNormalHeader(refreshingBlock: {
            temp()
            self.tableView.mj_header.endRefreshing()
        })
        header?.setTitle("下拉刷新...", for: .idle)
        header?.setTitle("松开刷新...", for: .pulling)
        header?.setTitle("正在刷新...", for: .refreshing)
        //根据拖拽比例自动切换透明度 
        header?.isAutomaticallyChangeAlpha = true
        //隐藏时间
        header?.lastUpdatedTimeLabel.isHidden = true
        tableView.mj_header = header
    }
    func MJ_footer(temp:@escaping (()->Void)){
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            temp()
            self.tableView.mj_footer.endRefreshing()
        })
    }
    func MJ_headerStart() {
        tableView.mj_header.beginRefreshing()
    }
}
extension UICollectionViewController{
    func MJ_header(temp:@escaping (()->Void)){
        let header = MJRefreshNormalHeader(refreshingBlock: {
            temp()
            self.collectionView?.mj_header.endRefreshing()
        })
        header?.setTitle("下拉刷新...", for: .idle)
        header?.setTitle("松开刷新...", for: .pulling)
        header?.setTitle("正在刷新...", for: .refreshing)
        //根据拖拽比例自动切换透明度
        header?.isAutomaticallyChangeAlpha = true
        //隐藏时间
        header?.lastUpdatedTimeLabel.isHidden = true
        collectionView?.mj_header = header
    }
    func MJ_footer(temp:@escaping (()->Void)){
        collectionView?.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            temp()
            self.collectionView?.mj_footer.endRefreshing()
        })
    }
    func MJ_headerStart() {
        collectionView?.mj_header.beginRefreshing()
    }
}
//播放mp3
var commonAudioPlayer:AVAudioPlayer?
func speech(url:URL) {
    commonAudioPlayer?.stop()
    let player = try! AVAudioPlayer(contentsOf: url)
    player.prepareToPlay()
    player.play()
    commonAudioPlayer = player
}
func speechMP3(name:String) {
    if let path = Bundle.main.url(forResource: name, withExtension: "mp3") {
        speech(url: path)
    }
}

extension UIViewController{
    //alter一个Button
    func alterOneButton(title:String,content:String,sure:((UIAlertAction)->Void)?=nil){
        let alter = UIAlertController(title: title, message: content, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确认", style: .default, handler: sure)
        alter.addAction(okAction)
        self.presentVc(vc: alter)
    }
    //alter二个Button
    func alterTwoButton(title:String,content:String,sure:((UIAlertAction)->Void)?=nil,cancle:((UIAlertAction)->Void)?=nil){
        let alter = UIAlertController(title: title, message: content, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确认", style: .default, handler: sure)
        let cancleAction = UIAlertAction(title: "取消", style: .default, handler: cancle)
        alter.addAction(okAction)
        alter.addAction(cancleAction)
        self.presentVc(vc: alter)
    }
}
extension UIButton{
    //按钮的边框和颜色
    func border(size:Int,coler:UIColor) {
        self.layer.borderWidth = CGFloat(size)
        self.layer.borderColor = coler.cgColor
    }
}
extension UIImageView{
    //圆形图片视图
    func roundness() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.width/2
    }
    //圆角图片视图
    func circularBead(size:Int) {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(size)
    }
}
//动画 设置左边上边距离父视图的距离
extension UIView{
    func animateLeft(time:Double,x:CGFloat) {
        UIView.animate(withDuration: time) {
            self.frame.origin.x = x
        }
    }
    func animateTop(time:Double,y:CGFloat) {
        UIView.animate(withDuration: time) {
            self.frame.origin.y = y
        }
    }
}
//空表格视图显示内容
extension UITableViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableViewNilCell()
    }
    func tableViewNilCell() {
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.tableFooterView = UIView()
    }
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
            return richText(string: "下拉刷新数据哦", image: #imageLiteral(resourceName: "a01"))
    }
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
extension UITableView:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func tableViewNilCell() {
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
        self.tableFooterView = UIView()
    }
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return richText(string: "下拉刷新数据哦", image: #imageLiteral(resourceName: "默认头像"))
    }
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
extension UICollectionViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableViewNilCell()
    }
    func tableViewNilCell() {
        self.collectionView?.emptyDataSetSource = self
        self.collectionView?.emptyDataSetDelegate = self
    }
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return richText(string: "下拉刷新数据哦", image: #imageLiteral(resourceName: "默认头像"))
    }
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
//添加充满父视图视图
extension UIView{
    func addFullView(view:UIView){
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
extension Date{
    var YM:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM"
        return formatter.string(from: self)
    }
}
extension UIColor {
    
    static func colorRegex(_ value:String) -> UIColor? {
        guard value.count == 7 else {
            return nil
        }
        guard value.first! == "#" else {
            return nil
        }
        let index = value.index(after: value.startIndex)
        let rRange = index..<value.index(index, offsetBy: 2)
        var r:CUnsignedInt = 0
        let gRange = value.index(index, offsetBy: 2)..<value.index(index, offsetBy: 4)
        var g:CUnsignedInt = 0
        let bRange = value.index(index, offsetBy: 4)..<value.index(index, offsetBy: 6)
        var b:CUnsignedInt = 0
        Scanner(string: String(value[rRange])).scanHexInt32(&r)
        Scanner(string: String(value[gRange])).scanHexInt32(&g)
        Scanner(string: String(value[bRange])).scanHexInt32(&b)
        
        let red = CGFloat(r)/255.0
        let green = CGFloat(g)/255.0
        let blue = CGFloat(b)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
//重用cell
extension UITableView{
    func reUseCell<T>(_ cellName:T.Type,_ indexPath: IndexPath) -> T{
        let cell = self.dequeueReusableCell(withIdentifier: "\(cellName)", for: indexPath)
        cell.selectionStyle = .none
        return cell as! T
    }
}
extension UICollectionView{
    func reUseCell<T>(_ cellName:T.Type,_ indexPath: IndexPath) -> T{
        let cell = self.dequeueReusableCell(withReuseIdentifier: "\(cellName)", for: indexPath)
        return cell as! T
    }
}
//
func DeviceIsX() -> Bool {
    if UIScreen.main.bounds.width == 375.0 && UIScreen.main.bounds.height == 812.0 {
        return true
    } else if UIScreen.main.bounds.height == 375.0 && UIScreen.main.bounds.width == 812.0 {
        return true
    }
    
    return false
}
//保存到本地
enum loginData:String{
    case account = "account"
    case password = "password"
}
func saveLoginData(account:String,password:String){
    UserDefaults.standard.set(account, forKey: loginData.account.rawValue)
    UserDefaults.standard.set(password, forKey: loginData.password.rawValue)
//    UserDefaults.standard.synchronize()
}
func readLoginData()->(String,String)?{
    guard let account = UserDefaults.standard.value(forKey: loginData.account.rawValue) else {
        return nil
    }
    guard let password = UserDefaults.standard.value(forKey: loginData.password.rawValue) else {
        return nil
    }
    return (account,password) as? (String, String)
}
func delLoginData(){
    UserDefaults.standard.removeObject(forKey: loginData.password.rawValue)
    UserDefaults.standard.removeObject(forKey: loginData.account.rawValue)
//    UserDefaults.standard.synchronize()
}
//navgationbar 隐藏或者显示
extension UIViewController{
    @objc func isHiddenNavgationBar() -> Bool {
        return false
    }
}
extension UINavigationController:UINavigationControllerDelegate{
    open override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        self.delegate = self
    }
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.setNavigationBarHidden(viewController.isHiddenNavgationBar(), animated: animated)
    }
}
//Cannot load underlying module for 'SwiftyUserDefaults'
extension DefaultsKeys{
    static let account = DefaultsKey<String>("account")
    static let password = DefaultsKey<String>("password")
}

//读plist文件
func readPlist<T:handy>(_ plistName:String,_ block:((T)->Void)){
    let diaryList:String = Bundle.main.path(forResource: plistName, ofType:"plist")!
    
    let data:NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: diaryList)!
    //        将字典对象转化为字符串对象
//    let message = data.description
//    print(message)
    //解析
    if let hasValue = T.deserialize(from:  data){
        block(hasValue)
    }
    else{
        print("错误")
    }
}

//
extension Int{
    var toHmS:String {
        //不足两位前面写0, 0.1f表示保留一位小数
        return String.init(format: "%02ld:%02ld:%02ld", self/60/60, self/60%60, self%60)
    }
}
//多线程
//let queue = DispatchQueue(label: "name"/*名字*/, qos: DispatchQoS.background/*优先级*/, attributes: [DispatchQueue.Attributes.concurrent,DispatchQueue.Attributes.initiallyInactive]/*并行队列 手动启动*/, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit/*销毁*/)
//queue.async {
//    <#code#>
//}/*异步*/
//queue.sync {
//    <#code#>
//}/*同步*/

//concurrentQueue.resume()可以挂起一个线程，就是把这个线程暂停了，它占着资源，但不运行。
//concurrentQueue.suspend(）可以继续挂起的线程，让这个线程继续执行下去。
/*public struct DispatchQoS : Equatable {
 
 public static let userInteractive: DispatchQoS //用户交互级别，需要在极快时间内完成的，例如UI的显示
 
 public static let userInitiated: DispatchQoS  //用户发起，需要在很快时间内完成的，例如用户的点击事件、以及用户的手势
 。
 public static let `default`: DispatchQoS  //系统默认的优先级，
 
 public static let utility: DispatchQoS   //实用级别，不需要很快完成的任务
 
 public static let background: DispatchQoS  //用户无法感知，比较耗时的一些操作
 
 public static let unspecified: DispatchQoS
 }*/
//获取手机型号
//let infoDictionary = Bundle.main.infoDictionary!
//let appDisplayName = infoDictionary["CFBundleDisplayName"] //程序名称
//let majorVersion = infoDictionary["CFBundleShortVersionString"]//主程序版本号
//let minorVersion = infoDictionary["CFBundleVersion"]//版本号（内部标示）
//let appVersion = majorVersion as! String
//
////设备信息
//let iosVersion = UIDevice.current.systemVersion //iOS版本
//let identifierNumber = UIDevice.current.identifierForVendor //设备udid
//let systemName = UIDevice.current.systemName //设备名称
//let model = UIDevice.current.model //设备型号
//let modelName = UIDevice.current.modelName //设备具体型号
//let localizedModel = UIDevice.current.localizedModel //设备区域化型号如A1533
public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch 5"
        case "iPod7,1":  return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":  return "iPhone 5"
        case "iPhone5,2":  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":  return "iPhone 5s"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"
            
        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":  return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":  return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":  return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":  return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
            
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":  return "Apple TV 4"
            
        case "i386", "x86_64":  return "Simulator"
            
        default:  return identifier
        }
    }
}
//下载图片
func downloadImg(_ url:String,_ myBookIndex:Int)->String{
    var name = url
    name = name.replacingOccurrences(of: "/", with: "")
    name = name.replacingOccurrences(of: ":", with: "")
    name = name.replacingOccurrences(of: ".", with: "")
    
    let destination:DownloadRequest.DownloadFileDestination = { _ , _ in
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("img/\(name).jpg")
        //如果路径中文件夹不存在则会自动创建
        return (fileURL, [.createIntermediateDirectories])
    }
    if File.fileIsExist(fileName: "img/\(name).jpg"){
        return "img/\(name).jpg"
    }
    Alamofire.download(url, to: destination)
        .response { response in
            if let imagePath = response.destinationURL?.path {
//                mybook[myBookIndex].imagePath = imagePath
            }
    }
    return ""
}
