// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let listData = try? newJSONDecoder().decode(ListData.self, from: jsonData)

import Foundation

// MARK: - ListData
struct ListData: Codable {
    var page: Page
}

// MARK: - Page
struct Page: Codable {
    var title, totalContentItems, pageNum, pageSize: String
    
    var contentItems: ContentItems
    
    enum CodingKeys: String, CodingKey {
        case title
        case totalContentItems = "total-content-items"
        case pageNum = "page-num"
        case pageSize = "page-size"
        case contentItems = "content-items"
    }
}

// MARK: - ContentItems
struct ContentItems: Codable {
    var content: [Content]
}

// MARK: - Content
struct Content: Codable {
    let name: String
    let posterImage: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case posterImage = "poster-image"
    }
}


