//
//  CustomTabBarController.swift
//  TakeItEasy
//
//  Created by squiggly on 1/28/25.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createRoundCornerTabBar()
        realignTabBarButtons()
        
    }
    

    func createRoundCornerTabBar() {
        let layer = CAShapeLayer()
        
        layer.path = UIBezierPath(roundedRect: CGRect(x: 10, y: self.tabBar.bounds.minY + 5, width: self.tabBar.bounds.width - 20, height: self.tabBar.bounds.height + 10), cornerRadius: 30).cgPath
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.medium.cgColor
        self.tabBar.unselectedItemTintColor = .dark
        self.tabBar.layer.insertSublayer(layer, at: 0)

    }
    
    func realignTabBarButtons() {
        if let items = self.tabBar.items {
          items.forEach { item in item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) }
        }

        self.tabBar.itemWidth = 30.0
        self.tabBar.itemSpacing = 40
        self.tabBar.itemPositioning = .centered
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
