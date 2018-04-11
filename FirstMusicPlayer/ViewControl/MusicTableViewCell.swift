//
//  MusicTableViewCell.swift
//  FirstMusicPlayer
//
//  Created by Nuch Phromsorn on 2018-04-09.
//  Copyright © 2018 Nuch Phromsorn. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var songTitleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
