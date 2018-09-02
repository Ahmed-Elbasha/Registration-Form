//
//  RegisterFormViewControllerCustomMethods.swift
//  RegisterForm
//
//  Created by Ahmed Elbasha on 8/23/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import Foundation
import UIKit

extension RegisterFormViewController {
    
    // MARK: Set DataSource and Delegates For UIControls
    func setDelegateForUIControls() {
        // Set Delegate for TextFields.
        codeTextField.delegate = self
        codeNumberTextField.delegate = self
        countryTextField.delegate = self
        cityTextField.delegate = self
        areaTextField.delegate = self
        fullNameTextField.delegate = self
        passwordTextField.delegate = self
        
        // Set Delegate for TableViews.
        codeTableView.delegate = self
        countryTableView.delegate = self
        cityTableView.delegate = self
        areaTableView.delegate = self
    }
    
    func setDataSourceForUIControls() {
        // Set DataSource for TableViews.
        codeTableView.dataSource = self
        countryTableView.dataSource = self
        cityTableView.dataSource = self
        areaTableView.dataSource = self
    }
    
    func fetchCountriesDataFromJsonResponse(handler: @escaping(_ status: Bool) -> ()) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        let countryEntity = NSEntityDescription.entity(forEntityName: "Country", in: managedContext!)
        let currencyEntity = NSEntityDescription.entity(forEntityName: "Currency", in: managedContext!)
        let codeEntity = NSEntityDescription.entity(forEntityName: "Code", in: managedContext!)
        
        Alamofire.request(generateGetCountriesApiUrl()).responseJSON { (response) in
            guard let countries = response.result.value as? [Dictionary<String, AnyObject>] else {return}
            
            for country in countries {
                let newCountry = NSManagedObject(entity: countryEntity!, insertInto: managedContext)
                let newCurrency = NSManagedObject(entity: currencyEntity!, insertInto: managedContext)
                let newCode = NSManagedObject(entity: codeEntity!, insertInto: managedContext)
                
                let countryId = country["Id"] as! Int32
                newCountry.setValue(countryId, forKey: "countryID")
                let countryEnglishTitle = country["TitleEN"] as! String
                newCountry.setValue(countryEnglishTitle, forKey: "countryEnglishTitle")
                let countryArabicTitle = country["TitleAR"] as! String
                newCountry.setValue(countryArabicTitle, forKey: "countryArabicTitle")
                
                let currencyId = country["CurrencyId"] as! Int32
                newCurrency.setValue(currencyId, forKey: "currencyID")
                let currencyEnglishTitle = country["CurrencyEN"] as! String
                newCurrency.setValue(currencyEnglishTitle, forKey: "currencyEnglishTitle")
                let currencyArabicTitle = country["CurrencyAR"] as! String
                newCurrency.setValue(currencyArabicTitle, forKey: "currencyArabicTitle")
                
                let codeNumber = country["Code"] as! String
                newCode.setValue(codeNumber, forKey: "code")
                let codeEnglishTitle = country["CodeEN"] as! String
                newCode.setValue(codeEnglishTitle, forKey: "codeEnglishTitle")
                let codeArabicTitle = country["CodeAR"] as! String
                newCode.setValue(codeArabicTitle, forKey: "codeArabicTitle")
                
                do {
                    try  managedContext?.save()
                    print("Countries Data Fetched Successfully.")
                    handler(true)
                } catch {
                    print("Data Fetch Operation Failed. \(error.localizedDescription)")
                    handler(false)
                }
            }
        }
    }
    
    func fetchCitiesDataFromJsonResponse(handler: @escaping(_ status: Bool) -> () ) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        let cityEntity = NSEntityDescription.entity(forEntityName: "City", in: managedContext!)
        
        Alamofire.request(generateGetCitiesApiUrl(countryId: Int32(countryId))).responseJSON { (response) in
            guard let cities = response.result.value as? [Dictionary<String, AnyObject>] else {return}
            
            for city in cities {
                let newCity = NSManagedObject(entity: cityEntity!, insertInto: managedContext)
                
                let cityId = city["Id"] as! Int32
                newCity.setValue(cityId, forKey: "cityId")
                let cityEnglishTitle = city["TitleEN"] as! String
                newCity.setValue(cityEnglishTitle, forKey: "cityEnglishTitle")
                let cityArabicTitle = city["TitleAR"] as! String
                newCity.setValue(cityArabicTitle, forKey: "cityArabicTitle")
                let countryId = city["CountryId"] as! Int32
                newCity.setValue(countryId, forKey: "countryId")
                
                do {
                    try  managedContext?.save()
                    print("Cities Data Fetched Successfully.")
                    handler(true)
                } catch {
                    print("Data Fetch Operation Failed. \(error.localizedDescription)")
                    handler(false)
                }
            }
        }
    }
}
