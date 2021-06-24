import SDWebImage

@objc(CachedBobViewManager)
class CachedBobViewManager: RCTViewManager {
  override func view() -> (CachedBobImageView) {
    return CachedBobImageView()
  }
}

class CachedBobImageView: UIImageView {
  @objc var uri: String = "" {
    didSet {
      self.sd_imageIndicator = SDWebImageProgressIndicator.`default`
      let url = URL(string: uri)
      self.sd_setImage(with: url)
    }
  }
}
