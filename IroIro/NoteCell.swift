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
    @IBOutlet weak var tagListView: TagListView!
    
    var noteColor: UIColor?
    var note: Note!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    func setupCell() {
        //var noteColor: UIColor
        if noteColor == nil {
            if note.tags?.count == 0 {
                noteColor = UIColor.white
            } else {
                noteColor = ((note.tags?.firstObject as! Tag).color as! UIColor)
            }
        }
        name.text = note.name ?? ""
        content.text = (note.content as! NSAttributedString).string
        time.text = timeAgoSinceDate(date: note.time as! NSDate, numericDates: false)
        name.textColor = noteColor
        content.textColor = noteColor
        time.textColor = Colors.darker(noteColor!)

        tagListView.tagBackgroundColor = Colors.darker(noteColor!)
        tagListView.textColor = UIColor.white
        //print("colors set")
        tagListView.removeAllTags()
        if let noteTags = note.tags {
            //print("apparently there are tags")
            print(noteTags.count)
            for tag in noteTags {
                tagListView.addTag("#" + ((tag as! Tag).name!))
                //print(tagView.currentTitle)
                //tagView.backgroundColor = Colors.darker(noteColor)
                //tagView.textColor = UIColor.white
            }
        }
    }
    //Note.content! as NSAttributedString

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
