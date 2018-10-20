import UIKit

//let arrayOfNumbers = [1,5,3,6,2,7,23,34]
//
//var sum = 0
//
//for number in arrayOfNumbers {
//    sum += number
//}
//print(sum)

//for number in 1..<10 where number % 2 == 0 {
//    print(number)
//}



//var numberBottles
//var song : string = "\(numberBottles) bottles of beer on the wall, \(numberBottles) bottles of beer, take one down, pass it around \(numberBottles)"

//for number in (1...99).reversed()
for x in stride(from: 99, to: 0, by: -1) {
    let bottle1 = x
    let bottle2 = x-1
    
    print("\(bottle1) bottles of beer on the wall, \(bottle1) bottles of beer, take one down, pass it around, \(bottle2) bottles of beer on the wall")
    
}
