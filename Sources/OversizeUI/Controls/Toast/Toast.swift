//
// Copyright © 2023 Alexander Romanov
// Toast.swift, created on 20.05.2023
//  

import SwiftUI




public struct Toast: View {
    
    private let text: String
    private let presentHandler: (() -> Void)?
    private let dismissHandler: (() -> Void)?
    
    @Binding private var isInternallyPresented: Bool
    
    // MARK: Initializers
    public init(
        text: String,
        isPresented: Binding<Bool>,
        onPresent presentHandler: (() -> Void)?,
        onDismiss dismissHandler: (() -> Void)?
    ) {
        self.text = text
        self.presentHandler = presentHandler
        self.dismissHandler = dismissHandler
        self._isInternallyPresented = isPresented
    }
    
    
    public var body: some View {
        ZStack(alignment: .bottom, content: {
            //dimmingView
            contentView
        })
    }
    
    private var dimmingView: some View {
        Color.backgroundPrimary.opacity(0.01)
            .ignoresSafeArea()
    }
    
    private var contentView: some View {
        Surface {
            HStack {
                Text(text)
                    .lineLimit(2)
                    .foregroundColor(.onSurfaceHighEmphasis)
                    .font(.body)
                
                Spacer()
                
                Button("Close") {
                    isInternallyPresented = false
                }
            }
            
        }
        .padding(.medium)
        .elevation(.z4)
        .opacity(isInternallyPresented ? 1 : 0)
        //.offset(y: isInternallyPresented ? -300 : 0)
    }
}

public extension View {
    
    func presentToast(isPresented: Binding<Bool>,
                             isBlocking: Bool = true,
                             @ViewBuilder notification: @escaping () -> Toast) -> some View {
        self.presentingView(isPresented: isPresented,
                            isBlocking: isBlocking) {
            notification()
        }
    }
}

public extension View {
    
    @ViewBuilder
    func presentingView<PresentedView: View>(isPresented: Binding<Bool>,
                                             dimmedBackgroundColor: Color = Color.black,
                                             dimmedBackgroundColorOpacity: Double = 0.1,
                                             hasDimmedBackground: Bool = false,
                                             isBlocking: Bool = false,
                                             @ViewBuilder presentedView: @escaping () -> PresentedView) -> some View {
        modifier(PresentationModifier(hasDimmedBackground: hasDimmedBackground,
                                      dimmedBackgroundColor: dimmedBackgroundColor,
                                      dimmedBackgroundColorOpacity: dimmedBackgroundColorOpacity,
                                      isBlocking: isBlocking,
                                      isPresented: isPresented,
                                      presentedView: presentedView))
    }
}


struct PresentationModifier<PresentedView: View>: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            content

            Rectangle()
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
            .foregroundColor(isPresented ? backgroundColor : Color.clear)
            .allowsHitTesting(isPresented && isBlocking)

            presentedView
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .center)
        .clipped()
    }

    var hasDimmedBackground: Bool
    var dimmedBackgroundColor: Color
    var dimmedBackgroundColorOpacity: Double
    var isBlocking: Bool
    @Binding var isPresented: Bool
    @ViewBuilder var presentedView: PresentedView

    var backgroundColor: Color {
        if hasDimmedBackground {
            return dimmedBackgroundColor.opacity(dimmedBackgroundColorOpacity)
        } else if isBlocking {
            // A clear color won't allow the background
            // view to block the underlying view
            return Color.black.opacity(Double.ulpOfOne)
        }

        return Color.clear
    }
}

//    func border(width: CGFloat,
//                edges: [Edge],
//                color: Color) -> some View {
//        overlay(EdgeBorder(width: width,
//                           edges: edges)
//            .foregroundColor(color))
//    }
//}

//extension View {
//
//    public func toast(
//        isPresented: Binding<Bool>,
//        text: String,
//        onPresent presentHandler: (() -> Void)? = nil,
//        onDismiss dismissHandler: (() -> Void)? = nil,
//    ) -> some View {
//        self
//            .presentationHost(
//                id: id,
//                allowsHitTests: false,
//                isPresented: isPresented,
//                content: {
//                    VToast(
//                        uiModel: uiModel,
//                        onPresent: presentHandler,
//                        onDismiss: dismissHandler,
//                        text: text
//                    )
//                }
//            )
//    }
//
//    @ViewBuilder public func presentationHost<Content>(
//        id: String,
//        allowsHitTests: Bool = true,
//        isPresented: Binding<Bool>,
//        content: @escaping () -> Content
//    ) -> some View
//        where Content: View
//    {
//#if os(iOS)
//        self
//            .onDisappear(perform: { _PresentationHostViewController.forceDismiss(id: id) })
//            .background(PresentationHostView(
//                id: id,
//                allowsHitTests: allowsHitTests,
//                isPresented: isPresented,
//                content: content
//            ))
//    }
//}

//struct Toast_Previews: PreviewProvider {
//    static var previews: some View {
//        Toast()
//    }
//}
