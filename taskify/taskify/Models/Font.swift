import SwiftUI

extension Font {
    
    /// Create a font with the large title text style.
    public static var largeTitle: Font {
        return Font.custom("Futura-Medium", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }

    /// Create a font with the title text style.
    public static var title: Font {
        return Font.custom("Futura-Medium", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }

    /// Create a font with the headline text style.
    public static var headline: Font {
        return Font.custom("Futura-Medium", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
    }

    /// Create a font with the subheadline text style.
    public static var subheadline: Font {
        return Font.custom("Futura-Medium", size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize)
    }

    /// Create a font with the body text style.
    public static var body: Font {
           return Font.custom("Futura-Medium", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
       }

    /// Create a font with the callout text style.
    public static var callout: Font {
           return Font.custom("Futura-Medium", size: UIFont.preferredFont(forTextStyle: .callout).pointSize)
       }

    /// Create a font with the footnote text style.
    public static var footnote: Font {
           return Font.custom("Futura-Medium", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
       }

    /// Create a font with the caption text style.
    public static var caption: Font {
           return Font.custom("Futura-Medium", size: UIFont.preferredFont(forTextStyle: .caption1).pointSize)
       }

    public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font {
        var font = "Futura-Medium"
        switch weight {
        case .bold: font = "Futura-Bold"
        case .heavy: font = "Futura-Bold"
        case .light: font = "Futura-Medium"
        case .medium: font = "Futura-Medium"
        case .semibold: font = "Futura-CondensedExtraBold"
        case .thin: font = "Futura-Medium"
        case .ultraLight: font = "Futura-Medium"
        default: break
        }
        return Font.custom(font, size: size)
    }
   
}



