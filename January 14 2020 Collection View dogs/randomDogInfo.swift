//
//  randomDogInfo.swift
//  January 14 2020 Collection View dogs
//
//  Created by Margiett Gil on 1/14/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
typealias DogImage = String

struct RandomDogInfo: Decodable {
    let message: [DogImage]
    
}
