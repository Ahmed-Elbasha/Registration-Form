//
//  ShowTermsAndConditionsViewController.swift
//  RegisterForm
//
//  Created by Ahmed Elbasha on 8/31/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import UIKit
import WebKit

class ShowTermsAndConditionsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var webKitView: WKWebView!
    
    // MARK: Class Attributes
    var urlString = ""
    
    // MARK: ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        webKitView.load(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Class Data Initialization
    func initWithData(url: String) {
        self.urlString = url
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: IBActions
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
