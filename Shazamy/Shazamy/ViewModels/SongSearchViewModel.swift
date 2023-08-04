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
    
    @Published private var songs: Array<Items> = []
    
    
    init(query: String) {
        //DataProvider.shared.findSong(Query: query)
        self.getData()
        self.makeSearch(query: query)
    }
    
    func getData() {
        // subscribe
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
        DataProvider.shared.findSong(Query: query)
    }
}


