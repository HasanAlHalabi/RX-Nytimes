//
//  NewsRepo.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 12/11/2021.
//

import Foundation
class NewsRepoApi: ObservableObject {


    func fetchallData(comp : @escaping ([Post])->()) {
    
    if let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=An55tTl23wCgXd2jASDZIxvdYT55fhI7") {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let result = try decoder.decode(Results.self, from: safeData)
                        comp(result.results)
                   
                        
                    } catch {
                        print("it a error here \(error)")
                    }
                }
            }
        }
        task.resume()
    }
}


}
