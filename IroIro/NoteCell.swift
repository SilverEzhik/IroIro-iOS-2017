//
//  NoteCell.swift
//  IroIro
//
//  Created by neoman nouiouat on 6/6/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    Note.content! as NSAttributedString

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
