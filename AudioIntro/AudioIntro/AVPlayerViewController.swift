//
//  AVPlayerViewController.swift
//  AudioIntro
//
//  Created by k-arimura on 2021/11/08.
//

import UIKit
import AVFoundation

class AVPlayerViewController: UIViewController {
    var playerItem: AVPlayerItem!
    var avPlayer: AVPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "ukulele.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        playerItem = AVPlayerItem(url: url)
        avPlayer = AVPlayer(playerItem: playerItem)
        playerItem.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
           guard let playerItem = object as? AVPlayerItem else { return }
               if keyPath == "status"{
                   if playerItem.status == AVPlayerItem.Status.readyToPlay{
                       avPlayer.play()
                   }else{
                       print("error")
                   }
               }
       }
}
