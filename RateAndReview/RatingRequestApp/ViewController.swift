//
//  ViewController.swift
//  RateAndReview
//
//  Created by Shehan Gunarathne on 07/01/2025.
//

import UIKit
import StoreKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let ratingRequestManager = RatingRequestManager.build(with: 3)
        ratingRequestManager.requestReviewIfAppropriate()
    }
}

