// swiftlint:disable:this file_name
// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// MARK: - Asset Catalogs

public enum IOSFakeNFTExtendedAsset: Sendable {
  public static let accentColor = IOSFakeNFTExtendedColors(name: "AccentColor")
  public static let ypBlack = IOSFakeNFTExtendedColors(name: "YP Black")
  public static let ypLightGrey = IOSFakeNFTExtendedColors(name: "YP Light Grey")
  public static let ypuBackground = IOSFakeNFTExtendedColors(name: "YP UBackground")
  public static let ypuBlack = IOSFakeNFTExtendedColors(name: "YP UBlack")
  public static let ypuBlue = IOSFakeNFTExtendedColors(name: "YP UBlue")
  public static let ypuGreen = IOSFakeNFTExtendedColors(name: "YP UGreen")
  public static let ypuGrey = IOSFakeNFTExtendedColors(name: "YP UGrey")
  public static let ypuRed = IOSFakeNFTExtendedColors(name: "YP URed")
  public static let ypuWhite = IOSFakeNFTExtendedColors(name: "YP UWhite")
  public static let ypuYellow = IOSFakeNFTExtendedColors(name: "YP UYellow")
  public static let ypWhite = IOSFakeNFTExtendedColors(name: "YP White")
  public static let active = IOSFakeNFTExtendedImages(name: "active")
  public static let camera = IOSFakeNFTExtendedImages(name: "camera")
  public static let cart = IOSFakeNFTExtendedImages(name: "cart")
  public static let cartCross = IOSFakeNFTExtendedImages(name: "cart_cross")
  public static let catalog = IOSFakeNFTExtendedImages(name: "catalog")
  public static let chevronLeft = IOSFakeNFTExtendedImages(name: "chevron.left")
  public static let emtpyAvatar = IOSFakeNFTExtendedImages(name: "emtpy_avatar")
  public static let noActive = IOSFakeNFTExtendedImages(name: "noActive")
  public static let profile = IOSFakeNFTExtendedImages(name: "profile")
  public static let sort = IOSFakeNFTExtendedImages(name: "sort")
  public static let squareAndPencil = IOSFakeNFTExtendedImages(name: "square_and_pencil")
  public static let star = IOSFakeNFTExtendedImages(name: "star")
  public static let statistic = IOSFakeNFTExtendedImages(name: "statistic")
  public static let success = IOSFakeNFTExtendedImages(name: "success")
  public static let ypLogo = IOSFakeNFTExtendedImages(name: "YP Logo")
  public static let close = IOSFakeNFTExtendedImages(name: "close")
  public static let mock1 = IOSFakeNFTExtendedImages(name: "mock_1")
}

// MARK: - Implementation Details

public final class IOSFakeNFTExtendedColors: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public var color: Color {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIColor: SwiftUI.Color {
      return SwiftUI.Color(asset: self)
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension IOSFakeNFTExtendedColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: IOSFakeNFTExtendedColors) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Color {
  init(asset: IOSFakeNFTExtendedColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct IOSFakeNFTExtendedImages: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: IOSFakeNFTExtendedImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: IOSFakeNFTExtendedImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: IOSFakeNFTExtendedImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftformat:enable all
// swiftlint:enable all
