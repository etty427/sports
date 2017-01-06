//
//  articleCell.swift
//  sportsNews
//
//  Created by Etnuh on 1/3/17.
//  Copyright © 2017 Rainman Technologies. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var imgViewz: UIImageView!
   
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
