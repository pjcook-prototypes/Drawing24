import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var label: UILabel!
    
    private var day = Day13()
    private var running = false
    private var imageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        day.displayImage = displayImage
        day.explosion = explosion
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(documentsDirectory())
        run()
    }

    private func displayImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
//            if let data = image.pngData() {
//                self.imageView.image = image
//                self.saveImage(data)
//            } else {
//                print("Invalid image")
//            }
        }
    }
    
    let explosionImages = [
        UIImage(named: "explosion-1")!,
        UIImage(named: "explosion-2")!,
        UIImage(named: "explosion-3")!,
        UIImage(named: "explosion-4")!,
        UIImage(named: "explosion-5")!,
        UIImage(named: "explosion-6")!,
        UIImage(named: "explosion-7")!,
        UIImage(named: "explosion-8")!,
    ]
    
    private func explosion(at position: Point, size: Point) {
        print("explosion", position, size)
        DispatchQueue.main.async {
            playSound(.explosion)
            let explosionView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
            explosionView.contentMode = .center
            explosionView.backgroundColor = .clear
            explosionView.animationImages = self.explosionImages
            explosionView.animationDuration = 1
            explosionView.animationRepeatCount = 1
            var adjustment: CGFloat = 0
            var extraX: CGFloat = 0, extraY: CGFloat = 0
            if self.imageView.frame.height > self.imageView.frame.width {
                extraY = (self.imageView.frame.height - self.imageView.frame.width) / 2
                adjustment = self.imageView.frame.width / CGFloat(size.x)
            } else {
                adjustment = self.imageView.frame.height / CGFloat(size.y)
                extraX = (self.imageView.frame.width - self.imageView.frame.height) / 2
            }
            let cgPoint = CGPoint(x: CGFloat(position.x) * adjustment + extraX, y: CGFloat(position.y) * adjustment + extraY)
            explosionView.center = cgPoint
            self.view.addSubview(explosionView)
            explosionView.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                explosionView.removeFromSuperview()
            }
        }
    }
    
    private func saveImage(_ imageData: Data) {
        let directory = documentsDirectory()
        let filename = directory.appendingPathComponent("image\(imageNumber)@2x.png")
        try? imageData.write(to: filename)
        imageNumber += 1
    }
    
    private func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func run() {
        guard !running else { return }
        running = true
        imageView.image = nil
        imageNumber = 0
        label.text = "Running"
        DispatchQueue.global().async {
            let input = self.getInput("Day13.input")
            _ = self.day.part2(input)
            DispatchQueue.main.async {
                self.label.text = "Finished"
                self.running = false
            }
        }
    }
    
    private func getInput(_ filename: String) -> [String] {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)!
        return try! String(contentsOf: url).lines
    }
}

