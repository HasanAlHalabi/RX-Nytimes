//
//  Reopmodel.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 12/11/2021.
//

import Foundation


struct Results: Decodable {
    let results: [Post]
    
}



struct metadataurl :Decodable{
    var url: String
    var format: String
}
struct Post: Decodable, Identifiable {
    var id: String {
           return String(asset_id)
       }
    let asset_id: Int
    let title: String
    let url: String
    let byline : String
    let published_date : String
    let abstract: String
    let adx_keywords : String
    let updated : String
   let media:[Postmetadata]?
    
}

struct Postmetadata:Decodable{
   
    let metadata:[metadataurl]
    enum CodingKeys: String, CodingKey {
        case  metadata = "media-metadata"
    }
}
