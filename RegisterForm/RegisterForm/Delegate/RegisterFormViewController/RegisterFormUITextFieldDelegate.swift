//
//  RegisterFormUITextFieldDelegate.swift
//  RegisterForm
//
//  Created by Ahmed Elbasha on 8/23/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import Foundation
import UIKit

extension RegisterFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0, 1, 3:
            return true
        case 2, 4, 5, 6:
            return false
        default:
            return false
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0, 1:
            textField.clearButtonMode = .whileEditing
            return true
        case 2, 3, 4, 5, 6:
            return false
        default:
            return false
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0, 1:
            return true
        case 2, 3, 4, 5, 6:
            return false
        default:
            return false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0, 1:
            textField.text = ""
            break
        default:
            break
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            if textField.text == "" {
                textField.text = "First Name"
                textField.resignFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            break
        case 1:
            if textField.text == "" {
                textField.text = "Password"
                textField.resignFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            break
        default:
            break
        }
        
    }
}
