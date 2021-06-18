//
//  AllCountriesVC.swift
//  Covid 2
//
//  Created by Austin O'Neil on 4/16/20.
//  Copyright © 2020 Austin O'Neil. All rights reserved.
//

import UIKit


class AllCountriesVC: UITableViewController {

    var dataManager = DataManager()
    var placeholder: String = "Test"
    var data = [CovidData]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
//            self.createSpinnerView()
            self.load()
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(placeholder)
        tableView.rowHeight = 200
        self.tableView.reloadData()
        self.createSpinnerView()
    }

    
    func formatted() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
    }

    func load() {
        if let url = URL(string: "https://coronavirus-19-api.herokuapp.com/countries/") {
             let jsonData = try! Data(contentsOf: url)
            self.data = try! JSONDecoder().decode([CovidData].self, from: jsonData)

                let stuff = data.distance(from: 0, to: 4)
                data.remove(at: stuff)
            
            self.tableView.reloadData()

        }
        

        
        
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()
        
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            child.willMove(toParent: nil)
                    child.view.removeFromSuperview()
                    child.removeFromParent()
        }
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Fetching")
        return data.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let countryData = data[indexPath.row]
    

        let arrayTwo = "Today's Cases: " + String(countryData.todayCases?.withCommas() ?? "N/A")
            + " \nToday's Deaths: " + String(countryData.todayDeaths?.withCommas() ?? "N/A")
            + " \nTotal Tested: " + String(countryData.totalTests?.withCommas() ?? "N/A")
            
                
        let array = (arrayTwo + " \nActive Cases: " + String(countryData.active?.withCommas() ?? "N/A") + " \nTotal Deaths: " + String(countryData.deaths?.withCommas() ?? "N/A") + " \nRecovered: " + String(countryData.recovered?.withCommas() ?? "0"))
    //ADD TOTALS
        
        cell.textLabel?.text = countryData.country
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24)
        cell.detailTextLabel?.numberOfLines = 9
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.detailTextLabel?.text =  array
       
        return cell
    }
}
