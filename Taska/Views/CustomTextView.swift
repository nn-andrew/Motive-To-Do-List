//
//  Helpers.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/31/20.
//  Copyright © 2020 medusza. All rights reserved.
//

import SwiftUI
import Combine

public struct CustomTextView: View {
    @Binding public var text: String
    @Binding public var taskDone: Bool
    @Binding var desiredHeight: CGFloat
    var onCommit: (() -> Void)
    
    public var body: some View {
        TextView_UI(text: $text, taskDone: $taskDone, desiredHeight: $desiredHeight, onEditingChanged: {_ in
            
        }, onCommit: self.onCommit)
    }
}
struct TextView_UI : UIViewRepresentable {
    
    typealias UIViewType = UITextView
    
    @Binding var text: String
    @Binding var taskDone: Bool
    @Binding var desiredHeight: CGFloat
    var onEditingChanged: ((String) -> Void)
    var onCommit: (() -> Void)
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = nil
        textView.text = self.text// ?? ""
//        if let font = context.environment.font {
//            textView.font = font.font_ui
//        } else {
            textView.font = .preferredFont(forTextStyle: .body)
//        }
        
        textView.delegate = context.coordinator
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.textContainerInset = .zero

        //MARK: disabling scroll messes up the frame so enjoy this hack??
        textView.isScrollEnabled = true
        textView.contentInsetAdjustmentBehavior = .never
        
        setHeight(textView: textView)
        
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
//        if let font = context.environment.font, font.font_ui != textView.font {
//            textView.font = font.font_ui
//        }
        
        if context.environment.colorScheme == .light {
            if self.taskDone {
                textView.textColor = UIColor.white
            } else {
                textView.textColor = UIColor.black
            }
        } else {
            if self.taskDone {
                textView.textColor = UIColor.white
            } else {
                textView.textColor = UIColor.white
            }
        }
                
        setHeight(textView: textView)
    }
    
    func setHeight(textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        DispatchQueue.main.async {
            self.desiredHeight =  newSize.height
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var field: TextView_UI
        
        init(_ field: TextView_UI) {
            self.field = field
        }
        
        func textViewDidChange(_ textView: UITextView) {
            field.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            field.onCommit()
        }
        
        
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                field.onCommit()
                textView.resignFirstResponder()
                return false
            }
            return true
        }
    }
}
