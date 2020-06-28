//
//  Configuration.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 29/04/20.
//  Copyright © 2020 Arpit Lokwani. All rights reserved.
//

import Foundation


struct Configuration {
    lazy var environment: Environment = {
        return Environment.Production
    }()
}
//https://newsapi.org/v2/top-headlines?country=us&apiKey=61c1b71704ac46fcbffca85d568efabd
enum Environment: String {
    case Production = "production"
    
    var baseURL: String {
        switch self {
            case .Production: return "https://newsapi.org/"
        }
    }
    var method: String {
        switch self {
        case .Production: return "v2/top-headlines"
        }
    }
    
    var country: String {
        switch self {
        case .Production: return "us"
        }
    }
    var apiKey: String {
        switch self {
        case .Production: return "61c1b71704ac46fcbffca85d568efabd"
        }
    }
}
