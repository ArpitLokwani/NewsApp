//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Arpit Lokwani on 28/06/20.
//  Copyright © 2020 Arpit Lokwani. All rights reserved.
//

import Foundation

class NewsViewModel {
    
    var dataSources:News?
       var totalDataCount = 10
       var loadMorePageCount = 1
       var totalNumbers = 0
       var dataCount = 0
       var articleDataSource = [Article]()
       let rest = RestManager()
       var configuration = Configuration()
    

    func getNews(pageNumber:String, completionHandler: @escaping ([Article])->()) {
           
          guard let url = URL(string: configuration.environment.baseURL+configuration.environment.method) else { return }
            
            rest.urlQueryParameters.add(value: configuration.environment.apiKey, forKey: "apiKey")
            rest.urlQueryParameters.add(value: configuration.environment.country, forKey: "country")
            rest.urlQueryParameters.add(value: pageNumber, forKey: "page")
            rest.urlQueryParameters.add(value: "5", forKey: "pageSize")
            

            rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
               if let data = results.data {
                self.dataSources = try? JSONDecoder().decode(News.self, from: data)
                self.totalNumbers = self.dataSources?.totalResults ?? 0
                self.dataCount += (self.dataSources?.articles!.count)!
                for i in 0...(self.dataSources?.articles!.count ?? 0)-1{
                    let article:Article = (self.dataSources?.articles![i])!
                    self.articleDataSource.append(article)
                }
                completionHandler(self.articleDataSource)
               }else{
                print(results.error ?? "")
                // put alert for showing error and reload again
                }
           }
            
        }
    
}
