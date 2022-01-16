import SwiftUI

/// An observable wrapper for an array of data for use in any chart
public class ChartData: ObservableObject {
    @Published public var data: [(String, Double)] = []
    @Published public var isNormalized: Bool = false

    var points: [Double] {
        data.map { $0.1 }
    }

    var values: [String] {
        data.map { $0.0 }
    }

    var normalisedPoints: [Double] {
        if  self.isNormalized {
            return points
        }
        let absolutePoints = points.map { abs($0) }
        return points.map { $0 / (absolutePoints.max() ?? 1.0) }
    }

    var normalisedRange: Double {
        let min = isNormalized ? 0.0 : normalisedPoints.min()
        let max = isNormalized ? 1.0 : normalisedPoints.max()

        return (max ?? 0.0) - (min ?? 0.0)
    }

    var isInNegativeDomain: Bool {
        (points.min() ?? 0.0) < 0
    }

    /// Initialize with data array
    /// - Parameter data: Array of `Double`
    public init(_ data: [Double], preNormalized: Bool = false) {
        self.isNormalized = preNormalized
        self.data = data.map { ("", $0) }
    }

    public init(_ data: [(String, Double)], preNormalized: Bool = false) {
        self.isNormalized = preNormalized
        self.data = data
    }

    public init() {
        self.data = []
    }
}
