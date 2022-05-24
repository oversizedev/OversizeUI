//
// Copyright © 2022 Alexander Romanov
// LocationPicker.swift
//

import CoreLocation
import MapKit
import SwiftUI

#if os(iOS)
    public struct LocationPicker: View {
        @Environment(\.theme) private var theme: ThemeSettings

        @Binding private var coordinates: CLLocationCoordinate2D
        @Binding private var positionName: String?
        private let label: String
        
        private let saveButtonText: String?
        @State private var offset = CGPoint(x: 0, y: 0)
        @State private var showModal = false
        @State private var isSelected = false

        public init(label: String, coordinates: Binding<CLLocationCoordinate2D>, positionName: Binding<String?>, saveButtonText: String? = nil) {
            self.label = label
            self.saveButtonText = saveButtonText
            _coordinates = coordinates
            _positionName = positionName
        }

        public var body: some View {
            Button {
                self.showModal.toggle()
            } label: {
                HStack(spacing: .xxSmall) {
                    Text(label)
                        .fontStyle(.subtitle1, color: .onSurfaceHighEmphasis)
                }
                Spacer()

                if let positionName = positionName {
                    Text(positionName)
                        .fontStyle(.subtitle2, color: .onSurfaceMediumEmphasis)
                }

                Icon(.chevronDown, color: .onSurfaceHighEmphasis)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                                 style: .continuous)
                    .fill(Color.surfaceSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                                         style: .continuous)
                            .stroke(theme.borderTextFields
                                ? Color.border
                                : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                    )
            )
            .sheet(isPresented: $showModal) {
                modal
            }
            .onChange(of: coordinates) {
                updateCityName(coordinate: $0)
            }
        }

        public var modal: some View {
            ZStack {
                MapView(centerCoordinate: $coordinates)
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    MaterialSurface {
                        VStack(alignment: .center, spacing: .xxSmall) {
                            if let positionName = positionName {
                                Text(positionName)
                                    .fontStyle(.title3, color: .onSurfaceHighEmphasis)
                            }
                            Text("\(coordinates.latitude), \(coordinates.longitude)")
                                .fontStyle(.subtitle2, color: .onSurfaceMediumEmphasis)
                        }
                    }
                    .controlPadding(.small)
                    .controlRadius(.large)
                    .multilineTextAlignment(.center)

                }.padding()
            }
            .navigationBar(label, style: .fixed($offset)) {
                BarButton(type: .close)
            } trailingBar: {
                BarButton(type: .secondary(saveButtonText ?? "Save", action: {
                    isSelected = true
                    showModal.toggle()
                }))
            }
        }

        private func updateCityName(coordinate: CLLocationCoordinate2D) {
            let loc = CLLocation(
                latitude: coordinate.latitude,
                longitude: coordinate.longitude
            )

            let geocoder = CLGeocoder()

            geocoder.reverseGeocodeLocation(loc) { placemarks, error in
                if error != nil { return }
                if let firstLocation = placemarks?.first as? CLPlacemark {
                    if let locality = firstLocation.locality {
                        self.positionName = locality

                    } else if let subLocality = firstLocation.subLocality {
                        self.positionName = subLocality
                    } else {
                        self.positionName = firstLocation.name
                    }
                }
            }
        }
    }

    extension CLLocationCoordinate2D: Equatable {}

    public func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
#endif
