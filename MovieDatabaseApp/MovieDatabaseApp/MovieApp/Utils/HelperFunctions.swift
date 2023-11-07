//
//  HelperFunctions.swift
//  MovieDatabaseApp
//
//  Created by Nikhil Srikuramdasu on 21/10/23.
//

import Foundation

func splitFraction(text: String) -> (Int, Int)? {
      if text.contains("/") {
          let components = text.components(separatedBy: "/")
          if components.count == 2, let i = Int(components[0]), let j = Int(components[1]) {
              return (i, j)
          }
      } else if text.contains("%") {
          let strippedText = text.replacingOccurrences(of: "%", with: "")
          if let i = Int(strippedText) {
              return (i, 100)
          }
      }
      return nil
  }
