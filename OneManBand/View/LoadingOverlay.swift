//
//  LoadingOverlay.swift
//  OneManBand
//
//  Created by Alexandra King on 24/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit

class LoadingOverlay: UIView {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        self.backgroundColor = UIColor.ombOverlay
        
        activityIndicator.center = self.center
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
