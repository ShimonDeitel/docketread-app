import Foundation

struct Series: Identifiable, Codable, Equatable {
    let id: UUID
    var series: String
    var volume: Int
    var chapter: Int
    var status: String
    var createdAt: Date

    init(id: UUID = UUID(), series: String = "", volume: Int = 0, chapter: Int = 0, status: String = "", createdAt: Date = Date()) {
        self.id = id
        self.series = series
        self.volume = volume
        self.chapter = chapter
        self.status = status
        self.createdAt = createdAt
    }
}
