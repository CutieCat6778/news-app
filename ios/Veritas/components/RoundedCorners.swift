import SwiftUI

/// A shape with only the top corners rounded.
struct TopRoundedCornersShape: Shape {
    // MARK: - Properties

    let topLeft: CGFloat
    let topRight: CGFloat

    // MARK: - Shape protocol

    func path(in rect: CGRect) -> Path {
        let width: CGFloat = rect.size.width
        let height: CGFloat = rect.size.height

        let topleft: CGFloat = min(topLeft, min(width / 2, height / 2))
        let topright: CGFloat = min(topRight, min(width / 2, height / 2))

        var path = Path()
        path.move(to: CGPoint(x: 0, y: topleft))

        // Top-left corner
        path.addArc(center: CGPoint(x: topleft, y: topleft),
                    radius: topleft,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)

        // Top edge
        path.addLine(to: CGPoint(x: width - topright, y: 0))

        // Top-right corner
        path.addArc(center: CGPoint(x: width - topright, y: topright),
                    radius: topright,
                    startAngle: Angle(degrees: 270),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)

        // Right edge
        path.addLine(to: CGPoint(x: width, y: height))

        // Bottom edge
        path.addLine(to: CGPoint(x: 0, y: height))

        // Left edge
        path.addLine(to: CGPoint(x: 0, y: topleft))

        path.closeSubpath()
        return path
    }
}
