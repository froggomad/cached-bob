import SDWebImage
import UIKit
import KDCircularProgress

@objc(CachedBobViewManager)
class CachedBobViewManager: RCTViewManager {
  override func view() -> (CachedBobImageView) {
    return CachedBobImageView()
  }
}

class CachedBobImageView: UIImageView {
    
    var label = CachedBobLabel()
    let progress = KDCircularProgress()
    var sources = [
        ["https://i.imgur.com/uxcy7TS.png"],
        ["https://i.imgur.com/gXdy1Vn.jpeg"],
        ["https://i.imgur.com/3rrydD4.png"],
        ["https://i.imgur.com/j8HdmNz.png"],
        ["https://upload.wikimedia.org/wikipedia/commons/e/e0/Large_Scaled_Forest_Lizard.jpg"]
    ]
    var current: Int = 0
    var color: UIColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    var progressCallback: SDImageLoaderProgressBlock?
    var completeCallback: SDExternalCompletionBlock?
    
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
        
        self.backgroundColor = self.color
        self.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        
        /**
         * Progress
         */
        
        self.addSubview(progress)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        progress.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        progress.heightAnchor.constraint(equalToConstant: 100).isActive = true
        progress.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        progress.trackThickness = 0.1
        progress.progressThickness = 0.1
        progress.glowAmount = 0.0
        progress.startAngle = -90
        progress.angle = 0
        progress.glowAmount = 0
        progress.trackColor = UIColor.black
        progress.set(colors: UIColor.red)
        
        // self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        progressCallback = { pr, size, url in
            
            let percent: Double = Double(pr) * 100 / Double(size)
            let a: Double = 360 / 100 * percent
            
            DispatchQueue.main.async { [weak self] in
                self?.progress.animate(toAngle: a, duration: 0.1, completion: nil)
            }
        }
        
        completeCallback = { [weak self] img, err, cacheType, url in
            self?.progress.isHidden = true
            self?.current += 1
            self?.loadNext()
        }
    }
    
    func next() {
        
        guard current < sources.count && sources[current].count > 0 else { return }
        
        /**
         * Image priority
         */
        let url = URL(string: sources[current][0])

        if priority == "high" {
            self.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, progress: progressCallback, completed: completeCallback)
        } else {
            self.sd_setImage(with: url, placeholderImage: nil, progress: progressCallback, completed: completeCallback)
        }
    }
    
    func loadNext() {
        guard current < sources.count && sources[current].count > 0 else { return }
        
        let url = URL(string: sources[current][0])
        
        let option: SDWebImageOptions = .lowPriority
        SDWebImageManager.shared.loadImage(with: url, options: option, progress: nil) {
            [weak self] image, data, error, cacheType, bool, url in
            
            self?.image = image
            self?.current += 1
            self?.loadNext()
        }
    }
    
    func didSetProps() {
        if (uri == "" || priority == "") {
            return
        }

        self.next()
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
