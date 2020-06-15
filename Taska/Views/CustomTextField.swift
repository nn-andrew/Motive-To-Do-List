//
//  Helpers.swift
//  Taska
//
//  Created by Andrew Nguyen on 5/31/20.
//  Copyright © 2020 medusza. All rights reserved.
//

import SwiftUI
import Combine

public struct CustomTextField: View {
    var placeholderText: String
    @Binding public var text: String
//    @Binding public var textColor: UIColor
    @Binding var desiredHeight: CGFloat
    var isFirstResponder: Bool
    var onCommit: (() -> Void)
    
    public var body: some View {
        TextField_UI(placeholderText: placeholderText, text: $text, desiredHeight: $desiredHeight, isFirstResponder: isFirstResponder, onEditingChanged: {_ in
            
        }, onCommit: self.onCommit)
    }
}
struct TextField_UI : UIViewRepresentable {
    
    typealias UIViewType = UITextField
    
    var placeholderText: String
    @Binding var text: String
//    @Binding var textColor: UIColor
    @Binding var desiredHeight: CGFloat
    var isFirstResponder: Bool
    var onEditingChanged: ((String) -> Void)
    var onCommit: (() -> Void)
    
    let padding = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 100)
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        textField.backgroundColor = nil
        textField.text = self.text
//        if let font = context.environment.font {
//            textField.font = font.font_ui
//        } else {
            textField.font = .preferredFont(forTextStyle: .body)
//        }
        
        textField.delegate = context.coordinator
                
        textField.placeholder = self.placeholderText

        textField.translatesAutoresizingMaskIntoConstraints = true
        
        if isFirstResponder {
            textField.becomeFirstResponder()
        }
        
//        textField.textContainerInset = .zero

        //MARK: disabling scroll messes up the frame so enjoy this hack??
//        textField.isScrollEnabled = true
//        textField.contentInsetAdjustmentBehavior = .never
        
//        setHeight(textField: textField)
        
        return textField
    }
    
    func updateUIView(_ textField: UITextField, context: Context) {
        
    }
    
    func setHeight(textField: UITextField) {
        let fixedWidth = textField.frame.size.width
        let newSize = textField.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        DispatchQueue.main.async {
            self.desiredHeight =  newSize.height
        }
    }
    
    func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }

    func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }

    func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var field: TextField_UI
        
        init(_ field: TextField_UI) {
            self.field = field
            
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            field.text = textField.text ?? ""
        }
                
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.returnKeyType = UIReturnKeyType.done
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField.text == "" {
                textField.resignFirstResponder()
                field.onCommit()
                return false
            }
            field.onCommit()
            textField.text = ""
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                if textField.text == "" {
                    textField.resignFirstResponder()
                    field.onCommit()
                    return false
                }
                field.onCommit()
                textField.text = ""
                return false
            }
            return true
        }
    }
}
