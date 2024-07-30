import Foundation
import UIKit
import SnapKit

public extension UIViewController {
    func showToast(message: String, isConfirmation: Bool = false) {
        if isConfirmation {
            let confirmationLabel = createStandardLabel(text: "copied", fontSize: 26.0, weight: .bold)
            setupLabelAndAnimate(label: confirmationLabel, centerY: true, fadeInDuration: 0.3, fadeOutDuration: 0.3, visibleDuration: 1.5)
        }
        
        let toastLabel = createStandardLabel(text: message, fontSize: 16.0, weight: .regular)
        setupLabelAndAnimate(label: toastLabel, centerY: false, fadeInDuration: 0.5, fadeOutDuration: 0.5, visibleDuration: 3)
    }
}

private extension UIViewController {
    func setupLabelAndAnimate(label: UILabel, centerY: Bool, fadeInDuration: TimeInterval, fadeOutDuration: TimeInterval, visibleDuration: TimeInterval) {
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(270)
            $0.height.equalTo(28)
            if centerY {
                $0.centerY.equalToSuperview()
            } else {
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            }
        }
        
        animateLabelVisibility(label: label, fadeInDuration: fadeInDuration, fadeOutDuration: fadeOutDuration, visibleDuration: visibleDuration)
    }
    
    func animateLabelVisibility(label: UILabel, fadeInDuration: TimeInterval, fadeOutDuration: TimeInterval, visibleDuration: TimeInterval) {
        UIView.animate(withDuration: fadeInDuration, animations: {
            label.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: fadeOutDuration, delay: visibleDuration, options: .curveEaseInOut, animations: {
                label.alpha = 0.0
            }) { _ in
                label.removeFromSuperview()
            }
        }
    }
    
    func createStandardLabel(text: String, fontSize: CGFloat, weight: UIFont.Weight) -> UILabel {
        let label = UILabel().then {
            $0.text = text
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
            $0.backgroundColor = UIColor.mainSubColor.withAlphaComponent(0.6)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.alpha = 0
        }
        return label
    }
}
