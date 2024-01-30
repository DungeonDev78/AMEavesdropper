//
//  View+Extension.swift
//  
//  Created by Alessandro Manilii on 29/01/24.
//

import SwiftUI


extension View {
    
    func injectIn(view: UIView) {
        let controller = UIHostingController(rootView: self)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.backgroundColor = .clear
        view.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
