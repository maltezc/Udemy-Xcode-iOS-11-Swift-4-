import UIKit

func bmiCalculator (yourname: String, yourHeight: Double, yourWeight: Double) -> String {
    
    let bmiScore = float_t(yourWeight / pow(yourHeight, 2))
    let shortenedBMI = String(format: "%.2f", bmiScore)
    var interpretation = ""
    
    if bmiScore > 25 {
        interpretation = "hit the gym, shed weight, and make gains"
    }
    else if bmiScore > 18.5 && bmiScore <= 25 {
        interpretation = "youre at normal weight"
    }
    else {
        interpretation = "youre skinny af"
    }
    
    return "Your BMI score is \(shortenedBMI), \(interpretation) "
    
//    return bmiCalculator(yourname: "chris", yourHeight: 66, yourWeight: 140)
    
}

print(bmiCalculator(yourname: "Chris", yourHeight: 1.7, yourWeight: 63))
