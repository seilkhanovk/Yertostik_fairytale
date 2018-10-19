//
//  ModelOfAudio.swift
//  Ertegi
//
//  Created by Kuanysh on 29.08.17.
//  Copyright © 2017 KuanyshTeam. All rights reserved.
//

import Foundation
import UIKit

struct listOfAudio {
    
    var name = ""
    var description = ""
    var cover: UIImage?
    
    init(_ name: String, _ description: String, cover: UIImage) {
        self.name = name
        self.description = description
        self.cover = cover
    }
    
   /* static func loadData () -> [listOfAudio] {
        return
        [listOfAudio("Мақта қыз бен мысық", "Ыбырай Алтынсарин", cover: #imageLiteral(resourceName: "Мақта қыз бен мысық-1"))]
    }*/
    
}
