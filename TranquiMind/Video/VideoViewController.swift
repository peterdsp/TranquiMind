//
//  VideoViewController.swift
//  Calm Castle
//
//  Created by Petros Dhespollari
//

import UIKit
import AVKit
import AVFoundation
import Foundation
import MediaPlayer
import StoreKit
import Lottie
import MagicTimer


class VideoViewController: UIViewController {
    
    var player = AVPlayer()
    var playerItem: AVPlayerItem?
    var playbackLikelyToKeepUpKeyPathObserver: NSKeyValueObservation?
    var playbackBufferEmptyObserver: NSKeyValueObservation?
    var playbackBufferFullObserver: NSKeyValueObservation?
    
    var timer : Timer?
    var countDownTime = Double()
    var timerOK = false
    
    var isPlaying = false
    var playerState = Int()
    var player2: AVPlayer?
    var playerItem2: AVPlayerItem?
    var selectedSoundFileName : String = " "
    
    var ViewAnimationName = String()
    
    
    var nowPlayingInfo = [String: Any]()
    var playerViewcontroller = AVPlayerViewController()
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var showTimer: MagicTimerView!
    
    var cv1Images = ["v0","v7","v2","v3","v5","v6","v8","v1","v9","v10"]
    
    var playerLayer: AVPlayerLayer!
    var videoToPlay = " "
    var videoLinks = ["https://github.com/peterdsp/Diplomatic.Thesis.Premium/raw/main/v0.mp4",
                      "https://github.com/peterdsp/Diplomatic.Thesis.Premium/raw/main/v7.mp4",
                      "https://github.com/peterdsp/Diplomatic.Thesis.Premium/raw/main/v2.mp4",
                      "https://github.com/peterdsp/Diplomatic.Thesis.Premium/raw/main/v3.mp4",
                      "https://github.com/peterdsp/Diplomatic.Thesis.Premium/raw/main/v5.mp4",
                      "https://github.com/peterdsp/Diplomatic.Thesis.Premium/raw/main/v6.mp4",
                      "https://github.com/peterdsp/Diplomatic.Thesis.Premium/raw/main/v8.mp4",
                      "https://github.com/peterdsp/Diplomatic.Thesis.Premium/raw/main/v1.mp4",
                      "https://github.com/peterdsp/Diplomatic.Thesis.Premium/raw/main/v9.mp4",
                      "https://github.com/peterdsp/Diplomatic.Thesis.Premium/raw/main/v10.mp4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        muteButton.setImage(UIImage(named: "stop.png"), for: .normal)
        
        overrideUserInterfaceStyle = .light
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        videoToPlay = " "

        
        videoToPlay = videoLinks[Num]
        playVideo()
        
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
        selectedSoundFileName = "https://github.com/peterdsp/Diplomatic.Thesis.Premium/raw/main/p5.mp3"
        
        
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
    
    override func viewDidDisappear(_ animated: Bool) {
//        player.isMuted = true
//        player.volume = 0
        if isPlaying == true { player2?.pause() }
        
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = "StresslessMe"
        
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        
        if playerState == 1 {
            playSound()
            muteButton.setImage(UIImage(named: "stop.png"), for: .normal)
            isPlaying = true
            playerState = 2
            playTimer()
            showTimer.isHidden = false
            showTimer.startCounting()
        } else if playerState == 2 {
            isPlaying = false
            playerState = 1
            player2?.pause()
            muteButton.setImage(UIImage(named: "play.png"), for: .normal)
            showTimer.isHidden = true

        }
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        switch event?.subtype {
        case UIEvent.EventSubtype.remoteControlPlay?:
            playSound()
            muteButton.setImage(UIImage(named: "stop.png"), for: .normal)
            isPlaying = true
            playerState = 2
            playTimer()
            showTimer.isHidden = false
            showTimer.startCounting()
            break
        case UIEvent.EventSubtype.remoteControlPause?:
            isPlaying = false
            playerState = 1
            player2?.pause()
            muteButton.setImage(UIImage(named: "play.png"), for: .normal)
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
    
    func playSound() {
        let url = URL(string: selectedSoundFileName)
        let playerItem2:AVPlayerItem = AVPlayerItem(url: url!)
        player2 = AVPlayer(playerItem: playerItem2)
        player2!.play()
        isPlaying = true
    }
    
    @objc func videoDidPlayToEnd(_ notification: Notification){
        playVideo()
    }

    
    func playTimer() {
        showTimer.isActiveInBackground = false
        showTimer.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        showTimer.mode = .countDown(fromSeconds: TimeInterval(Int(countDownTime - player2!.currentTime().seconds)))
//        showTimer.delegate = self
    }

   
    func timerElapsedTimeDidChange(timer: MagicTimerView, elapsedTime: TimeInterval) {
        if elapsedTime == 0.0 {
            player2?.pause()
            showTimer.isHidden = true
            playerState = 1
        }
    }

    func playVideo(){
        let url = URL(string: videoToPlay)!
//        let path = URL(fileURLWithPath: Bundle.main.path(forResource: videoToPlay, ofType: "mp4")!)
        let player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = videoView.bounds
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoView.layer.addSublayer(playerLayer)
        
        player.play()
        
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        NotificationCenter.default.addObserver(self, selector: #selector(VideoViewController.videoDidPlayToEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
    }

}
