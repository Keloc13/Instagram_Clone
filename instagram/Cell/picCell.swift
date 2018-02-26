//
//  picCell.swift
//  instagram
//
//  Created by Kevin Nguyen on 2/25/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit

class picCell: UITableViewCell {

    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var imageDescript: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
