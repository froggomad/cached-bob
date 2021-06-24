//
//  CachedBobLabel.swift
//  CachedBob
//
//  Created by Nazim Gadzhiagayev on 24.06.2021.
//  Copyright © 2021 Facebook. All rights reserved.
//

import Foundation
import UIKit

//class CachedBobLabel: UIView {
//    
//    var lb: UILabel = {
//        let lb = UILabel()
//        lb.text = "4K"
//        lb.textColor = UIColor.black
//        lb.font = UIFont.systemFont(ofSize: 10)
//        return lb
//    }()
//    
//    init() {
//        super.init(frame: .zero)
//        
//        backgroundColor = UIColor.gray.withAlphaComponent(0.4)
//        layer.cornerRadius = 4
//        
//        addSubview(lb)
//    }
//    
//    func setText(_ text: String) {
//        lb.text = text
//        lb.sizeToFit()
//        
//        lb.frame.origin = CGRect(x: 4, y: 4)
//        frame.size = CGSize(width: lb.frame.width + 8, height: lb.frame.height + 8 )
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
