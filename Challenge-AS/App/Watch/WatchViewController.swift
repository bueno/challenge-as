//
//  WatchViewController.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit

class WatchViewController: BaseViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var watchDetailViewController: WatchDetailViewController? = nil
    var symbolCollection: [Symbol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        symbolCollection = SymbolAPI.getAllSymbols()
        
        adjustCollectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func adjustCollectionViewLayout() {
        let size = (view.frame.width - 30) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: size, height: size)
    }
}

extension WatchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return symbolCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchCollectionViewCell", for: indexPath)
        if let label = cell.viewWithTag(100) as? UILabel {
            
            let symbol = symbolCollection[indexPath.row]
            label.text = symbol.id
        }
        
        if let logo = cell.viewWithTag(101) as? UIImageView {
            
            let symbol = symbolCollection[indexPath.row]
            logo.image = UIImage(named: symbol.logo)
            
//            logo.image = UIImage(named name: symbol.logo)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "watchSymbolDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "watchSymbolDetail" {
            let controller = segue.destination as! WatchDetailViewController
            let indexPath = sender as! IndexPath
            controller.symbol = symbolCollection[indexPath.row]
        }
    }
    
}
