//
//  ViewController.swift
//  TicTacToe
//
//  Created by Kely Sotsky on 18/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    @IBOutlet weak var Xscore: UILabel!
    @IBOutlet weak var Oscore: UILabel!
    
    @IBOutlet weak var whoWon: UILabel!
    
    
    @IBOutlet weak var winningLine: UIImageView!
    
    enum Turn{
        case Nought
        case Cross
    }
    
    
    @IBAction func newGameBtn(_ sender: UIButton) {
        resetBtn(sender)
        noughtsScore = 0
        crossesScore = 0
        Xscore.text = crossesScore.description
        Oscore.text = noughtsScore.description
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        imageName = "empty"
        whoWon.isHidden = true
        
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought
        {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        else if firstTurn == Turn.Cross
        {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
    }
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = [UIButton]()
    
    var noughtsScore = 0
    var crossesScore = 0
    
    var imageName = "empty"{
        didSet{
            if winningLine != nil{
                winningLine.image = UIImage(named: imageName)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winningLine.image = UIImage(named: imageName)
        initBoard()
    }

    func initBoard()
    {
        imageName = "empty"
        whoWon.isHidden = true
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    
    @IBAction func Board(_ sender: UIButton) {
        
        addToBoard(sender)
        
        if checkForVictory(CROSS)
        {
            crossesScore += 1
            resultAlert(title: "X Won! 🥳")
        }
        
        else if checkForVictory(NOUGHT)
        {
            noughtsScore += 1
            resultAlert(title: "O Won! 🥳")
        }
        
        else if(fullBoard())
        {
            resultAlert(title: "Draw 🙁")
        }
    }
    
    func checkForVictory(_ s :String) -> Bool
    {
        // Horizontal Victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
        {
            imageName = "horizontal1"
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
        {
            imageName = "horizontal2"
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
        {
            imageName = "horizontal3"
            return true
        }
        
        // Vertical Victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
        {
            imageName = "vertical1"
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
        {
            imageName = "vertical2"
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
        {
            imageName = "vertical3"
            return true
        }
        
        // Diagonal Victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
        {
            imageName = "diagonal1"
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
        {
            imageName = "diagonal2"
            return true
        }
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String)
    {
        if(currentTurn == Turn.Nought)
        {
            turnLabel.text = CROSS
        }
        else{
            turnLabel.text = NOUGHT
        }
        Xscore.text = crossesScore.description
        Oscore.text = noughtsScore.description
        whoWon.isHidden = false
        whoWon.text = title

    }
    
    func fullBoard() -> Bool
    {
        for button in board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if(currentTurn == Turn.Nought)
            {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if(currentTurn == Turn.Cross)
            {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
    
}

