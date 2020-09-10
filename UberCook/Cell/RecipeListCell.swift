//
//  RecipeListCell.swift
//  UberCook
//
//  Created by 超 on 2020/9/3.
//

import UIKit

class RecipeListCell: UITableViewCell {
    @IBOutlet weak var chefImageView: UIImageView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var chefNameLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipePointLabel: UILabel!
    @IBOutlet weak var recipeConLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
