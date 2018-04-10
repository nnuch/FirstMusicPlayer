//
//  LibraryTableViewController.swift
//  FirstMusicPlayer
//
//  Created by Nuch Phromsorn on 2018-04-09.
//  Copyright © 2018 Nuch Phromsorn. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController {
    
     var library = MusicLibrary().library

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return library.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MusicTableViewCell

        // Configure the cell...
        cell.artistLabel.text = library[indexPath.row]["artist"]
        cell.songTitleLabel.text = library[indexPath.row]["title"]
        
        if let coverImage = library[indexPath.row]["coverImage"] {
            cell.coverImageView.image = UIImage(named: "\(coverImage).jpg")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMusicPlayer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playerVC = segue.destination as! DetailPlayerViewController
        let indexPath = tableView.indexPathForSelectedRow!
        playerVC.trackID = indexPath.row
            
        }
    }


 





