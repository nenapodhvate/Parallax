//
//  Place.swift
//  Parallax
//
//  Created by Akari on 11.03.23.
//

import SwiftUI

//MARK: - Place Model
struct Place: Identifiable,Hashable{
    var id: String = UUID().uuidString
    var placeName: String
    var imageName: String
    var bgName: String
}

var resources: [Place] = [
    .init(placeName: "xolokillua",imageName: "black_hair_girl", bgName: "cloud"),
    .init(placeName: "xolokillua",imageName: "red_hair_girl", bgName: "city"),
    .init(placeName: "xolokillua ",imageName: "green_hair_girl", bgName: "forest")
]
