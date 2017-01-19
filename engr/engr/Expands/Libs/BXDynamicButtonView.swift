//*=====================================*
//* 公司:上海笑溢网络科技有限公司            *
//* 开发作者:卞翔                        *
//* 联系QQ: 1023537528                   *
//* iOS技术交流群: 160603792              *
//* GitHub:https://github.com/bianxiang *
//* CSDN:http://blog.csdn.net/bx_jobs   *
//*=====================================*
//*/



import UIKit

class BXDynamicButtonView: UIView {

    typealias OnClick = (_ title:String,_ index:Int)->Void
    
    var onClick:OnClick?
    
    var titles = [String]()
    var enables : [Bool]?
    
    func titlesHas(_ titles:[String],enables:[Bool]? = nil,onClick:@escaping OnClick) {
        self.zz_removeAllSubviews()
        self.titles = titles
        self.enables = enables
        self.onClick = onClick
        
        var i:CGFloat = 0
        
        var btnW = (self.frame.size.width - 20*CGFloat(titles.count-1))/CGFloat(titles.count)
        if titles.count == 1 {
            btnW = (self.frame.size.width)/CGFloat(titles.count)
        }
        
        for title in titles {
            
            let btn = UIButton(frame: CGRect(x: i * btnW + 20*(i), y: 0, width: btnW, height: self.frame.size.height))
            btn.setTitle(title, for: UIControlState())
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.tag = Int(i)
            btn.addTarget(self, action: #selector(BXDynamicButtonView.btnClick(_:)), for: .touchUpInside)
            btn.backgroundColor = UIColor.main
            if let enables = enables {
                btn.isEnabled = (enables[Int(i)])
            }else {
                btn.isEnabled = true
            }
            
            self.addSubview(btn)
            
            i += 1
            
        }
    }
    func btnClick(_ sender:UIButton){
        self.onClick!(sender.currentTitle!,sender.tag)
    }
    override func layoutSubviews() {
        var i:CGFloat = 0
        
        var btnW = (self.frame.size.width - 1*CGFloat(titles.count-1))/CGFloat(titles.count)
        if titles.count == 1 {
            btnW = (self.frame.size.width)/CGFloat(titles.count)
        }
        for btn in self.subviews {
            btn.frame = CGRect(x: i * btnW + 1*(i), y: 0, width: btnW, height: self.frame.size.height)
            i += 1
        }
        
        
    }

}
