//
//  UINavigationController+Ext.swift
//  LexPlay
//
//  Created by Tubagus Adhitya Permana on 20/07/22.
//

import UIKit

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Kembali", style: .plain, target: nil, action: nil)
    }
}
