//
//  ViewController.swift
//  Flashcards1
//
//  Created by Taia Williams on 2/22/20.
//  Copyright © 2020 Taia Williams-Rivera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapFlashcard(_ sender: Any) {
        frontLabel.isHidden=true
    }
    

}

