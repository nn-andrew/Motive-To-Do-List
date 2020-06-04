//
//  Helpers.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/31/20.
//  Copyright © 2020 six. All rights reserved.
//

import SwiftUI
import Combine

public struct TextEditor: View {
    var placeholderText: String?
    @Binding public var text: String
    var task: Task
    @Binding var desiredHeight: CGFloat
    var isFirstResponder: Bool
    var onCommit: (() -> Void)
//    var isHeightAdjustable: Bool
    
    public var body: some View {
        TextField_UI(text: $text, task: task, desiredHeight: $desiredHeight, isFirstResponder: isFirstResponder, onEditingChanged: {_ in
            
        }, onCommit: self.onCommit)
    }
}
struct TextField_UI : UIViewRepresentable {
//    @EnvironmentObject var tasks: Tasks
    
    typealias UIViewType = UITextView
    
    @Binding var text: String//?
    var task: Task
    @Binding var desiredHeight: CGFloat
    var isFirstResponder: Bool
//    var isHeightAdjustable: Bool
    var onEditingChanged: ((String) -> Void)
    var onCommit: (() -> Void)
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = nil
        textView.text = text// ?? ""
//        if let font = context.environment.font {
//            textView.font = font.font_ui
//        } else {
            textView.font = .preferredFont(forTextStyle: .body)
//        }
        
        textView.delegate = context.coordinator
        
        textView.textColor = UIColor.black

        textView.translatesAutoresizingMaskIntoConstraints = false
        
//        if isFirstResponder {
//            textView.becomeFirstResponder()
//        }
        
        textView.textContainerInset = .zero

        //MARK: disabling scroll messes up the frame so enjoy this hack??
        textView.isScrollEnabled = true
        textView.contentInsetAdjustmentBehavior = .never
        
//        if isHeightAdjustable {
//            makeUITextViewHeightAdjustable(textView: textView)
//        }
        
//        textView.textContainer.maximumNumberOfLines = 1
//        print(self.desiredHeight)
        
        setHeight(textView: textView)
        
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
//        if let font = context.environment.font, font.font_ui != textView.font {
//            textView.font = font.font_ui
//        }
        textView.text = text// ?? ""
        textView.textColor = task.taskDone ? UIColor.white : UIColor.black
        
        setHeight(textView: textView)
        
//        print(self.desiredHeight)
    }
    
    func setHeight(textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        DispatchQueue.main.async {
            self.desiredHeight =  newSize.height
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var field: TextField_UI
        
        init(_ field: TextField_UI) {
            self.field = field
        }
        
        func textViewDidChange(_ textView: UITextView) {
            field.text = textView.text
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            return true
        }
    }
}
