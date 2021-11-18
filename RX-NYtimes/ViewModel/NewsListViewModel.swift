//
//  NewsListViewModel.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 14/11/2021.
//

import Foundation
import RxCocoa
import RxSwift
class NewsListViewModel{
    var newfetchdata = NewsRepoApi()
    
    public enum homeError {
        case internetError (String)
        case serverMessage (String)
    }
    public let news : PublishSubject<[Post]> = PublishSubject()
    public let loading : PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<homeError> = PublishSubject()

    private let disposable = DisposeBag()
   
    public func requestData(time: Int){
    self.loading.onNext(true)
    self.newfetchdata.fetchallData(nb: time){articles in
        self.news.onNext(articles)
    }
       
       
}
}
