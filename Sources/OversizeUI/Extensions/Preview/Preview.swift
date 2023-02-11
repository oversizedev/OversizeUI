//
// Copyright © 2021 Alexander Romanov
// Preview.swift, created on 11.09.2021
//

import SwiftUI

public enum Devices: String {
    case iphoneSE1Gen = "iPhone SE (1st generation)"
    case iphone8 = "iPhone 8"
    case iphone8Plus = "iPhone 8 Plus"
    case iphone11 = "iPhone 11"
    case iphone11Pro = "iPhone 11 Pro"
    case iphone11ProMax = "iPhone 11 Pro Max"
    case iphone12Mini = "iPhone 12 mini"
    case iphone12 = "iPhone 12"
    case iphone12Pro = "iPhone 12 Pro"
    case iphone12ProMax = "iPhone 12 Pro Max"

    case ipadPro9 = "iPad Pro (9.7-inch)"
    case ipadPro12 = "iPad Pro (12.9-inch) (4th generation)"
    case ipadMin = "iPad mini (5th generation)"
    case ipad = "iPad (8th generation)"
    case ipadAir = "iPad Air (4th generation)"

    case mac = "Mac"

    case appleTV4K = "Apple TV 4K"
    case appleTV = "Apple TV 4K (at 1080p)"

    case watch38mm = "Apple Watch - 38mm"
    case watch42mm = "Apple Watch - 42mm"
    case watch40mm = "Apple Watch Series 6 - 40mm"
    case watch44mm = "Apple Watch Series 6 - 44mm"
}

public extension View {
    func previewDevice(_ device: Devices) -> some View {
        previewDevice(PreviewDevice(rawValue: device.rawValue))
            .previewDisplayName(device.rawValue)
    }

    func previewDevices(_ devices: [Devices]) -> some View {
        ForEach(devices, id: \.self) { device in
            previewDevice(device)
        }
    }

    @ViewBuilder
    func previewPhones() -> some View {
        let iPhones: [Devices] = [.iphone11Pro, .iphone12, .iphone12ProMax, .iphone12Mini, .iphone8, .iphoneSE1Gen]

        ForEach(iPhones, id: \.rawValue) { device in
            previewDevice(device)
        }
    }

    @ViewBuilder
    func previewPad() -> some View {
        let iPads: [Devices] = [.ipad, .ipadAir, .ipadPro12]

        ForEach(iPads, id: \.rawValue) { device in
            previewDevice(device)
        }
    }

    @ViewBuilder
    func previewMac() -> some View {
        let mac: [Devices] = [.mac]

        ForEach(mac, id: \.rawValue) { device in
            previewDevice(device)
        }
    }

    @ViewBuilder
    func previewAppleTV() -> some View {
        let tv: [Devices] = [.appleTV, .appleTV4K]

        ForEach(tv, id: \.rawValue) { device in
            previewDevice(device)
        }
    }

    @ViewBuilder
    func previeWatch() -> some View {
        let watch: [Devices] = [.watch44mm, .watch40mm, .watch38mm]

        ForEach(watch, id: \.rawValue) { device in
            previewDevice(device)
        }
    }

    @ViewBuilder
    func previeUniversal() -> some View {
        let phoneUniversal: [Devices] = [.iphone11Pro, .iphone8, .ipad, .mac]

        ForEach(phoneUniversal, id: \.rawValue) { device in
            previewDevice(device)
        }
    }

    @ViewBuilder
    func previeMobile() -> some View {
        let phoneMobile: [Devices] = [.iphone11Pro, .iphone8, .ipad]

        ForEach(phoneMobile, id: \.rawValue) { device in
            previewDevice(device)
        }
    }

    @ViewBuilder
    func previeAll() -> some View {
        let allDevices: [Devices] = [.iphone11Pro, .iphone8, .ipad, .mac, .watch40mm]

        ForEach(allDevices, id: \.rawValue) { device in
            previewDevice(device)
        }
    }
}
