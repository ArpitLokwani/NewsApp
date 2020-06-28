//
//  News.swift
//  NewsApp
//
//  Created by Arpit Lokwani on 27/06/20.
//  Copyright © 2020 Arpit Lokwani. All rights reserved.
//

import Foundation


struct News : Codable {

        let articles : [Article]?
        let status : String?
        let totalResults : Int?

        enum CodingKeys: String, CodingKey {
                case articles = "articles"
                case status = "status"
                case totalResults = "totalResults"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                articles = try values.decodeIfPresent([Article].self, forKey: .articles)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        }

}

struct Article : Codable {

        let author : String?
        let content : String?
        let descriptionField : String?
        let publishedAt : String?
        let source : Source?
        let title : String?
        let url : String?
        let urlToImage : String?

        enum CodingKeys: String, CodingKey {
                case author = "author"
                case content = "content"
                case descriptionField = "description"
                case publishedAt = "publishedAt"
                case source = "source"
                case title = "title"
                case url = "url"
                case urlToImage = "urlToImage"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                author = try values.decodeIfPresent(String.self, forKey: .author)
                content = try values.decodeIfPresent(String.self, forKey: .content)
                descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
                publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
                source = try Source(from: decoder)
                title = try values.decodeIfPresent(String.self, forKey: .title)
                url = try values.decodeIfPresent(String.self, forKey: .url)
                urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage)
        }

}


struct Source : Codable {

        let id : String?
        let name : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                name = try values.decodeIfPresent(String.self, forKey: .name)
        }

}
