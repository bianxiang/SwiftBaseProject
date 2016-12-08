//
//  SharePresentVCViewController.swift
//  zuber
//
//  Created by duzhe on 16/8/10.
//  Copyright © 2016年 duzhe. All rights reserved.
//

import UIKit

struct ShareItem {
    var name:String
    var img:UIImage?
}
class SharePresentVC: UIViewController {
    fileprivate var items:[ShareItem] = []
    fileprivate var kRowHeight:CGFloat = 110
    fileprivate var clickItems:((_ item:Int)->())?
    
    var itemsInLine:Int = 3
    
    var collectionView:UICollectionView!
    
    init(items:[ShareItem]){
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }
    func clickItemHandle(clickItems:((_ itemIndex:Int)->())?){
        self.clickItems = clickItems
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SharePresentVC{
    
    func layoutUI(){
        self.view.backgroundColor = UIColor.clear
        var row = 0
        if items.count%itemsInLine == 0{
            row = Int(items.count/itemsInLine)
        }else{
            row = Int(items.count/itemsInLine)+1
        }
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: CGFloat(row)*kRowHeight)
            
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        self.view.addSubview(blurEffectView)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (_sw-40)/CGFloat( itemsInLine ), height: kRowHeight)
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        self.view.addSubview(collectionView)
        self.collectionView.frame = self.view.bounds.insetBy(dx: 20, dy: 0)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName:"SharePresentCell" ,bundle:Bundle.main) , forCellWithReuseIdentifier: "SharePresentCell")

        
    }
    
}


extension SharePresentVC:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SharePresentCell", for: indexPath) as! SharePresentCell
        cell.imageV.image = self.items[indexPath.row].img
        cell.nameLabel.text = self.items[indexPath.row].name
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true){ [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.clickItems?(indexPath.row )
        }
    }
    
}

extension UIViewController{
    
    
    func zz_sharepresentController(items:[ShareItem],clickItemHandler:((_ index:Int)->())?,completion:(() -> ())? = nil){
        // 这个相当于toViewController
        let svc:SharePresentVC = SharePresentVC(items: items)
        svc.clickItemHandle { (itemIndx) -> () in
            clickItemHandler?(itemIndx)
        }
        // 创建PresentationController
        let customPresentationController:SharePresentCustomeVC = SharePresentCustomeVC(presentedViewController: svc, presenting: self)
        svc.transitioningDelegate = customPresentationController
        self.present(svc, animated: true, completion: completion)
    }
    
    
    
    func zz_invitePresentController(clickItemHandler:@escaping ((_ type:ShareTap)->()),completion:(() -> ())? = nil){
        
        var items:[ShareItem] = []
        //确定安装了微信安装微信
        if WXApi.isWXAppSupport() && WXApi.isWXAppInstalled(){
            items.append( ShareItem(name:"微信",img:ImageAsset.WxFriend.image))
            items.append( ShareItem(name:"朋友圈",img:ImageAsset.WxCircle.image))
        }else{
//            ZZAlert.showAlert(self, meg: "安装微信客户端才可以使用")
            return
        }
        
        // 这个相当于toViewController
        let svc:SharePresentVC = SharePresentVC(items: items)
        svc.itemsInLine = 2
        svc.clickItemHandle { (itemIndx) -> () in
            let item = items[itemIndx]
            switch item.name{
            case "微信":
                clickItemHandler(.Wx)
            case "朋友圈":
                clickItemHandler(.Circle)
            default:
                break
            }
        }
        // 创建PresentationController
        let customPresentationController:SharePresentCustomeVC = SharePresentCustomeVC(presentedViewController: svc, presenting: self)
        svc.transitioningDelegate = customPresentationController
        self.present(svc, animated: true, completion: completion)
    }
    
}
enum ShareTap{
    case Wx
    case Circle
}











