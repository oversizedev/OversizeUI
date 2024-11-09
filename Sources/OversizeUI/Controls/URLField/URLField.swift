//
// Copyright © 2023 Alexander Romanov
// URLField.swift
//

import SwiftUI

#if os(iOS) || os(macOS)
@available(iOS 15.0, *)
@available(macOS 14.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct URLField: View {
    @Binding private var url: URL?
    @State private var urlString: String = ""
    let title: String

    @State private var textFieldHelper: FieldHelperStyle = .none

    public init(_ title: String = "URL", url: Binding<URL?>) {
        self.title = title
        _url = url
        _urlString = .init(initialValue: url.wrappedValue?.absoluteString ?? "")
    }

    public var body: some View {
        TextField(title, text: $urlString, onEditingChanged: { state in
            #if os(iOS)
            if state {
                textFieldHelper = .none
            } else if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                textFieldHelper = .none
                self.url = url
            } else {
                textFieldHelper = .errorText
                urlString = ""
            }
            #else

            if state {
                textFieldHelper = .none
            } else if let url = URL(string: urlString) {
                textFieldHelper = .none
                self.url = url
            } else {
                textFieldHelper = .errorText
                urlString = ""
            }
            #endif

        }, onCommit: {
            #if os(iOS)
            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                textFieldHelper = .none
                self.url = url
            } else {
                textFieldHelper = .errorText
            }
            #else
            if let url = URL(string: urlString) {
                textFieldHelper = .none
                self.url = url
            } else {
                textFieldHelper = .errorText
            }
            #endif
        })
        #if os(iOS)
        .keyboardType(.URL)
        .textInputAutocapitalization(.never)
        #endif
        .textContentType(.URL)
        .autocorrectionDisabled()
        .fieldHelper(.constant("Invalid URL"), style: $textFieldHelper)
        .onChange(of: url) { newValue in
            if let newValue, newValue.absoluteString != urlString {
                urlString = newValue.absoluteString
            }
        }
    }
}
#endif
