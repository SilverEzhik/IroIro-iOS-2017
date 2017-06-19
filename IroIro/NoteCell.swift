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

    }
    func setupCell() {
        var noteColor: UIColor
        if note.tags?.count == 0 {
            noteColor = UIColor.white
        } else {
            noteColor = ((note.tags?.firstObject as! Tag).color as! UIColor)
        }
        
        print("setting up cell?")
        name.text = note.name ?? ""
        print(name.text)
        content.text = (note.content as! NSAttributedString).string
        print("setting up time")
        time.text = timeAgoSinceDate(date: note.time as! NSDate, numericDates: false)
        print("time set")
        name.textColor = noteColor
        content.textColor = noteColor
        time.textColor = Colors.darker(noteColor)
        print("got you color")
        print("colors set")
        if let noteTags = note.tags {
            print("apparently there are tags")
            print(noteTags.count)
            for tag in noteTags {
                let tagView = tags.addTag("#" + ((tag as! Tag).name!))
                print(tagView.currentTitle)
                tagView.backgroundColor = Colors.darker(noteColor)
                tagView.textColor = UIColor.white
            }
        }
        //tags.tagBackgroundColor = Colors.darker(noteColor)
        //tags.tagBackgroundColor = noteColor
        //tags.textColor = UIColor.white
        
        print("setup cell")
        
    }
    //Note.content! as NSAttributedString

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
