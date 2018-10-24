//
//  ViewController.swift
//  SeguesXcode
//
//  Created by Chris Maltez on 10/23/18.
//  Copyright © 2018 Christopher Maltez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

   
    @IBAction func buttonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSecondScreen", sender: self )
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondScreen" {
            
            let destinationVC = segue.destination as! SecondViewController
            
            destinationVC.textPassedOver = textField.text
        }
    }
}

