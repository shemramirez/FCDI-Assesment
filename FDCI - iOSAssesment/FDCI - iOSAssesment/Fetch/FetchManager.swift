//
//  FetchManager.swift
//  FDCI - iOSAssesment
//
//  Created by Shem Ramirez on 3/3/25.
//

import Foundation


struct FetchManager {
    func getRegions() async throws -> [Country] {
        let endpoint = "https://restcountries.com/v3.1/all"
        
        guard let url = URL(string: endpoint) else {
            throw FDCIError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FDCIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let countries = try decoder.decode([Country].self, from: data)
            
            return countries
    
        
        } catch {
            throw FDCIError.invalidData
        }
        
    }
}
