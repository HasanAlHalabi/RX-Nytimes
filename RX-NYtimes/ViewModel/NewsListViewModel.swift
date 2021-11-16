//
//  NewsListViewModel.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 14/11/2021.
//

import Foundation
import RxCocoa
import RxSwift
struct NewslistViewModel{
    let articlesVM : [NewsModel]
    func numberOfRowsInSection(_ section: Int)-> Int{
           return self.articlesVM.count
       }
    func newsAtindex(_ index: Int ) -> NewsModel{
            let news = self.articlesVM[index]
        return NewsModel(news.article)
        }
    var numberOfSections : Int {
           return 1
       }
}
extension NewslistViewModel{
    init(_ articles: [Post]){
        self.articlesVM = articles.compactMap(NewsModel.init)
    }
}
struct NewsModel{
    let article : Post
    init(_ article : Post){
        self.article = article
    }
}
extension NewsModel{
    var title : String{
        return article.title
    }
    var byLine : String{
        return article.byline
    }
    var updated : String{
        return article.updated
    }
    var imageurl : String{
        return article.media?.first?.metadata[0].url ?? "https://1000logos.net/wp-content/uploads/2017/04/Symbol-New-York-Times.png"
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
