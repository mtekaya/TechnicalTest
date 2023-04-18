//
//  StartupUtils.swift
//  TechnicalTest
//
//  Created by compte temporaire on 18/04/2023.
//

import Foundation

struct StartupUtils {
  static func shouldRunWithMock() -> Bool {
    return CommandLine.arguments.contains("-mock")
  }
}
