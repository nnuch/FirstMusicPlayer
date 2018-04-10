//
//  RoundButton.swift
//  FirstMusicPlayer
//
//  Created by Nuch Phromsorn on 2018-04-09.
//  Copyright © 2018 Nuch Phromsorn. All rights reserved.
//


import UIKit
@IBDesignable class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor  =  UIColor.clear
        {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
}

