//
//  DetailPlayerViewController.swift
//  FirstMusicPlayer
//
//  Created by Nuch Phromsorn on 2018-04-09.
//  Copyright © 2018 Nuch Phromsorn. All rights reserved.
//

import UIKit



class DetailPlayerViewController: UIViewController {
   
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var songTitleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    
    @IBOutlet var progressView: UIView!
    
    var trackID: Int = 0
    var library = MusicLibrary().library
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let coverImage = library[trackID]["coverImage"] {
            coverImageView.image = UIImage(named: "\(coverImage).jpg")
        }
        artistLabel.text = library[trackID]["artist"]
        songTitleLabel.text = library[trackID]["title"]
        
    }

    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
