import Lottie
import Purchases
import UIKit

class AppSettings {
    static let shared = AppSettings()
    
    var thesisMode: Bool = true //Variable to enable thesis mode
}

class SubscriptionViewController: UIViewController {
    @IBOutlet var goPremiumButton: UIButton!
    @IBOutlet var subscriptionLabel: UILabel!
    @IBOutlet var restorePurchase: UIButton!
    
    var buttonColor = UIColor(hexString: "F1AFB7")
    
    var packagesAvailableForPurchase = [Purchases.Package]()
    
    var thesisMode = AppSettings.shared.thesisMode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a pulsating effect to the button's background color
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = buttonColor.withAlphaComponent(1)
        animation.toValue = UIColor.clear.cgColor
        animation.duration = 1
        animation.repeatCount = 3
        animation.autoreverses = true
        goPremiumButton.layer.add(animation, forKey: nil)
        
//        SubTV.dataSource = self
//        SubTV.delegate = self
        
        goPremiumButton.layer.masksToBounds = true
        goPremiumButton.cornerRadius = 15
    
        overrideUserInterfaceStyle = .light
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear

        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol!
        
        Purchases.shared.offerings { offerings, _ in
            if let offerings = offerings {
                let offer = offerings.current
                let packages = offer?.availablePackages
                
                guard packages != nil else {
                    return
                }
                
                for i in 0 ... packages!.count - 1 {
                    let package = packages![i]
                    
                    self.packagesAvailableForPurchase.append(package)
                    
                    let product = package.product
                    
                    let title = product.localizedTitle
                    let price = product.price
                    
                    print("Subscription data: \(title) and \(price)")
                    
                    var duration = ""
                    let subscriptionPeriod = product.subscriptionPeriod
                    
                    switch subscriptionPeriod!.unit {
                    case SKProduct.PeriodUnit.month:
                        duration = "\(subscriptionPeriod!.numberOfUnits)"
                        
                    default:
                        duration = ""
                    }
                    
                    self.subscriptionLabel.text = "Start your free 7 days trial now and automatically \(price)\(currencySymbol) a week after the trial period"
                    
                    self.goPremiumButton.addTarget(self, action: #selector(self.goPremiumButtonTapped), for: .touchUpInside)
                    self.goPremiumButton.tag = i
                    
                    self.restorePurchase.addTarget(self, action: #selector(self.restorePurchasesButtonTapped), for: .touchUpInside)
                    self.restorePurchase.tag = i
                }
            }
        }
        
        setupUserInterface()
    }
    
    @IBAction func openPrivacy(_ sender: Any) {
        hapticFeedback()
        if let url = URL(string: "https://app-development-1.jimdosite.com/terms-of-use/") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func openTermsOfUse(_ sender: Any) {
        hapticFeedback()
        if let url = URL(string: "https://app-development-1.jimdosite.com") {
            UIApplication.shared.open(url)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Делает прозрачный верхний navigation controller
    func setupUserInterface() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    @objc func goPremiumButtonTapped(sender: UIButton) {
        let package = packagesAvailableForPurchase[sender.tag]
        
        Purchases.shared.purchasePackage(package) { _, purchaserInfo, _, _ in
            if self.thesisMode {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                if purchaserInfo?.entitlements["fullappaccess"]?.isActive == true {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        hapticFeedback()
    }
    
    @objc func restorePurchasesButtonTapped(sender: UIButton) {
        Purchases.shared.restoreTransactions { purchaserInfo, error in
            if let e = error {
                print("RESTORE ERROR: - \(e.localizedDescription)")
            }
            
            let package = self.packagesAvailableForPurchase[sender.tag]
            
            if self.thesisMode {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                if purchaserInfo?.entitlements["fullappaccess"]?.isActive == true {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        hapticFeedback()
    }
    
    func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

// extension SubscriptionViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = SubTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubTVTableViewCell
//        cell.bgLabel.layer.masksToBounds = true
//        cell.bgLabel.cornerRadius = 20
//        cell.nameLabel.text = names[indexPath.row]
//        return cell
//    }
//
//
// }
