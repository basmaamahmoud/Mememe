//
//  MememeDetailsViewController.swift
//  MememeV2
//
//  Created by Basma Ahmed Mohamed Mahmoud on 3/9/18.
//  Copyright © 2018 Basma Ahmed Mohamed Mahmoud. All rights reserved.
//

import UIKit

class MememeDetailsViewController: UIViewController {
    
    @IBOutlet weak var memeDetailsImageView: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = addButton
        
      
    }
    
    // edit buttom function
    @objc func addTapped() {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vs = storyboard.instantiateViewController(withIdentifier: "MememeEditorViewController") as! MememeEditorViewController
        vs.meme = meme
        vs.delegate = self as? CellDelegate
        present(vs, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        tabBarController?.tabBar.isHidden = true
        
        guard let image = meme?.memedImage else {
            
            dismiss(animated: true, completion: nil)
            return
            
        }
        memeDetailsImageView.image = image
    }
    
    
}
