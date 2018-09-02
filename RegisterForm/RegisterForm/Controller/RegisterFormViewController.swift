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

    // MARK: IBOutlets
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
    
    // MARK: Class Attributes
    var countriesArray: [Country]!
    var citiesArray: [City]!
    var currenciesArray: [Currency]!
    var codesArray: [Code]!
    var isArabic: Bool = false
    var conditionsAndTermsUrlLink =  "https://termsfeed.com/blog/sample-terms-and-conditions-template/"
    
    // MARK: ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performFetchingGetCountriesWebApiDataOperation()
        setDelegateForUIControls()
        setDataSourceForUIControls()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    @IBAction func registerButtonPressed(_ sender: Any) {
        if self.isDataValid() {
            self.showRegistrationSuccessAlert()
        } else {
            self.showRegistrationFailureAlert()
        }
    }
    
    @IBAction func showCodeTableButtonPressed(_ sender: Any) {
        if codeTableView.isHidden == false {
            codeTableView.isHidden = true
        } else {
            codeTableView.isHidden = false
            codeTableView.reloadData()
        }
    }
    
    @IBAction func showCountryTableButtonPressed(_ sender: Any) {
        if countryTableView.isHidden == false {
            countryTableView.isHidden = true
        } else {
            countryTableView.isHidden = false
            countryTableView.reloadData()
        }
    }
    
    @IBAction func showCityTableButtonPressed(_ sender: Any) {
        if cityTableView.isHidden == false {
            cityTableView.isHidden = true
        } else {
            cityTableView.isHidden = false
            cityTableView.reloadData()
        }
    }
    
    @IBAction func showAreaTableButtonPressed(_ sender: Any) {
        if areaTableView.isHidden == false {
            areaTableView.isHidden = true
        } else {
            areaTableView.isHidden = false
            areaTableView.reloadData()
        }
    }
    
    @IBAction func showTermsAndConditionsButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showUrl", sender: self)
    }
    
    @IBAction func changeLanguageButtonPressed(_ sender: Any) {
        
        if isArabic == false && changeLanguageButton.titleLabel?.text == "Change Language" {
            self.setLocalizationForUIControlsInArabic()
        } else if isArabic == true && changeLanguageButton.titleLabel?.text == "تغيير اللغة" {
            self.setLocalizationForUIControlsInEnglish()
        }
        
        self.setIsArabicValue()
        
        // Reloads TableViews Data.
        self.reloadTableViewsData()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUrl" {
            let showTermsAndConditionsVC = segue.destination as! ShowTermsAndConditionsViewController
            showTermsAndConditionsVC.initWithData(url: conditionsAndTermsUrlLink)
        }
    }
}

