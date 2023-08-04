//
//  ShazamViewModel.swift
//  Shazamy
//
//  Created by will astilla on 11/10/22.
//

import Foundation

import AVKit
import Combine
import ShazamKit

@MainActor
class ViewModel: NSObject, ObservableObject {
    @Published var currentItem: SHMediaItem? = nil
    @Published var shazamMedia: ShazamMedia = .init(title: "Title...", subtitle: "Subtitle...", artistName: "Artist Name...", albumArtURL: URL(string: "https://google.com"), genres: ["Pop"])

    @Published var shazaming = false
    @Published var found = false

    private let session = SHSession()
    private let audioEngine = AVAudioEngine()
    private let signatureGenerator = SHSignatureGenerator()

    override init() {
        super.init()
        session.delegate = self
    }

    /*public func check(){
        if self.shazamMedia.title != "Title..."{
            self.found = true
        }
        else{
            self.found = false
        }
    }*/
    private func prepareAudioRecording() throws {
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    }

    private func generateSignature() {
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: .zero)

        inputNode.installTap(onBus: .zero, bufferSize: 1024, format: recordingFormat) { [weak session] buffer, _ in
            session?.matchStreamingBuffer(buffer, at: nil)
        }
    }

    private func startAudioRecording() throws {
        self.found = false
        try audioEngine.start()
        shazaming = true
    }

    public func startRecognition() {
        do {
            if audioEngine.isRunning {
                stopRecognition()
                return
            }
            try prepareAudioRecording()
            generateSignature()
            try startAudioRecording()
        } catch {
            print(error.localizedDescription)
        }
    }

    public func stopRecognition() {
        shazaming = false
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: .zero)
    }
}

extension ViewModel: SHSessionDelegate {
    func session(_ session: SHSession, didFind match: SHMatch) {
        guard let mediaItem = match.mediaItems.first else { return }

        Task {
            self.currentItem = mediaItem
        }
    }
}
