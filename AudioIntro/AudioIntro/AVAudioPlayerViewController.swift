//
//  AVAudioPlayerViewController.swift
//  AudioIntro
//
//  Created by k-arimura on 2021/11/08.
//

import UIKit
import AVFoundation

class AVAudioPlayerViewController: UIViewController {
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "ukulele.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
    }
}
