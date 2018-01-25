//
//  Data.swift
//  getirHackathon
//
//  Created by Emre HAVAN on 25.01.2018.
//  Copyright © 2018 Emre HAVAN. All rights reserved.
//

import Foundation
import SwiftyJSON

struct jsonData {
    
    let value: String
    let id: String
    let key: String
    let createdAt: String
    
    init(userJson: JSON) {
        self.value = userJson["_id"]["value"].stringValue
        self.id = userJson["_id"]["_id"].stringValue
        self.key = userJson["_id"]["key"].stringValue
        self.createdAt = userJson["_id"]["createdAt"].stringValue
    }
}


