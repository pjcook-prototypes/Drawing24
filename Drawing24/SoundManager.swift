import AVFoundation

public class SoundManager: NSObject, AVAudioPlayerDelegate {
    private var playing = Set<AVAudioPlayer>()
    private var channels = [Int: (url: URL, player: AVAudioPlayer)]()
    
    public static let shared = SoundManager()
    
    private override init() {}
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playing.remove(player)
    }
}

public extension SoundManager {
    func activate() throws {
        #if !os(macOS)
        try AVAudioSession.sharedInstance().setActive(true)
        #endif
    }
    
    func preload(_ url: URL, channel: Int? = nil) throws -> AVAudioPlayer {
        if let channel = channel, let (oldURL, oldSound) = channels[channel] {
            if oldURL == url {
                return oldSound
            }
            oldSound.stop()
        }
        return try AVAudioPlayer(contentsOf: url)
    }
    
    func play(_ url: URL, channel: Int?, volume: Double, pan: Double, numberOfLoops: Int = 0) throws {
        let player = try preload(url, channel: channel)
        if let channel = channel {
            channels[channel] = (url, player)
        }
        playing.insert(player)
        player.delegate = self
        player.volume = Float(volume)
        player.pan = Float(pan)
        player.numberOfLoops = numberOfLoops
        player.play()
    }
    
    func isPlaying(_ url: URL, channel: Int?) -> Bool {
        guard let channel = channel else { return false }
        return channels[channel]?.url == url
    }
    
    func pause(channel: Int) {
        guard let item = channels[channel] else { return }
        item.player.pause()
    }
    
    func resume(channel: Int) {
        guard let item = channels[channel] else { return }
        item.player.play()
    }
    
    func clearChannel(_ channel: Int) {
        channels[channel]?.player.stop()
        channels[channel] = nil
    }
    
    func clearAll() {
        channels.keys.forEach(clearChannel)
    }
}
