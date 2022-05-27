//
//  ViewController.swift
//  Assignment
//
//  Created by Nitin Raj on 13/05/22.
//

import UIKit

class ListViewController: UIViewController {

    var currentListObject: ListData?
    @IBOutlet weak var listCollectionView: UICollectionView!

    @IBOutlet weak var btnTitle: UIBarButtonItem!
    var viewModel = ListViewModel()

    // MARK: - Init Method
    override func viewDidLoad() {
        super.viewDidLoad()
        btnTitle.setTitleTextAttributes([ NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 22.0)], for: UIControl.State.normal)
        viewModel.readDataFromFile()
        closureSetUp()
    }
    
    func closureSetUp()  {
        viewModel.reloadList = { [weak self] ()  in
            ///UI chnages in main tread
            DispatchQueue.main.async {
                self?.listCollectionView.reloadData()
            }
        }
    }

}

// MARK: - CollectionView Delegate
extension ListViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrayOfList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! ListCell
      
        cell.imgPoster.image = UIImage(named:(viewModel.arrayOfList[indexPath.row].posterImage))
          
        cell.lblName.text = viewModel.arrayOfList[indexPath.row].name
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.arrayOfList.count < viewModel.totalObjectCount && indexPath.row  == viewModel.arrayOfList.count - 10 {
            print("Current index \(indexPath.row)")
            print(viewModel.arrayOfList.count - 10)
            viewModel.readDataFromFile()
        }
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 10, bottom: 30, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        
        return CGSize(width: (collectionViewWidth-45)/3, height: (collectionViewWidth-45)/3 + 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
   
}

