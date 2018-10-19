//
//  ViewController.swift
//  magic 8 Ball
//
//  Created by Chris Maltez on 10/19/18.
//  Copyright © 2018 Christopher Maltez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let ballArray = ["ball1", "ball2", "ball3", "ball4", "ball5" ]
    
    var randomBallNumber = 0
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newBallImage()
    }

    @IBAction func askButtonPressed(_ sender: UIButton) {
        
        newBallImage()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        newBallImage()
    }
    
    func newBallImage() {
        randomBallNumber = Int(arc4random_uniform(5))
        imageView.image = UIImage(named: ballArray[randomBallNumber])
        
    }
    
}

