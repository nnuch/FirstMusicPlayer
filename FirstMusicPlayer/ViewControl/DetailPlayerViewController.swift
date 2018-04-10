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
    
  
    @IBOutlet var progressView: UIProgressView!
    
    @IBOutlet var sliderView: UISlider!
    var smartWidth:CFloat = 0.0
    
    @IBOutlet var maxTimer: UILabel!
    @IBOutlet var currentTimer: UILabel!
    
    var trackID: Int = 0
    var library = MusicLibrary().library
    var audioPlayer: AVAudioPlayer!
    
    //switch icon-image
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
        
        
       // self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .never
      // self.view.layer.backgroundColor = UIColor.black.cgColor
        basePlayer()
        
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
    
    func basePlayer(){
        
        if let coverImage = library[trackID]["coverImage"] {
            coverImageView.image = UIImage(named: "\(coverImage).jpg")
        } else {
            
        }
        artistLabel.text = library[trackID]["artist"]
        songTitleLabel.text = library[trackID]["title"]
        
        let path = Bundle.main.path(forResource: "\(trackID)", ofType: "mp3")
        
        if let path = path {
            let mp3URL = URL(fileURLWithPath: path)
        
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                audioPlayer.currentTime = 0
                isPlaying = true
                playAndPause()
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(DetailPlayerViewController.updateProgressView), userInfo: nil, repeats: true)
               progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration),animated: true)

            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    

    @objc func updateProgressView(){
//        if audioPlayer.isPlaying {
//            progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
//        }
//
        
        if audioPlayer.isPlaying {
            
            
            sliderView.value = CFloat(audioPlayer.currentTime) // based on ur case
            sliderView.maximumValue = CFloat(audioPlayer.duration)
            
            
            smartWidth = CFloat(365 * audioPlayer.duration ) / 100
            
            currentTimer.text = String(format: "%.2f",sliderView.value / 60)
            maxTimer.text = String(format: "%.2f", sliderView.maximumValue / 60)
            
//            shadowSlider.frame = CGRectMake( shadowSlider.frame.origin.x , shadowSlider.frame.origin.y , smartWidth , shadowSlider.frame.size.height);
            
            
        
        }
        
    }

    
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
    
    

    
    @IBAction func previousClicked(_ sender: Any) {
        if trackID != 0 || trackID > library.count {
            trackID -= 1
        }
        audioPlayer.currentTime = 0
        progressView.progress = 0
        basePlayer()
        
    }
    
    
    @IBAction func shuffleClicked(_ sender: Any) {
    }
    
    @IBAction func nextClicked(_ sender: Any) {
         trackID += 1
        if trackID > library.count - 1 {
           trackID -= 1
          
        }
        audioPlayer.currentTime = 0
        progressView.progress = 0
        basePlayer()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
