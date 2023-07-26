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
            if #available(iOS 16.0, *) {
                TextField(title, value: $url, format: .url)
                    .keyboardType(.URL)
                    .textContentType(.URL)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            } else {
                TextField(title, text: $urlString)
                    .keyboardType(.URL)
                    .textContentType(.URL)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .fieldHelper(.constant("Invalid URL"), style: $textFieldHelper)
            }
        }
    }
#endif
