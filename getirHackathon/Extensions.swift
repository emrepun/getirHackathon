//
//  Extensions.swift
//  getirHackathon
//
//  Created by Emre HAVAN on 25.01.2018.
//  Copyright © 2018 Emre HAVAN. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("showAlerActionTitle", comment: ""), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
