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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        bookingIcon.isHidden = true
    }

}
