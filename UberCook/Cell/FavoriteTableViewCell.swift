//
//  FavoriteTableViewCell.swift
//  UberCook
//
//  Created by 超 on 2020/9/11.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var trackSwitch: UISwitch!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
