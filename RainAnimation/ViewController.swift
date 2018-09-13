import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewForRain: UIView!
    @IBOutlet weak var startRainButton: UIButton!
    @IBOutlet weak var slowRainButton: UIButton!
    @IBOutlet weak var fastRainButton: UIButton!
    @IBOutlet weak var waterView: UIView!
    @IBOutlet weak var waterViewHeightConstrant: NSLayoutConstraint!
    
    private weak var timer: Timer?
    var animationDuration = 5
    let width = CGFloat(15)
    let height = CGFloat(15)
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewForRain()
    }
    
    private func setUpViewForRain() {
        self.viewForRain.backgroundColor = .white

        self.startRainButton.setTitle("Start", for: .normal)
        self.startRainButton.setTitleColor(.white, for: .normal)
        self.startRainButton.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        self.startRainButton.layer.cornerRadius = 7
        
        self.slowRainButton.setTitle("Slower", for: .normal)
        self.slowRainButton.setTitleColor(.white, for: .normal)
        self.slowRainButton.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        self.slowRainButton.layer.cornerRadius = 7
        
        self.fastRainButton.setTitle("Faster", for: .normal)
        self.fastRainButton.setTitleColor(.white, for: .normal)
        self.fastRainButton.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
        self.fastRainButton.layer.cornerRadius = 7
    }

    @IBAction func startRainButtonPressed(_ sender: UIButton) {
        self.scheduleTimer()
    }
    
    @IBAction func slowRainButtonPressed(_ sender: UIButton) {
        self.makeRainSlower()
    }
    
    @IBAction func fastRainButtonPressed(_ sender: UIButton) {
        self.makeRainFaster()
    }

    private func scheduleTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
            self.startRain()
        })
        timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true, block: { (timer) in
            self.startRain()
        })
    }
    
    private func startRain() {
        for _ in 0 ..< 10 {
            let randomX = CGFloat(arc4random_uniform(UInt32(self.viewForRain.frame.width)))
            let randomY = CGFloat(Int(arc4random_uniform(30))-100)
            
            let drop = #imageLiteral(resourceName: "drop")
            let dropView = UIImageView(image: drop)
            dropView.frame = CGRect(x: randomX, y: randomY, width: width, height: height)
            self.viewForRain.addSubview(dropView)
            
            UIView.animateKeyframes(withDuration: TimeInterval(animationDuration), delay: 0, options: .calculationModeDiscrete, animations: {
                dropView.frame.origin.y = self.viewForRain.frame.height + 100
            }) { (_) in
                self.riseWater()
            }
        }
    }
    
    private func riseWater() {
        self.counter += 1
        if self.counter == 10 {
            self.counter = 0
            self.waterViewHeightConstrant.constant += 1
            print(self.waterViewHeightConstrant.constant)
            print(self.waterView.frame)
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func makeRainSlower() {
        self.animationDuration += 1
    }
    
    private func makeRainFaster() {
        if self.animationDuration > 1 {
            self.animationDuration -= 1
        } else {
            self.animationDuration = 1
        }
    }
}







































        
        
        
        
        
        
        



