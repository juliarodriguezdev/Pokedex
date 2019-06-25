//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by julia rodriguez on 6/25/19.
//  Copyright © 2019 julia rodriguez. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    @IBOutlet weak var pokemonSpriteImage: UIImageView!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    @IBOutlet weak var pokemonIDLabel: UILabel!
    
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchBar.delegate = self

    }
    func updatesView(pokemon: TopLevelDict) {
        DispatchQueue.main.async {
        self.pokemonNameLabel.text = pokemon.name
        self.pokemonIDLabel.text = "\(pokemon.id)"
        self.pokemonAbilitiesLabel.text = pokemon.abilities[0].ability.name
        // image?
        }
    }
}

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        PokemonController.sharedInstance.fetchPokemonWith(searchTerm: searchText) { (pokemon) in
            guard let pokeball = pokemon else {return}
            PokemonController.sharedInstance.fetchPokemonImage(pokemon: pokeball, completion: { (image) in
                DispatchQueue.main.async {
                    self.pokemonSpriteImage.image = image
                }
                self.updatesView(pokemon: pokeball)
            })
       
        }
    }
    
}
