//
//  Extensions.swift
//  SosMedApp
//
//  Created by Amelia Esra S on 07/01/22.
//

import Foundation
import UIKit

var vSpinner : UIView?

//MARK: Extension of UIViewController
extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
      
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    //hide keyboard
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Toast message
    //MARK: show toast message
    func showToast(message: String){
        let width = widthOfString(text: message, font: UIFont(name: "Futura", size: 17))
      
        let toastLabel = UILabel(frame:CGRect(x: self.view.frame.width/2 - (width/2), y: self.view.frame.size.height - 150 , width: 400, height: 45))
        toastLabel.font = UIFont(name: "Futura", size: 17)
        toastLabel.numberOfLines = 0
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.systemPink
        toastLabel.textColor = UIColor.white
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5
        toastLabel.dropShadow()
        toastLabel.clipsToBounds = true
        toastLabel.text = message
        toastLabel.center.x = self.view.center.x
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseInOut, animations: {
            toastLabel.alpha = 0.0
        }) { (isCompleted) in
            toastLabel.removeFromSuperview()
        }
    }
    
    func widthOfString(text: String, font: UIFont?) -> CGFloat {
        
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = text.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
        
        return size.width
    }
   
}


//MARK: VIEW
extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
           let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
           let mask = CAShapeLayer()
           mask.path = path.cgPath
           layer.mask = mask
       }

    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropBorder(scale: Bool = true) {
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


//MARK: Extension of UIImageView
extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
}

