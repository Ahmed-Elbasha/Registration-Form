//
//  RegisterFormUITableViewDelegate.swift
//  RegisterForm
//
//  Created by Ahmed Elbasha on 8/23/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import Foundation
import UIKit

extension RegisterFormViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case 0:
            return codesArray.count
        case 1:
            return countriesArray.count
        case 2:
            return citiesArray.count
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "codeCell")
            let currentCode = codesArray[indexPath.row]
            if isArabic == false {
                cell?.textLabel?.text = currentCode.codeEnglishTitle
            } else {
                cell?.textLabel?.text = currentCode.codeArabicTitle
            }
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell")
            let currentCountry = countriesArray[indexPath.row]
            if isArabic == false {
                cell?.textLabel?.text = currentCountry.countryEnglishTitle
            } else {
                cell?.textLabel?.text = currentCountry.countryArabicTitle
            }
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell")
            let currentCity = citiesArray[indexPath.row]
            if isArabic == false {
                cell?.textLabel?.text = currentCity.cityEnglishTitle
            } else {
                cell?.textLabel?.text = currentCity.cityArabicTitle
            }
            return cell!
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isHidden = true
        switch tableView.tag {
        case 0:
            tableView.isHidden = true
            let currentCode = codesArray[indexPath.row]
            if isArabic == false {
                codeTextField.text = currentCode.codeEnglishTitle
            } else {
                codeTextField.text = currentCode.codeArabicTitle
            }
            break
        case 1:
            tableView.isHidden = true
            let currentCountry = countriesArray[indexPath.row]
            if isArabic == false {
                countryTextField.text = currentCountry.countryEnglishTitle
            } else {
                countryTextField.text = currentCountry.countryArabicTitle
            }
            break
        case 2:
            tableView.isHidden = true
            let currentCity = citiesArray[indexPath.row]
            if isArabic == false {
                cityTextField.text = currentCity.cityEnglishTitle
            } else {
                cityTextField.text = currentCity.cityArabicTitle
            }
            break
        case 3:
            tableView.isHidden = false
            break
        default:
            break
        }
    }
}
