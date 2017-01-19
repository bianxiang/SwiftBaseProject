//
//  ZZFlowLabelLayout.swift
//  CollectionViewAllInOne
//
//  Created by duzhe on 16/8/5.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit
// -首先，-(void)prepareLayout将被调用，默认下该方法什么没做，但是在自己的子类实现中，一般在该方法中设定一些必要的layout的结构和初始需要的参数等。
//
// -之后，-(CGSize) collectionViewContentSize将被调用，以确定collection应该占据的尺寸。注意这里的尺寸不是指可视部分的尺寸，而应该是所有内容所占的尺寸。collectionView的本质是一个scrollView，因此需要这个尺寸来配置滚动行为。
//
// -接下来-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect被调用，这个没什么值得多说的。初始的layout的外观将由该方法返回的UICollectionViewLayoutAttributes来决定。

class ZZFlowLabelLayout: UICollectionViewLayout {
    fileprivate var cellCount:Int!
    fileprivate var collectionSize:CGSize!
    
    fileprivate var width:CGFloat = 0 // 最大宽度
    var innerMargin:CGFloat = 20 // 内边距 两边总共
    var hmargin:CGFloat = 10    // 水平间距
    var itemHeight:CGFloat = 35 // 元素高度
    var vmargin:CGFloat = 10     // 垂直间距
    
    var items:[String] 
    fileprivate var fontSize:CGFloat
    fileprivate var itemsFrames:[Int:CGRect] = [:]
    
    init(items:[String],fontSize:CGFloat) {
        self.items = items
        self.fontSize = fontSize
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var line:CGFloat = 0
    override func prepare() {
        super.prepare()
        width = self.collectionView?.frame.size.width ?? 0
        cellCount = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        collectionSize = calContentSize()
    }
    
    
    fileprivate func calContentSize()->CGSize{
        guard items.count == cellCount else { return CGSize.zero }
        var superFrame = CGRect.zero // 上一个frmame
        itemsFrames.removeAll() // 计算前 先移除所有
        for i in 0 ..< cellCount{
            let lbWidth = self.getTextRectSize(items[i] as NSString,size: fontSize )+innerMargin
            if i == 0{
                // 第一个
                superFrame = CGRect(x: hmargin , y: vmargin , width: lbWidth , height: itemHeight )
            }else{
                // 其他
                if superFrame.maxX + lbWidth + hmargin*2 > width{
                    // 换行
                    superFrame = CGRect(x: hmargin , y: superFrame.maxY + vmargin , width: lbWidth , height: itemHeight)
                    
                }else{
                    // 不换行
                    superFrame = CGRect(x: superFrame.maxX + hmargin, y: superFrame.origin.y , width: lbWidth , height: itemHeight)
                }
            }
            // 记录 frame
            itemsFrames[i] = superFrame
        }
        return CGSize(width: width, height: superFrame.maxY+vmargin)
    }
    
    // 返回collectionView的内容的尺寸
    override var collectionViewContentSize : CGSize {
        return collectionSize
    }
    
    // 返回rect中的所有的元素的布局属性
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        if let count = self.cellCount {
            for i in 0 ..< count{
                //这里利用了-layoutAttributesForItemAtIndexPath:来获取attributes
                let indexPath = IndexPath(item: i, section: 0)
                let attributes =  self.layoutAttributesForItem(at: indexPath)
                attributesArray.append(attributes!)
            }
        }
        return attributesArray
    }
    
    // 返回对应于indexPath的位置的cell的布局属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attrs.frame = itemsFrames[(indexPath as NSIndexPath).row] ?? CGRect.zero
        return attrs
    }
    
    //    // 当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
    //    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    //        return true
    //    }
    
    /**
     根据文字 确定label的宽度
     */
    func getTextRectSize(_ text:NSString,size:CGFloat) -> CGFloat {
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: size)]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: CGSize.zero, options: option, attributes: attributes, context: nil)
        return rect.width
    }
}


//func getHeightWithTag(_ tags:[Tag]?,width:CGFloat)->CGFloat{
//    var strs:[String] = []
//    if let tags = tags{
//        for item in tags{
//            if let name = item.name{
//                strs.append(name as String)
//            }
//        }
//    }
//    let w_height:CGFloat = 10
//    let h_padding:CGFloat = 10
//    var superFrame = CGRect.zero
//    var isFirst = true
//    if strs.count>0{
//        for str in strs {
//            let lbWidth = Utils.getTextRectSize(str,size: 13)+35
//            if isFirst {
//                isFirst = false
//                superFrame = CGRect(x: 0, y: 0, width: lbWidth, height: 30)
//            }else{
//                if superFrame.maxX + lbWidth + w_height > width{
//                    // 换行
//                    superFrame = CGRect(x: 0 , y: superFrame.maxY + h_padding , width: lbWidth , height: 30)
//                    
//                }else{
//                    // 不换行
//                    superFrame = CGRect(x: superFrame.maxX + w_height, y: superFrame.origin.y , width: lbWidth, height: 30)
//                }
//            }
//        }
//    }
//    return superFrame.maxY + 14 + 14
//}

