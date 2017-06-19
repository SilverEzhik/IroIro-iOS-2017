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
    @IBOutlet var tags: TagListView!
    
    var note: Note!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let noteColor = ((note.tags?.allObjects[0] as! Tag).color as! UIColor) ?? UIColor.white
        
        name.text = note.name
        content.text = (note.content as! NSAttributedString).string
        time.text = timeAgoSinceDate(date: ), numericDates: <#T##Bool#>)
        
        name.textColor = noteColor
        content.textColor = noteColor
        
        tags.tagBackgroundColor = Colors.darker(noteColor)
        
        for tag in note.tags! {
            tags.addTag("#" + (tag as! Tag).name!)
        }
    }
    
    //Note.content! as NSAttributedString

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
