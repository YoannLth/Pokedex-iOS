//
//  HomeVC.swift
//  Pokedex
//
//  Created by yoann lathuiliere on 25/03/2017.
//  Copyright © 2017 yoann lathuiliere. All rights reserved.
//

import UIKit
import AVFoundation

class HomeVC: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  
  
  
  
  // MARK: - Variables
  var pokemonArray = [Pokemon]()
  var musicPlayer: AVAudioPlayer!
  var filteredPokemonArray = [Pokemon]()
  var isInFilterMode = false
  
  
  
  
  
  // MARK: - Functions
  func parsePokemonCSV() {
    do {
      if let path = Bundle.main.path(forResource: "pokemon", ofType: "csv") {
        let csv = try CSV(contentsOfURL: path)
        let rows = csv.rows
        
        for row in rows {
          if let pokeIDString = row["id"], let pokeID = Int(pokeIDString), let name = row["identifier"] {
            let pokemon = Pokemon(name: name, pokedexID: pokeID)
            pokemonArray.append(pokemon)
          }
        }
      }
    } catch let err as NSError {
      print(err.debugDescription)
    }
  }
  
  func initAudio() {
    if let path = Bundle.main.path(forResource: "music", ofType: "mp3"), let url = URL(string: path) {
      do {
        musicPlayer = try AVAudioPlayer(contentsOf: url)
        musicPlayer.prepareToPlay()
        musicPlayer.numberOfLoops = -1
        musicPlayer.play()
      } catch let err as NSError {
        print(err.debugDescription)
      }
    }
  }
  
  
  
  
  
  // MARK: - Actions
  @IBAction func playButtonPressed(_ sender: UIButton) {
      if musicPlayer.isPlaying {
        musicPlayer.pause()
        sender.alpha = 0.2
      } else {
        musicPlayer.play()
        sender.alpha = 1.0
      }
  }

  
  
  
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.delegate = self
    collectionView.dataSource = self
    searchBar.delegate = self
    
    parsePokemonCSV()
    initAudio()
  }
}





// MARK: - UICollectionView
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as? PokemonCell {
      var pokemon: Pokemon
        
      if isInFilterMode {
        pokemon = filteredPokemonArray[indexPath.row]
      } else {
        pokemon = pokemonArray[indexPath.row]
      }
      
      cell.configureCell(pokemon: pokemon)
      
      return cell
    }
    
    return UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var pokemon: Pokemon
    
    if isInFilterMode {
      pokemon = filteredPokemonArray[indexPath.row]
    } else {
      pokemon = pokemonArray[indexPath.row]
    }
    
    performSegue(withIdentifier: "PokemonDetailsVC", sender: pokemon)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isInFilterMode {
      return filteredPokemonArray.count
    } else {
      return pokemonArray.count
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 105, height: 105)
  }
}





// MARK: - UISearchBar
extension HomeVC: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text == nil || searchBar.text == "" {
      isInFilterMode = false
      collectionView.reloadData()
      view.endEditing(true)
    } else {
      isInFilterMode = true
      
      if let lower = searchBar.text?.lowercased() {
        filteredPokemonArray = pokemonArray.filter({$0.name.range(of: lower) != nil})
        collectionView.reloadData()
      }
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    view.endEditing(true)
  }
}





// MARK: - Segue
extension HomeVC {
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "PokemonDetailVC" {
      if let detailsVC = segue.destination as? PokemonDetailsVC {
        if let pokemon = sender as? Pokemon {
          detailsVC.pokemon = pokemon
        }
      }
    }
  }
}
