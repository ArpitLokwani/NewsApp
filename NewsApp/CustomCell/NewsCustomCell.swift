//
//  NewsCustomCell.swift
//  NewsApp
//
//  Created by Arpit Lokwani on 27/06/20.
//  Copyright © 2020 Arpit Lokwani. All rights reserved.
//

import UIKit

class NewsCustomCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var newsImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var titlePlaceholderLabel: UILabel!
    
    @IBOutlet weak var descPlaceholderLabel: UILabel!
    @IBOutlet weak var authorPlaceholderLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
