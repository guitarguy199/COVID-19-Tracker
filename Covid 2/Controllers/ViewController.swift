//
//  ViewController.swift
//  Covid 2
//
//  Created by Austin O'Neil on 4/16/20.
//  Copyright © 2020 Austin O'Neil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
 
    
    var dataManager = DataManager()
    var selectedCountry: String? = nil
    var pickerData = PickerData()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
             navigationController?.setNavigationBarHidden(true, animated: true)
             countrySelect.isHidden = true
             countrySelect.delegate = self
             searchButton.isHidden = true
             searchOne.isHidden = false
             allCountriesOutlet.isHidden = false
             orLabel.isHidden = false
             xButton.isHidden = true
             xButton.layer.cornerRadius = 0.5 * xButton.bounds.size.width
             xButton.clipsToBounds = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchOne.layer.cornerRadius = searchOne.frame.height / 2
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        allCountriesOutlet.layer.cornerRadius = allCountriesOutlet.frame.height / 2
    }
    
    override func viewDidDisappear(_ animated: Bool) {
          navigationController?.setNavigationBarHidden(false, animated: true)

    }


    @IBOutlet weak var countrySelect: UIPickerView!
    @IBOutlet weak var xButton: UIButton!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResultsVC" {
        let destinationVC = segue.destination as! ResultsVC

            destinationVC.placeholder = selectedCountry ?? "World"
        }
         else if segue.identifier == "goToAllCountriesVC" {}
    }
    
    @IBOutlet weak var searchButton: UIButton!
    
    

    @IBAction func searchButtonPressed(_ sender: Any) {}
    
    @IBOutlet weak var searchOne: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    
    
    @IBAction func countrySearchOne(_ sender: UIButton) {
            countrySelect.isHidden = false
            searchOne.isHidden = true
            searchButton.isHidden = false
            orLabel.isHidden = true
            xButton.isHidden = false
            allCountriesOutlet.isHidden = true
    }


    

    @IBAction func xButtonPressed(_ sender: UIButton) {
                countrySelect.isHidden = true
                searchOne.isHidden = false
                searchButton.isHidden = true
                allCountriesOutlet.isHidden = false
                orLabel.isHidden = false
                xButton.isHidden = true
    }

    @IBAction func allCountriesPressed(_ sender: UIButton) {}
    
    @IBOutlet weak var allCountriesOutlet: UIButton!
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData.data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard row < pickerData.data.count else {
            return
        }
        if pickerData.data[0] == selectedCountry {
            selectedCountry = "World"
        } else {
            selectedCountry = pickerData.data[row]
        }
    }
}

