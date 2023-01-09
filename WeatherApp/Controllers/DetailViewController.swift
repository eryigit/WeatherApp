
import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityDegreeLabel: UILabel!
    
    var cityName = String()
    var active = false
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "WeatherBG")!)
        cityNameLabel.text = cityName.capitalized
        if active {
            activeIndicator.isHidden = false
            activeIndicator.startAnimating()
        }
        getWeatherInfo()
    }
    func getWeatherInfo() {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=-") {
           let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { [self]data, response, err in
                if err == nil {
                    if let incomingData = data {
                        do {
                            let jsonResponse = try JSONSerialization.jsonObject(with: incomingData, options: []) as? [String: Any]
                            if let main = jsonResponse!["main"] as? NSDictionary {
                                if let temp = main["temp"] as? Double {
                                    let state = String(Int(temp-272.15))
                                    DispatchQueue.main.sync {
                                        self.cityDegreeLabel.text = "\(state)℃"
                                        activeIndicator.stopAnimating()
                                        activeIndicator.isHidden = true
                                    }
                                }
                            }
                            if let weatherDetail = jsonResponse!["weather"] as? [[String:Any]] {
                                if let description = weatherDetail[0]["description"] as? String {
                                    let state = description
                                    DispatchQueue.main.sync {
                                        descriptionLabel.text = state.capitalized
                                    }
                                }
                            }
                        } catch {
                            print(err!.localizedDescription)
                        }
                    }
                }
           }.resume()
        }
    }
}
