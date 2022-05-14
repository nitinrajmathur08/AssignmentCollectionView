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
    
    // MARK: - Init Method
    override func viewDidLoad() {
        super.viewDidLoad()
        btnTitle.setTitleTextAttributes([ NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 22.0)], for: UIControl.State.normal)
        self.readDataFromFile()
    }
    
    // MARK: - Custom Method
    private func readDataFromFile(){
       let dataObj = (currentListObject != nil) ? readLocalFile(forName: "CONTENTLISTINGPAGE-PAGE\(Int(currentListObject!.page.pageNum)! + 1)") : readLocalFile(forName: "CONTENTLISTINGPAGE-PAGE1")
        if (dataObj != nil) {
            print("Time for read Data From file \(Date())")
            self.parse(jsonData: dataObj!)
        }
       
        
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(ListData.self,
                                                       from: jsonData)
            
            if(currentListObject == nil){
                currentListObject = decodedData

            }
            else{
                currentListObject!.page.contentItems.content.append(contentsOf: decodedData.page.contentItems.content)
                DispatchQueue.main.async {
                    self.listCollectionView.reloadData()
                }
            }
            
            
            print("===================================")
        } catch {
            print(error)

            print("decode error")
        }
    }
}

// MARK: - CollectionView Delegate
extension ListViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (currentListObject != nil) ? currentListObject!.page.contentItems.content.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! ListCell
      
        cell.imgPoster.image = UIImage(named:(self.currentListObject!.page.contentItems.content[indexPath.row].posterImage))
          
        cell.lblName.text = self.currentListObject!.page.contentItems.content[indexPath.row].name
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if currentListObject!.page.contentItems.content.count < Int(currentListObject!.page.totalContentItems)! && indexPath.row  == currentListObject!.page.contentItems.content.count - 10 {
            print("Current index \(indexPath.row)")
            print(currentListObject!.page.contentItems.content.count - 10)
                readDataFromFile()
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
        return CGSize(width: (collectionViewWidth-45)/3, height: (collectionViewWidth-45)/3 + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
   
}

