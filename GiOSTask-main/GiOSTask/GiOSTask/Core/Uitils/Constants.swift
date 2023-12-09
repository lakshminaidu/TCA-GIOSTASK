//
//  Constants.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import Foundation

struct AppConstants {
    static let apikey = "e29e295e-e9ea-4917-859c-07d54b65cde8"
}

// MARK: Font used in app
enum AppFont: String, Codable, CaseIterable {
    case InterBlack = "Inter-Black"
    case InterBold = "Inter-Bold"
    case InterExtraBold = "Inter-ExtraBold"
    case InterExtraLight = "Inter-ExtraLight"
    case InterLight = "Inter-Light"
    case InterMedium = "Inter-Medium"
    case InterRegular = "Inter-Regular"
    case InterSemiBold = "Inter-SemiBold"
    case InterThin = "Inter-Thin"
}

// MARK: Icons used in app
enum AppIcons: String, CaseIterable, Codable {
    case searchIc = "SearchIc"
    case filterIc = "FilterIc"
    case greenChart
    case redChart
}
