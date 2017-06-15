//
//  Colors.swift
//  NoteTest
//
//  Created by Ezhik on 6/14/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class Colors: NSObject {
    static let Lime = UIColor(hexString: "A4C400")
    static let Green = UIColor(hexString: "60A917")
    static let Emerald = UIColor(hexString: "008A00")
    static let Teal = UIColor(hexString: "00ABA9")
    
    static let Cyan = UIColor(hexString: "1BA1E2")
    static let Cobalt = UIColor(hexString: "0050EF")
    static let Indigo = UIColor(hexString: "6A00FF")
    static let Violet = UIColor(hexString: "AA00FF")
    
    static let Pink = UIColor(hexString: "F472D0")
    static let Magenta = UIColor(hexString: "D80073")
    static let Crimson = UIColor(hexString: "A20025")
    static let Red = UIColor(hexString: "E51400")
    
    static let Orange = UIColor(hexString: "FA6800")
    static let Amber = UIColor(hexString: "F0A30A")
    static let Yellow = UIColor(hexString: "E3C800")
    static let Brown = UIColor(hexString: "825A2C")
    
    static let Olive = UIColor(hexString: "6D8764")
    static let Steel = UIColor(hexString: "647687")
    static let Mauve = UIColor(hexString: "76608A")
    static let Taupe = UIColor(hexString: "87794E")
    
    static let Array = [Lime, Green, Emerald, Teal,
                        Cyan, Cobalt, Indigo, Violet,
                        Pink, Magenta, Crimson, Red,
                        Orange, Amber, Yellow, Brown,
                        Olive, Steel, Mauve, Taupe]
    
    static func random() -> UIColor {
        return Array[Int(arc4random_uniform(UInt32(Array.count)))]
    }
}
