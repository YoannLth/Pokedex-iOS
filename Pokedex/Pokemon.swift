//
//  Pokemon.swift
//  Pokedex
//
//  Created by yoann lathuiliere on 24/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import Foundation

class Pokemon {
  //MARK: - Variables
  // Privates
  private var _name: String!
  private var _pokedexID: Int!
  
  // Publics
  var name: String { return _name }
  var pokedexID: Int { return _pokedexID }
  
  
  
  
  
  //MARK: - Initializer 
  init(name: String, pokedexID: Int) {
    self._name = name
    self._pokedexID = pokedexID
  }
}
