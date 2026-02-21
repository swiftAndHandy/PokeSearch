//
//  AudioPlayer.swift
//  PokeSearch
//
//  Created by Andre Veltens on 21.02.26.
//

import OggDecoder
import AVFoundation

struct OGGPlayer {
    private static var audioPlayer: AVAudioPlayer?
    
    static func playURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("cry.ogg")
                try data.write(to: tempURL)
                
                let decoder = OGGDecoder()
                
                if let wavURL = await decoder.decode(tempURL) {
                    audioPlayer = try? AVAudioPlayer(contentsOf: wavURL)
                    audioPlayer?.play()
                } else {
                    print("Converting OGG to WAV failed")
                }
            } catch {
                print("Error while loading: \(error.localizedDescription)")
            }
        }
    }
}
