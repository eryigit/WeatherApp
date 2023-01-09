
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "WeatherBG")!)
        textField.attributedPlaceholder = NSAttributedString(string: "Write your city", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailVC" {
            let destination = segue.destination as! DetailViewController
            destination.active = true
            destination.cityName = textField.text!
        }
    }
    @IBAction func showButton(_ sender: Any) {
        if textField.text == "" {
            let alertController = UIAlertController(title: "Warning", message: "Please write your city!", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelButton)
            self.present(alertController, animated: true)
        }else {
            performSegue(withIdentifier: "detailVC", sender: nil)
        }
    }
}

