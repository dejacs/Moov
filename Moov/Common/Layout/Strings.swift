//
//  Strings.swift
//  Moov
//
//  Created by Jade Silveira on 01/12/21.
//

enum Strings {
    enum Color {
        static let branding = "clr_branding"
        static let highlight = "clr_highlight"
        static let primaryBackground = "clr_primary_background"
        static let primaryText = "clr_primary_text"
        static let secondaryText = "clr_secondary_text"
        static let tertiaryText = "clr_tertiary_text"
        static let transparentBackground = "clr_transparent_background"
        static let linkText = "clr_link_text"
        static let backButton = "clr_back_button"
    }
    
    enum Placeholder {
        static let image = "img_placeholder"
    }
    
    enum Locale {
        static let brazil = "pt_BR"
    }
    
    enum LocalizableKeys {
        static let loadError = "loadError"
        static let locale = "locale"
        
        enum Search {
            static let placeholder = "search.placeholder"
            
            enum Empty {
                static let title = "search.empty.title"
                static let message = "search.empty.message"
            }
            enum Error {
                static let title = "search.error.title"
                static let message = "search.error.message"
                static let button = "search.error.button"
            }
        }
        enum Welcome {
            static let title = "welcome.title"
            static let message = "welcome.message"
        }
    }
}
