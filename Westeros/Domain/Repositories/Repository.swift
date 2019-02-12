//
//  Repository.swift
//  Westeros
//
//  Created by Oscar canton on 11/2/19.
//  Copyright © 2019 Oscar canton. All rights reserved.
//

import Foundation
import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias HouseFilter = (House) -> Bool
    var houses: [House]{get} // Solo get porque sera de solo lectura
    func house(named: String) -> House?
    func houses(filteredBy filter: HouseFilter) -> [House]
}

final class LocalFactory: HouseFactory {
    var houses: [House] {
        //Creacion de casas
        let starkSigil = Sigil(image: UIImage(named: "codeiscoming")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister")!, description: "León Rampante")
        let targatyenSigil = Sigil(image: UIImage(named:  "targaryenSmall")!, description: "Dragón Tricefalo")
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", wikiURL: starkURL)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", wikiURL: lannisterURL)
        let targaryenHouse = House(name: "Targaryen", sigil: targatyenSigil, words: "Fuego y Sangre", wikiURL: targaryenURL)
        
        
        //añadir algunos personajes
        let robb = Person(name: "Robb", alias: "El joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        let cersei = Person(name: "Cercei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de dragones", house: targaryenHouse)
        
        starkHouse.add(persons: robb, arya)
        lannisterHouse.add(persons: tyrion, cersei , jaime)
        targaryenHouse.add(person: dani)
        
        return [targaryenHouse, starkHouse,lannisterHouse].sorted()
        
    }
    
    func house(named name: String) -> House? {
        let house = houses.filter {$0.name.uppercased() == name.uppercased()}.first
        return house
    }
    func houses (filteredBy theFilter: (House) -> Bool) -> [House] {
        return houses.filter(theFilter)
    }

}
