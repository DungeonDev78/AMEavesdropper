//
//  UIApplication+Extension.swift
//
//  Created by Alessandro Manilii on 29/01/24.
//

import UIKit

extension UIApplication {
    
    /// The app's key window.
    var keyWindowInConnectedScenes: UIWindow? {
        let windowScenes: [UIWindowScene] = connectedScenes.compactMap({ $0 as? UIWindowScene })
        let windows: [UIWindow] = windowScenes.flatMap({ $0.windows })
        return windows.first(where: { $0.isKeyWindow })
    }
    
}
