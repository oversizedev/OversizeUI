//
// Copyright © 2022 Alexander Romanov
// Icon.swift
//

import SwiftUI

// swiftlint:disable type_body_length identifier_name
public enum IconsNames: String, CaseIterable {
    case none
    case activity
    case airplay
    case alertCircle = "alert-circle"
    case alertOctagon = "alert-octagon"
    case alertTriangle = "alert-triangle"
    case alignCenter = "align-center"
    case alignJustify = "align-justify"
    case alignLeft = "align-left"
    case alignRight = "align-right"
    case anchor
    case aperture
    case archive
    case arrowDownCircle = "arrow-down-circle"
    case arrowDownLeft = "arrow-down-left"
    case arrowDownRight = "arrow-down-right"
    case arrowDown = "arrow-down"
    case arrowLeftCircle = "arrow-left-circle"
    case arrowLeft = "arrow-left"
    case arrowRightCircle = "arrow-right-circle"
    case arrowRight = "arrow-right"
    case arrowUpCircle = "arrow-up-circle"
    case arrowUpLeft = "arrow-up-left"
    case arrowUpRight = "arrow-up-right"
    case arrowUp = "arrow-up"
    case atSign = "at-sign"
    case award
    case barChart2 = "bar-chart-2"
    case barChart = "bar-chart"
    case batteryCharging = "battery-charging"
    case battery
    case bellOff = "bell-off"
    case bell
    case bluetooth
    case bold
    case bookOpen = "book-open"
    case book
    case bookmark
    case box
    case briefcase
    case calendar
    case cameraOff = "camera-off"
    case camera
    case cast
    case checkCircle = "check-circle"
    case checkSquare = "check-square"
    case check
    case checkMini = "check-mini"
    case chevronDown = "chevron-down"
    case chevronLeft = "chevron-left"
    case chevronRight = "chevron-right"
    case chevronUp = "chevron-up"
    case chevronsDown = "chevrons-down"
    case chevronsLeft = "chevrons-left"
    case chevronsRight = "chevrons-right"
    case chevronsUp = "chevrons-up"
    case chrome
    case circle
    case clipboard
    case clock
    case closeButton
    case cloudDrizzle = "cloud-drizzle"
    case cloudLightning = "cloud-lightning"
    case cloudOff = "cloud-off"
    case cloudRain = "cloud-rain"
    case cloudSnow = "cloud-snow"
    case cloud
    case code
    case codepen
    case codesandbox
    case coffee
    case columns
    case command
    case compass
    case copy
    case cornerDownLeft = "corner-down-left"
    case cornerDownRight = "corner-down-right"
    case cornerLeftDown = "corner-left-down"
    case cornerLeftUp = "corner-left-up"
    case cornerRightDown = "corner-right-down"
    case cornerRightUp = "corner-right-up"
    case cornerUpLeft = "corner-up-left"
    case cornerUpRight = "corner-up-right"
    case cpu
    case creditCard = "credit-card"
    case crop
    case crosshair
    case database
    case delete
    case disc
    case dollarSign = "dollar-sign"
    case downloadCloud = "download-cloud"
    case download
    case droplet
    case edit2 = "edit-2"
    case edit3 = "edit-3"
    case externalLink = "external-link"
    case eyeOff = "eye-off"
    case eye
    case facebook
    case fastForward = "fast-forward"
    case feather
    case figma
    case fileMinus = "file-minus"
    case filePlus = "file-plus"
    case fileText = "file-text"
    case file
    case film
    case filter
    case flag
    case folderMinus = "folder-minus"
    case folderPlus = "folder-plus"
    case folder
    case four
    case framer
    case frown
    case gift
    case gitBranch = "git-branch"
    case gitCommit = "git-commit"
    case gitMerge = "git-merge"
    case gitPullRequest = "git-pull-request"
    case github
    case gitlab
    case globe
    case grid
    case hardDrive = "hard-drive"
    case hash
    case headphones
    case heart
    case helpCircle = "help-circle"
    case hexagon
    case home
    case image
    case inbox
    case info
    case instagram
    case italic
    case key
    case layers
    case layout
    case libra
    case lifeBuoy = "life-buoy"
    case link2 = "link-2"
    case link
    case linkedin
    case list
    case loader
    case lock
    case logIn = "log-in"
    case logOut = "log-out"
    case mail
    case mapPin = "map-pin"
    case map
    case maximize2 = "maximize-2"
    case maximize
    case meh
    case menu
    case menu2line
    case messageCircle = "message-circle"
    case messageSquare = "message-square"
    case micOff = "mic-off"
    case mic
    case minimize2 = "minimize-2"
    case minimize
    case minusCircle = "minus-circle"
    case minusSquare = "minus-square"
    case minus
    case monitor
    case moon
    case moreHorizontal = "more-horizontal"
    case moreVertical = "more-vertical"
    case mousePointer = "mouse-pointer"
    case move
    case music
    case navigation2 = "navigation-2"
    case navigation
    case newItem
    case octagon
    case package
    case paperclip
    case pauseCircle = "pause-circle"
    case pause
    case penTool = "pen-tool"
    case percent
    case phoneCall = "phone-call"
    case phoneForwarded = "phone-forwarded"
    case phoneIncoming = "phone-incoming"
    case phoneMissed = "phone-missed"
    case phoneOff = "phone-off"
    case phoneOutgoing = "phone-outgoing"
    case phone
    case pieChart = "pie-chart"
    case playCircle = "play-circle"
    case play
    case plusCircle = "plus-circle"
    case plusSquare = "plus-square"
    case plus
    case pocket
    case power
    case printer
    case radio
    case refreshCcw = "refresh-ccw"
    case refresh
    case `repeat`
    case rewind
    case rotateCcw = "rotate-ccw"
    case rotateCw = "rotate-cw"
    case rss
    case ruller
    case save
    case scissors
    case search
    case send
    case server
    case settings
    case share2 = "share-2"
    case share
    case shieldOff = "shield-off"
    case shield
    case shoppingBag = "shopping-bag"
    case shoppingCart = "shopping-cart"
    case shuffle
    case sidebar
    case skipBack = "skip-back"
    case skipForward = "skip-forward"
    case slack
    case slash
    case sliders
    case smartphone
    case smile
    case speaker
    case square
    case star
    case stopCircle = "stop-circle"
    case sun
    case sunrise
    case sunset
    case tablet
    case tag
    case target
    case terminal
    case thermometer
    case thumbsDown = "thumbs-down"
    case thumbsUp = "thumbs-up"
    case toggleLeft = "toggle-left"
    case toggleRight = "toggle-right"
    case tool
    case trash2 = "trash-2"
    case trash
    case trello
    case trendingDown = "trending-down"
    case trendingUp = "trending-up"
    case triangle
    case truck
    case tv
    case twitch
    case twitter
    case type
    case umbrella
    case underline
    case unlock
    case uploadCloud = "upload-cloud"
    case upload
    case userCheck = "user-check"
    case userMinus = "user-minus"
    case userPlus = "user-plus"
    case userX = "user-x"
    case user
    case users
    case videoOff = "video-off"
    case video
    case voicemail
    case volume1 = "volume-1"
    case volume2 = "volume-2"
    case volumeX = "volume-x"
    case volume
    case watch
    case wifiOff = "wifi-off"
    case wifi
    case wind
    case xCircle = "x-circle"
    case xMini = "x-mini"
    case xOctagon = "x-octagon"
    case xSquare = "x-square"
    case x
    case youtube
    case zapOff = "zap-off"
    case zap
    case zoomIn = "zoom-in"
    case zoomOut = "zoom-out"
}

public enum IconSizes: Int, CaseIterable {
    case small
    case medium
    case large
    case xLarge
}

public struct Icon: View {
    private enum Constants {
        /// Size
        static var small: CGFloat = Space.small.rawValue
        static var medium: CGFloat = Space.medium.rawValue
        static var large: CGFloat = Space.large.rawValue
        static var xLarge: CGFloat = Space.xLarge.rawValue
    }

    let name: IconsNames
    let size: IconSizes
    var color: Color

    public init(_ name: IconsNames = .menu) {
        self.name = name
        size = .medium
        color = Color.onBackgroundHighEmphasis
    }

    public init(_ name: IconsNames = .menu, size: IconSizes = .medium, color: Color = .onBackgroundHighEmphasis) {
        self.name = name
        self.color = color
        self.size = size
    }

    public var body: some View {
        Image(name.rawValue, bundle: .module)
            .resizable()
            .frame(width: iconSize, height: iconSize)
            .foregroundColor(color)
    }

    var iconSize: CGFloat {
        switch size {
        case .medium:
            return Constants.medium
        case .small:
            return Constants.small
        case .large:
            return Constants.large
        case .xLarge:
            return Constants.xLarge
        }
    }
}

struct IconAsset_Previews: PreviewProvider {
    static var previews: some View {
        let grid = [GridItem(),
                    GridItem(),
                    GridItem(),
                    GridItem(),
                    GridItem(),
                    GridItem()]

        LazyVGrid(columns: grid) {
            ForEach(IconsNames.allCases, id: \.self) { icon in
                Icon(icon)
                    .padding(.vertical)
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
