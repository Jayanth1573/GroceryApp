//
//  String+Extension.swift
//  GroceryApp
//
//  Created by Jayanth Ambaldhage on 15/06/24.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
