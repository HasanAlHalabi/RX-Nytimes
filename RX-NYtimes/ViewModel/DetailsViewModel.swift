//
//  DetailsViewModel.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 17/11/2021.
//

import Foundation

struct DetailModel{
    let article : Post
    init(_ article : Post){
        self.article = article
    }
}
extension DetailModel{
    var title : String{
        return article.title
    }
    var byLine : String{
        return article.byline
    }
    var updated : String{
        return article.updated
    }

    var thumb : String{
        return article.media?.first?.metadata[2].url ?? "https://1000logos.net/wp-content/uploads/2017/04/Symbol-New-York-Times.png"
    }
    var publishdate : String{
        return article.published_date
    }
    var keys : String{
        return article.adx_keywords
    }
    var abstract : String{
        return article.abstract
    }
}
