//
//  RegisterFormViewController.swift
//  RegisterForm
//
//  Created by Ahmed Elbasha on 8/16/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class RegisterFormViewController: UIViewController {

    // IBOutlets for full time.
    @IBOutlet weak var fullNameTextField: UITextField!
    // IBOutlets for password.
    @IBOutlet weak var passwordTextField: UITextField!
    // IBOutlets for code.
    @IBOutlet weak var codeImageView: UIImageView!
    @IBOutlet weak var codeTextField: UITextField!
    // IBOutlets for code number.
    @IBOutlet weak var codeNumberTextField: UITextField!
    // IBOutlets for code table view.
    @IBOutlet weak var codeTableView: UITableView!
    // IBOutlets for country.
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var countryTableView: UITableView!
    // IBOutlets for city.
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityTableView: UITableView!
    // IBOutlets for area.
    @IBOutlet weak var areaImageView: UIImageView!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var areaTableView: UITableView!
    // IBOutlets for confirm registration label.
    @IBOutlet weak var confirmRegisteringLabel: UILabel!
    @IBOutlet weak var showTermsAndConditionsButton: UIButton!
    @IBOutlet weak var confirmRegistrationStackView: UIStackView!
    // IBOutlets for register button.
    @IBOutlet weak var registerButton: UIButton!
    // IBOutlets for change language button.
    @IBOutlet weak var changeLanguageButton: UIButton!
    
    var countries: [Country]!
    var cities: [City]!
    var currencies: [Currency]!
    var codes: [Code]!
    var isArabic: Bool = false
    var conditionsAndTermsUrlLink =  "https://termsfeed.com/blog/sample-terms-and-conditions-template/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
                
                let currencyId = country["CurrencyID"] as! Int32
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

    @IBAction func registerButtonPressed(_ sender: Any) {
        print("Register Button Pressed")
    }
    
    @IBAction func showCodeTableButtonPressed(_ sender: Any) {
        print("Show Code Table Button Pressed")
    }
    
    @IBAction func showCountryTableButtonPressed(_ sender: Any) {
        print("Show Country Table Button Pressed")
    }
    
    @IBAction func showCityTableButtonPressed(_ sender: Any) {
        print("Show City Table Button Pressed")
    }
    
    @IBAction func showAreaTableButtonPressed(_ sender: Any) {
        print("Show Area Table Button Pressed")
    }
    
    @IBAction func showTermsAndConditionsButtonPressed(_ sender: Any) {
        print("Show Terms and Conditions Button Pressed")
    }
    
    @IBAction func changeLanguageButtonPressed(_ sender: Any) {
        print("Change Language Button Pressed")
    }
}

