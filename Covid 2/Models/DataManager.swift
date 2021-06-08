//
//  DataManager.swift
//  Covid 2
//
//  Created by Austin O'Neil on 4/16/20.
//  Copyright © 2020 Austin O'Neil. All rights reserved.
//

import Foundation

protocol DataManagerDelegate {
    func didFail(error: Error)
    func didUpdateData(_ dataManager: DataManager, data: CovidModel)
}

struct DataManager {
    
    var delegate: DataManagerDelegate?
    var dataArray:NSArray = []
    
    
    let covidURL = "https://coronavirus-19-api.herokuapp.com/countries/"
    
    func fetchCountries() {
        let urlString = "\(covidURL)"
        performRequest(with: urlString)
    }
    
    func fetchData(countryName: String) {
        let urlString = "\(covidURL)"
        let escapedString = urlString + (countryName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "total:")
        performRequest(with: escapedString)
        print(escapedString)
    }
    
    func performRequest(with URLString: String) {
        
        if let url = URL(string: URLString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFail(error: error!)
                    return
                }
                if let safeData = data {
                    
                    if let covidData = self.parseJSON(safeData) {
                        
                        self.delegate?.didUpdateData(self, data: covidData)
                        
                    }
                    
                }
            }
            task.resume()
            
        }
        
        
    }
    
    func parseJSON(_ coronaData: Data) -> CovidModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CovidData.self, from: coronaData)
            
            let country = decodedData.country
            let cases = decodedData.cases
            let todayCases = decodedData.todayCases
            let deaths = decodedData.deaths
            let todayDeaths = decodedData.todayDeaths
            let recovered = decodedData.recovered
            let active = decodedData.active
            let critical = decodedData.critical
            let totalTests = decodedData.totalTests
            
        
            let covidResults = CovidModel(
                countryName: country,
                cases: cases?.withCommas() ?? "0",
                todaysCases: todayCases,
                totalDeaths: deaths?.withCommas() ?? "N/A",
                todaysDeaths: todayDeaths ,
                totalRecovered: recovered?.withCommas() ?? "0",
                totalActive: active?.withCommas() ?? "N/A",
                totalCrticial: critical?.withCommas() ?? "N/A",
                totalTestsDone: totalTests?.withCommas() ?? "N/A")
            return covidResults
        } catch {
            delegate?.didFail(error: error)
            return nil
        }
        
        
    }
}
