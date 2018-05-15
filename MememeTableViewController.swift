//
//  MememeViewController.swift
//  MememeV2
//
//  Created by Basma Ahmed Mohamed Mahmoud on 3/5/18.
//  Copyright © 2018 Basma Ahmed Mohamed Mahmoud. All rights reserved.
//

import UIKit

class MememeTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var memes: [Meme]?
    
    
    @IBOutlet weak var mememeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mememeTableView.delegate = self
        mememeTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        reloadMemes()
    }
    
    // number of row(images) in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mememeCell") as! MememeTableViewCell
        cell.mememeImage.layer.masksToBounds = false
        cell.mememeImage.clipsToBounds = true
        
        let meme = memes?[indexPath.row]
        cell.meme = meme
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MemeDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemeDetails" {
            let indexPath = mememeTableView.indexPathForSelectedRow
            let dvc = segue.destination as! MememeDetailsViewController
            dvc.meme = memes?[(indexPath?.row)!]
            
        }
    }
    
    @IBAction func addMemeImage(_ sender: Any) {
        let controller: MememeEditorViewController
        
        controller = self.storyboard?.instantiateViewController(withIdentifier: "MememeEditorViewController") as! MememeEditorViewController
        
        self.present(controller, animated: true, completion: nil)
    }
    
}
extension MememeTableViewController {
    func reloadMemes() {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        mememeTableView.reloadData()
    }
    
}
