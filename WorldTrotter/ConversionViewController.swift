import UIKit

class ConversionViewController: UIViewController , UITextFieldDelegate {
    //Outlets
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? //“Adding a property observer to fahrenheitValue”
    {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        //Overriding viewDidLoad()
        updateCelsiusLabel()
    }
    //actions
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        
        //Internationalizing the temperature entry
        if let text = textField.text, let number = numberFormatter.number(from: text) {
                fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
            } else {
                fahrenheitValue = nil
            }
        }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    //Number formatter
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
//method updateCelsiusLabel for converting fahrenheit value to celsius
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text =
                        numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
//Adding a delegate method
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
//Internationalizing the decimal separator
        let currentLocale = Locale.current
            let decimalSeparator = currentLocale.decimalSeparator ?? "."

            let existingTextHasDecimalSeparator
                    = textField.text?.range(of: decimalSeparator)
            let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)

            if existingTextHasDecimalSeparator != nil,
                replacementTextHasDecimalSeparator != nil {
                return false
            } else {
                return true
            }
        }
}
