//
//  CovidData.swift
//  Covid 2
//
//  Created by Austin O'Neil on 4/16/20.
//  Copyright © 2020 Austin O'Neil. All rights reserved.
//

import Foundation

struct Results: Codable {
    let hits: [CovidData]
}

struct CovidData: Codable {
    let country: String?
    let cases: Int?
    let todayCases: Int?
    let deaths: Int?
    let todayDeaths: Int?
    let recovered: Int?
    let active: Int?
    let critical: Int?
    let totalTests: Int?
}




//json

//"country": "Canada",
//"cases": 29929,
//"todayCases": 1550,
//"deaths": 1191,
//"todayDeaths": 181,
//"recovered": 9674,
//"active": 19064,
//"critical": 557,
//"casesPerOneMillion": 793,
//"deathsPerOneMillion": 32,
//"totalTests": 487625,
//"testsPerOneMillion": 12920
