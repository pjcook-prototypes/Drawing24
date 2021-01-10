//  Copyright © 2020 Software101. All rights reserved.

import Foundation

enum AudioChannel {
    static let backgroundMusic = 1
    static let soundEffects = 2
}

enum SoundName: String, CaseIterable {
    case explosion = "explosion.wav"
    case die = "die.mp3"
}

extension SoundName {
    var url: URL? {
        return soundURLs[self]
    }
}

private var soundURLs = [SoundName: URL]()
func setUpAudio() {
    for name in SoundName.allCases {
        let url = Bundle.main.url(forResource: name.rawValue, withExtension: nil)
        precondition(url != nil, "Missing audio file for \(name.rawValue)")
        soundURLs[name] = url
    }
    
    try? SoundManager.shared.activate()
    _ = try? SoundManager.shared.preload(SoundName.allCases[0].url!)
}

private let audioQueue = DispatchQueue(label: "AudioQueue", qos: .userInitiated)
func playSound(_ name: SoundName?, channel: Int? = nil, volume: Double = 1, pan: Double = 0) {
    audioQueue.async {
        guard let url = name?.url else {
            return
        }
        
        try? SoundManager.shared.play(
            url,
            channel: channel,
            volume: volume,
            pan: pan
        )
    }
}

func playSound(_ name: SoundName) {
    guard let url = name.url else {
        SoundManager.shared.clearChannel(AudioChannel.soundEffects)
        return
    }
    
    if SoundManager.shared.isPlaying(url, channel: AudioChannel.soundEffects) {
        SoundManager.shared.clearChannel(AudioChannel.soundEffects)
    }
    try? SoundManager.shared.play(url, channel: AudioChannel.soundEffects, volume: 1, pan: 0)
}
