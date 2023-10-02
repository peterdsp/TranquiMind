

import UIKit
import Purchases

class SplashViewController: UIViewController {
    
//    let save = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if save.value(forKey: "onboarding_finished") == nil {
//            performSegue(withIdentifier: "go_to_onboarding", sender: self)
//        } else {
            self.performSegue(withIdentifier: "go_to_app", sender: self)
//        }
//    }
}
    
}

