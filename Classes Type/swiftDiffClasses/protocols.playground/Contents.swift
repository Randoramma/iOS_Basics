//: Protocol

import UIKit

protocol FullyName
{
    var fullname:String{ get }
}


//EXAMPLE 1
struct User: FullyName {

    var fullname:String

}


let user = User(fullname: "Jimmy John")


//EXAMPLE 2
struct Friend:FullyName {
    var firstName:String
    var middleName:String
    var lastName:String

    var fullname:String{
        return "\(firstName) \(middleName) \(lastName)"
    }
}


let friend = Friend(firstName: "Luis", middleName: "Andres", lastName: "Castillo")

friend.fullname


//MODELING LOOSE RELATIONSHIPS

protocol Blendable
{
    func blend()
}


class Fruit:Blendable {
    var name:String
    
    init(name:String)
    {
        self.name = name
    }
}//eo-c

class Diary {
    var name:String
    
    init(name:String)
    {
        self.name = name
    }
}//eo-c

class Cheese:Diary
{
}//eo-c

class Milk:Diary, Blendable
{
    
    func blend()
    {
        print("I havent changed, Im still Milk!!")
    }
}//eo-c


func makeSmoothie(ingredients: [Blendable])
{
    print("Make Smoothie time!")
}//eom

let strawberry = Fruit(name: "Strawberry")
let cheddar = Cheese(name: "Cheddar Cheese")
let chocolateMilk = Milk(name: "Chocolate Milk")


//
//let myIngredients:[Blendable] = [strawberry, cheddar, chocolateMilk]


//notice how the below does NOT have cheddar, thats because cheddar is from Cheese which doesnt contain the protocol Blendable
let myIngredients:[Blendable] = [strawberry, chocolateMilk]

makeSmoothie(myIngredients)


//Random Number Generator
protocol RandomNumberGenerator
{

    func random()-> Double
}


class LinearCongruentialGenerator: RandomNumberGenerator {
    
    var lastRandom = 42.0
    let m = 13874.0
    let a = 3978.0
    let c = 29663.0
    
    func random() -> Double {
        
        lastRandom = ( (lastRandom * a + c) % m )
        
        return lastRandom/m
        
    }//eom
    
}//eoc



class Dice {
    
    let sides:Int
    let generator: RandomNumberGenerator
    
    init(sides:Int, generator:RandomNumberGenerator)
    {
        self.sides     = sides
        self.generator = generator
    }
    
    func roll()->Int
    {
        return Int( generator.random() * Double(sides) )+1
    }
    
}//eoc



var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())



