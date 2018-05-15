//
//  MememeCollectionViewController.swift
//  MememeV2
//
//  Created by Basma Ahmed Mohamed Mahmoud on 3/6/18.
//  Copyright © 2018 Basma Ahmed Mohamed Mahmoud. All rights reserved.
//

import UIKit

class MememeCollectionViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var mememeCollectionView: UICollectionView!
    @IBOutlet weak var addMemeImage: UIBarButtonItem!
    
    var memes: [Meme]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeCellSpacing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        reloadMemes()
    }
    
    func removeCellSpacing(){
        let itemsize = UIScreen.main.bounds.width/5 - 1
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0)
        layout.itemSize = CGSize(width: itemsize, height: itemsize)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        mememeCollectionView.collectionViewLayout = layout
        mememeCollectionView.delegate = self
        mememeCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mememeCollVC", for: indexPath) as! MememeCollectionViewCell
        
        cell.meme = memes?[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MemeDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemeDetails" {
            let indexPath = mememeCollectionView.indexPathsForSelectedItems?[0]
            let dvc = segue.destination as! MememeDetailsViewController
            dvc.meme = memes?[(indexPath?.row)!]
        }
    }
    
    @IBAction func addMemeImageButtn(_ sender: Any) {
        let controller: MememeEditorViewController
        
        controller = self.storyboard?.instantiateViewController(withIdentifier: "MememeEditorViewController") as! MememeEditorViewController
        
        self.present(controller, animated: true, completion: nil)
    }
    
}

extension MememeCollectionViewController {
    func reloadMemes() {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        mememeCollectionView?.reloadData()
    }
    
}
