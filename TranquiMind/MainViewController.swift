//
//  MainViewController.swift
//  TranquiMind
//
//  Created by Petros Dhespollari
//

var VideoName = ""
var Num = Int()
var PlayerIndex = Int()
var playerPass = ""

import CleanyModal
import Foundation
import Purchases
import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var collectionView1: UICollectionView!
    @IBOutlet var collectionView2: UICollectionView!
    
    var dayPassed = false
    
    var cv1Images = ["v0", "v7", "v2", "v3", "v5", "v6", "v8", "v1", "v9", "v10"]
    var cv1Labels = ["Sea ​​Pier", "Bright Art", "Flexible Steel", "Splash", "Green Paint", "Fire Dust", "Space Surface", "Bright Art", "Movement", "The Master"]
    
    var cv2Images = ["pl1", "pl2", "pl3", "pl4", "pl5", "pl6", "pl7", "pl8", "pl9", "pl10", "pl11", "pl12"]
    var thesisMode = AppSettings.shared.thesisMode
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        collectionView1.dataSource = self
        collectionView1.delegate = self
        collectionView2.dataSource = self
        collectionView2.delegate = self
        
        let date = Date()
        let components = date.get(.day, .month, .year)
        if let day = components.day, let month = components.month, let year = components.year {
            print("day: \(day), month: \(month), year: \(year)")
        }
    }
    
    func checkDateMatch() {
        let defaults = UserDefaults.standard
        let lastGreeting = defaults.object(forKey: "greetingDate") as? Date ?? .distantPast
        let now = Date()
        if Calendar.current.compare(now, to: lastGreeting, toGranularity: .day) == .orderedDescending {
            defaults.set(now, forKey: "greetingDate")
            performSegue(withIdentifier: "next", sender: self)
        }
        else {
            let alert = MyAlertViewController(
                title: "Don't hurry!",
                message: "You can use a map once a day.",
                imageName: "map")
            alert.addAction(title: "OK", style: .default)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func goToSpaceMap(_ sender: Any) {
        checkDateMatch()
//        performSegue(withIdentifier: "next", sender: self)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1 {
            return 10
        }
        return cv2Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1 {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! AntistressCollectionViewCell
        
            cell1.c1Image.image = UIImage(named: cv1Images[indexPath.item])
            cell1.c1Label.text = cv1Labels[indexPath.item]
            if indexPath.item < 2 {
                cell1.premium.isHidden = true
            }
            else {
                Purchases.shared.purchaserInfo { purchaserInfo, error in
                    if let e = error {
                        print(e.localizedDescription)
                    }
                    if self.thesisMode {
                        print("USER IS IN THESIS MODE")
                        cell1.premium.isHidden = true
                    }
                    else {
                        if purchaserInfo?.entitlements["fullappaccess"]?.isActive == true {
                            print("USER IS SUBSCRIBED")
                            cell1.premium.isHidden = true
                        }
                        else {
                            print("USER IS NOT SUBSCRIBED")
                            cell1.premium.isHidden = false
                        }
                    }
                }
            }
            return cell1
        }
        
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! PlayersCollectionViewCell
        cell2.backImage.image = UIImage(named: cv2Images[indexPath.item])
        if indexPath.item < 2 {
            cell2.premium.isHidden = true
        }
        else {
            Purchases.shared.purchaserInfo { purchaserInfo, error in
                if let e = error {
                    print(e.localizedDescription)
                }
                if self.thesisMode {
                    print("USER IS IN THESIS MODE")
                    cell2.premium.isHidden = true
                }
                else {
                    if purchaserInfo?.entitlements["fullappaccess"]?.isActive == true {
                        print("USER IS SUBSCRIBED")
                        cell2.premium.isHidden = true
                    }
                    else {
                        print("USER IS NOT SUBSCRIBED")
                        cell2.premium.isHidden = false
                    }
                }
            }
        }
        return cell2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexPath = collectionView.indexPathsForSelectedItems?.first
//        let cell = collectionView.cellForItem(at: indexPath!) as? CollectionViewCell1
        
        if collectionView == collectionView1 {
            Num = indexPath!.item
            if indexPath!.item < 2 {
                VideoName = cv1Images[indexPath!.item]
                performSegue(withIdentifier: "go_video", sender: self)
            }
            else {
                Purchases.shared.purchaserInfo { purchaserInfo, error in
                    if let e = error {
                        print(e.localizedDescription)
                    }
                    if self.thesisMode {
                        print("USER IS IN THESIS MODE")
                        VideoName = self.cv1Images[indexPath!.item]
                        self.performSegue(withIdentifier: "go_video", sender: self)
                    }
                    else {
                        if purchaserInfo?.entitlements["fullappaccess"]?.isActive == true {
                            print("USER IS SUBSCRIBED")
                            VideoName = self.cv1Images[indexPath!.item]
                            self.performSegue(withIdentifier: "go_video", sender: self)
                        }
                        else {
                            print("USER IS NOT SUBSCRIBED")
                            self.performSegue(withIdentifier: "go_subscribe", sender: self)
                        }
                    }
                }
            }
        }
        
        else if collectionView == collectionView2 {
            if indexPath!.item < 2 {
                PlayerIndex = indexPath!.item
                performSegue(withIdentifier: "go_player", sender: self)
            }
            else {
                Purchases.shared.purchaserInfo { purchaserInfo, error in
                    if let e = error {
                        print(e.localizedDescription)
                    }
                    if self.thesisMode {
                        print("USER IS IN THESIS MODE")
                        PlayerIndex = indexPath!.item
                        self.performSegue(withIdentifier: "go_player", sender: self)
                    }
                    else {
                        if purchaserInfo?.entitlements["fullappaccess"]?.isActive == true {
                            print("USER IS SUBSCRIBED")
                            PlayerIndex = indexPath!.item
                            self.performSegue(withIdentifier: "go_player", sender: self)
                        }
                        else {
                            print("USER IS NOT SUBSCRIBED")
                            self.performSegue(withIdentifier: "go_subscribe", sender: self)
                        }
                    }
                }
            }
        }
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
