//
//  PostModel.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 18/11/2021.
//

import Foundation

struct Post: Decodable, Identifiable {
    var id: String {
           return String(asset_id)
       }
    let asset_id: Int
    var title: String
    let url: String
    let byline : String
    let published_date : String
    let abstract: String
    let adx_keywords : String
    let updated : String
    let media:[Postmetadata]?
    
}
