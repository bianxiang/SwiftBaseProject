//
//  ZZImageScroll.swift
//  DZImageScan
//
//  Created by duzhe on 15/12/7.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ZZPictureItem :NSCopying{
    var thunmView:UIImageView?
    var lageImageSize:CGSize?
    var largeImageURL:URL?
    var largeImage:UIImage?
    var largeImagePath:String?
    
    var smallRect:CGRect?
    var thumbImage:UIImage?{
        return thunmView?.image
    }
    @objc func copy(with zone: NSZone?) -> Any {
        return ZZPictureItem()
    }
}

class ZZPictureViewCell: UIScrollView,UIScrollViewDelegate{
    var imageContainerView:UIView!
    var imageView:UIImageView!
    var page:NSInteger?
    var showProgress:Bool = true
    var progress:CGFloat = 0
    var progressLayer:CAShapeLayer!
    var itemDidLoad:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(){
        self.init(frame:UIScreen.main.bounds)
        self.delegate = self
        self.bouncesZoom = true
        self.maximumZoomScale = 3
        self.isMultipleTouchEnabled = true
        self.alwaysBounceVertical = false
        self.showsVerticalScrollIndicator = true
        self.showsHorizontalScrollIndicator = false
        
        imageContainerView = UIView()
        imageContainerView.clipsToBounds = true
        self.addSubview(imageContainerView)
        
        imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        imageContainerView.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ZZPictureViewCell.longPress))
        longPress.minimumPressDuration = 0.7
        imageView.addGestureRecognizer(longPress)
        
        progressLayer = CAShapeLayer()
        progressLayer.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        progressLayer.cornerRadius = 20
        progressLayer.backgroundColor = UIColor(white: 0, alpha: 0.5).cgColor
        let path =  UIBezierPath(roundedRect:  progressLayer.bounds.insetBy(dx: 7, dy: 7), cornerRadius: (40/2 - 7))
        
        progressLayer.path = path.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 4
        progressLayer.lineCap = kCALineCapRound
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        progressLayer.isHidden = true
        progressLayer.strokeColor = UIColor.white.cgColor
        self.layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressLayer.zz_center = CGPoint(x: self.zz_width / 2, y: self.zz_height / 2);
    }
    
    
    func resizeSubviewSize(){
        imageContainerView.zz_origin = CGPoint.zero
        imageContainerView.frame.size.width = self.frame.width
        if let image = imageView.image{
            if  image.size.height/image.size.width > self.frame.height / self.frame.width {
                imageContainerView.frame.size.height = floor(image.size.height / (image.size.width / self.frame.width));
            } else {
                var height = image.size.height / image.size.width * self.frame.width;
                if (height < 1 || height.isNaN) {
                    height = self.frame.height
                }
                height = floor(height);
                imageContainerView.frame.size.height = height;
                imageContainerView.center.y = self.frame.height / 2;
            }
            
            if imageContainerView.frame.height > self.frame.height && imageContainerView.frame.height - self.frame.height <= 1 {
                imageContainerView.zz_height = self.zz_height
            }
            self.contentSize = CGSize(width: self.zz_width, height: max(imageContainerView.zz_height, self.zz_height))
            self.scrollRectToVisible(self.bounds, animated: false)
            if (imageContainerView.zz_height <= self.zz_height) {
                self.alwaysBounceVertical = false
            } else {
                self.alwaysBounceVertical = true
            }
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            imageView.frame = imageContainerView.bounds
            CATransaction.commit()
        }
    }
    
    var item:ZZPictureItem?{
    
        didSet{
            //带 进度 带成功回调 图片缓存
            itemDidLoad = false
           
            if item == nil{
                imageView.image = nil
                return
            }

            self.setZoomScale(1, animated: false)
            self.maximumZoomScale = 1
            imageView.layer.zz_removePreviousFadeAnimation()
            if item!.largeImage != nil{
                self.progressLayer.isHidden = true
            }else{
                self.progressLayer.isHidden = false
            }
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            progressLayer.strokeEnd = 0.0
            CATransaction.commit()
            
           
            if item!.largeImage != nil{
                self.maximumZoomScale = 3
                //有大图 直接赋值
                self.itemDidLoad = true
                imageView.image = item!.largeImage
                self.resizeSubviewSize()
            }else if item!.largeImagePath != nil{
                //本地路径读取
                
                self.itemDidLoad = true
                
//               _zc.getImg(item!.largeImagePath!, compelete: { (image) -> () in
//                    if let image = image{
//                        self.maximumZoomScale = 3
//                        self.progressLayer.hidden = true
//                        self.imageView.image = image
//                        self.resizeSubviewSize()
//                    }else{
//                        self.imageView.kf_setImageWithURL(self.item!.largeImageURL!, placeholderImage:  self.item?.thumbImage, optionsInfo: nil , progressBlock: { (receivedSize, totalSize) -> () in
//                            self.progressLayer.strokeEnd = CGFloat(CGFloat(receivedSize)/CGFloat(totalSize))
//                            }) { (image, error, cacheType, imageURL) -> () in
//                                self.progressLayer.hidden = true
//                                self.maximumZoomScale = 3
//                                if let _ = image{
//                                    self.itemDidLoad = true
//                                }
//                                self.resizeSubviewSize()
//                                self.imageView.layer.zz_addFadeAnimationWithDuration(0.1, curve: UIViewAnimationCurve.Linear)
//                        }
//                    }
//               })
                _i.getImage(item!.largeImagePath!, complete: { (img) -> () in
                        self.maximumZoomScale = 3
                        self.progressLayer.isHidden = true
                        self.imageView.image = img
                        self.resizeSubviewSize()
                    }, fail: { () -> () in
                        
                        self.imageView.zz_setImage(withUrl: self.item!.largeImageURL!, progressBlock: { (receivedSize, totalSize) in
                            self.progressLayer.strokeEnd = CGFloat(CGFloat(receivedSize)/CGFloat(totalSize))
                            }, success: { (req, resp, img) in
                                self.progressLayer.isHidden = true
                                self.maximumZoomScale = 3
                                if let _ = img{
                                    self.itemDidLoad = true
                                }
                                self.resizeSubviewSize()
                                self.imageView.layer.zz_addFadeAnimationWithDuration(0.1, curve: UIViewAnimationCurve.linear)
                        })
                        
                        self.imageView.zz_setImage(withUrl: self.item!.largeImageURL! ,placeholder: self.item?.thumbImage  , progressBlock: { (receivedSize, totalSize) in
                            self.progressLayer.strokeEnd = CGFloat(CGFloat(receivedSize)/CGFloat(totalSize))
                            }, success: { (req, resp, image) in
                                self.progressLayer.isHidden = true
                                self.maximumZoomScale = 3
                                if let _ = image{
                                    self.itemDidLoad = true
                                }
                                self.resizeSubviewSize()
                                self.imageView.layer.zz_addFadeAnimationWithDuration(0.1, curve: UIViewAnimationCurve.linear)
                        })
                        
                        
//                        self.imageView.kf_setImageWithURL(self.item!.largeImageURL!, placeholderImage:  self.item?.thumbImage, optionsInfo: nil , progressBlock: { (receivedSize, totalSize) -> () in
//                            self.progressLayer.strokeEnd = CGFloat(CGFloat(receivedSize)/CGFloat(totalSize))
//                            }) { (image, error, cacheType, imageURL) -> () in
//                                self.progressLayer.hidden = true
//                                self.maximumZoomScale = 3
//                                if let _ = image{
//                                    self.itemDidLoad = true
//                                }
//                                self.resizeSubviewSize()
//                                self.imageView.layer.zz_addFadeAnimationWithDuration(0.1, curve: UIViewAnimationCurve.Linear)
//                        }
                })
            }else{
               //网络加载
                
                imageView.zz_setImage(withUrl: item!.largeImageURL!,placeholder: self.item?.thumbImage  , progressBlock: { (receivedSize, totalSize) in
                    self.progressLayer.strokeEnd = CGFloat(CGFloat(receivedSize)/CGFloat(totalSize))
                    }, success: { (req, resp, img) in
                        self.progressLayer.isHidden = true
                        self.maximumZoomScale = 3
                        if let _ = img{
                            self.itemDidLoad = true
                        }
                        self.resizeSubviewSize()
                        self.imageView.layer.zz_addFadeAnimationWithDuration(0.1, curve: UIViewAnimationCurve.linear)
                })
                
//                imageView.kf_setImageWithURL(item!.largeImageURL!, placeholderImage: item?.thumbImage, optionsInfo: nil , progressBlock: { (receivedSize, totalSize) -> () in
//                    self.progressLayer.strokeEnd = CGFloat(CGFloat(receivedSize)/CGFloat(totalSize))
//                    }) { (image, error, cacheType, imageURL) -> () in
//                        self.progressLayer.hidden = true
//                        self.maximumZoomScale = 3
//                        if let _ = image{
//                            self.itemDidLoad = true
//                        }
//                        self.resizeSubviewSize()
//                        self.imageView.layer.zz_addFadeAnimationWithDuration(0.1, curve: UIViewAnimationCurve.Linear)
//                }
            }
           
        }
    }
    
    fileprivate var context = 0
    //MARK: -长按保存照片
    func longPress(){
        ZZAlert.showAlert(self.responderViewController(), meg: "是否保存照片到相册?", btn1: "否", btn2: "是") { (action) -> Void in
            if let image = self.imageView.image{
                UIImageWriteToSavedPhotosAlbum(image,self,#selector(ZZPictureViewCell.saveComplete(_:err:info:)),&self.context)
            }
        }
    }

    func saveComplete(_ img:UIImage,err:NSError?,info:UnsafeMutableRawPointer){
        if err == nil{
            HUD.flash(.label("保存成功"), delay: __$.WAITTING_SECONDS)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageContainerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let subView = imageContainerView
        let offsetX =  (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0
        let offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ?
        (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
        
        subView?.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX,
            y: scrollView.contentSize.height * 0.5 + offsetY)
    }
}

let kPadding:CGFloat = 20.0

class ZZPictureView:UIView,UIScrollViewDelegate,UIGestureRecognizerDelegate{
    var groupItems:[ZZPictureItem]?
    var currentPage:NSInteger{
        set{
            self.currentPage = newValue
        }
        get{
            if self.groupItems == nil{
                return 0
            }
            var page = Int(self.scrollView.contentOffset.x / scrollView.zz_width + 0.5)
            if (page >= self.groupItems!.count) {
                page = self.groupItems!.count - 1
            }
            if (page < 0) {
                page = 0
            }
            return page
        }
    }
    
    weak var fromView:UIView?
    weak var toContainerView:UIView?
    
    var zz_snapshotImage:UIImage?
    var zz_snapshorImageHideFromView:UIImage?
    
    var background:UIImageView!
    
    var contentView:UIView!
    var scrollView:UIScrollView!
    
    var cells:[ZZPictureViewCell]?
    var pager:UIPageControl!
    var fromNavigationBarHidden:Bool = false
    var fromItemIndex:NSInteger = 0
    var isPresented:Bool = false
    var panGesture:UIPanGestureRecognizer?
    var panGestureBeginPoint:CGPoint?
    var isOnePlace = false
    var oneFromView:UIView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(groupItems:[ZZPictureItem]?){
        self.init(frame:UIScreen.main.bounds)
        if groupItems?.count == 0{
            return
        }
        self.groupItems = groupItems
        self.clipsToBounds = true
        self.backgroundColor = UIColor.black
        
        //消失
        let tap = UITapGestureRecognizer(target: self, action: #selector(ZZPictureView.dismiss))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        
        //双击
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(ZZPictureView.doubleTap(_:)))
        tap2.delegate = self
        tap2.numberOfTapsRequired = 2
        tap.require(toFail: tap2)
        self.addGestureRecognizer(tap2)
        
        //滑动手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ZZPictureView.pan(_:)))
        self.addGestureRecognizer(pan)
        self.panGesture = pan
        
        cells = []
        background = UIImageView()
        background.frame = self.bounds
        background.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleHeight]
        background.backgroundColor = UIColor.clear
        
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: -kPadding / 2, y: 0, width: self.zz_width + kPadding, height: self.zz_height);
        scrollView.delegate = self
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = true
        scrollView.alwaysBounceHorizontal = groupItems?.count>1
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleHeight]
        scrollView.canCancelContentTouches = true
        
        
        pager = UIPageControl()
        pager.hidesForSinglePage = true
        pager.isUserInteractionEnabled = false
        pager.zz_width = self.zz_width - 36
        pager.zz_height = 10
        pager.center = CGPoint(x: self.zz_width / 2, y: self.zz_height - 18)
        pager.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleHeight]
        
        self.addSubview(background)
        self.addSubview(pager)
        self.addSubview(scrollView)
    }
    
    //MARK: -更具下标返回cell
    func cellForPage(_ page:NSInteger)->ZZPictureViewCell?{
        if let cells = self.cells{
            for cell in cells{
//              print("cell.page is \(cell.page) ， page is \(page)")
                if cell.page == page{
                    return cell
                }
            }
        }
        return nil
    }
    
    //MARK: -创建可重用的cell
    func dequeueReusableCell()->ZZPictureViewCell{
        var xcell:ZZPictureViewCell? = nil
        for zcell in self.cells!{
            if zcell.superview == nil{
                return zcell
            }
        }
        
        xcell = ZZPictureViewCell()
        xcell?.frame = self.bounds
        xcell?.imageContainerView.frame = self.bounds
        xcell?.imageView.frame = self.bounds
        xcell?.page = -1
        xcell?.item = nil
        self.cells?.append(xcell!)
        return xcell!
    }
    
    func updateCellsForReuse(){
        if let cells = self.cells{
            for cell in cells{
                if cell.superview != nil{
                    if (cell.zz_left > scrollView.contentOffset.x + scrollView.zz_width * 2 ||
                        cell.zz_right < scrollView.contentOffset.x - scrollView.zz_width) {
                        cell.removeFromSuperview()
                        cell.page = -1;
                        cell.item = nil;
                    }
                }
            }
        }
    }
    
    func presentFromImageView(_ fromView:UIView,containerView:UIView? = nil,animated:Bool,completion:(()->())?){
        self.fromView = fromView
        if containerView == nil{
            self.toContainerView = UIApplication.shared.keyWindow
        }else{
            self.toContainerView = containerView
        }
        guard let _ = self.toContainerView  else{return}
        
        var page:NSInteger = -1
        for i in 0..<self.groupItems!.count{
            if fromView == self.groupItems![i].thunmView{
                page = i
                break
            }
            if page == -1{
                page = 0
            }
        }
        fromItemIndex = page
        self.zz_snapshotImage = self.toContainerView?.zz_snapshotImageAfterScreenUpdates(false)
        let fromViewHidden = fromView.isHidden
        fromView.isHidden = true
        self.zz_snapshorImageHideFromView = self.toContainerView?.zz_snapShotImage()  //屏幕截图
        fromView.isHidden = fromViewHidden
        self.zz_size = self.toContainerView!.zz_size
        self.pager.alpha = 0
        self.pager.numberOfPages = self.groupItems!.count
        self.pager.currentPage = page;

        self.toContainerView?.addSubview(self)
        self.toContainerView?.bringSubview(toFront: self)
        self.scrollView.contentSize = CGSize(width: scrollView.zz_width*CGFloat(self.groupItems!.count), height: scrollView.zz_height)
        self.scrollView.scrollRectToVisible(CGRect(x: scrollView.zz_width*CGFloat(pager.currentPage),y: 0, width: scrollView.zz_width, height: scrollView.zz_height), animated: false)
        self.scrollViewDidScroll(scrollView)
        
        UIView.setAnimationsEnabled(true)
        fromNavigationBarHidden = UIApplication.shared.isStatusBarHidden
        UIApplication.shared.isStatusBarHidden = true

        let cell = self.cellForPage(page)
        guard let _cell = cell else { return } //如果cell为nil 不执行
        let item = self.groupItems![page]
        let urlStr = item.largeImageURL!.absoluteString
        
        if KingfisherManager.shared.cache.isImageCached(forKey: urlStr).cached || KingfisherManager.shared.cache.isImageCached(forKey: urlStr).cacheType == CacheType.memory{
            _cell.item = item
        }
        
        if _cell.item == nil{
            _cell.imageView.image = item.thumbImage
            _cell.resizeSubviewSize()
        }
        
        var fromFrame = item.smallRect
        if fromFrame == nil{
            fromFrame = self.fromView!.convert(item.smallRect ?? CGRect.zero, to: _cell.imageContainerView)
        }
        if self.isOnePlace{
            if let oneFromView = self.oneFromView{
               fromFrame = oneFromView.convert(item.smallRect == nil ? CGRect.zero:item.smallRect!, to: _cell.imageContainerView)
            }
        }
        zp("++++\(fromFrame)")
        if let containerView = containerView{
            fromFrame = _cell.imageContainerView.convert(fromFrame!, from: containerView)
        }
        
        _cell.imageContainerView.clipsToBounds = false
        _cell.imageView.frame = fromFrame!
        _cell.imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.background.alpha = 0
        
//        zp(_cell.imageContainerView.frame)
        let oneTime = animated ? 0.38:0
        UIView.animate(withDuration: oneTime, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
             self.background.alpha = 1
            }, completion: nil)
        scrollView.isUserInteractionEnabled = false
        UIView.animate(withDuration: oneTime, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                _cell.imageView.frame = _cell.imageContainerView.bounds;
                _cell.imageView.layer.zz_transformScale = 1.01;
            }){ _ in
                UIView.animate(withDuration: oneTime, delay:0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                        _cell.imageView.layer.zz_transformScale = 1.0;
                        self.pager.alpha = 1;
                    }, completion: { (b) -> Void in
                        _cell.imageContainerView.clipsToBounds = true;
                        self.isPresented = true
                        self.scrollViewDidScroll(self.scrollView)
                        self.scrollView.isUserInteractionEnabled = true;
                        self.pager.alpha = 0
                        completion?();
                })
        }
    }
    
    //MARK: -预加载 三个cell
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateCellsForReuse()  //把非空的cell属性清掉
        let floatPage = scrollView.contentOffset.x / scrollView.zz_width;
        let page = scrollView.contentOffset.x / scrollView.zz_width + 0.5;
        for i in Int(page-1) ... Int(page+1){
            if i >= 0 && i < self.groupItems!.count{
                let cell = self.cellForPage(i)
                if cell == nil{
                    let cell = self.dequeueReusableCell()
                    cell.page = i
                    cell.zz_left = (self.zz_width+kPadding) * CGFloat(i) + kPadding / CGFloat(2)
                    if self.isPresented{
                        cell.item = self.groupItems![i]
                    }
                    self.scrollView.addSubview(cell)
                }else{
                    if self.isPresented && cell?.item == nil{
                        cell?.item = self.groupItems![i]
                    }
                }
            }
        }
        var intPage:Int = Int(floatPage + 0.5)
        if intPage < 0{
            intPage = 0
        }else{
            if (intPage) >= (self.groupItems!.count-1){
                (intPage) = (self.groupItems!.count-1)
            }
        }
        self.pager.currentPage = intPage
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState  , animations: { () -> Void in
                self.pager.alpha = 1
            }) { (b) -> Void in
        }
    }
    
    
    func dismiss(){
        self.dismissAnimated(true, competion: nil)
    }
    
    func dismissAnimated(_ animated:Bool,competion:(()->())?){
        UIView.setAnimationsEnabled(true)
        UIApplication.shared.isStatusBarHidden = false
        let cell = self.cellForPage(currentPage)
        let item = self.groupItems![currentPage]
        let fromView:UIView!
        if self.fromItemIndex == currentPage{
            fromView = self.fromView
        }else{
            fromView = item.thunmView
        }
        
        
        self.isPresented = false
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        guard let _cell = cell else{ return }
        _cell.progressLayer.isHidden = true
        CATransaction.commit()
        if fromView == nil{
            self.background.image = self.zz_snapshotImage
            UIView.animate(withDuration: animated ? 0.25 : 0, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                    self.alpha = 0.0;
                    self.scrollView.layer.zz_transformScale = 0.95;
                    self.scrollView.alpha = 0;
                    self.pager.alpha = 0;
                }, completion: { (b) -> Void in
                    self.removeFromSuperview()
                    competion?()
            })
        }
        if self.fromItemIndex != currentPage{
            self.background.image = self.zz_snapshotImage
            self.background.layer.zz_addFadeAnimationWithDuration(0.25, curve: UIViewAnimationCurve.easeInOut)
        }else{
            self.background.image = self.zz_snapshotImage
        }
        zp(_cell.imageView.frame)
        UIView.animate(withDuration: animated ? 0.2 : 0, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                self.pager.alpha = 0
            
                _cell.imageContainerView.clipsToBounds = false
            
                var fromFrame = item.smallRect
                if fromFrame == nil {
                   fromFrame = fromView.convert(item.smallRect ?? CGRect.zero, to: _cell.imageContainerView)
                }
                if let containerView = self.toContainerView{
                    fromFrame = _cell.imageContainerView.convert(fromFrame!, from: containerView)
                }
                if self.isOnePlace{
                    if let oneFromView = self.oneFromView{
                        fromFrame = oneFromView.convert(item.smallRect == nil ? CGRect.zero:item.smallRect!, to: _cell.imageContainerView)
                    }
                }
                zp("++++\(fromFrame)")
                if item.smallRect == nil{
                    _cell.alpha = 0
                }else{
                    _cell.imageView.contentMode = fromView.contentMode
                    _cell.imageView.clipsToBounds = true
                    _cell.imageView.frame = fromFrame!
                }
            }, completion: { (b) -> Void in
                UIView.animate(withDuration: animated ? 0.2 : 0, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                    self.alpha = 0
                    }, completion: { (b) -> Void in
                    self.removeFromSuperview()
                    competion?()
                })
        })
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            self.hiderPager()
        }
    }
   
    //MARK: -隐藏页码
    func hiderPager(){
        UIView.animate(withDuration: 0.3, delay: 0.75, options: UIViewAnimationOptions.beginFromCurrentState  , animations: { () -> Void in
            self.pager.alpha = 0
            }) { (b) -> Void in
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.hiderPager()
    }
    
    //MARK: -双击缩放
    func doubleTap(_ g:UITapGestureRecognizer){
        if !self.isPresented{
            return
        }
        let  tile = self.cellForPage(self.currentPage)
        if let tile = tile{
            if tile.zoomScale>1{
                tile.setZoomScale(1, animated: true)
            }else{
                let touchPoint = g.location(in: tile.imageView)
                let newZoomScale = tile.maximumZoomScale
                let xsize = self.zz_width/newZoomScale
                let ysize = self.zz_height/newZoomScale
                tile.zoom(to: CGRect(x: touchPoint.x - xsize/2, y: touchPoint.y - ysize/2, width: xsize, height: ysize), animated: true)
            }
        }
    }
    
    //MARK: -上下滑手势
    func pan(_ g:UIPanGestureRecognizer){
        switch g.state{
        case .began:
            if self.isPresented{
                self.panGestureBeginPoint = g.location(in: self)
            }else{
                self.panGestureBeginPoint = CGPoint.zero
            }
            break
        case .changed:
            if self.panGestureBeginPoint?.x == 0 && self.panGestureBeginPoint?.y == 0 {
                return
            }
            let p = g.location(in: self)
            let deltaY = p.y - self.panGestureBeginPoint!.y
            self.scrollView.zz_top = deltaY
            let alphaDelta:CGFloat = 160
            var alpha = (alphaDelta - fabs(deltaY) + 50.0)/alphaDelta
            alpha = ZZ_CLAP(alpha, 0, 1)
            self.backgroundColor = UIColor.black.withAlphaComponent(alpha)
            self.pager.alpha = alpha
            break
        case .ended:
            if self.panGestureBeginPoint?.x == 0 && self.panGestureBeginPoint?.y == 0 {
                return
            }
            let v = g.velocity(in: self)
            let p = g.location(in: self)
            let deltaY = p.y - self.panGestureBeginPoint!.y
            if fabs(v.y) > 1000 || fabs(deltaY) > 120{
                self.isPresented = false
                UIApplication.shared.isStatusBarHidden = self.fromNavigationBarHidden
                let moveToTop = (v.y < -50 || (v.y < 50 && deltaY < 0))
                var vy = fabs(v.y)
                if vy<1{
                    vy = 1
                }
                var duration = (moveToTop ? self.scrollView.zz_bottom : self.zz_height - self.scrollView.zz_top) / vy
                duration *= 0.8
                duration = ZZ_CLAP(duration, 0.05, 0.3)
                UIView.animate( withDuration: TimeInterval(duration), delay:0, options: [UIViewAnimationOptions.beginFromCurrentState, UIViewAnimationOptions.curveLinear]  , animations: { () -> Void in
                    self.backgroundColor = UIColor.black.withAlphaComponent(0)
                    self.pager.alpha = 0
                    if (moveToTop) {
                        self.scrollView.zz_bottom = 0;
                    } else {
                        self.scrollView.zz_top = self.zz_height;
                    }
                    }) { (b) -> Void in
                        self.removeFromSuperview()
                    }
                self.background.image = self.zz_snapshotImage
                self.background.layer.zz_addFadeAnimationWithDuration(0.3, curve: UIViewAnimationCurve.easeInOut)
            }else {
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: v.y/1000, options: [UIViewAnimationOptions.allowUserInteraction, UIViewAnimationOptions.beginFromCurrentState], animations: { () -> Void in
                        self.scrollView.zz_top = 0
                        self.backgroundColor = UIColor.black.withAlphaComponent(1)
                        self.pager.alpha = 1
                    }, completion: { (b) -> Void in

                    })
            }
        case .cancelled:
            self.scrollView.zz_top = 0
        default:
            break
        }
    }
    
}

//MARK: -_value去高地中间的值
func ZZ_CLAP(_ _value:CGFloat,_ _low:CGFloat,_ _high:CGFloat)->CGFloat{
    return _value<_low ? _low: _value>_high ? _high:_value
}
























