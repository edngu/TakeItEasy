//
//  CustomTabBarController.swift
//  TakeItEasy
//
//  Created by Saul on 1/28/25.
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
        
        layer.path = UIBezierPath(roundedRect: CGRect(x: 4, y: self.tabBar.bounds.minY + 2, width: self.tabBar.bounds.width - 8, height: self.tabBar.bounds.height + 10), cornerRadius: 30).cgPath
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.tabBar.cgColor

        //self.tabBar.unselectedItemTintColor = .white
        self.tabBar.layer.insertSublayer(layer, at: 0)

    }
    
    func realignTabBarButtons() {
 
        self.tabBar.itemWidth = 30.0
        self.tabBar.itemSpacing = 50
        self.tabBar.itemPositioning = .centered

        
    }
    func updateTabBarLayerColor(layer: CAShapeLayer) {
        layer.fillColor = UIColor.tabBar.cgColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Update TabBarColor when using dark/light mode
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            if let layer = self.tabBar.layer.sublayers?.first(where: { $0 is CAShapeLayer }) as? CAShapeLayer {
                updateTabBarLayerColor(layer: layer)
            }
        }
    }
    
}
