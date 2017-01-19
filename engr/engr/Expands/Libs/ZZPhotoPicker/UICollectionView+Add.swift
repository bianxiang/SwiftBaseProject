//
//  UICollectionView+Add.swift
//  ZZImagePicker
//
//  Created by duzhe on 16/4/27.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit
import Photos

extension UICollectionView{
    
//    func zz_indexPathsForElementsInRect(_ rect:CGRect) -> [IndexPath] {
//        let allLayoutAttributes = self.collectionViewLayout.layoutAttributesForElements(in: rect)
//        if let allLayoutAttributes = allLayoutAttributes ,  allLayoutAttributes.count == 0 {
//            var indexPaths = [IndexPath]()
//            for attr in allLayoutAttributes{
//                let indexPath = attr.indexPath
//                indexPaths.append(indexPath)
//            }
//            return indexPaths
//        }else {
//            return []
//        }
//    }
    
}

extension IndexSet{
    
//    func zz_indexPathsFromIndexesWithSection(_ section:Int)->[IndexPath]{
//        
//        var indexPaths = [IndexPath]()
//        
//        self.forEach { (idx) in
//            indexPaths.append(IndexPath(item: idx, section: section))
//        }
//        return indexPaths
//        
//    }
    
}

extension UIViewController{

    fileprivate func authorize(_ status: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus())->Bool{
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            // 请求授权
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    _ = self.authorize(status)
                })
            })
        default: ()
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: "访问相册受限",
                message: "点击“设置”，允许访问您的相册",
                preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title:  "取消", style: .cancel, handler:nil)
            
            let settingsAction = UIAlertAction(title: "设置", style: .default, handler: { (action) -> Void in
                let url = URL(string: UIApplicationOpenSettingsURLString)
                if let url = url , UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                }
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
        }
        return false
    }
    
//    func zz_presentPhotoVC(_ maxSelected:Int,completeHandler:((_ assets:[PHAsset])->())?) -> ZZPhotoViewController?{
//        guard authorize() else { return nil }
//        if let vc = UIStoryboard(name: "ZZImage", bundle: Bundle.main).instantiateViewController(withIdentifier: "photoVC") as? ZZPhotoViewController{
//            vc.completeHandler = completeHandler
//            vc.maxSelected = maxSelected
//            let nav = UINavigationController(rootViewController: vc)
//            self.present(nav, animated: true, completion: nil)
//            return vc
//        }
//        return nil
//    }
    
    
}








