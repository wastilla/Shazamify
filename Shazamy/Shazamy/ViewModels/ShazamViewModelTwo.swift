//
//  ShazamViewModelTwo.swift
//  Shazamy
//
//  Created by will astilla on 11/25/22.
//

import AVKit
import Combine
import Foundation
import ShazamKit

class ShazamViewModelTwo: NSObject, ObservableObject {
    @Published var shazamMedia = ShazamMedia(title: "Title...",
                                             subtitle: "Subtitle...",
                                             artistName: "Artist Name...",
                                             albumArtURL: URL(string: "https://google.com"),
                                             genres: ["Pop"])
    @Published var isRecording = false

    private let audioEngine = AVAudioEngine()
    private let session = SHSession()
    private let signatureGenerator = SHSignatureGenerator()

    override init() {
        super.init()
        session.delegate = self
    }

    public func startOrEndListening() {
        guard !audioEngine.isRunning else {
            audioEngine.stop()
            DispatchQueue.main.async {
                self.isRecording = false
            }
            return
        }

        let audioSession = AVAudioSession.sharedInstance()
        audioSession.requestRecordPermission { granted in
            guard granted else { return }
            try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            let inputNode = self.audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0,
                                 bufferSize: 1024,
                                 format: recordingFormat) { (buffer: AVAudioPCMBuffer,
                                                             _: AVAudioTime) in
                    self.session.matchStreamingBuffer(buffer, at: nil)
            }
            self.audioEngine.prepare()
            do {
                try self.audioEngine.start()
            } catch {
                assertionFailure(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.isRecording = true
            }
        }
    }
}

extension ShazamViewModelTwo: SHSessionDelegate {
    func session(_ session: SHSession, didFind match: SHMatch) {
        let mediaItems = match.mediaItems

        if let firstItem = mediaItems.first {
            let _shazamMedia = ShazamMedia(title: firstItem.title,
                                           subtitle: firstItem.subtitle,
                                           artistName: firstItem.artist,
                                           albumArtURL: firstItem.artworkURL,
                                           genres: firstItem.genres)
            DispatchQueue.main.async {
                self.shazamMedia = _shazamMedia
            }
        }
    }
}
