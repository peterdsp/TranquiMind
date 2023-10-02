//
//  MapResultViewController.swift
//  TranquiMind
//
//  Created by Petros Dhespollari
//

import UIKit

class MapResultViewController: UIViewController {

    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var resultsLabel: UILabel!
    var buttonColor = UIColor(hexString: "C68B55")
    var results = ["Great success awaits you today. Get ready to meet him with dignity. \n\nDo not be nervous and arrive in a good mood to attract good luck faster."
                   ,"Beware of outside criticism. Try not to pay attention to it and not think about it. \n\nWhen people see change in you, you become a better person!"
                   ,"Love is in the air. Today is a day that you can safely devote to the people you love. Watch the movie, chat and be the first to show your feelings. \n\nYou will definitely be reciprocated."
                   ,"Dedicate today to what you have long wanted to do, but did not have time. \n\nMaybe this is a new life's work or hobby, or maybe a new walking path that will lead you to new opportunities!",
                   "Day of rest. A day off is never too much. Modern man is constantly in stress and routine. \n\nDevote this day to your loved one and have a good rest.",
                   "Career day. Today, all work tasks, oddly enough, are easy and fast, you are very inspired and efficient. \n\nYou feel a surge of strength and a desire to create, and all your colleagues are delighted with you!",
                   "A magical day to diversify and expand your spiritual space. \n\nTake at least ten minutes today to read a book or stretch. Your mind and body will thank you.",
                   "Looking for new sensations. Today you just need to experience something new. \n\nLet it be a new tasty dish, a new acquaintance, or please yourself and buy something unusual for your home!",
                   "A burst of energy. Accumulated negative energy? We urgently need to get rid of it. Take a walk, eat delicious food or cry.\n\nLet your body and mind speak."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        resultsLabel.text = results.randomElement()
    }
 


}
