// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum Localized {
  /// bulaBody
  internal static let body = Localized.tr("Localizable", "BODY")
  /// Câmera
  internal static let camera = Localized.tr("Localizable", "CAMERA")
  /// camera_start
  internal static let cameraStart = Localized.tr("Localizable", "CAMERA_START")
  /// Cancelar
  internal static let cancel = Localized.tr("Localizable", "CANCEL")
  /// cancel_text_search
  internal static let cancelTextSearch = Localized.tr("Localizable", "CANCEL_TEXT_SEARCH")
  /// medicates
  internal static let collection = Localized.tr("Localizable", "COLLECTION")
  /// medicineBottle
  internal static let description = Localized.tr("Localizable", "DESCRIPTION")
  /// dismiss_result
  internal static let dismiss = Localized.tr("Localizable", "DISMISS")
  /// /
  internal static let endUrl = Localized.tr("Localizable", "END_URL")
  /// Ocorreu um erro inesperado
  internal static let error = Localized.tr("Localizable", "ERROR")
  /// favorite_clicked
  internal static let favorite = Localized.tr("Localizable", "FAVORITE")
  /// h3
  internal static let headers = Localized.tr("Localizable", "HEADERS")
  /// p
  internal static let htmlTexts = Localized.tr("Localizable", "HTML_TEXTS")
  /// image
  internal static let image = Localized.tr("Localizable", "IMAGE")
  /// Galeria
  internal static let library = Localized.tr("Localizable", "LIBRARY")
  /// library_start
  internal static let libraryStart = Localized.tr("Localizable", "LIBRARY_START")
  /// Carregando...
  internal static let loading = Localized.tr("Localizable", "LOADING")
  /// name
  internal static let name = Localized.tr("Localizable", "NAME")
  /// Sem Texto Detectado!
  internal static let noText = Localized.tr("Localizable", "NO_TEXT")
  /// OK
  internal static let ok = Localized.tr("Localizable", "OK")
  /// https://www.bulario.com/
  internal static let siteUrl = Localized.tr("Localizable", "SITE_URL")
  /// start_text_search
  internal static let startTextSearch = Localized.tr("Localizable", "START_TEXT_SEARCH")
  /// text
  internal static let text = Localized.tr("Localizable", "TEXT")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
