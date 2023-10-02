//
//  Info2ViewController.swift
//  TranquiMind
//
//  Created by Petros Dhespollari
//

import UIKit

class Info2ViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

        infoLabel.text = "Often experiencing anger, negative emotions and stress, the body needs a splash of this energy. Remember how you wanted to break something being mad?!\n\nThe practice of pulsing points means that you have to press the screen as many times as you experience negative emotions and  keep bad thoughts in your head. \n\nThen look at the screen: all your bad experiences have turned into pulsating points. And all of these pulsing points are living in YOU. See how you are hurting your body and mind.\n\nLeave them here. Take a deep breathe. Let your worries be just pulsing points."

        
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
//        sender.layer.add(pulseAnimation(), forKey: "pulse")
    }
    
//    func pulseAnimation() -> CABasicAnimation {
//        let animation = CABasicAnimation(keyPath: "transform.scale")
//        animation.duration = 0.15
//        animation.toValue = NSNumber(value: 1.1)
//        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//        animation.autoreverses = true
//        animation.repeatCount = .infinity
//        return animation
//    }

}
