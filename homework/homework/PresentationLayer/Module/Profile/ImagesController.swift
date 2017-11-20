//
//  ImagesController.swift
//  homework
//
//  Created by Gregory Oberemkov on 19.11.17.
//  Copyright © 2017 Gregory Oberemkov. All rights reserved.
//

import Foundation
import UIKit

class ImagesController: UIViewController,UICollectionViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    var imagesLinks = [String]()
    let sender = RequestSender()
    var images = [UIImage]()
    var imageViewToChange:UIImageView?
    let apiKey = "7096634-b5c384e6fb585e42ef53fcbad"
    fileprivate let sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 3
    var linkDownloader:LinksDownloader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        linkDownloader = LinksDownloader(apiKey: apiKey)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        linkDownloader?.requestImagesLinks(tag: "flower", closure: self.handleData)
    }
    
    func handleData(data:[String]){
        print("Data recieved \(data.count)")
        imagesLinks = data
        images = Array(repeating: UIImage(named:"avatarImage")!, count: data.count)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension ImagesController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return imagesLinks.count
    }
    
    func congfigurateCell(index:IndexPath){
        if self.images[index.row] == UIImage(named:"avatarImage"){
            sender.send(url: URL(string:imagesLinks[index.row])!) { (data, error) in
                if let data = data{
                    self.images[index.row] = UIImage(data:data)!
                    DispatchQueue.main.async() { () -> Void in
                        self.collectionView.reloadItems(at: [index])
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                      for: indexPath) as! ImageCollectionViewCell
        cell.backgroundColor = UIColor.black
        cell.mainView.image = self.images[indexPath.row]
        congfigurateCell(index: indexPath)
        return cell
    }
    
}

extension ImagesController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.imageViewToChange?.image = images[indexPath.row]
        self.dismiss(animated: true, completion: nil)
    }
    
}

