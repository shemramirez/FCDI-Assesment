//
//  Region.swift
//  FDCI - iOSAssesment
//
//  Created by Shem Ramirez on 3/3/25.
//

import Foundation

struct CountryName: Codable, Hashable { 
    let common: String
}

struct Country: Codable {
    let name: CountryName
    let region: String
}
