

import UIKit
import Lottie
import Purchases

class FinishViewController: UIViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var checkOne: UIImageView!
    @IBOutlet weak var checkTwo: UIImageView!
    @IBOutlet weak var checkThree: UIImageView!
    @IBOutlet weak var checkFour: UIImageView!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    
    let save = UserDefaults.standard
    var secondsRemaining = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        loadingTimer()
        userInterfaceConfiguration()
    }
    
    func loadingTimer(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if self.secondsRemaining > 0 {
                print ("\(self.secondsRemaining) seconds")
                self.secondsRemaining -= 1
                
                if self.secondsRemaining == 13 {
                    self.checkOne.alpha = 1.0
                } else if self.secondsRemaining == 9 {
                    self.checkTwo.alpha = 1.0
                } else if self.secondsRemaining == 7 {
                    self.checkThree.alpha = 1.0
                } else if self.secondsRemaining == 4 {
                    self.checkFour.alpha = 1.0
                }
                
            } else {
                Timer.invalidate()
                //self.showBottomSubscription()
                
//                save.set(true, forKey: "onboarding_finished")
//
//                self.save.set(true, forKey: "setup_completed")
//                self.save.synchronize()
//                save.set(0, forKey: "index")
//                save.set(true, forKey: "index-saved")
//
//                Purchases.shared.purchaserInfo { (purchaserInfo, error) in
//                    if let e = error {
//                        print(e.localizedDescription)
//                    }
//
//                    if purchaserInfo?.entitlements["fullappaccess"]?.isActive == true {
                        self.performSegue(withIdentifier: "go_to_app", sender: self)
//                    } else {
//                        //self.performSegue(withIdentifier: "user_not_subscribed", sender: self)
//                        self.performSegue(withIdentifier: "go_to_app", sender: self)
//                    }
//                }
            }
        }
    }
    
    func userInterfaceConfiguration(){
        let loadingAnimation = LottieAnimationView(name: "man")
        animationView.contentMode = .scaleAspectFit
        self.animationView.addSubview(loadingAnimation)
        loadingAnimation.frame = self.animationView.bounds
        loadingAnimation.animationSpeed = 1.2
        loadingAnimation.loopMode = .loop
        loadingAnimation.play()
        
        checkOne.alpha = 0.2
        checkTwo.alpha = 0.2
        checkThree.alpha = 0.2
        checkFour.alpha = 0.2
        
        overrideUserInterfaceStyle = .light
    }
    
}
