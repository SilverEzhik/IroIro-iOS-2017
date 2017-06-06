//
//  Note.swift
//  IroIro
//
//  Created by Neoman  Nouiouat on 6/5/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class Note: NSObject {
    var id: Int = 0
    var name:String = ""
    var content:String = ""
    var tags:[String] = []
    var time:Int = 0
    
    init(id:Int,name:String,content:String,tags:[String],time:Int) {
        self.id=id
        self.name=name
        self.content=content
        self.tags=tags
        self.time=time
    }
    

}
