//
//  ResultsVC.swift
//  Covid 2
//
//  Created by Austin O'Neil on 4/16/20.
//  Copyright © 2020 Austin O'Neil. All rights reserved.
//


import UIKit

class ResultsVC: UIViewController, DataManagerDelegate {
    func didFail(error: Error) {
        print(error)
    }
    
    func didUpdateData(_ dataManager: DataManager, data: CovidModel) {
          DispatchQueue.main.async {

            self.todayCasesLabel.text = data.casesString
            self.todaysDeathsLabel.text = data.todaysDeathsString
            self.totalCasesLabel.text = data.cases
            self.totalDeathsLabel.text = data.totalDeaths
            self.totalCriticalLabel.text = data.totalCrticial
            self.totalRecoveredLabel.text = data.totalRecovered
            self.totalActiveLabel.text = data.totalActive
            self.totalTestsLabel.text = data.totalTestsDone
                if self.totalTestsLabel.text == "0" {
                    self.totalTestsLabel.text = "Not Available"
             }
            if self.totalRecoveredLabel.text == "0" {
                self.totalRecoveredLabel.text = "Not Available"
            }
       }
    }
    
    var vc = ViewController()
    var dataManager = DataManager()
    var date = Date()
    var placeholder: String = ""
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var todayCasesLabel: UILabel!
    @IBOutlet weak var todaysDeathsLabel: UILabel!
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var totalTestsLabel: UILabel!
    @IBOutlet weak var totalCriticalLabel: UILabel!
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    @IBOutlet weak var totalActiveLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        if self.placeholder == "Worldwide Total" {
                  placeholder = "World"
                       }
        dataManager.fetchData(countryName: placeholder)
        navigationItem.title = "\(placeholder)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.countryLabel.text = placeholder
        print(placeholder)
        dataManager.delegate = self
      
        let formattedDate = dateFormat(date: Date())
        self.dateLabel.text = "Results for \(formattedDate)"
        self.todayCasesLabel.begin()
        self.totalCasesLabel.begin()
        self.todaysDeathsLabel.begin()
        self.totalDeathsLabel.begin()
        self.totalTestsLabel.begin()
        self.totalCriticalLabel.begin()
        self.totalRecoveredLabel.begin()
        self.totalActiveLabel.begin()
        self.todayCasesLabel.fadeIn()
        self.totalCasesLabel.fadeIn()
        self.todaysDeathsLabel.fadeIn()
        self.totalDeathsLabel.fadeIn()
        self.totalTestsLabel.fadeIn()
        self.totalCriticalLabel.fadeIn()
        self.totalRecoveredLabel.fadeIn()
        self.totalActiveLabel.fadeIn()
        
//        if self.totalTestsLabel.text == "0" {
//            self.totalTestsLabel.text = "Not Available"
//        }
    }
    
    func dateFormat(date: Date) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .medium
           return dateFormatter.string(from: date)
       }

}


extension UILabel {
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
        self.alpha = 1.0
        })
}
    func begin() {
        self.alpha = 0
    }
}

