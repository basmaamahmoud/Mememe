//
//  MememeCollectionViewCell.swift
//  MememeV2
//
//  Created by Basma Ahmed Mohamed Mahmoud on 3/6/18.
//  Copyright © 2018 Basma Ahmed Mohamed Mahmoud. All rights reserved.
//

import UIKit

class MememeCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var mememeCoCImage: UIImageView!
    
    var meme: Meme? {
        didSet {
            if let meme = meme {
                mememeCoCImage?.image = meme.memedImage ?? meme.originalImage
            }
        }
    }
    
}
