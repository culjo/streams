//
//  MovieTableViewCell.swift
//  Streams
//
//  Created by MAC on 3/13/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var metaData: UILabel!
    
    // Set the reuse identifier to the name to the cell class
    // Note: I can use the type of
    static let resuseId = "MovieTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(movie: Movie) {
        do {
            posterImage.downloadedFrom(url: try movie.poster.asURL(), contentMode: .scaleToFill)
        } catch {
            print("Cannot Load Movie Poster: Invalid Url..")
        }
        
        title.text = movie.title
        director.text = movie.director + " - " + movie.year
        metaData.text = movie.released
        
    }

}
