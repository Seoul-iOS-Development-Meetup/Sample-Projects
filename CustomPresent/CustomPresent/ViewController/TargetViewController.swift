//
//  TargetViewController.swift
//  CustomPresent
//
//  Created by BaekSungwook on 2/10/18.
//  Copyright © 2018 BaekSungwook. All rights reserved.
//

import UIKit

class TargetViewController: UIViewController {

    
    var dismissInteractionController: DissmissInteractionController?
    
    @IBAction func dismissTapped(_ sender: Any) {
        
         dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
         dismissInteractionController = DissmissInteractionController(viewController: self)
    }

  
}
