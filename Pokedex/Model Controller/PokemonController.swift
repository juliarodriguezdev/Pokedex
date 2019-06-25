//
//  PokemonController.swift
//  Pokedex
//
//  Created by julia rodriguez on 6/25/19.
//  Copyright © 2019 julia rodriguez. All rights reserved.
//

import UIKit

class PokemonController {
    
    // Singleton: One instance of pokemon
    static let sharedInstance = PokemonController()
    
    // Create
    func fetchPokemonWith(searchTerm: String, completion: @escaping (TopLevelDict?) -> Void) {
        // Build URL
        
        let baseURL = URL(string: "https://pokeapi.co/api/v2")
        
        let pokemonPathComponentURL = baseURL?.appendingPathComponent("pokemon")
        guard let finalURL = pokemonPathComponentURL?.appendingPathComponent(searchTerm) else {return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            // Handle the Error
            if let error = error {
                print("There was an error\(error.localizedDescription)")
            }
            // Check if there's data
            if let data = data {
                // decode the data
                do {
                    // Handle the data
                    let pokemon = try JSONDecoder().decode(TopLevelDict.self, from: data)
                    completion(pokemon)
                } catch {
                    print("Error Fetching pokemon!")
                    completion(nil);return
                }
                
            }
            
        }.resume()
    }
    func fetchPokemonImage(pokemon: TopLevelDict, completion: @escaping (UIImage?) -> Void) {
        // Build URL
        let imageURL = pokemon.spritesDictionary.image
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            // Handle the error
            if let error = error {
                print("There was an image error\(error.localizedDescription)")
            }
            // Check if there's data
            if let data = data {
                guard let pokemonImage = UIImage(data: data) else { completion(nil);return}
                completion(pokemonImage)
        
                }
            }.resume()
        }
    }

