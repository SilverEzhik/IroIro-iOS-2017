//
//  TagCell.swift
//  IroIro
//
//  Created by neoman nouiouat on 6/6/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class TagCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    var color:UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        name.textColor = color
        count.color = Colors.darker(color)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
