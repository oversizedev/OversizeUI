//
//  File.swift
//  
//
//  Created by alexander on 02.12.2021.
//

import SwiftUI

public extension ScrollView {
    func loading(_ isLoading: Bool) -> some View {
        Group {
            if isLoading {
                self.overlay(LoaderOverlayView(.spiner))
            } else {
                self
            }
        }
    }
}

public extension List {
    func loading(_ isLoading: Bool) -> some View {
        Group {
            if isLoading {
                self.overlay(LoaderOverlayView(.spiner))
            } else {
                self
            }
        }
    }
}

public extension HStack {
    func loading(_ isLoading: Bool) -> some View {
        Group {
            if isLoading {
                self.overlay(LoaderOverlayView(.spiner))
            } else {
                self
            }
        }
    }
}

public extension VStack {
    func loading(_ isLoading: Bool) -> some View {
        Group {
            if isLoading {
                self.overlay(LoaderOverlayView(.spiner))
            } else {
                self
            }
        }
    }
}

public extension ZStack {
    func loading(_ isLoading: Bool) -> some View {
        Group {
            if isLoading {
                self.overlay(LoaderOverlayView(.spiner))
            } else {
                self
            }
        }
    }
}
