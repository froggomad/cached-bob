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
    
    var current: Int = 0
    var color: UIColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    var progressCallback: SDImageLoaderProgressBlock?
    var completeCallback: SDExternalCompletionBlock?
    
    @objc var sources: [[String]] = [] {
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
        progress.setupProgramatically()
        progress.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progress.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        progressCallback = { pr, size, url in
            
            let percent: Double = Double(pr) * 100 / Double(size)
            let a: Double = 360 / 100 * percent
            
            DispatchQueue.main.async { [weak self] in
                self?.progress.animate(toAngle: a, duration: 0.1, completion: nil)
            }
        }
        
        completeCallback = { [weak self] img, err, cacheType, url in
            guard let self = self else { return }
            
            self.progress.isHidden = true
            
            self.label.setText(self.sources[self.current][1])
            
            self.current += 1
            self.loadNext()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func next() {
        
        guard current < sources.count && sources[current].count > 1 else { return }
        
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
        guard current < sources.count && sources[current].count > 1 else { return }
        
        let url = URL(string: sources[current][0])
        
        let option: SDWebImageOptions = .lowPriority
        SDWebImageManager.shared.loadImage(with: url, options: option, progress: nil) {
            [weak self] image, data, error, cacheType, bool, url in
            guard let self = self else { return }
            
            
            self.label.setText(self.sources[self.current][1])
            self.image = image
            self.current += 1
            self.loadNext()
        }
    }
    
    func didSetProps() {
        if (sources.count == 0 || priority == "") {
            return
        }
        
        self.next()
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

extension KDCircularProgress {
    
    func setupProgramatically(height: CGFloat = 100,
                              trackThickness: CGFloat = 0.1,
                              progressThickness: CGFloat = 0.1,
                              glowAmount: CGFloat = 0.0,
                              startAngle: CGFloat = -90,
                              angle: CGFloat = 0,
                              trackColor: UIColor = .black,
                              setColor: UIColor = .red) {
        translatesAutoresizingMaskIntoConstraints = false

        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
        
        trackThickness = trackThickness
        progressThickness = progressThickness
        glowAmount = glowAmount
        startAngle = startAngle
        angle = angle
        trackColor = trackColor
        set(colors: setColor)
    }
    
}
