//
//  ViewController.swift
//  TranquiMind
//
//  Created by Petros Dhespollari
//

import UIKit

class CirclesViewController: UIViewController {
    
    let hexColors = [UIColor(hexString: "#e6d7ff"),
                     UIColor(hexString: "#d2b1ea"),
                     UIColor(hexString: "#e1c4ff"),
                     UIColor(hexString: "#d2afff"),
                     UIColor(hexString: "#bebcdb"),
                     UIColor(hexString: "#E0B5EF")]
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)

        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let tapPoint = sender.location(in: view)

        
        let circle = CAShapeLayer()
        circle.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50)).cgPath
        circle.position = tapPoint
//        circle.fillColor = UIColor.red.cgColor
        circle.fillColor = hexColors.randomElement()?.cgColor
        view.layer.addSublayer(circle)

        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0.5
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = .infinity
        circle.add(animation, forKey: "scale")
    }

}

