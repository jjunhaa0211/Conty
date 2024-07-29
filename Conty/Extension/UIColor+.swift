import UIKit

public extension UIColor {
    static let mainTintColor = UIColor(hex: "191919")
    static let mainSubColor = UIColor(hex: "2C2C2C")
}

extension UIColor {
    convenience init(hex: String) {
        var rgb: UInt64 = 0
        let scanner = Scanner(string: hex)
        
        _ = scanner.scanString("#")
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        
        self.init(cgColor: CGColor(red: r, green: g, blue: b, alpha: 1.0))
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        var rgb: UInt64 = 0
        let scanner = Scanner(string: hex)
        
        _ = scanner.scanString("#")
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        
        self.init(cgColor: CGColor(red: r, green: g, blue: b, alpha: alpha))
    }
}
