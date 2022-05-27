//
//  ListViewModel.swift
//  Assignment
//
//  Created by Nitin Raj on 27/05/22.
//

import UIKit
class ListViewModel {
    
    ///closure use for notifi
    var reloadList = {() -> () in }
    var currentFileIndex = 1
    var totalObjectCount = 0
    
    ///Array of List Model class
    var arrayOfList : [Content] = []{
        ///Reload data when data set
        didSet{
            reloadList()
        }
    }
    
    
    // MARK: - Custom Method
    func readDataFromFile(){
        let dataObj = (arrayOfList.count > 0) ? readLocalFile(forName: "CONTENTLISTINGPAGE-PAGE\(currentFileIndex + 1)") : readLocalFile(forName: "CONTENTLISTINGPAGE-PAGE1")
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
            
            if(arrayOfList.count == 0){
                totalObjectCount = Int(decodedData.page.totalContentItems) ?? 0
                arrayOfList = decodedData.page.contentItems.content

            }
            else{
                
                currentFileIndex = currentFileIndex + 1
                arrayOfList.append(contentsOf: decodedData.page.contentItems.content)
                
//                DispatchQueue.main.async {
//                   // self.listCollectionView.reloadData()
//                }
            }
            
            
            print("===================================")
        } catch {
            print(error)

            print("decode error")
        }
    }
    
    
    ///get data from api
}
