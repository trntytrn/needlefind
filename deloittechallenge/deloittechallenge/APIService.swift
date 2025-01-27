//
//  APIService.swift
//  deloittechallenge
//
//  Created by Trinity Tran on 1/26/25.
//

import Foundation

class APIService {
    private let apiKey = //INSERT YOUR OWN API KEY HERE
    private let endpoint = "https://api.openai.com/v1/chat/completions"
    
    func getProductRecommendation(item: String, store: String, preference: String) async throws -> String {
        let prompt = "Find me a \(item) at \(store) that focuses on \(preference)"
        
        let message = [
            ["role": "user", "content": prompt]
        ]
        
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": message,
            "max_tokens": 150
        ]
        
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let response: ChatGPTResponse
        do {
            response = try decoder.decode(ChatGPTResponse.self, from: data)
        } catch {
            throw NSError(domain: "APIService", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to decode API response: \(error.localizedDescription)"])
        }
        if response.choices.isEmpty {
            throw NSError(domain: "APIService", code: 1, userInfo: [NSLocalizedDescriptionKey: "No choices returned from API"])
        }
        print(response.choices.first?.message.content ?? "No recommendation found")
        return response.choices.first?.message.content ?? "No recommendation found"
    }
}

struct ChatGPTResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}

struct Message: Codable {
    let content: String
}
