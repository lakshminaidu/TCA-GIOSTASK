//
//  Constants.swift
//  GiOSTask
//
//  Created by iSHIKA on 15/11/23.
//

import Foundation
import UIKit
import SwiftUICharts
import SwiftUI

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
    case notificationIc = "NotificationIc"
    case settingIc = "SettingIc"
    case searchIc = "SearchIc"
    case filterIc = "FilterIc"
    case indicator = "Indicator"
    case btcIc
    case greenChart
    case redChart
    case shopIc
    case exchangeIc
    case metaverseIc
    case launchpadIc
    case walletIc
}


//This is for assignment only
let data = LineDataSet(
    dataPoints: [
        LineChartDataPoint(value: 12000, xAxisLabel: "M", description: "Monday"),
        LineChartDataPoint(value: 13000, xAxisLabel: "T", description: "Tuesday"),
        LineChartDataPoint(value: 8000,  xAxisLabel: "W", description: "Wednesday"),
        LineChartDataPoint(value: 17500, xAxisLabel: "T", description: "Thursday"),
        LineChartDataPoint(value: 16000, xAxisLabel: "F", description: "Friday"),
        LineChartDataPoint(value: 11000, xAxisLabel: "S", description: "Saturday"),
        LineChartDataPoint(value: 9000,  xAxisLabel: "S", description: "Sunday")
    ],
    legendTitle: "Test One",
    pointStyle: PointStyle(),
    style: LineStyle(lineColour: ColourStyle(colours: [Color.chartlineColor, Color.chartFillColor],
                                             startPoint: .top,
                                             endPoint: .bottom),
                     lineType: .line))

let lineChartData = LineChartData(dataSets: data,
                                  metadata: ChartMetadata(title: "Some Data", subtitle: "A Week"),
                                  xAxisLabels: ["Monday", "Thursday", "Sunday"],
                                  chartStyle: LineChartStyle(infoBoxPlacement: .header,
                                                             markerType: .full(attachment: .point),
                                                             xAxisLabelsFrom: .chartData(rotation: .degrees(0)),
                                                             baseline: .minimumWithMaximum(of: 5000)))
