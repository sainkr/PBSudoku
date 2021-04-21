//
//  PBSudokuManager.swift
//  PBSudoku
//
//  Created by 홍승아 on 2021/03/18.
//

import Foundation

public let sudoku = PBSudoku()

public class PBSudoku{
    private var pbSudoku = PBSudokuGenerator()
    
    private var mySudoku: [[[Int]]] = []

    public var original_sudoku: [[Int]] = []
    public var game_sudoku: [[Int]] = []

    public var level = 0
    
    public func setLevel(level : Int){
        self.level = level
        self.mySudoku = pbSudoku.getSudoku(level: level)
        self.original_sudoku = mySudoku[0]
        self.game_sudoku = mySudoku[1]
    }
}


