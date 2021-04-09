//
//  CustomeActivityIndicator.swift
//  TheMovieDB
//
//  Created by VENKSTESHKSTL on 07/04/21.
//

import Foundation
import UIKit
class VCActivityIndicator {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = VCActivityIndicator()
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param uiView - add activity indicator to this view
     */
    func showActivityIndicator(controller: UIViewController) {
        
        let window = UIApplication.shared.keyWindow
//        let window = container.window
        self.container.frame = (window?.frame)!
        self.container.backgroundColor = UIColor.clear
        window?.addSubview(self.container)
        
//        container.frame = uiView.frame
//        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
        container.backgroundColor = UIColor.clear
        loadingView.frame = CGRect(x:0, y:0, width: 120, height: 120)
        loadingView.center = container.center
        loadingView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 0.9)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100.0, height: 100.0);
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
//        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param uiView - remove activity indicator from this view
     */
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.container.removeFromSuperview()
        }
        
    }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}
