//
//  HTMLextensions.swift
//  Rest API
//
//  Created by Singh, Akash | RIEPL on 27/05/22.
//  Copyright © 2022 Niso. All rights reserved.
//

import Foundation

extension String {
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}
