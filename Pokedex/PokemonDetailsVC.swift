//
//  PokemonDetailsVC.swift
//  Pokedex
//
//  Created by yoann lathuiliere on 27/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var mainImage: UIImageView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var defenseLabel: UILabel!
  @IBOutlet weak var heightLabel: UILabel!
  @IBOutlet weak var pokedexIDLabel: UILabel!
  @IBOutlet weak var weightLabel: UILabel!
  @IBOutlet weak var baseAttackLabel: UILabel!
  @IBOutlet weak var evolutionLabel: UILabel!
  @IBOutlet weak var nextEvolutionImage: UIImageView!
  @IBOutlet weak var pokemonNameLabel: UILabel!
  
  
  
  
  
  // MARK: - Variables
  var pokemon: Pokemon!
  
  
  
  
  // MARK: - Functions
  func updateUI() {
    mainImage.image = UIImage(named: "\(pokemon.pokedexID)")
    descriptionLabel.text = pokemon.description
    typeLabel.text = pokemon.type
    defenseLabel.text = pokemon.defense
    heightLabel.text = pokemon.height
    pokedexIDLabel.text = "\(pokemon.pokedexID)"
    weightLabel.text = pokemon.height
    baseAttackLabel.text = pokemon.attack
    
    if pokemon.nextEvolutionId == "" {
      
      evolutionLabel.text = "No Evolutions"
      nextEvolutionImage.isHidden = true
      
    } else {
      nextEvolutionImage.isHidden = false
      nextEvolutionImage.image = UIImage(named: pokemon.nextEvolutionId)
      let str = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
      evolutionLabel.text = str
    }
  }
  
  
  
  
  // MARK: - Actions
  @IBAction func backButtonPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}





// MARK: - Lifecycle
extension PokemonDetailsVC {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pokemonNameLabel.text = pokemon.name.capitalized
    
    let img = UIImage(named: "\(pokemon.pokedexID)")
    mainImage.image = img
    //currentEvoImg.image = img
    pokedexIDLabel.text = "\(pokemon.pokedexID)"
    
    pokemon.downloadPokemonDetails(completion: {
      self.updateUI()
    })
  }
}
