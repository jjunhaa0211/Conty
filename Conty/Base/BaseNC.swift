import UIKit
import Then

open class BaseNC: UINavigationController {

    private var backButtonImage: UIImage? {
        return UIImage(systemName: "chevron.backward")!
            .withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: -12.0, bottom: 0.0, right: 0.0))
    }

    private var backButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        return backButtonAppearance
    }

    public static func makeNavigationController(rootViewController: UIViewController) -> BaseNC {
        let navigationController = BaseNC(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearance()
    }

    open func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance().then {
            $0.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
            $0.backgroundColor = UIColor.clear
            $0.configureWithTransparentBackground()
            $0.backButtonAppearance = backButtonAppearance

        }
        let appearance2 = UINavigationBarAppearance().then {
            $0.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)

            $0.configureWithDefaultBackground()
            $0.backButtonAppearance = backButtonAppearance
        }

        navigationBar.tintColor = UIColor.white
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationBar.standardAppearance = appearance2
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.backItem?.title = nil
    }
}
