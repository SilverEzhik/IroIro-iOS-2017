//
//  Tag.swift
//  IroIro
//
//  Created by Neoman  Nouiouat on 6/5/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class Tag: NSObject {
    var name:String = ""
    var notes:[Int] = []
    var color:UIColor = UIColor.clear
    
    init(name:String,notes:[Int],color:UIColor){
        self.name=name
        self.notes=notes
        self.color=color
    }

}
