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
    let articles = PublishSubject<[Post]>()
    var newfetchdata = NewsRepoApi()
    func fetchdata(){
        newfetchdata.fetchallData{ result in
            articles.onNext(result)
            articles.onCompleted()
        }
    }
}
