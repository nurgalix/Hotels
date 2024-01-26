//
//  HotelManager.swift
//  Hotels
//
//  Created by Nurgali on 20.12.2023.
//

import Foundation

protocol HotelManagerDelegate {
    func didFetchHotel(_ hotel: MainHotel)
}

struct HotelManager {
    private let hotelURLString = "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473"
    
    var delegate: HotelManagerDelegate?
    
    func performRequest() {
        guard let url = URL(string: hotelURLString) else {
            return
        }
        
        URLSession.shared.fetchData(at: url) { (result: Result<MainHotel, Error>) in
            switch result {
            case.success(let hotel):
                DispatchQueue.main.async {
                    self.delegate?.didFetchHotel(hotel)
                }
            case.failure(let error):
                // A failure, please handle
                print(error)
            }
            
        
        }
    }
}
