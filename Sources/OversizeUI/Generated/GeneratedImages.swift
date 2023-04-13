// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI


// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Images {

    public static let allImages: [Image] = [
    Appearance.dark,
    Appearance.light,
    Appearance.system,
    avatar,
    Status.error,
    Status.success,
    Status.warning,
    ]
  public static let allNames: [String] = [
      "",
      "Avatar",
      "",
  ]
  public enum Appearance {
      public static let allImages: [Image] = [
      dark,
      light,
      system,
      ]
    public static let allNames: [String] = [
        "Dark",
        "Light",
        "System",
    ]
  public static let dark: Image = .init("Dark", bundle: .module)
  public static let darkName: String = "Dark"
  public static let light: Image = .init("Light", bundle: .module)
  public static let lightName: String = "Light"
  public static let system: Image = .init("System", bundle: .module)
  public static let systemName: String = "System"
  }
public static let avatar: Image = .init("Avatar", bundle: .module)
public static let avatarName: String = "Avatar"
  public enum Status {
      public static let allImages: [Image] = [
      error,
      success,
      warning,
      ]
    public static let allNames: [String] = [
        "Error",
        "Success",
        "Warning",
    ]
  public static let error: Image = .init("Error", bundle: .module)
  public static let errorName: String = "Error"
  public static let success: Image = .init("Success", bundle: .module)
  public static let successName: String = "Success"
  public static let warning: Image = .init("Warning", bundle: .module)
  public static let warningName: String = "Warning"
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details



// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
