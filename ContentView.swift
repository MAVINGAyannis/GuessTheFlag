//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Yannis Mavinga on 08/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var FlagTapped = 0
    @State private var FlagTapped2 = 0
    @State private var score = 0

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all);            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { FlagTapped in
                    Button(action: {
                        FlagTapped2 = FlagTapped
                        self.flagTapped(FlagTapped)
                    }) {
                        Image(self.countries[FlagTapped])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                    VStack {
                        Text("\(score)")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text("Wrong !"), message: Text("That's the flag of \(countries[FlagTapped2])"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                    self.score = 0
                })
            }
        }
    }
    func flagTapped(_ FlagTapped: Int) {
        if FlagTapped == correctAnswer {
            self.score += 1
            self.askQuestion()
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        FlagTapped2 = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
