//
//  RegisterFormViewControllerCustomMethods.swift
//  RegisterForm
//
//  Created by Ahmed Elbasha on 8/23/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Alamofire

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
    
    // MARK: Fetching Data From GetCountries Web API
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
    
    // MARK: Fetching Data From GetCities Web API
    func fetchCitiesDataFromJsonResponse(countryId: Int32, handler: @escaping(_ status: Bool) -> ()) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        let cityEntity = NSEntityDescription.entity(forEntityName: "City", in: managedContext!)
        
        Alamofire.request(generateGetCitiesApiUrl(countryId: countryId)).responseJSON { (response) in
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
    
    // MARK: Store Countries Data Into Array
    func storeCountriesDataIntoArray(handler: @escaping(_ ststus: Bool) -> ()) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Country>(entityName: "Country")
        
        do {
            countriesArray = try managedContext?.fetch(fetchRequest)
            print("The count of countriesArray is: \(countriesArray.count)")
            print("Countries Data stored Successfully.")
            handler(true)
        } catch {
            print("Data Storing Operation Failed. \(error.localizedDescription)")
            handler(false)
        }
    }
    
    // MARK: Store Currencies Data Into Array
    func storeCurrenciesDataIntoArray(handler: @escaping(_ ststus: Bool) -> ()) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Currency>(entityName: "Currency")
        
        do {
            currenciesArray = try managedContext?.fetch(fetchRequest)
            print("The count of currenciesArray is: \(currenciesArray.count)")
            print("Currencies Data stored Successfully.")
            handler(true)
        } catch {
            print("Data Storing Operation Failed. \(error.localizedDescription)")
            handler(false)
        }
    }
    
    // MARK: Store Codes Data Into Array
    func storeCodesDataIntoArray(handler: @escaping(_ ststus: Bool) -> ()) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Code>(entityName: "Code")
        
        do {
            codesArray = try managedContext?.fetch(fetchRequest)
            print("The count of codesArray is: \(codesArray.count)")
            print("Code Data stored Successfully.")
            handler(true)
        } catch {
            print("Data Storing Operation Failed. \(error.localizedDescription)")
            handler(false)
        }
    }
    
    // MARK: Store Cities Data Into Array
    func storeCitiesDataIntoArray(handler: @escaping(_ ststus: Bool) -> ()) {
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<City>(entityName: "City")
        
        do {
            citiesArray = try managedContext?.fetch(fetchRequest)
            print("The count of citiesArray is: \(citiesArray.count)")
            print("City Data stored Successfully.")
            handler(true)
        } catch {
            print("Data Storing Operation Failed. \(error.localizedDescription)")
            handler(false)
        }
    }
    
    // MARK: Perform Fetching Data From GetCountries Web API Operation
    func performFetchingGetCountriesWebApiDataOperation() {
        self.fetchCountriesDataFromJsonResponse { (complete) in
            if complete {
                self.storeCountriesDataIntoArray(handler: { (complete) in
                    if complete {
                        self.countryTableView.reloadData()
                    } else {
                        return
                    }
                })
                
                self.storeCodesDataIntoArray(handler: { (complete) in
                    if complete {
                        self.codeTableView.reloadData()
                    } else {
                        return
                    }
                })
                
                self.storeCurrenciesDataIntoArray(handler: { (complete) in
                    
                })
                
            } else {
                return
            }
        }
    }
    
    // MARK: Perform Fetching Data From GetCities Web API Operation
    func performFetchingGetCitiesWebApiDataOperation(countryId: Int32) {
        self.fetchCitiesDataFromJsonResponse(countryId: countryId, handler: { (complete) in
            if complete {
                self.storeCitiesDataIntoArray(handler: { (complete) in
                    if complete {
                        self.cityTableView.reloadData()
                    } else {
                        return
                    }
                })
                print("Operation is Finished")
            } else {
                print("Operation Failed")
                return
            }
        })
    }
    
    // MARK: The Implementation Happen when Register Button Touched.
    func isDataValid() -> Bool {
        if (fullNameTextField.text != "" && fullNameTextField.text != "Full Name" && fullNameTextField.text != "الآسم الآول") && (passwordTextField.text != "" && passwordTextField.text != "Password" && passwordTextField.text != "كلمة المرور") && (codeTextField.text != "" && codeTextField.text != "Code" && codeTextField.text != "الكود") && (codeNumberTextField.text != "12345" && codeNumberTextField.text != "") && (countryTextField.text != "" && countryTextField.text != "Country" && countryTextField.text != "الدولة") && (cityTextField.text != "" && cityTextField.text != "City" && cityTextField.text != "المدينة") && (areaTextField.text != "" && areaTextField.text != "Area" && areaTextField.text != "المنطقة") {
            return true
        } else {
            return false
        }
    }
    
    func showRegistrationSuccessAlertInEnglish() {
        let alertController = UIAlertController(title: "Success", message: "Registration is complete", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showRegistrationSuccessAlertInArabic() {
        let alertController = UIAlertController(title: "نجاح", message: "اكتمال التسجيل بنجاح", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "حسنا", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showRegistrationSuccessAlert() {
        if isArabic == false {
            showRegistrationSuccessAlertInEnglish()
        } else {
            showRegistrationSuccessAlertInArabic()
        }
    }
    
    func showRegistrationFailureInEnglish() {
        let alertController = UIAlertController(title: "Failure", message: "Registration is failed", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showRegistrationFailureInArabic() {
        let alertController = UIAlertController(title: "فشل", message: "فشل التسجيل", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "حسنا", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showRegistrationFailureAlert() {
        if isArabic == false {
            showRegistrationFailureInEnglish()
        } else {
            showRegistrationFailureInArabic()
        }
    }
    
    
    // MARK: Set Localization For UIControls
    func setLocalizationForChangeLanguageButtonInArabic() {
        changeLanguageButton.setTitle("تغيير اللغة", for: .normal)
        changeLanguageButton.setTitle("تغيير اللغة", for: .highlighted)
        changeLanguageButton.titleLabel?.font = UIFont(name: "GE Dinar One", size: 19)
    }
    
    func setLocalizationForRegisterButtonInArabic() {
        registerButton.setTitle("تسجيل", for: .normal)
        registerButton.setTitle("تسجيل", for: .highlighted)
        registerButton.titleLabel?.font = UIFont(name: "GE Dinar One", size: 17)
    }
    
    func setLocalizationForRegisterConfirmationLineInArabic() {
        confirmRegistrationStackView.semanticContentAttribute = .forceRightToLeft
        confirmRegisteringLabel.text = "بالضغط على زر تسجيل انت موافق على"
        confirmRegisteringLabel.textAlignment = .right
        confirmRegisteringLabel.font = UIFont(name: "GE Dinar One", size: 3)
        showTermsAndConditionsButton.setTitle(".الشروط و الآحكام", for: .normal)
        showTermsAndConditionsButton.setTitle(".الشروط و الآحكام", for: .highlighted)
        showTermsAndConditionsButton.titleLabel?.textAlignment = .right
        showTermsAndConditionsButton.titleLabel?.font = UIFont(name: "GE Dinar One", size: 3)
    }
    
    func setLocalizationForFullNameTextFieldInArabic() {
        if fullNameTextField.text == "Fulll Name" {
            fullNameTextField.text = "الآسم الكامل"
            fullNameTextField.textAlignment = .right
            fullNameTextField.font = UIFont(name: "GE Dinar One", size: 14)
        } else {
            fullNameTextField.textAlignment = .right
            fullNameTextField.font = UIFont(name: "GE Dinar One", size: 14)
        }
    }
    
    func setLocalizationForPasswordTextFieldInArabic() {
        if passwordTextField.text == "Password" {
            passwordTextField.text = "كلمة المرور"
            passwordTextField.textAlignment = .right
            passwordTextField.font = UIFont(name: "GE Dinar One", size: 14)
        } else {
            passwordTextField.textAlignment = .right
            passwordTextField.font = UIFont(name: "GE Dinar One", size: 14)
        }
    }
    
    func setLocalizationForCodeTextFieldInArabic() {
        codeImageView.image = UIImage(named: "list_small_ar")
        if codeTextField.text == "Code" {
            codeTextField.text = "الكود"
            codeTextField.textAlignment = .right
            codeTextField.font = UIFont(name: "GE Dinar One", size: 14)
        } else {
            codeTextField.textAlignment = .right
            codeTextField.font = UIFont(name: "GE Dinar One", size: 14)
        }
    }
    
    func setLocalizationForCodeNumberTextFieldInArabic() {
        codeNumberTextField.textAlignment = .right
        codeNumberTextField.font = UIFont(name: "GE Dinar One", size: 14)
    }
    
    func setLocalizationForCountryTextFieldInArabic() {
        countryImageView.image = UIImage(named: "list_ar")
        if countryTextField.text == "Country" {
            countryTextField.text = "الدولة"
            countryTextField.textAlignment = .right
            countryTextField.font = UIFont(name: "GE Dinar One", size: 14)
        } else {
            countryTextField.textAlignment = .right
            countryTextField.font = UIFont(name: "GE Dinar One", size: 14)
        }
    }
    
    func setLocalizationForCityTextFieldInArabic() {
        cityImageView.image = UIImage(named: "list_ar")
        if cityTextField.text == "City" {
            cityTextField.text = "المدينة"
            cityTextField.textAlignment = .right
            cityTextField.font = UIFont(name: "GE Dinar One", size: 14)
        } else {
            cityTextField.textAlignment = .right
            cityTextField.font = UIFont(name: "GE Dinar One", size: 14)
        }
    }
    
    func setLocalizationForAreaTextFieldInArabic() {
        areaImageView.image = UIImage(named: "list_ar")
        if areaTextField.text == "Area" {
            areaTextField.text = "المنطقة"
            areaTextField.textAlignment = .right
            areaTextField.font = UIFont(name: "GE Dinar One", size: 14)
        } else {
            areaTextField.textAlignment = .right
            areaTextField.font = UIFont(name: "GE Dinar One", size: 14)
        }
    }
    
    func setLocalizationForChangeLanguageButtonInEnglish() {
        changeLanguageButton.setTitle("Change Location", for: .normal)
        changeLanguageButton.setTitle("Change Location", for: .highlighted)
        changeLanguageButton.titleLabel?.font = UIFont(name: "Montserrat", size: 19)
    }
    
    func setLocalizationForRegisterButtonInEnglish() {
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitle("Register", for: .highlighted)
        registerButton.titleLabel?.font = UIFont(name: "Montserrat", size: 17)
    }
    
    func setLocalizationForRegisterConfirmationLineInEnglish() {
        confirmRegistrationStackView.semanticContentAttribute = .forceLeftToRight
        confirmRegisteringLabel.text = "By clicking register you are agree to"
        confirmRegisteringLabel.textAlignment = .left
        confirmRegisteringLabel.font = UIFont(name: "Montserrat", size: 11)
        showTermsAndConditionsButton.setTitle("Terms and conditions.", for: .normal)
        showTermsAndConditionsButton.setTitle("Terms and conditions.", for: .highlighted)
        showTermsAndConditionsButton.titleLabel?.textAlignment = .left
        showTermsAndConditionsButton.titleLabel?.font = UIFont(name: "Montserrat", size: 11)
    }
    
    func setLocalizationForFullNameTextFieldInEnglish() {
        if fullNameTextField.text == "الآسم الكامل" {
            fullNameTextField.text = "Full Name"
            fullNameTextField.textAlignment = .left
            fullNameTextField.font = UIFont(name: "Montserrat", size: 14)
        } else {
            fullNameTextField.textAlignment = .left
            fullNameTextField.font = UIFont(name: "Montserrat", size: 14)
        }
    }
    
    func setLocalizationForPasswordTextFieldInEnglish() {
        if passwordTextField.text == "كلمة المرور" {
            passwordTextField.text = "Password"
            passwordTextField.textAlignment = .left
            passwordTextField.font = UIFont(name: "Montserrat", size: 14)
        } else {
            passwordTextField.textAlignment = .left
            passwordTextField.font = UIFont(name: "Montserrat", size: 14)
        }
    }
    
    func setLocalizationForCodeTextFieldInEnglish() {
        codeImageView.image = UIImage(named: "list_small_en")
        if codeTextField.text == "الكود" {
            codeTextField.text = "Code"
            codeTextField.textAlignment = .left
            codeTextField.font = UIFont(name: "Montserrat", size: 14)
        } else {
            codeTextField.textAlignment = .left
            codeTextField.font = UIFont(name: "Montserrat", size: 14)
        }
    }
    
    func setLocalizationForCodeNumberTextFieldInEnglish() {
        codeNumberTextField.textAlignment = .left
        codeNumberTextField.font = UIFont(name: "Montserrat", size: 14)
    }
    
    func setLocalizationForCountryTextFieldInEnglish() {
        countryImageView.image = UIImage(named: "list_en")
        if countryTextField.text == "الدولة" {
            countryTextField.text = "Country"
            countryTextField.textAlignment = .left
            countryTextField.font = UIFont(name: "Montserrat", size: 14)
        } else {
            countryTextField.textAlignment = .left
            countryTextField.font = UIFont(name: "Montserrat", size: 14)
        }
    }
    
    func setLocalizationForCityTextFieldInEnglish() {
        cityImageView.image = UIImage(named: "list_en")
        if cityTextField.text == "المدينة" {
            cityTextField.text = "City"
            cityTextField.textAlignment = .left
            cityTextField.font = UIFont(name: "Montserrat", size: 14)
        } else {
            cityTextField.textAlignment = .left
            cityTextField.font = UIFont(name: "Montserrat", size: 14)
        }
    }
    
    func setLocalizationForAreaTextFieldInEnglish() {
        areaImageView.image = UIImage(named: "list_en")
        if areaTextField.text == "المنطقة" {
            areaTextField.text = "Area"
            areaTextField.textAlignment = .left
            areaTextField.font = UIFont(name: "Montserrat", size: 14)
        } else {
            areaTextField.textAlignment = .left
            areaTextField.font = UIFont(name: "Montserrat", size: 14)
        }
    }
    
    func setLocalizationForUIControlsInArabic() {
        // Set Localization For Change Location Button
        setLocalizationForChangeLanguageButtonInArabic()
        
        // Set Localization For Register Button
        setLocalizationForRegisterButtonInArabic()
        
        // Set Localization For Register Conformation Line.
        setLocalizationForRegisterConfirmationLineInArabic()
        
        // Set Localization For Full Name Text Field.
        setLocalizationForFullNameTextFieldInArabic()
        
        // Set Localization For Password TextField.
        setLocalizationForPasswordTextFieldInArabic()
        
        // Set Localization For Code TextField.
        setLocalizationForCodeTextFieldInArabic()
        
        // Set Localization For Code Number TextField
        setLocalizationForCodeNumberTextFieldInArabic()
        
        // Set Localization For Country TextField
        setLocalizationForCountryTextFieldInArabic()
        
        // Set Localization For City TextField
        setLocalizationForCityTextFieldInArabic()
        
        // Set Localization For Area TextField
        setLocalizationForAreaTextFieldInArabic()
    }
    
    func setLocalizationForUIControlsInEnglish() {
        // Set Localization for Change Localization Button
        setLocalizationForChangeLanguageButtonInEnglish()
        
        // Set Localization For Register Button
        setLocalizationForRegisterButtonInEnglish()
        
        // Set Localization For Register Confirmation Line.
        setLocalizationForRegisterConfirmationLineInEnglish()
        
        // Set Localization For Full Name Text Field
        setLocalizationForFullNameTextFieldInEnglish()
        
        // Set Localization For Password Text Field
        setLocalizationForPasswordTextFieldInEnglish()
        
        // Set Localization For Code TextField
        setLocalizationForCodeTextFieldInEnglish()
        
        // Set Localization For Code Number TextField
        setLocalizationForCodeNumberTextFieldInEnglish()
        
        // Set Localization For Country TextField
        setLocalizationForCountryTextFieldInEnglish()
        
        // Set Localization For City TextField
        setLocalizationForCityTextFieldInEnglish()
        
        // Set Localization For Area TextField
        setLocalizationForAreaTextFieldInEnglish()
    }
    
    func setIsArabicValue() {
        if isArabic == false {
            isArabic = true
        } else if isArabic == true{
            isArabic = false
        }
    }
    
    func reloadTableViewsData() {
        codeTableView.reloadData()
        countryTableView.reloadData()
        cityTableView.reloadData()
        areaTableView.reloadData()
    }
}
