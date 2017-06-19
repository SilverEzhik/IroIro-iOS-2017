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
        var noteColor: UIColor
        if note.tags?.count == 0 {
            noteColor = UIColor.white
        } else {
            noteColor = ((note.tags?.allObjects[0] as! Tag).color as! UIColor)
        }
        
        name.text = note.name
        content.text = (note.content as! NSAttributedString).string
        time.text = timeAgoSinceDate(date: note.time as! NSDate, numericDates: false)
        
        name.textColor = noteColor
        content.textColor = noteColor
        time.textColor = Colors.darker(noteColor)
        tags.tagBackgroundColor = Colors.darker(noteColor)
        tags.textColor = UIColor.white
        
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
