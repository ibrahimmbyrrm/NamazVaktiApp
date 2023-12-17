//
//  BaseViewController.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 16.12.2023.
//

import UIKit

class BaseViewController<V : UIView> : UIViewController {
    
    var rootView : V {
        view as! V
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = V()
    }
}

