//
//  String+Helpers.swift
//  MammothNotificationServiceExtension
//
//  Created by Benoit Nolens on 26/01/2024
//  Copyright © 2024 The BLVD. All rights reserved.
//

import Foundation

extension String {
    func stripCustomEmojiShortcodes() -> String {
        var strippedText = self
        let regex = try! NSRegularExpression(pattern: ":[a-zA-Z0-9\\._]+:", options: [])
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
        
        // Iterate through matches in reverse order to correctly adjust indices
        for match in matches.reversed() {
            if let range = Range(match.range, in: self) {
                let shortcode = self[range]
                strippedText = strippedText.replacingOccurrences(of: String(shortcode), with: "")
            }
        }
        
        return strippedText.replaceDoubleSpaces()
    }
    
    func replaceDoubleSpaces() -> String {
        let regex = try! NSRegularExpression(pattern: "\\s+", options: [])
            let replacedText = regex.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count), withTemplate: " ")
            return replacedText
    }
}
