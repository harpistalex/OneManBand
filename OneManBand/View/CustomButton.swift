//
//  CustomButton.swift
//  OneManBand
//
//  Created by Alexandra King on 03/07/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    //for programmatically created buttons
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    //for Storyboard/.xib created buttons
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    //called within the Storyboard editor itself for rendering @IBDesignable controls
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        // Common logic goes here
        refreshCorners(value: cornerRadius)
        
        
    }
    
    //Rounded corners
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    //@IBInspectable variables are exposed to the Storyboard UI, which allows you to change these properties via the "Attributes Inspector". 15 is default value.
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
}
