import UIKit



func fibonacci (until n : Int) {
    print(0)
    print(1)
    
    var num1 = 0
    var num2 = 1
    
    for _ in 0...n {
        let num = num1 + num2
        print(num)
        
        num1 = num2
        num2 = num
    }
    
}

fibonacci(until: 20)


//first attempt V
//var startNumber = 0
//var fibResult = 0
//var fibArray = [] as Array
//
//
//func fibonacci (endNumber: Int) {
//    let fibResult = 0
//    var fibArray = [] as Array
//    fibArray.append(0)
//    fibArray.append(1)
//
//    for x in fibArray {
//        if x as! Int <= 20 do {
//            let preNum1 = fibArray.count - 2 as Int
//            let number1 = fibArray[preNum1] as! Int
//            let number2 = fibArray.last as! Int
//            let fibResult = number1 + number2
//            fibArray.append(fibResult)
//        }
//
//    }
//
//}



//fibonacci(endNumber: 20)

//start out with empty var 0 and empty array
//add result to Array then add 2nd to last position and last position
// repeat until user set number is reached
//0 + 1 = 1
//1 + 1 = 2
//1 + 2 = 3
//2 + 3 = 5
var dummyArray = [1,2,3,4,3,5,10,20] as Array


//let lastButOne = dummyArray.count - 2
//let lastOne = dummyArray.last
//let horseshit = dummyArray[lastButOne]
//print(lastOne!)
//print(horseshit)
//print(lastOne! + horseshit)

//func shitty(_ num: Int) -> Int {
//    if num == 0 {
//        return 0
//    }
//    else if num == 1 {
//        return 1
//    }
//    return shitty(num - 2) + shitty(num - 1)
//}
//
//let shittyshit = shitty(5)
//
//print(shittyshit)

//print(dummyArray.count - 2)
//print(dummyArray.count)

