import UIKit

class ViewController3: UIViewController {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var playersView: UIView!
    @IBOutlet private var label: UILabel!
    @IBOutlet private var completeTurns: UILabel!
    @IBOutlet private var turn: UILabel!
    
    private var day = Day15()
    private var running = false
    private var turns = [Set<Day15.Player>]() {
        didSet {
            turn.text = "Step: \(index) of \(turns.count)"
            
        }
    }
    private var index = 0 {
        didSet {
            turn.text = "Step: \(index) of \(turns.count)"
            if turns.count > index {
                drawPlayers(turns[index])
            }
        }
    }
    private var boardSize: Point = .zero
    private var manualUpdate = false
    private var animating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        day.drawBoard = drawBoard
        day.displayLevel = displayLevel
//        day.explosion = explosion
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        run()
    }
    
    @IBAction func backwards() {
        animating = false
        manualUpdate = true
        if index > 0 {
            index -= 1
        }
    }
    
    @IBAction func forwards() {
        animating = false
        manualUpdate = true
        if index < turns.count {
            index += 1
        }
    }
    
    @IBAction func restart() {
        animating = false
        manualUpdate = true
        index = 0
    }
    
    @IBAction func play() {
        manualUpdate = true
        animating = !animating
        if animating {
            animationTick()
        }
    }
    
    private func animationTick() {
        guard animating, index < turns.count else { return }
        self.index += 1
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            if self.animating {
                self.animationTick()
            }
        }
    }

    private func displayLevel(_ board: Day15.Board) {
        let players = board.getPlayers()
        let boardTurns = board.getTurns()
        DispatchQueue.main.async {
            self.turns.append(players)
            self.completeTurns.text = "Complete turns: \(boardTurns)"
            if !self.manualUpdate {
                self.index = self.turns.count-1
            }
        }
    }
    
    private func drawPlayers(_ players: Set<Day15.Player>) {
        self.playersView.subviews.forEach { $0.removeFromSuperview() }
        let contentWidth = self.contentView.frame.size.width
        let contentHeight = self.contentView.frame.size.height
        let boardTileWidth = CGFloat(boardSize.x)
        let boardTileHeight = CGFloat(boardSize.y)
        let blockX = contentWidth / boardTileWidth
        let blockY = contentHeight / boardTileHeight
        let blockSize = min(blockX, blockY)
        let addX = (contentWidth - (blockSize * boardTileWidth)) / 2
        let addY = (contentHeight - (blockSize * boardTileHeight)) / 2
        let elfImage = UIImage(named: "elf")!
        let goblinImage = UIImage(named: "goblin")!

        for y in (0..<boardSize.y) {
            for x in (0..<boardSize.x) {
                let point = Point(x: x, y: y)
                if let player = players.first(where: { $0.position == point }) {
                    let imageView = UIImageView(frame: CGRect(x: CGFloat(x) * blockSize + addX, y: CGFloat(y) * blockSize + addY, width: blockSize, height: blockSize))
                    imageView.contentMode = .scaleToFill
                    imageView.image = player.race == .elf ? elfImage : goblinImage
                    let healthBar = UIView(frame: CGRect(x: 2, y: 2, width: blockSize-4, height: 3))
                    healthBar.backgroundColor = .black
                    let health = UIView(frame: CGRect(x: 0, y: 0, width: (blockSize-4) / 200.0 * CGFloat(player.health), height: 3))
                    health.backgroundColor = .red
                    healthBar.addSubview(health)
                    imageView.addSubview(healthBar)
                    self.playersView.addSubview(imageView)
                }
            }
        }

    }
    
    private func drawBoard(_ board: Day15.Board) {
        self.boardSize = board.size
        let players = board.getPlayers()
        DispatchQueue.main.async {
            self.turns.append(players)
            let contentWidth = self.contentView.frame.size.width
            let contentHeight = self.contentView.frame.size.height
            let boardTileWidth = CGFloat(board.size.x)
            let boardTileHeight = CGFloat(board.size.y)
            let blockX = contentWidth / boardTileWidth
            let blockY = contentHeight / boardTileHeight
            let blockSize = min(blockX, blockY)
            let addX = (contentWidth - (blockSize * boardTileWidth)) / 2
            let addY = (contentHeight - (blockSize * boardTileHeight)) / 2
            let tiles = board.getTiles()
            let wallImage = UIImage(named: "cristal-wall")!
            let floorImage = UIImage(named: "Floor6")!
            
            for y in (0..<board.size.y) {
                for x in (0..<board.size.x) {
                    let point = Point(x: x, y: y)
                    let imageView = UIImageView(frame: CGRect(x: CGFloat(x) * blockSize + addX, y: CGFloat(y) * blockSize + addY, width: blockSize, height: blockSize))
                    imageView.contentMode = .scaleToFill
                    imageView.image = tiles[point] == .wall ? wallImage : floorImage
                    self.contentView.insertSubview(imageView, belowSubview: self.playersView)
                }
            }
            
            self.index = 0
        }
    }
    
    let explosionImages = [
        UIImage(named: "explosion2-1")!,
        UIImage(named: "explosion2-2")!,
        UIImage(named: "explosion2-3")!,
        UIImage(named: "explosion2-4")!,
        UIImage(named: "explosion2-5")!,
        UIImage(named: "explosion2-6")!,
        UIImage(named: "explosion2-7")!,
    ]
    
    private func explosion(at position: Point, size: Point) {
        DispatchQueue.main.async {
            playSound(.die)
            
            let contentWidth = self.contentView.frame.size.width
            let contentHeight = self.contentView.frame.size.height
            let boardTileWidth = CGFloat(size.x)
            let boardTileHeight = CGFloat(size.y)
            let blockX = contentWidth / boardTileWidth
            let blockY = contentHeight / boardTileHeight
            let blockSize = min(blockX, blockY)
            let addX = (contentWidth - (blockSize * boardTileWidth)) / 2
            let addY = (contentHeight - (blockSize * boardTileHeight)) / 2
            
            let explosionView = UIImageView(
                frame: CGRect(
                    x: CGFloat(position.x) * blockSize + addX,
                    y: CGFloat(position.y) * blockSize + addY,
                    width: blockSize,
                    height: blockSize
                    )
                )
            explosionView.contentMode = .center
            explosionView.backgroundColor = .clear
            explosionView.animationImages = self.explosionImages
            explosionView.animationDuration = 1
            explosionView.animationRepeatCount = 1
            self.view.addSubview(explosionView)
            explosionView.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                explosionView.removeFromSuperview()
            }
        }
    }
    
    private func run() {
        guard !running else { return }
        running = true
        turns = []
        index = 0
        manualUpdate = true
        label.text = "Running"
        DispatchQueue.global().async {
            let input = self.getInput("Day15.input")
            _ = self.day.part1(input)
            DispatchQueue.main.async {
                self.label.text = "Finished"
                self.running = false
            }
        }
    }
    
    private func getInput(_ filename: String) -> [String] {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)!
        return try! String(contentsOf: url).trimmingCharacters(in: .whitespacesAndNewlines).lines
    }
}

