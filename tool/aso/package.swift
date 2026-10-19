// Encode opaque store PNGs and generate overview sheets. macOS/AppKit only.
import AppKit
import ImageIO
import UniformTypeIdentifiers

let root = URL(fileURLWithPath: CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "docs/aso/previews")

func load(_ path: URL) throws -> CGImage {
    guard let source = CGImageSourceCreateWithURL(path as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        throw NSError(domain: "ASO", code: 1, userInfo: [NSLocalizedDescriptionKey: "Cannot read \(path.path)"])
    }
    return image
}

func context(_ width: Int, _ height: Int) -> CGContext {
    let result = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0,
                           space: CGColorSpace(name: CGColorSpace.sRGB)!, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)!
    result.setFillColor(NSColor(red: 1, green: 248.0 / 255, blue: 238.0 / 255, alpha: 1).cgColor)
    result.fill(CGRect(x: 0, y: 0, width: width, height: height))
    result.interpolationQuality = .high
    return result
}

func save(_ image: CGImage, _ path: URL) throws {
    guard let destination = CGImageDestinationCreateWithURL(path as CFURL, UTType.png.identifier as CFString, 1, nil) else {
        throw NSError(domain: "ASO", code: 2)
    }
    CGImageDestinationAddImage(destination, image, [kCGImagePropertyPNGDictionary: [kCGImagePropertyPNGsRGBIntent: 0]] as CFDictionary)
    guard CGImageDestinationFinalize(destination) else { throw NSError(domain: "ASO", code: 3) }
}

let names = ["01-growth", "02-emotion", "03-photo", "04-widget", "05-search", "06-drafts"]
let platforms = CommandLine.arguments.count > 2 ? [CommandLine.arguments[2]] : ["ios", "android"]
for platform in platforms {
    let tileWidth = platform == "ios" ? 440 : 360
    let tileHeight = platform == "ios" ? 956 : 640
    let sheet = context(tileWidth * 3, tileHeight * 2)
    for (index, name) in names.enumerated() {
        let path = root.appendingPathComponent(platform).appendingPathComponent(name + ".png")
        let image = try load(path)
        let opaque = context(image.width, image.height)
        opaque.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
        let normalized = opaque.makeImage()!
        let x = (index % 3) * tileWidth
        let y = (1 - index / 3) * tileHeight
        sheet.draw(normalized, in: CGRect(x: x, y: y, width: tileWidth, height: tileHeight))
        try save(normalized, path)
    }
    try save(sheet.makeImage()!, root.appendingPathComponent(platform + "-overview.png"))
}
let feature = root.appendingPathComponent("featureGraphic.png")
let image = try load(feature)
let opaque = context(image.width, image.height)
opaque.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
try save(opaque.makeImage()!, feature)
print("Encoded opaque PNGs and generated overview sheets for: \(platforms.joined(separator: ", "))")
