//
//  FifteenBoard.swift
//  FifteenPuzzle
//
//  Created by Ron Cotton on 2/19/18.
// Copyright © 2018 Ron Cotton.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

//import UIKit is not needed, this class needs to know nothing of UIKit...
import Foundation

class EightBoard {
    
    //kul had surt katb?:(.(. la2 mesh ana hada // hada code el design ma elo bel algorithm nafshaa
    // bas ele ktbto elo bel aglortihm ele ho el
    
    
    // el application kolo m2sam la 3 things hada bto5doh be software bas bshr7lk 3al sare3
    // 3enaa el view wel model wel controller... ok
    // el view ele he el design el he el malf ele 3al shaml ele mtkob 3aleh boardview ....ah
    // el view bas el design
    // el model ele he el functions ele btl3ab bel data oe rules oel data nfshaaaa e7na hala2 bel
    // modeeeel welocme :p .. okk.hahaha ok
    // el controller brbot ma ben el model wel view ya3ne maslan bas tkbse kabse 3ala button 3al view
    // el controller btlob function men el model obnfzooo o hek ookkk. el controller ele ho
    //el malf ele mktob 3aleh viewcontroller. ookkk..okkkkk
    
    // 5lena nrkez 3al model hala2 ele e7na feeh okk.
    
    // r7 ashr7lk function function kef bsht8el hoon okk..ok
    
    var state : [[Int]] =   [
        
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 0]
    ]
    
    // hay kaman
    // hay bdlha sabteeeh ma btt8yar, kolshe tmam..okk
    var goalState: [[Int]] = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 0]
    ]
    
    //number of rows and cols constant ma btt8yro
    let rows = 3
    let cols = 3
    
    // hay dfthom abel shoy bas ma dft 3alehom she.. mesh mt2kd lesa eza hek lazm any way
    
    // kolshe tmam..tmaaaaam
    
    var open = [Int]()
    var closes = [Int]()
    
    

    func random(_ n:Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    } // end random()
    
    
    // ma tt32de men el code eza she mar2t 3aleh mesh mafhom e7kele ok
    // shu r2yk t3teni aqr2u l7ali awal
    // okk.
    // ende men had / onzleee
    
    func swapTile(fromRow r1: Int, Column c1: Int, toRow r2: Int, Column c2: Int) {
        state[r2][c2] = state[r1][c1]
        state[r1][c1] = 0
    } // end swapTile()

    // Choose one of the “slidable” tiles at random and slide it into the empty space; repeat n times. We use this method to start a new game using a large value (e.g., 150) for n.
    func scramble(numTimes n: Int) {
        resetBoard()
        
        // eno hoon el 1..n eno men 1 la n el included hoon ok..okk
        
        
        for _ in 1...n {
            
            var movingTiles : [(atRow: Int, Column: Int)] = []
            var numMovingTiles : Int = 0
            for r in 0..<rows {
                for c in 0..<cols {
                    if canSlideTile(atRow: r, Column: c) {
                        
                        movingTiles.append((r, c))
                        numMovingTiles = numMovingTiles + 1
                    } // end if canSlideTile()
                } // end for c
            } // end for r
            let randomTile = random(numMovingTiles)
            var moveRow : Int, moveCol : Int
            (moveRow , moveCol) = movingTiles[randomTile]
            slideTile(atRow: moveRow, Column: moveCol)
            
        } // end for i
    } // end scamble()
    
    // Fetch the tile at the given position (0 is used for the space).
    func getTile(atRow r: Int, atColumn c: Int) -> Int {
        return state[r][c]
    } // end getTile()
    
    
    
    func calculateTheHeuristic() -> Int
    {
        var heuristic = 0
        
        for i in 0..<rows{
            
            for j in  0..<cols
            {
                if (state[i][j] == 0)
                {
                    continue
                }
                
                if state[i][j] != goalState[i][j]
                {
                    heuristic = heuristic + 1
                }
            }
        }
        
        return heuristic
    }
    
    
    // Find the position of the given tile (0 is used for the space) – returns tuple holding row and column.
    func getRowAndColumn(forTile tile: Int) -> (row: Int, column: Int)? {
        if (tile > (rows*cols-1)) {
            
            return nil
            
        }
        for x in 0..<rows {
            for y in 0..<cols {
                if ((state[x][y]) == tile) {
                    return (row: x,column: y)
                }
            }
        }
        return nil
    } // end getRowAndColumn()
    
    // Determine if puzzle is in solved configuration.
    func canSlideTileUp(atRow r : Int, Column c : Int) -> Bool {
            return (r < 1) ? false : ( state[r-1][c] == 0 )
    } // end canSlideTileUp
    
    // Determine if the specified tile can be slid up into the empty space.
    func canSlideTileDown(atRow r :  Int, Column c :  Int) -> Bool {
        return (r > (rows-2)) ? false : ( state[r+1][c] == 0 )
    } // end canSlideTileDown
    
    func canSlideTileLeft(atRow r :  Int, Column c :  Int) -> Bool {
            return (c < 1) ? false : ( state[r][c-1] == 0 )
    } // end canSlideTileLeft
    
    func canSlideTileRight(atRow r :  Int, Column c :  Int) -> Bool {
            return (c > (cols-2)) ? false : ( state[r][c+1] == 0 )
    } // end canSlideTileRight
    
    func canSlideTile(atRow r :  Int, Column c :  Int) -> Bool {
        return  (canSlideTileRight(atRow: r, Column: c) ||
            canSlideTileLeft(atRow: r, Column: c) ||
            canSlideTileDown(atRow: r, Column: c) ||
            canSlideTileUp(atRow: r, Column: c))
    } // canSlideTile()

    // Slide the tile into the empty space, if possible.
    // tile is at [r,c]
    // 0 is at [r-1,c], [r+1,c], [r,c-1], [r, c+1]
    func slideTile(atRow r: Int, Column c: Int) {
        // basecase
        if (r > rows || c > cols || r < 0 || c < 0) {
            return
        }
        if (canSlideTile(atRow: r, Column: c)) {
            if (canSlideTileUp(atRow: r, Column: c)) {
                swapTile(fromRow: r, Column: c, toRow: r-1, Column: c)
            }
            if (canSlideTileDown(atRow: r, Column: c)) {
                swapTile(fromRow: r, Column: c, toRow: r+1, Column: c)
            }
            if (canSlideTileLeft(atRow: r, Column: c)) {
                swapTile(fromRow: r, Column: c, toRow: r, Column: c-1)
            }
            if (canSlideTileRight(atRow: r, Column: c)) {
                swapTile(fromRow: r, Column: c, toRow: r, Column: c+1)
            }
        } // end if canSlideTile
        
        var test = calculateTheHeuristic()
        print(test)
        
        
    } // end slideTile()
    
    func isSolved() -> Bool {
        
        var comparison = 1
        for r in 0..<rows {
            for c in 0..<cols {
                if state[r][c] != comparison%9 {
                    return false
                } // end if
                comparison = comparison + 1
            }
        }
        return true
    } // end isSolved()
    
    // reset board to default
    func resetBoard() {
        var set = 1
        for r in 0..<rows {
            for c in 0..<cols {
                state[r][c] = set%9
                set = set + 1
            }
        }
    } // end resetBoard()
} // end FifteenBoard()
//keef b2dr du a5du 3nde // okk // shoy arfa3o kolo 5leke ma3e

