//
//  Pokemon.swift
//  _Pokemon Json
//
//  Created by Raphael de Melo Silva on 19/09/16.
//  Copyright © 2016 Raphael de Melo Silva. All rights reserved.
//

import UIKit

class Pokemon: NSObject {
    
    var id:String = ""
    var nome:String = ""
    var hp:String = ""
    var raridade:String = ""
    var tipo:[String] = []
    var imagemUrl:String = ""
    var artista:String = ""

}

//trabalhando com substring - Já  mudou em Swift 3
/*
 var str = "Hello, playground"
 str.substringWithRange(Range<String.Index>(start: str.startIndex, end: str.endIndex)) //"Hello, playground"
 
 
 var str = "Hello, playground"
 str.substringWithRange(Range<String.Index>(start: str.startIndex.advancedBy(2), end: str.endIndex.advancedBy(-1))) //"llo, playgroun"
 */
