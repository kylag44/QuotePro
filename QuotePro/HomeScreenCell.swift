//
//  HomeScreenCell.swift
//  QuotePro
//
//  Created by Kyla  on 2018-09-12.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit

class HomeScreenCell: UITableViewCell {

  @IBOutlet weak var cellImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var quoteLabel: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


