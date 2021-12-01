//
//  NewsListViewModel.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 14/11/2021.
//

import Foundation

import RxSwift
class NewsListViewModel{
    
    
    
    public let news : PublishSubject<[Post]> = PublishSubject()
    public let isLoading : PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    var newfetchdata = NewsRepoApi()
    public func requestData(time: Int){
        isLoading.onNext(true)
        self.newfetchdata.fetchallData(nb: time){articles, error in
            self.isLoading.onNext(false)
            if error == nil {
                self.news.onNext(articles)
            }else{
                self.error.onNext(error ?? "something is wrong")
            }
            
            
            
        }
        
        
    }
    
    
}
