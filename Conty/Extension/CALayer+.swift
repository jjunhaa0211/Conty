import UIKit

public extension CALayer {
    func apply(_ changes: (CALayer) -> Void) {
        changes(self)
    }
}
