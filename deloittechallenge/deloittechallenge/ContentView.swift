//
//  ContentView.swift
//  deloittechallenge
//
//  Created by Trinity Tran on 1/26/25.
//

import SwiftUI

struct ContentView: View {
    @State private var input1 = ""
    @State private var input2 = ""
    @State private var input3 = ""
    
    private var isFormValid: Bool {
        !input1.isEmpty && !input2.isEmpty && !input3.isEmpty
    }
    
    var body : some View {
        NavigationView {
            VStack() {
                Text("Search")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .overlay(Divider(), alignment: .bottom)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .zIndex(1)
                
                ScrollView {
                    VStack {
                        Text("🪡")
                            .font(.system(size: 60))
                            .padding()
                        Text("Welcome to NeedleFind! Finding the perfect product for you can be like trying to find a needle in a haystack. Input what product you are looking for in the first box, then input where you are shopping. It can be online or in store! Then, input what are you specifically targeting.")
                            .padding(.top)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Text("What are you trying to find?")
                            .font(.headline)
                            .padding(.top)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        TextField("Ex. Sunscreen, Cat food, water bottle, etc.", text: $input1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .padding(.bottom)
                        Text("Where are you shopping?")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                        TextField("Ex. Target, Ulta, Walgreens, Lowe's, etc.", text: $input2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .padding(.bottom)
                        Text("What is important to you?")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                        TextField("Ex. Sustainability, acne, dairy free, etc.", text: $input3)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .padding(.bottom)
                        
                        NavigationLink(destination: ResultsView(searchItem: input1, store: input2, preference: input3)) {
                            Text("Submit")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 100)
                                .padding()
                                .background(isFormValid ? Color.blue : Color.gray)
                                .cornerRadius(10)
                        }
                        .disabled(!isFormValid)
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
