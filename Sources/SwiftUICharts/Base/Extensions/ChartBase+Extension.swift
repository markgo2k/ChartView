import SwiftUI

extension View where Self: ChartBase {
	
	/// Set data for a chart
	/// - Parameter data: array of `Double`
	/// - Returns: modified `View` with data attached
    public func data(_ data: [Double], preNormalized: Bool = false) -> some View {
        chartData.data = data.map { ("", $0) }
        chartData.isNormalized = preNormalized
        return self
            .environmentObject(chartData)
            .environmentObject(ChartValue())
    }

    public func data(_ data: [(String, Double)], preNormalized: Bool = false) -> some View {
        chartData.data = data
        chartData.isNormalized = preNormalized
        return self
            .environmentObject(chartData)
            .environmentObject(ChartValue())
    }
}
