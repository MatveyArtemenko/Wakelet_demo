//
//  SafariView.swift
//  Wakelet_demo
//
//  Created by admin on 18/04/2023.
//

import Foundation
import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    var urlString: String = ""

    func makeUIViewController(context: Context) -> SFSafariViewController {
        if let url = URL(string: urlString) {
            let controller = SFSafariViewController(url: url)
            return controller
        } else {
            return SFSafariViewController(url: URL(string: "https://www.google.co.uk")!)
        }
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}
