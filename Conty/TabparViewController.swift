//
//  TabparViewController.swift
//  Conty
//
//  Created by 박준하 on 7/29/24.
//

import UIKit

class TabBarController: UITabBarController {
    let tagList: [String] = [
        asciiArt1,
        asciiArt2,
        asciiArt3,
        asciiArt4,
        asciiArt5,
        asciiArt6,
        asciiArt7,
        asciiArt8,
        asciiArt9,
        asciiArt10,
        asciiArt11,
        asciiArt12,
        asciiArt13,
        asciiArt14,
        asciiArt16
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstVC = BaseNC(rootViewController: MainViewController())
        let secondVC = BaseNC(rootViewController: BigEmoticonsViewController(tagList: tagList))
        let thirdVC = BaseNC(rootViewController: UIViewController())
        let fourthVC = BaseNC(rootViewController: UIViewController())

        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
        fourthVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 3)

        viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
    }
}
