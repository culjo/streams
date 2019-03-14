//
//  MovieDetailTableViewCell.swift
//  Streams
//
//  Created by MAC on 3/13/19.
//  Copyright © 2019 novugrid. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    
    static let resuseId = "MovieDetailTableViewCell"
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(key: String, value: String) {
        keyLabel.text = key
        valueLabel.text = value
    }

}
