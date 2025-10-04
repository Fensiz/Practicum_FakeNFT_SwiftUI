import Foundation

extension DateFormatter {
    // We use static var because creating a dateFormatter is an expensive operation and we should do it once
    @MainActor static let defaultDateFormatter: ISO8601DateFormatter = .init()
}
