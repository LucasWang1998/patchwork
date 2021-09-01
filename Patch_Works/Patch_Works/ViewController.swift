
import UIKit

var type:Int = 0



class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var custom_input: UITextField!
    

    
    @IBAction func med(_ sender: UIButton) {
        if(sender.tag == 1){
            type = 10
        }
        else{
         type = 35
        }
        
    }
    
    @IBAction func large(_ sender: Any) {
        type = 70
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.custom_input.delegate = self
        custom_input.placeholder = "# Stitches!"
        
       
    }
    @IBAction func custom(_ sender: Any) {
        if let temp = Float(custom_input.text!){
            if(temp != 0){
                type = Int(temp)
            }
            else{
                let alert = UIAlertController(title: "Invalid Number of Stiches", message: "Not a valid number of stitches try again", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: "Invalid Number of Stiches", message: "Not a valid number of stitches try again", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)
        -> Bool {
            
            let allowed = CharacterSet.decimalDigits
            let character = CharacterSet(charactersIn: string)
            return allowed.isSuperset(of: character)
    }
    
    

    
    
    
}

