//
//  Locale.swift
//  NewsApp
//
//  Created by Arpit Lokwani on 27/06/20.
//  Copyright © 2020 Arpit Lokwani. All rights reserved.
//

import Foundation

extension Locale {
    static var preferredLanguage: String {
        get {
            return self.preferredLanguages.first ?? "en"
        }
        set {
            UserDefaults.standard.set([newValue], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }
    }
}

extension String {
    var localized: String {

    var result: String

    let languageCode = Locale.preferredLanguage //en-US

    var path = Bundle.main.path(forResource: languageCode, ofType: "lproj")

    if path == nil, let hyphenRange = languageCode.range(of: "-") {
        let languageCodeShort = languageCode.substring(to: hyphenRange.lowerBound) // en
        path = Bundle.main.path(forResource: languageCodeShort, ofType: "lproj")
    }

    if let path = path, let locBundle = Bundle(path: path) {
        result = locBundle.localizedString(forKey: self, value: nil, table: nil)
    } else {
        result = NSLocalizedString(self, comment: "")
    }
        return result
    }
}
