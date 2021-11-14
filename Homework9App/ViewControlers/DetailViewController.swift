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
    
    var movie: Result? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let imageUrl = "https://image.tmdb.org/t/p/w500/"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepare()
    }
    
    func prepare() {
        self.posterDescriptionLabel.text = movie?.overview
        self.releaseDateLabel.text = movie?.firstAirDate
        if let avarage = movie?.voteAverage {
            self.voteAvarageLabel.text = "Vote Avarage: \(avarage)"
        }
        if let imagePath = self.movie?.posterPath {
            let pathString = imageUrl + imagePath
            
            self.posterImage.sd_setImage(with: URL(string: pathString),
                                         placeholderImage: UIImage.init(systemName: "user"))
        }
    }
   
}
