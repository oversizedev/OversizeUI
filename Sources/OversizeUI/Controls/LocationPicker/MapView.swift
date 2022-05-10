//
// Copyright © 2022 Alexander Romanov
// MapView.swift
//

import CoreLocation
import Foundation
import MapKit
import SwiftUI

#if os(iOS)
    public struct MapView: UIViewRepresentable {
        @Binding var centerCoordinate: CLLocationCoordinate2D

        let mapView = MKMapView()

        public func makeUIView(context: Context) -> MKMapView {
            mapView.delegate = context.coordinator

            // mapView.centerCoordinate = centerCoordinate
            let center = CLLocationCoordinate2D(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)

            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: center, span: span)
            mapView.setRegion(region, animated: true)

            return mapView
        }

        public func updateUIView(_: MKMapView, context _: Context) {}

        public func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        public class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
            var parent: MapView

            var gRecognizer = UITapGestureRecognizer()

            init(_ parent: MapView) {
                self.parent = parent
                super.init()
                gRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
                gRecognizer.delegate = self
                self.parent.mapView.addGestureRecognizer(gRecognizer)
            }

            @objc func tapHandler(_: UITapGestureRecognizer) {
                let location = gRecognizer.location(in: parent.mapView)

                let coordinate = parent.mapView.convert(location, toCoordinateFrom: parent.mapView)

                withAnimation {
                    let clObject = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    parent.centerCoordinate = clObject

                    let annotation = MKPointAnnotation()
                    annotation.coordinate = clObject

                    withAnimation {
                        parent.mapView.removeAnnotations(parent.mapView.annotations)
                        parent.mapView.addAnnotation(annotation)
                    }
                }
            }
        }
    }
#endif
