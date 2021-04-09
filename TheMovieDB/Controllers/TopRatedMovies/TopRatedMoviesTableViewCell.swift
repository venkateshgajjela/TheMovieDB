//
//  TopRatedMoviesTableViewCell.swift
//  TheMovieDB
//
//  Created by VENKSTESHKSTL on 07/04/21.
//

import UIKit

class TopRatedMoviesTableViewCell: UITableViewCell {

    @IBOutlet var cellBgView: UIView!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
