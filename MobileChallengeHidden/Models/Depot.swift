//
//  Depot.swift
//  MobileChallengeHidden
//
//  Created by imac dt on 15/11/2018.
//  Copyright © 2018 Libasse MBAYE. All rights reserved.
//

import Foundation

class Depot {
    var name: String
    var description: String
    var etoile: Int
    var user: String
    var avatar: String
    
    init(name: String,description: String,etoile: Int,user: String,avatar:String) {
        self.name = name
        self.description = description
        self.etoile = etoile
        self.user = user
        self.avatar = avatar
    }
}
