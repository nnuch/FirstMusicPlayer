//
//  DetailPlayerViewController.swift
//  FirstMusicPlayer
//
//  Created by Nuch Phromsorn on 2018-04-09.
//  Copyright © 2018 Nuch Phromsorn. All rights reserved.
//

import UIKit
import AVFoundation

class DetailPlayerViewController: UIViewController {
   
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var songTitleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    
    //SliderView - updateprogressView
    @IBOutlet var sliderView: UISlider!
    var smartWidth:CFloat = 0.0
    @IBOutlet var maxTimer: UILabel!
    @IBOutlet var currentTimer: UILabel!
    
    
    var trackID: Int = 0
    var library = MusicLibrary().library
    var audioPlayer: AVAudioPlayer!

    
    //Switch toolIcon play button and pause button
    @IBOutlet var toolIcon: RoundButton!
    var tool:UIImageView!
    var isPlaying = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //toolIcon for switching brush and erase
        tool = UIImageView()
        tool.frame = CGRect(x: self.view.bounds.size.width, y: self.view.bounds.size.height, width: 70, height: 70)
        tool.image = #imageLiteral(resourceName: "play")
        self.view.addSubview(tool)
        
        
        self.navigationItem.largeTitleDisplayMode = .never
        basePlayer()
        
    }
    

    //MARK:  Stop audioPlayer
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }

    
    
    func basePlayer(){
    
        if let coverImage = library[trackID]["coverImage"] {
            coverImageView.image = UIImage(named: "\(coverImage).jpg")
        }
        
        artistLabel.text = library[trackID]["artist"]
        songTitleLabel.text = library[trackID]["title"]
        
        let path = Bundle.main.path(forResource: "\(trackID)", ofType: "mp3")
        let mp3URL = URL(fileURLWithPath: path!)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                audioPlayer.currentTime = 0
                isPlaying = true
                playAndPause()
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(DetailPlayerViewController.updateProgressView), userInfo: nil, repeats: true)

                } catch let error as NSError {
                    print(error.localizedDescription)
            }
    }
    
    

    @objc func updateProgressView(){
        if audioPlayer.isPlaying {
            
            sliderView.value = CFloat(audioPlayer.currentTime) // based on ur case
            sliderView.maximumValue = CFloat(audioPlayer.duration)

            smartWidth = CFloat(365 * audioPlayer.duration ) / 100
            
            currentTimer.text = String(format: "%.2f",sliderView.value / 60)
            maxTimer.text = String(format: "%.2f","-",sliderView.maximumValue / 60)
            
        }
        
    }

    //MARK: Play and Pause buttons
    func playAndPause() {
        if (isPlaying) {
        
            tool.image = #imageLiteral(resourceName: "pause")
            toolIcon.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            if !audioPlayer.isPlaying {
                audioPlayer.play()
            }
        } else {
            tool.image = #imageLiteral(resourceName: "play")
            toolIcon.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            if audioPlayer.isPlaying {
                audioPlayer.pause()
            }
        }
        isPlaying = !isPlaying  //revert between true and false for the button icons
    }
    
    @IBAction func playClicked(_ sender: Any) {
        playAndPause()
    }
    
    

   
    //MARK:  Previous button
    @IBAction func previousClicked(_ sender: Any) {
        if trackID != 0 || trackID > library.count {
            trackID -= 1
        }
        audioPlayer.currentTime = 0
        audioPlayer.stop()
        basePlayer()
        
    }
    
    
    //MARK: Shuffle button
    @IBAction func shuffleClicked(_ sender: Any) {
        
    }
    
    //MARK: Next button
    @IBAction func nextClicked(_ sender: Any) {
         trackID += 1
        if trackID > library.count - 1 {
           trackID -= 1
          
        }
        audioPlayer.currentTime = 0
        audioPlayer.stop()
        basePlayer()
    }
    

}
