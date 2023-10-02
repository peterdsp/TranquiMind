//
//  InfoViewController.swift
//  TranquiMind


import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    var buttonColor = UIColor(hexString: "C68B55")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        infoLabel.text = "Arrange the space objects on the map the way you like.\n\n Get a positive and motivational prediction for the day!"

    }
    


}
