//
//  CovidModel.swift
//  Covid 2
//
//  Created by Austin O'Neil on 4/16/20.
//  Copyright © 2020 Austin O'Neil. All rights reserved.
//

import Foundation

struct CovidModel {
    let countryName: String?
    let cases: String?
    let todaysCases: Int?
    let totalDeaths: String?
    let todaysDeaths: Int?
    let totalRecovered: String?
    let totalActive: String?
    let totalCrticial: String?
    let totalTestsDone: String?
    
    var casesString: String {
        print(todaysCases!.withCommas())
        return String(todaysCases!.withCommas())
        
    }
    var todaysDeathsString: String {
        return String(todaysDeaths!.withCommas())
    }
}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
