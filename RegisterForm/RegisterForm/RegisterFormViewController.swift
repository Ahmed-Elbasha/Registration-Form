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

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var codeImageView: UIImageView!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var codeNumberTextField: UITextField!
    @IBOutlet weak var codeTableView: UITableView!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var areaImageView: UIImageView!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var areaTableView: UITableView!
    @IBOutlet weak var confirmRegisteringLabel: UILabel!
    @IBOutlet weak var showTermsAndConditionsButton: UIButton!
    @IBOutlet weak var confirmRegistrationStackView: UIStackView!
    @IBOutlet weak var registerButton: UIButton!
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
    }
    
    @IBAction func showCodeTableButtonPressed(_ sender: Any) {
    }
    
    @IBAction func showCountryTableButtonPressed(_ sender: Any) {
    }
    
}

