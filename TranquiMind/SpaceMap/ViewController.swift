//
//  ViewController.swift
//  TranquiMind
//

import UIKit
import AVKit
import AVFoundation
import Foundation
import MediaPlayer
import StoreKit
import Lottie
import MagicTimer

class ViewController: UIViewController {

    var originalCenter: CGPoint!
    
    var buttonColor = UIColor(hexString: "C68B55")
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var planet1: UIView!
    @IBOutlet weak var planet2: UIView!
    @IBOutlet weak var planet3: UIView!
    @IBOutlet weak var planet4: UIView!
    @IBOutlet weak var planet5: UIView!
    
    @IBOutlet weak var videoView: UIView!
    
    var player = AVPlayer()
    var playerItem: AVPlayerItem?
    var playbackLikelyToKeepUpKeyPathObserver: NSKeyValueObservation?
    var playbackBufferEmptyObserver: NSKeyValueObservation?
    var playbackBufferFullObserver: NSKeyValueObservation?
    var playerLayer: AVPlayerLayer!
    var videoName = "space2"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

        playVideo()
        doneButton.isHidden = true
        
        // Add a pulsating effect to the button's background color
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = buttonColor.withAlphaComponent(1)
        animation.toValue = UIColor.clear.cgColor
        animation.duration = 1
        animation.repeatCount = 2
        animation.autoreverses = true
        doneButton.layer.add(animation, forKey: nil)
        
        //MOVING AN OBJECT
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        planet1.addGestureRecognizer(panGestureRecognizer)
        
        let panGestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(handlePan2(sender:)))
        planet2.addGestureRecognizer(panGestureRecognizer2)
        
        let panGestureRecognizer3 = UIPanGestureRecognizer(target: self, action: #selector(handlePan3(sender:)))
        planet3.addGestureRecognizer(panGestureRecognizer3)
        
        let panGestureRecognizer4 = UIPanGestureRecognizer(target: self, action: #selector(handlePan4(sender:)))
        planet4.addGestureRecognizer(panGestureRecognizer4)
        
        let panGestureRecognizer5 = UIPanGestureRecognizer(target: self, action: #selector(handlePan5(sender:)))
        planet5.addGestureRecognizer(panGestureRecognizer5)
        //MOVING AN OBJECT
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Add a pulsating effect to the button's background color
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = buttonColor.withAlphaComponent(1)
        animation.toValue = UIColor.clear.cgColor
        animation.duration = 1
        animation.repeatCount = 2
        animation.autoreverses = true
        doneButton.layer.add(animation, forKey: nil)
    }
    
    //MOVING AN OBJECT
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: planet1)
        if sender.state == .began {
            originalCenter = planet1.center
        }
        planet1.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)
        doneButton.isHidden = false
    }
    
    @objc func handlePan2(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: planet2)
        if sender.state == .began {
            originalCenter = planet2.center
        }
        planet2.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)
        doneButton.isHidden = false
    }
    
    @objc func handlePan3(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: planet3)
        if sender.state == .began {
            originalCenter = planet3.center
        }
        planet3.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)
        doneButton.isHidden = false
    }
    
    @objc func handlePan4(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: planet4)
        if sender.state == .began {
            originalCenter = planet4.center
        }
        planet4.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)
        doneButton.isHidden = false
    }
    
    @objc func handlePan5(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: planet5)
        if sender.state == .began {
            originalCenter = planet5.center
        }
        planet5.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)
        doneButton.isHidden = false
    }
    //MOVING AN OBJECT
    
    @objc func videoDidPlayToEnd(_ notification: Notification){
        playVideo()
    }
    

    
    func playVideo(){
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: videoName, ofType: "mp4")!)
        let player = AVPlayer(url: path)
        playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = videoView.bounds
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoView.layer.addSublayer(playerLayer)
        
        player.play()
        
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.videoDidPlayToEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
    }

}


