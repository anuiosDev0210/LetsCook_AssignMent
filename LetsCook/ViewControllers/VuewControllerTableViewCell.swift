//
//  VuewControllerTableViewCell.swift
//  LetsCook
//
//  Created by Anu Agrawal on 5/9/21.
//

import UIKit

class VuewControllerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var linkButn: UIButton!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
