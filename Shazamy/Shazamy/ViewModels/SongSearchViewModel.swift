//
//  SongSearchViewModel.swift
//  Shazamy
//
//  Created by will astilla on 11/25/22.
//


import Foundation
import Combine

class SongSearchViewModel: ObservableObject{
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var songs: Array<Items> = []
    
    
    init(query: String) {
        //DataProvider.shared.findSong(Query: query)
        self.getData()
        self.makeSearch(query: query)
    }
    
    func getData() {
        // subscribe to songSearchSubject
        DataProvider.shared.songSearchSubject
            .sink(receiveValue: { [weak self] items in
                guard let self = self else { return }
                self.songs = items
            }).store(in: &cancellables)
    }
    
    func getSong() -> Array<Items>{
        return songs
    }
    
    func makeSearch(query: String){
        // Call find song to send data through songSearchSubject
        DataProvider.shared.findSong(Query: query)
    }
}


