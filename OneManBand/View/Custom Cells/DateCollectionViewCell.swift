//
//  DateCollectionViewCell.swift
//  OneManBand
//
//  Created by Alexandra King on 22/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bookingIcon: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    override var isSelected: Bool {
        didSet {
            self.containerView.backgroundColor = isSelected ? .ombDarkGrey : .ombLightGrey
        }
    }

}


