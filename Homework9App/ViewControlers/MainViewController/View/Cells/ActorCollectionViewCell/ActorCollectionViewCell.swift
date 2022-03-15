//
// ActorCollectionViewCell.swift
//  Homework9App
//
//  Created by 1 on 21.11.2021.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var actorPathImageView: UIImageView!
    
    static let identifier = String(describing: ActorCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cornerRaduis()
    }
    
    //Static func
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    //Public func
    public func configureWith(actorName: String?, imagePath: String?) {
        actorNameLabel.text = actorName
        loadImage(imagePath: imagePath)
    }
    
    //Private func
    private func cornerRaduis() {
        self.actorPathImageView.layer.cornerRadius = self.actorPathImageView.frame.height / 2
    }
    
    private func loadImage(imagePath: String?) {
        
        guard imagePath != nil else { return }
        
        let imageURL = URL(string: Constant.network.defaultImagePath + imagePath!)
        self.actorPathImageView.sd_setImage(with: imageURL, completed: nil)
    }
}

