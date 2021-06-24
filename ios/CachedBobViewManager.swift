import SDWebImage
import UIKit

@objc(CachedBobViewManager)
class CachedBobViewManager: RCTViewManager {
  override func view() -> (CachedBobImageView) {
    return CachedBobImageView()
  }
}

class CachedBobImageView: UIImageView {
    
    var label = CachedBobLabel()
    
    @objc var uri: String = "" {
        didSet {
            didSetProps()
        }
      }
    
    
    @objc var priority: String = "" {
        didSet {
            didSetProps()
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    func didSetProps() {
        if (uri == "" || priority == "") {
            return
        }
        
        self.sd_imageIndicator = SDWebImageProgressIndicator.`default`
        let url = URL(string: uri)
        self.sd_setImage(with: url)
        
        label.setText("4K")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CachedBobLabel: UIView {
    
    var lb: UILabel = {
        let lb = UILabel()
        lb.text = "4K"
        lb.textColor = UIColor.black
        lb.font = UIFont.systemFont(ofSize: 10)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        layer.cornerRadius = 4
        
        addSubview(lb)
        lb.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lb.centerYAnchor.constraint(equalTo: centerYAnchor).isActive  = true
        
        widthAnchor.constraint(equalTo: lb.widthAnchor, constant: 8).isActive = true
        heightAnchor.constraint(equalTo: lb.heightAnchor, constant: 8).isActive = true
    }
    
    func setText(_ text: String) {
        lb.text = text
        lb.sizeToFit()
        
        lb.frame.origin = CGPoint(x: 4, y: 4)
        frame.size = CGSize(width: lb.frame.width + 8, height: lb.frame.height + 8 )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
