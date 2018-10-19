//
//  ViewController.swift
//  Dicee
//
//  Created by Chris Maltez on 10/18/18.
//  Copyright © 2018 Christopher Maltez. All rights reserved.
//

import UIKit

var randomDiceIndex1 : Int = 0
var randomDiceIndex2 : Int = 0

let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]


class ViewController: UIViewController {

    @IBOutlet weak var diceImageView1: UIImageView!

    @IBOutlet weak var diceImageView2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDiceImages()
        
    }

    @IBAction func rollButtonPressed(_ sender: Any) {
        updateDiceImages()
    }
    func updateDiceImages() {
        randomDiceIndex1 = Int(arc4random_uniform(6))
        randomDiceIndex2 = Int(arc4random_uniform(6))
        
        diceImageView1.image = UIImage(named:diceArray[randomDiceIndex1])
        diceImageView2.image = UIImage(named:diceArray[randomDiceIndex2])
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
}

