//
//  SwiftUIView.swift
//  
//
//  Created by Alessandro Manilii on 01/02/24.
//

import UIKit
import SwiftUI

struct AttributedLabel: View {

    @State private var height: CGFloat = .zero
    @Environment(\.colorScheme) private var colorScheme
    
    var text: String
    var searchText: String?
    
    var textColor: UIColor {
        colorScheme == .dark ? UIColor.white : UIColor.black
    }
    
    var body: some View {
        
        InternalTextView(
            textColor: textColor,
            text: text,
            searchText: searchText,
            dynamicHeight: $height
        )
        .frame(minHeight: height)
    }

    struct InternalTextView: UIViewRepresentable {

        var attributedText: NSAttributedString
        @Binding var dynamicHeight: CGFloat
        
        init(textColor: UIColor, text: String, searchText: String?, dynamicHeight: Binding<CGFloat>) {
            let attributedText = InternalTextView.getAttributedString(
                for: text, highlighted: searchText, textColor: textColor
            )
            self.attributedText = attributedText
            self._dynamicHeight = dynamicHeight
        }

        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView()
            textView.textAlignment = .justified
            textView.isScrollEnabled = false
            textView.isUserInteractionEnabled = false
            textView.showsVerticalScrollIndicator = false
            textView.showsHorizontalScrollIndicator = false
            textView.allowsEditingTextAttributes = false
            textView.backgroundColor = .clear
            textView.setContentCompressionResistancePriority(
                .defaultLow, for: .horizontal
            )
            textView.setContentCompressionResistancePriority(
                .defaultLow, for: .vertical
            )
            return textView
        }

        func updateUIView(_ uiView: UITextView, context: Context) {
            uiView.attributedText = attributedText
            DispatchQueue.main.async {
                dynamicHeight = uiView.sizeThatFits(CGSize(width: uiView.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
            }
        }
        
        private static func getAttributedString(
            for text: String, highlighted: String?,
            textColor: UIColor
        ) -> NSMutableAttributedString {

            var fullMutString = NSMutableAttributedString(string: "", attributes: [
                .font: UIFont.systemFont(ofSize: 10),
                .foregroundColor: textColor,
                .kern: 0.0
            ])
            
            if let highlighted, !highlighted.isEmpty {

                let parts = text.localizedLowercase.components(separatedBy: highlighted.lowercased())
                
                for (index, item) in parts.enumerated() {
                    let textPart = NSMutableAttributedString(
                        string: item,
                        attributes: [
                            .font: UIFont.systemFont(ofSize: 10),
                            .foregroundColor: textColor,
                            .kern: 0.0
                        ])
                    
                    fullMutString.append(textPart)
                    
                    if index < parts.count-1 {
                        let highlightedText = NSMutableAttributedString(
                            string: highlighted,
                            attributes: [
                                .font: UIFont.boldSystemFont(ofSize: 12),
                                .foregroundColor: textColor,
                                .kern: 0.0
                            ])
                        
                        fullMutString.append(highlightedText)
                    }
                }
            } else {
                fullMutString = NSMutableAttributedString(string: text, attributes: [
                    .font: UIFont.systemFont(ofSize: 10),
                    .foregroundColor: textColor,
                    .kern: 0.0
                ])
            }
            
            return fullMutString
        }
    }
}

#Preview {
    VStack {
        AttributedLabel(text: "Andiamo con un testo molto lungo che potrebbe andare su due righe, ma ancora di più, che guarda lo mando su ", searchText: "anD")
    }
    
}

