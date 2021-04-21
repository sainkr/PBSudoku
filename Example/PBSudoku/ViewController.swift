//
//  ViewController.swift
//  PBSudoku
//
//  Created by sainkr on 04/21/2021.
//  Copyright (c) 2021 sainkr. All rights reserved.
//

import UIKit
import PBSudoku

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: Any) {
 
        sudoku.setLevel(level: 1)
    
        print(sudoku.game_sudoku)
        print(sudoku.original_sudoku)
    }
}

