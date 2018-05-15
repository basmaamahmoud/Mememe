//
//  MememeTableViewCell.swift
//  MememeV2
//
//  Created by Basma Ahmed Mohamed Mahmoud on 3/6/18.
//  Copyright © 2018 Basma Ahmed Mohamed Mahmoud. All rights reserved.
//

import UIKit

class MememeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mememeCellView: UIView!
    @IBOutlet weak var mememeImage: UIImageView!
    @IBOutlet weak var mememeText: UILabel!
    
    var meme: Meme? {
        didSet {
            if let meme = meme {
                mememeImage.image = meme.memedImage ?? meme.originalImage
                mememeText.text = meme.topText! + ".." + meme.bottomText!
            }
        }
    }
    
   
    
    
}
