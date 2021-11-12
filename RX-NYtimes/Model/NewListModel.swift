//
//  NewListModel.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 12/11/2021.
//

import Foundation
struct NewslistModel{
    private let newslist : Post
    
}
extension NewslistModel{
    init(_ newslist : Post){
        self.newslist = newslist
    }
}

extension NewslistModel{
    var title : String{
        return self.newslist.title
    }
    var published_date : String{
        return self.newslist.published_date
    }
    var byline : String{
        return self.newslist.byline
    }
    var mediaurl : String{
        let mediaMetaData = self.newslist.media?.first?.metadata
              
        return mediaMetaData?.first?.url ?? "https://1000logos.net/wp-content/uploads/2017/04/Symbol-New-York-Times.png"
    }
    var update : String{
        return self.newslist.updated
    }
    var abstrack : String {
        return self.newslist.abstract
    }
}
