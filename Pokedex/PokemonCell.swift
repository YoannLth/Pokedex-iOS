//
//  PokemonCell.swift
//  Pokedex
//
//  Created by yoann lathuiliere on 24/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
  
  // MARK: - Outlets
  @IBOutlet weak var thumbImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  
  
  
  // MARK: - Init
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    layer.cornerRadius = 5.0
  }
  
  
  
  
  
  // MARK: - Functions
  func configureCell(pokemon: Pokemon!) {
    nameLabel.text = pokemon.name.capitalized
    thumbImage.image = UIImage(named: "\(pokemon.pokedexID)") ?? UIImage()
  }
}
