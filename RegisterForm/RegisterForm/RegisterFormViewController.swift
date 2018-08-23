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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

