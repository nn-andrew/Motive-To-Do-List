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
    @Binding public var textColor: UIColor
//    var task: Task
    @Binding var desiredHeight: CGFloat
    var isFirstResponder: Bool
    var clearOnEdit: Bool
    var onCommit: (() -> Void)
//    var isHeightAdjustable: Bool
    
    public var body: some View {
        TextField_UI(placeholderText: placeholderText, text: $text, textColor: $textColor, desiredHeight: $desiredHeight, isFirstResponder: isFirstResponder, clearOnEdit: clearOnEdit, onEditingChanged: {_ in
            
        }, onCommit: self.onCommit)
    }
}
struct TextField_UI : UIViewRepresentable {
//    @EnvironmentObject var tasks: Tasks
    
    typealias UIViewType = UITextView
    
    var placeholderText: String?
    @Binding var text: String//?
    @Binding var textColor: UIColor
//    var task: Task
    @Binding var desiredHeight: CGFloat
    var isFirstResponder: Bool
    var clearOnEdit: Bool
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
                
        if self.placeholderText != "" && self.text == "" {
            textView.text = self.placeholderText
            textView.textColor = UIColor.placeholderText
            textView.becomeFirstResponder()
        }
        else {
            textView.textColor = UIColor.label
        }

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
        
//        if self.text == "" {
//            textView.text = self.placeholderText
//            textView.textColor = UIColor.placeholderText
//        }
//        else {
//            textView.text = text
//            textView.textColor = UIColor.black
//        }
        
//        textView.text = text// ?? ""
//        textView.textColor = task.taskDone ? UIColor.white : UIColor.black
        if self.placeholderText != "" && self.text == "" {
//            textView.text = self.placeholderText
            textView.textColor = UIColor.placeholderText
        }
        else {
            textView.textColor = self.textColor
        }
        
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
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if field.clearOnEdit {
                textView.text = ""
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if field.clearOnEdit {
                textView.text = field.placeholderText
            }
            
            field.onCommit()
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
//                print(field.placeholderText)
                if field.placeholderText == "" || field.placeholderText == nil {
                    textView.resignFirstResponder()
                    field.onCommit()
                    return false
                }
                field.onCommit()
                textView.text = ""
                return false
            }
            return true
        }
    }
}
