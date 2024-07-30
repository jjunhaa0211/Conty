import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var upperLineView: UIView!
    let spacing: CGFloat = 12

    let tagList: [String] = [
        "asciiArt1",
        "asciiArt2",
        "asciiArt3",
        "asciiArt4",
        "asciiArt5",
        "asciiArt6",
        "asciiArt7",
        "asciiArt8",
        "asciiArt9",
        "asciiArt10",
        "asciiArt11",
        "asciiArt12",
        "asciiArt13",
        "asciiArt14",
        "asciiArt16"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        let firstVC = BaseNC(rootViewController: MainViewController())
        let secondVC = BaseNC(rootViewController: BigEmoticonsViewController(tagList: tagList))
        let thirdVC = BaseNC(rootViewController: UIViewController())
        let fourthVC = BaseNC(rootViewController: UIViewController())

        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
        fourthVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 3)
        
        viewControllers = [firstVC, secondVC, thirdVC, fourthVC]

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.addTabbarIndicatorView(index: 0, isFirstTime: true)
        }
    }
    
    func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false) {
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
            return
        }
        if upperLineView == nil {
            upperLineView = UIView()
            upperLineView.backgroundColor = UIColor.mainTintColor
            tabBar.addSubview(upperLineView)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.upperLineView.frame = CGRect(x: tabView.frame.minX + self.spacing, y: tabView.frame.minY + 0.1, width: tabView.frame.width - self.spacing * 2, height: 4)
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabbarIndicatorView(index: self.selectedIndex)
    }
}
