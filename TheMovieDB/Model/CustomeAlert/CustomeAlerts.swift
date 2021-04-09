//
//  File.swift
//  TheMovieDB
//
//  Created by VENKSTESHKSTL on 07/04/21.
//

import Foundation
import UIKit


class CustomeAlert: NSObject {

    static let shared = CustomeAlert()
    
    override init() {
        
    }
    
    
    func showValidationAlert(target : UIViewController, title : String, message : String, OntapOkButton : @escaping (() -> Void))  {
        
        let emailAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (okayAction) in
            
            OntapOkButton()
            
        }
        emailAlert.addAction(okAction)
        DispatchQueue.main.async {
            target.present(emailAlert, animated: true, completion: nil)
        }
        
    }
    func showAlertTost(viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        viewController.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
    }
    func showAlertVC(viewController: UIViewController, title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action =  UIAlertAction(title: "OK", style: .default) { (alert) in
        }
        alertView.addAction(action)
        viewController.present(alertView, animated: true, completion: nil)
        
    }
    
}
