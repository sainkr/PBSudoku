//
//  PBSudoku.swift
//  PBSudoku
//
//  Created by 홍승아 on 2021/03/16.
//

import Foundation


public class PBSudokuGenerator {
    private var sudoku: [[[Int]]] = []
    private var original_sudoku: [[Int]] = []
    private var game_sudoku: [[Int]] = []

    private var S : [[Int]] = [[1, 2, 3],
                               [4, 5, 6],
                               [7, 8, 9]]
    private let X1 = [[0,0,1],
                      [1,0,0],
                      [0,1,0]]
    private let X2 = [[0,1,0],
                      [0,0,1],
                      [1,0,0]]
    private var level: Int = 1 // 1단계 : 쉬움 , 2단계 : 보통, 3단계 : 어려움
    
    
    private func resetSudoku(){
        sudoku = []
        original_sudoku = []
        game_sudoku = []
        
        setSudoku()
    }

    private func setSudoku() {
        // S0 랜덤 생성
        for _ in 0...9{
            let randNum1 = Int(arc4random_uniform(3))
            let randNum2 = Int(arc4random_uniform(3))
            let randNum3 = Int(arc4random_uniform(3))
            let randNum4 = Int(arc4random_uniform(3))
            
            let temp = S[randNum1][randNum2]
            S[randNum1][randNum2] = S[randNum3][randNum4]
            S[randNum3][randNum4] = temp
        }

        // *** 1. 기본적인 스도쿠 완성하기 ***

        // S0 = S
        sudoku.append(S)

        // S1 = X1 * S
        var S1: [[Int]] = []
        for k in 0...2{
            var arr: [Int] = []
            for i in 0...2{
                var sum = 0
                for j in 0...2{
                    sum += X1[k][j] * S[j][i]
                }
                arr.append(sum)
            }
            S1.append(arr)
        }

        sudoku.append(S1)

        // S2 = X2 * S
        var S2: [[Int]] = []
        for k in 0...2{
            var arr: [Int] = []
            for i in 0...2{
                var sum = 0
                for j in 0...2{
                    sum += X2[k][j] * S[j][i]
                }
                arr.append(sum)
            }
            S2.append(arr)
        }

        sudoku.append(S2)

        // S3 = S * X1
        var S3: [[Int]] = []
        for k in 0...2{
            var arr: [Int] = []
            for i in 0...2{
                var sum = 0
                for j in 0...2{
                    sum += S[k][j] * X1[j][i]
                }
                arr.append(sum)
            }
            S3.append(arr)
        }

        sudoku.append(S3)

        // S4 = X1 * S * X1
        var S4: [[Int]] = []
        for k in 0...2{
            var arr: [Int] = []
            for i in 0...2{
                var sum = 0
                for j in 0...2{
                    sum += S1[k][j] * X1[j][i]
                }
                arr.append(sum)
            }
            S4.append(arr)
        }

        sudoku.append(S4)

        // S5 = X2 * S * X1
        var S5: [[Int]] = []
        for k in 0...2{
            var arr: [Int] = []
            for i in 0...2{
                var sum = 0
                for j in 0...2{
                    sum += S2[k][j] * X1[j][i]
                }
                arr.append(sum)
            }
            S5.append(arr)
        }

        sudoku.append(S5)

        // S6 = S * X2
        var S6: [[Int]] = []
        for k in 0...2{
            var arr: [Int] = []
            for i in 0...2{
                var sum = 0
                for j in 0...2{
                    sum += S[k][j] * X2[j][i]
                }
                arr.append(sum)
            }
            S6.append(arr)
        }

        sudoku.append(S6)

        // S7 = X1 * S * X2
        var S7: [[Int]] = []
        for k in 0...2{
            var arr: [Int] = []
            for i in 0...2{
                var sum = 0
                for j in 0...2{
                    sum += S1[k][j] * X2[j][i]
                }
                arr.append(sum)
            }
            S7.append(arr)
        }

        sudoku.append(S7)

        // S8 = X2 * S * X2
        var S8: [[Int]] = []
        for k in 0...2{
            var arr: [Int] = []
            for i in 0...2{
                var sum = 0
                for j in 0...2{
                    sum += S2[k][j] * X2[j][i]
                }
                arr.append(sum)
            }
            S8.append(arr)
        }

        sudoku.append(S8)
        
        changeArrSudoku()
    }
    
    private func changeArrSudoku(){
        for i in 0...8{
            var arr: [Int] = []
            for j in 0...2{
                for k in 0...2{
                    arr.append(sudoku[i][j][k])
                }
            }
            original_sudoku.append(arr)
        }
        
        transformSudoku()
    }
    
    private func transformSudoku() {
        // *** 2. 스도쿠 변형하기 ***

        // - 같은 3*3 영역에 있는 전체 세로줄과 전체 가로줄은 교환이 가능하다.
        // 가로줄 교환
        var horizonNum = 0
        for _ in 0...2{
            let randNum1 = Int(arc4random_uniform(3)) + horizonNum
            let randNum2 = Int(arc4random_uniform(3)) + horizonNum
            
            if randNum1 != randNum2 {
                let temp = original_sudoku[randNum1]
                original_sudoku[randNum1] = original_sudoku[randNum2]
                original_sudoku[randNum2] = temp
            }
            horizonNum += 3
        }

        // 세로줄 교환
        var verticalNum = 0
        for _ in 0...2{
            let randNum1 = Int(arc4random_uniform(3)) + verticalNum
            let randNum2 = Int(arc4random_uniform(3)) + verticalNum
            
            if randNum1 != randNum2{
                for i in 0...8{
                    let temp = original_sudoku[i][randNum1]
                    original_sudoku[i][randNum1] = original_sudoku[i][randNum2]
                    original_sudoku[i][randNum2] = temp
                }
            }
            
            verticalNum += 3
        }

        // - 3*3 영역 전체를 잇는 3개의 가로 영역(3*9)끼리 or 세로 영역(9*3)끼리 교환이 가능하다.
        // 가로 영역
        let randNum1 = Int(arc4random_uniform(3)) * 3
        let randNum2 = Int(arc4random_uniform(3)) * 3

        if randNum1 != randNum2{
            for i in 0...2{
                let temp = original_sudoku[randNum1 + i]
                original_sudoku[randNum1 + i] = original_sudoku[randNum2 + i]
                original_sudoku[randNum2 + i] = temp
            }
        }

        // 세로 영역
        let randNum3 = Int(arc4random_uniform(3)) * 3
        let randNum4 = Int(arc4random_uniform(3)) * 3

        if randNum3 != randNum4{
            for i in 0...2{
                for j in 0...8{
                    let temp = original_sudoku[j][i + randNum3]
                    original_sudoku[j][i + randNum3] = original_sudoku[j][i + randNum4]
                    original_sudoku[j][i + randNum4] = temp
                }
            }
        }

        // - 9*9 스도쿠의 회전이 가능하다 ( -90도, 180도, 270도)
        // - 9*9 스도쿠의 거울 대칭이 가능하다. (-x축, y축, y=x, y=-x)

        // - 숫자끼리의 교환이 가능하다. (1 ~ 9 까지 전체 1:1 교환 및 재배열 가능)
        for _ in 1...10{
            let randNum1 = Int(arc4random_uniform(9)) + 1
            let randNum2 = Int(arc4random_uniform(9)) + 1
            
            if randNum1 != randNum2{
                var xyArr: [[Int]] = []
                for i in 0...8{
                    var cnt = 0
                    for j in 0...8{
                        if original_sudoku[i][j] == randNum1{
                            xyArr.append([i,j,randNum2])
                            cnt += 1
                        } else if original_sudoku[i][j] == randNum2{
                            xyArr.append([i,j,randNum1])
                            cnt += 1
                        }
                        
                        if cnt == 2{
                            break
                        }
                    }
                }
                
                for i in xyArr{
                    original_sudoku[i[0]][i[1]] = i[2]
                }
            }
        }
        generateSudoku()
    }
    
    private func generateSudoku(){
        var zeroNum = Int(arc4random_uniform(5) + 1)
        if level == 1{
            zeroNum += 35
        } else if level == 2{
            zeroNum += 40
        } else {
            zeroNum += 45
        }

        game_sudoku = original_sudoku
        
        var x = 0
        while zeroNum > 0{
            let num = Int(arc4random_uniform(5))
            
            for _ in 0...num {
                let y = Int(arc4random_uniform(9))
                
                if game_sudoku[x][y] != 0 {
                    game_sudoku[x][y] = 0
                    zeroNum -= 1
                }
            }
            
            if x == 8{
                x = 0
            }else {
                x += 1
            }
        }
    }
    
    // 유일성 체크
    private func uniqueSudoku()-> Int{
        var check_row: [[Bool]] = []
        var check_col: [[Bool]] = []
        var check_square: [[Bool]] = []
        let boolArr: [Bool] = [false, false, false, false, false, false, false, false, false]
        
        for _ in 0...8{
            check_row.append(boolArr)
            check_col.append(boolArr)
            check_square.append(boolArr)
        }
        
        var count = 0
        
        func solveSudoku(_ x : Int, _ y : Int){
            if count > 1 {
                return
            }
            if(x == 8 && y == 8) {
                count += 1
                return
            }
            
            if(game_sudoku[x][y] != 0){
                if y < 8{
                    solveSudoku(x, y+1)
                }else {
                    solveSudoku(x+1, 0)
                }
                
            } else {
                for i in 0...8{
                    if(!check_row[x][i] && !check_col[y][i] && !check_square[(x/3) * 3 + (y/3)][i]){
                        
                        check_row[x][i] = true
                        check_col[y][i] = true
                        check_square[(x/3) * 3 + (y/3)][i] = true
                        game_sudoku[x][y] = i + 1
                        
                        if y < 8{
                            solveSudoku(x, y+1)
                        }else {
                            solveSudoku(x+1, 0)
                        }
                        
                        check_row[x][i] = false
                        check_col[y][i] = false
                        check_square[(x/3) * 3 + (y/3)][i] = false
                        game_sudoku[x][y] = 0
                    }
                }
            }
        }
        
        for i in 0...8{
            for j in 0...8{
                if(game_sudoku[i][j] != 0){
                    check_row[i][game_sudoku[i][j]-1] = true
                    check_col[j][game_sudoku[i][j]-1] = true
                    check_square[(i/3) * 3 + (j/3)][game_sudoku[i][j]-1] = true
                }
            }
        }
        
        solveSudoku(0,0)
        
        return count
    }
    
    public func getSudoku(level: Int)->[[[Int]]]{
        self.level = level
        resetSudoku()
        
        while uniqueSudoku() != 1{
            generateSudoku()
        }
        
        return [original_sudoku, game_sudoku]
    }
}


