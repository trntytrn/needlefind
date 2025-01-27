//
//  ResultsView.swift
//  deloittechallenge
//
//  Created by Trinity Tran on 1/26/25.
//

import SwiftUI

struct ResultsView: View {
    let searchItem: String
    let store: String 
    let preference: String
    @State private var recommendation: String = "Loading..."
    var body: some View {
        VStack {
            Text("Results")
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
                    Text("You are trying to find \(searchItem) at \(store) that is focusing on \(preference)")
                        .font(.headline)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    Text("Here is an option for you:")
                        .font(.headline)
                        .padding()
                        .multilineTextAlignment(.center)
                    Text(recommendation)
                        .font(.headline)
                        .padding()
                        .multilineTextAlignment(.center)
                        .task {
                        do {
                            let apiService = APIService()
                            recommendation = try await apiService.getProductRecommendation(
                                item: searchItem,
                                store: store,
                                preference: preference
                            )
                        } catch {
                            recommendation = "Error getting recommendation"
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ResultsView(searchItem: "Sunscreen", store: "Target", preference: "Sustainability")
}
