import SwiftUI

struct ContentView: View {
    @State private var couleurGenerer = ""
    @State private var messageAlerte = ""
    @State private var afficherAlerte = false
    @State private var cardImageName = ""

    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    Text("Devinez la couleur \n Rouge ou Noir")
                        .padding()
                        .foregroundColor(.gray)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Image("")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 300)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        HStack{
                            Button(action: {
                                choisirCouleur(couleur: "rouge")
                                afficherAlerte = true
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
                                afficherAlerte = true
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
            .toolbar(content: {
                ToolbarItem(placement: .principal, content: {
                    Text("Red or Black")
                        .font(.largeTitle)
                })
            })
        }
    }

    func choisirCouleur(couleur: String) {
        genererCouleur()

        if couleur.lowercased() == couleurGenerer {
            messageAlerte = "Bravo"
        } else {
            messageAlerte = "Perdu"
        }
    }

    func genererCouleur() {
        couleurGenerer = Bool.random() ? "rouge" : "noir"
        print(couleurGenerer)
    }
}


#Preview {
    ContentView()
}
