import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var label: UILabel!
    
    private var day = Day24()
    private var running = false
    private var imageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        day.displayImage = displayImage
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(documentsDirectory())
        run()
    }

    private func displayImage(_ image: UIImage) {
        DispatchQueue.main.async {
            if let data = image.pngData() {
                self.imageView.image = image
                self.saveImage(data)
            } else {
                print("Invalid image")
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
            let input = self.getInput("Day24.input")
            let instructions = self.day.parse(input)
            _ = self.day.part2(instructions)
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

