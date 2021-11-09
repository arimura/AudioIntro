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

        let path = Bundle.main.path(forResource: "ukulele.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)

        playerItem = AVPlayerItem(url: url)
        avPlayer = AVPlayer(playerItem: playerItem)
        playerItem.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)

        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 2, preferredTimescale: timeScale)
        avPlayer.addPeriodicTimeObserver(forInterval: time, queue: DispatchQueue.main) {_ in
            print("request")
            // use local mock server
            let url = URL(string: "http://192.168.86.218:8000")!

            let task = URLSession.shared.dataTask(with: url) {(data, _, error) in
                if error != nil {
                    print("error: \(error!.localizedDescription)")
                }
                guard let data = data else { return }
                print(String(data: data, encoding: .utf8)!)
            }
            task.resume()
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let playerItem = object as? AVPlayerItem else { return }
        if keyPath == "status"{
            if playerItem.status == AVPlayerItem.Status.readyToPlay {
                avPlayer.play()
            } else {
                print("error")
            }
        }
    }
}
