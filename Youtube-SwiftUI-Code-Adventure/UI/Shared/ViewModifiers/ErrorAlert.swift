//
//  ErrorAlert.swift
//  Youtube-SwiftUI-Code-Adventure
//
//  Created by Orisajobi Akinbola on 4/18/25.
//


//
//  UtilityViews.swift
//  TravelBuddy
//
//  Created by Admin on 5/8/23.
//

import Foundation
import SwiftUI
import Combine

struct ErrorAlert: ViewModifier {
    
    var errorDetails: ErrorDetails
    
    
    var isPresented: Binding<Bool> {
        return Binding {
            //errorDetails.message != "" ? true : false
            errorDetails.errorId != nil ? true : false
        } set: { newValue, _ in
            if !newValue {
                //errorDetails.clear()
            }
        }
    }
    
    
    
    func body(content: Content) -> some View {
        content
            .alert(errorDetails.title, isPresented: isPresented) {
                Button {
                    errorDetails.clear()
                } label: {
                    Text("OK")
                        .keyboardShortcut(.defaultAction)
                }
                
            } message: {
                Text("\(errorDetails.message)")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
    }
    
    
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

/*
struct NoLoadedData: View {
    
    let message: String
    let retryAction: (() -> Void)?
    
    init(message: String, retryAction: (() -> Void)? = nil) {
        self.message = message
        self.retryAction = retryAction
    }
    
    var body: some View {
        VStack(spacing: Constants.spacing) {
            
            Text("\(message)")
                .foregroundColor(Color(uiColor: .systemGray))
                .font(.footnote)
                .multilineTextAlignment(.center)
            Button {
                retryAction?()
            } label: {
                Label("Retry", systemImage: "arrow.clockwise")
                    .foregroundColor(.primaryText)
            }
            .buttonStyle(.bordered)
            .controlSize(.regular)
            .tint(.white)
            .background(content: {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .strokeBorder(Color.primaryText, lineWidth: Constants.lineWidth)
            })
            
        }
        .frame(minWidth: Constants.minWidth, maxWidth: .infinity, minHeight: Constants.minHeight, maxHeight: .infinity)
        .padding()
    }
    
    private struct Constants {
        static let spacing: CGFloat = 24.0
        static let cornerRadius: CGFloat = 8.0
        static let lineWidth: CGFloat = 2.0
        static let minWidth: CGFloat = 0
        static let minHeight: CGFloat = 0
        
    }
}

struct Progressable: ViewModifier {
    
    var status: RequestStatus
    var showText: Bool
    var refreshAction: ()->Void
    
    
    func body(content: Content) -> some View {
        
        VStack {
            if status == .loading  {
                VStack {
                    ProgressView()
                        .controlSize(.small)
                    if showText {
                        Text("Loading")
                            .font(.footnote)
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(maxHeight: .infinity)
            } else if case .failed(let requestError) = status {
                NoLoadedData(message: requestError.customMessage) {
                    refreshAction()
                }
            } else {
                content
            }
        }
        
    }
    
    
    
    
    
}

// Simple preference that observes a CGFloat.
struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

// A ScrollView wrapper that tracks scroll offset changes.
struct ObservableScrollView<Content>: View where Content : View {
    @Namespace var scrollSpace
    
    @Binding var scrollOffset: CGFloat
    let content: (ScrollViewProxy) -> Content
    
    init(scrollOffset: Binding<CGFloat>,
         @ViewBuilder content: @escaping (ScrollViewProxy) -> Content) {
        _scrollOffset = scrollOffset
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                content(proxy)
                    .background(GeometryReader { geo in
                        let offset = -geo.frame(in: .named(scrollSpace)).minY
                        Color.clear
                            .preference(key: ScrollViewOffsetPreferenceKey.self,
                                        value: offset)
                    })
            }
        }
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
    }
}

class UIEmojiTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setEmoji() {
        _ = self.textInputMode
    }
    
    
    
    override var textInputContextIdentifier: String? {
        return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                self.keyboardType = .default // do not remove this
                return mode
            }
        }
        return nil
    }
}

struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        //emojiTextField.returnKeyType = .done
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text =  text //String(text.prefix(1))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            return (textField.text?.isEmpty ?? true) || string == "" ? true : false
        }
        
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.text = textField.text ?? ""
                
            }
        }
    }
}


struct NumberOnly: ViewModifier {
    
    @Binding var text: String
    let includesDecimal: Bool
    let decimalSeparator: String
    let groupingSeparator: String
    
    func body(content: Content) -> some View {
        content
            .keyboardType(.numbersAndPunctuation)
        //.keyboardType(includesDecimal ? .decimalPad : .numberPad)
        // produces a new value just once each time a char is assign to text
            .onReceive(Just(text)) { newValue in
                var allowedDigits = "0123456789"
                //let decimalSeperator = Locale.current.decimalSeparator ?? "."
                let decimalSeperator = decimalSeparator
                if includesDecimal {
                    allowedDigits += decimalSeperator
                }
                allowedDigits += groupingSeparator
                // test whether there are more than one decimal seperator
                if newValue.components(separatedBy: decimalSeperator).count - 1 > 1 {
                    let filtered = newValue
                    text = String(filtered.dropLast())
                    
                } else {
                    let filtered = newValue.filter({allowedDigits.contains($0)})
                    if filtered != newValue {
                        text = filtered
                    }
                }
            }
    }
}

struct RequestStatusView: View {
    
    @Binding  var status: RequestStatus
    var perform: () async throws -> Void
    
    var body: some View {
        VStack {
            
            if status == .loading {
                
                ProgressView()
                    .controlSize(.regular)
                
            } else if case .failed(let error) = status {
                NoLoadedData(message: error.customMessage) {
                    Task {
                        
                        status = .loading
                        do {
                            try await perform()
                            status = .idle
                            
                        } catch {
                            status = .failed(error as? RequestError ?? .unexpected(nil))
                        }
                    }
                }
                
            }
            
            
        }
        //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        // .padding()
    }
}



//extension TextField {
//    func numberOnly() -> some View {
//
//    }
//}

extension TextField {
    func numberOnly(_ text: Binding<String>, includesDecimal: Bool = false, decimalSeparator: String = ".", groupingSeparator: String = ",") -> some View {
        
        self.modifier(NumberOnly(text: text, includesDecimal: includesDecimal,
                                 decimalSeparator: decimalSeparator,
                                 groupingSeparator: groupingSeparator
                                )
        )
    }
}

extension Text {
    func required(yOffset: CGFloat = -2.0) -> some View {
        HStack(spacing: 2) {
            self
            Text("*")
                .font(.footnote)
                .offset(x: 0, y: yOffset)
        }
    }
}

struct HStackWithSeperator<Content: View>: View  {
    
    var seperator: Content
    var content: ()->Content
    
    var body: some View {
        HStack {
            content()
        }
    }
}*/

 

 



