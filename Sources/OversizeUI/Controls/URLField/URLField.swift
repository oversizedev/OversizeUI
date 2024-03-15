//
// Copyright © 2023 Alexander Romanov
// URLField.swift
//

import SwiftUI

#if os(iOS)
@available(iOS 15.0, *)
@available(macOS, unavailable)
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
    }

    public var body: some View {
        TextField(title, text: $urlString, onEditingChanged: { state in
            if state {
                textFieldHelper = .none
            } else if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                textFieldHelper = .none
                self.url = url
            } else {
                textFieldHelper = .errorText
                urlString = ""
            }
        }, onCommit: {
            if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                textFieldHelper = .none
                self.url = url
            } else {
                textFieldHelper = .errorText
            }
        })
        .keyboardType(.URL)
        .textContentType(.URL)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .fieldHelper(.constant("Invalid URL"), style: $textFieldHelper)
    }
}
#endif
