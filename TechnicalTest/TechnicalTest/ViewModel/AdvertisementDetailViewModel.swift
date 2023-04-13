//
//  AdvertisementDetailViewModel.swift
//  TechnicalTest
//
//  Created by Marouene on 13/04/2023.
//

import Foundation

protocol AdvertisementDetailViewModelProtocol {
    var advertisement: RichAdvertisement { get }
}

class AdvertisementDetailViewModel: AdvertisementDetailViewModelProtocol {
    let advertisement: RichAdvertisement
    
    init(advertisement: RichAdvertisement) {
        self.advertisement = advertisement
    }
}
