
import UIKit
var high_smol:Int = 0
var high_meg:Int = 0
var high_lrg:Int = 0

class HighScoreView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var small: UILabel!
    
    @IBOutlet weak var medium: UILabel!
    
    @IBOutlet weak var large: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update(){
        small.text = "Small: " + String(UserDefaults.standard.integer(forKey:"small"))
        medium.text = "Medium: " + String(UserDefaults.standard.integer(forKey:"medium"))
        large.text = "Large: " + String(UserDefaults.standard.integer(forKey:"large"))
        
    }
    
    
 
    
    
    
    
}

