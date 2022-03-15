//
//  DetailViewController.swift
//  Homework9App
//
//  Created by 1 on 25.10.2021.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var posterDescriptionLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteAvarageLabel: UILabel!
    
    var detailViewModel: DetailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepare()
    }
    
    func prepare() {
        self.posterDescriptionLabel.text = self.detailViewModel.movie?.overview
        self.releaseDateLabel.text = self.detailViewModel.movie?.firstAirDate
        if let avarage = self.detailViewModel.movie?.voteAverage {
            self.voteAvarageLabel.text = "Vote Avarage: \(avarage)"
        }
        if let imagePath = self.detailViewModel.movie?.posterPath {
            let pathString = Constant.ui.imageUrl + imagePath
            
            self.posterImage.sd_setImage(with: URL(string: pathString),
                                         placeholderImage: UIImage.init(systemName: "user"))
        }
    }
    
}
