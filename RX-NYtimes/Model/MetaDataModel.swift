//
//  MetaDataModel.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 18/11/2021.
//

import Foundation
struct Postmetadata:Decodable{
   
    let metadata:[metadataurl]
    enum CodingKeys: String, CodingKey {
        case  metadata = "media-metadata"
    }
}

