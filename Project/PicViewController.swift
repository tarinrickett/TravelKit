//
//  PicViewController.swift
//  Project
//
//  Created by Tarin Rickett on 12/12/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class PicViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    ///////////////////
    //   COLLECTION  //
    //    METHODS    //
    ///////////////////
    
    let picDataSource = PicDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = picDataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
