//
//  UserDefults.swift
//  project1
//
//  Created by nikita on 06.02.2023.
//

import UIKit

class UserCustomDefults: NSObject, Codable {
    var imageViewCount: Int
    
    init(imageViewCount: Int) {
        self.imageViewCount = imageViewCount
    }
}

