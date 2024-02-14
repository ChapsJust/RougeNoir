//
//  ContentView.swift
//  JeuRougeNoir
//
//  Created by Chaps on 2024-02-14.
//

import SwiftUI

//Modele de donnees pour une carte
struct Carte{
    var nom: String
    var estRouge: Bool { nom.contains("hearts") || nom.contains("diamonds") }
}

struct ContentView: View {
    @State private var paquetDeCartes: [Carte] = ContentView.genererPaquetCartes()
    @State private var couleurGenerer = ""
    @State private var messageAlerte = ""
    @State private var afficherAlerte = false
    @State private var cardImageName = ""
    @State private var score = 0
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    Text("Devinez la couleur \n Rouge ou Noir")
                        .padding()
                        .foregroundColor(.gray)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    
                    Text("Score : \(score)")
                        .padding()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        
                    Image(cardImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 300)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        HStack{
                            Button(action: {
                                choisirCouleur(couleur: "rouge")
                            }) {
                                Text("Rouge")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .cornerRadius(8)
                            }
                            .alert(messageAlerte, isPresented: $afficherAlerte){}
                            
                            Button(action: {
                                choisirCouleur(couleur: "noir")
                            }) {
                                Text("Noir")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.black)
                                    .cornerRadius(8)
                            }
                            .alert(messageAlerte, isPresented:$afficherAlerte){}
                        }
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(20)
                    }
                    .padding()
                    .foregroundColor(.gray)
                    .font(.headline)
                }
                .padding()
            }
            .onAppear(){
                carteStart()
            }
            .toolbar(content: {
                ToolbarItem(placement: .principal, content: {
                    Text("Red or Black")
                        .font(.largeTitle)
                })
            })
        }
    }
    
    static func genererPaquetCartes() -> [Carte]{
        let valeurs = ["ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "jack", "queen", "king"]
        let couleurs = ["hearts", "diamonds", "spades", "clubs"]
        var paquet: [Carte] = []
        
        for couleur in couleurs {
            for valeur in valeurs {
                let nomCarte = "\(valeur)_of_\(couleur)"
                paquet.append(Carte(nom: nomCarte))
                print(nomCarte)
            }
        }
        return paquet.shuffled()
    }
    
    func choisirCouleur(couleur: String) {
        if paquetDeCartes.isEmpty{
            messageAlerte = "Le paquet est vide"
            afficherAlerte = true
            return
        }
        
        let cartePigee = paquetDeCartes.removeFirst()
        cardImageName = cartePigee.nom
        let couleurCarte = cartePigee.estRouge ? "rouge" : "noir"

        if couleur.lowercased() == couleurCarte{
            score += 1
            messageAlerte = "Bravo"
        } else {
            messageAlerte = "Perdu"
        }
        afficherAlerte = true
    }
    
    func carteStart(){
        let cartePigee = paquetDeCartes.removeFirst()
        cardImageName = cartePigee.nom
    }
}


#Preview {
    ContentView()
}

