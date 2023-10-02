//
//  Created by Julia Lebedeva on 27.09.22.
//

import UIKit
import Lottie
import Foundation
import MagicTimer
import AVFoundation
import MediaPlayer
import AVKit
import StoreKit

class PlayerViewController: UIViewController, MagicTimerViewDelegate {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var showTimer: MagicTimerView!
    @IBOutlet weak var stopButton: UIButton!
    
//    var player1Names = ["Freedom", "White Noise","Deep Joy", "Silent Space","Inner Peace","Pure Presence","Serenity Now","Calm Castle","Clear Mind"]
//    var playerNames = ["Quiet", "Up & Down","Tranquil", "Newborn","Bliss","Balance","Restore","Calm Castle","Clear Mind"]
    var imagesNames = [""]

    var soundsArray = ["https://workhost.xyz/SoundsShenChi/p1.mp3",
                       "https://workhost.xyz/SoundsShenChi/p2.mp3",
                       "https://workhost.xyz/SoundsShenChi/p3.mp3",
                       "https://workhost.xyz/SoundsShenChi/p4.mp3",
                       "https://workhost.xyz/SoundsShenChi/p5.mp3",
                       "https://workhost.xyz/SoundsShenChi/p6.mp3",
                       "https://workhost.xyz/SoundsShenChi/p7.mp3",
                       "https://workhost.xyz/SoundsShenChi/p8.mp3",
                       "https://workhost.xyz/SoundsShenChi/p9.mp3",
                       "https://workhost.xyz/SoundsShenChi/ne1.mp3",
                       "https://workhost.xyz/SoundsShenChi/ne2.mp3",
                       "https://workhost.xyz/SoundsShenChi/ne3.mp3",
                       "https://workhost.xyz/SoundsShenChi/ne4.mp3",
                       "https://workhost.xyz/SoundsShenChi/ne5.mp3",
                       "https://workhost.xyz/SoundsShenChi/ne6.mp3"]
    var cv2Images = ["pl1","pl2","pl3","pl4","pl5","pl6","pl7","pl8","pl9","pl10","pl11","pl12"]
    
    
    var speed = Double()
    
    var timer : Timer?
    var countDownTime = Double()
    var timerOK = false
    
    var isPlaying = false
    var playerState = Int()
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var selectedSoundFileName : String = " "
    
    var nowPlayingInfo = [String: Any]()
    var playerViewcontroller = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light

        selectedSoundFileName = soundsArray[1]
        selectedSoundFileName = soundsArray[PlayerIndex]
        backImage.image = UIImage(named: cv2Images[PlayerIndex])
        
        stopButton.setTitle("STOP LISTENING", for: .normal)
        
//        for i in 0...8 {
//            if playerPass == playerNames[i] {
//                selectedSoundFileName = soundsArray[i]
//            }
//        }

        
        //Timer is Invalid when the Internet is no Connected
        if timerOK == true {
            print("Internet Connection is OK")
            showTimer.isHidden = false
        }
        else {
            print("Internet Connection is not OK")
            showTimer.isHidden = true
        }
        //Timer is Invalid when the Internet is no Connected
        
        playerState = 1
        
//        // Add a pulsating effect to the button's background color
//        let animation = CABasicAnimation(keyPath: "backgroundColor")
//        animation.fromValue = UIColor.systemIndigo
//        animation.toValue = UIColor.clear.cgColor
//        animation.duration = 1
//        animation.repeatCount = 3
//        animation.autoreverses = true
//        stopButton.layer.add(animation, forKey: nil)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

        
        let url = URL(string: selectedSoundFileName)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        countDownTime = Double(playerItem.asset.duration.value) / Double(playerItem.asset.duration.timescale)
        
        playSound()
        isPlaying = true
        playerState = 2
        playTimer()
        showTimer.isHidden = false
        showTimer.startCounting()
        timerOK = true
    }
    

    
    @IBAction func playButtonAction(_ sender: Any) {
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = "StresslessMe"
        
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        
        if playerState == 1 {
            playSound()
            stopButton.setTitle("STOP LISTENING", for: .normal)
            isPlaying = true
            playerState = 2
            playTimer()
            timeLeftLabel.isHidden = false
            showTimer.isHidden = false
            showTimer.startCounting()
        } else if playerState == 2 {
            isPlaying = false
            playerState = 1
            timeLeftLabel.isHidden = true
            player?.pause()
            stopButton.setTitle("START LISTENING", for: .normal)
            showTimer.isHidden = true

        }
    }
    
    func playSound() {
        let url = URL(string: selectedSoundFileName)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        player!.play()
        isPlaying = true
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        switch event?.subtype {
        case UIEvent.EventSubtype.remoteControlPlay?:
            playSound()
            stopButton.setTitle("STOP LISTENING", for: .normal)
            isPlaying = true
            playerState = 2
            playTimer()
            timeLeftLabel.isHidden = false
            showTimer.isHidden = false
            showTimer.startCounting()
            break
        case UIEvent.EventSubtype.remoteControlPause?:
            isPlaying = false
            playerState = 1
            player?.pause()
            timeLeftLabel.isHidden = true
            stopButton.setTitle("START LISTENING", for: .normal)
            showTimer.isHidden = true
            break
        default:
            break
        }
    }
    
    public func disconnectAVPlayer() {
        playerViewcontroller.player = nil
    }
    
    public func reconnectAVPlayer() {
        playerViewcontroller.player = player
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if isPlaying == true { player?.pause() }
    }
    
    
    func playTimer() {
        showTimer.isActiveInBackground = false
        showTimer.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        showTimer.mode = .countDown(fromSeconds: TimeInterval(Int(countDownTime - player!.currentTime().seconds)))
        showTimer.delegate = self
    }

   
    func timerElapsedTimeDidChange(timer: MagicTimerView, elapsedTime: TimeInterval) {
        if elapsedTime == 0.0 {
            player?.pause()
            showTimer.isHidden = true
            playerState = 1
            timeLeftLabel.isHidden = true
            stopButton.setTitle("START LISTENING", for: .normal)
        }
    }

}

