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
    var houses: [House]{get} // Solo get porque sera de solo lectura
}

final class LocalFactory: HouseFactory {
    var houses: [House] {
        //Creacion de casas
        let starkSigil = Sigil(image: UIImage(named: "codeiscoming")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister")!, description: "León Rampante")
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno")
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido")
        //añadir algunos personajes
        let robb = Person(name: "Robb", alias: "El joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        
        starkHouse.add(person: robb)
        starkHouse.add(person: arya)
        lannisterHouse.add(person: tyrion)
        
        return [lannisterHouse,starkHouse]
        
    }
}
