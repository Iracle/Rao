//
//  RaoContentViewController.swift
//  Rao
//
//  Created by Iracle Zhang on 7/13/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

import UIKit

public protocol RaoContentViewControllerDelegate:NSObjectProtocol {
    func didClickGoBack()
}

class RaoContentViewController: UIViewController {
    
    internal weak var delegate: RaoContentViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
         delegate?.didClickGoBack()
    }


}
