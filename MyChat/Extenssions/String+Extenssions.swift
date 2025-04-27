//
//  String+Extenssions.swift
//  MyChat
//
//  Created by Rupesh Mishra on 22/04/25.
//

import Foundation

extension String{
    var isEmptyOrWhiteSpace: Bool{
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
