//
//  CustomTableViewCell.swift
//  Homework9App
//
//  Created by 1 on 28.10.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var posterTitleLabel: UILabel!
    @IBOutlet weak var voteAvarageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
