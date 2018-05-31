//
//  ChartDefaults.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/25/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit
import SwiftCharts

struct ChartDefaults {
    
    static var chartSettings: ChartSettings {
        if Devices.iPad {
            return iPadChartSettings
        } else {
            return iPhoneChartSettings
        }
    }
    
    static var chartSettingsWithPanZoom: ChartSettings {
        if Devices.iPad {
            return iPadChartSettingsWithPanZoom
        } else {
            return iPhoneChartSettingsWithPanZoom
        }
    }
    
    fileprivate static var iPadChartSettings: ChartSettings {
        var chartSettings = ChartSettings()
        chartSettings.leading = 20
        chartSettings.top = 20
        chartSettings.trailing = 20
        chartSettings.bottom = 20
        chartSettings.labelsToAxisSpacingX = 10
        chartSettings.labelsToAxisSpacingY = 10
        chartSettings.axisTitleLabelsToLabelsSpacing = 5
        chartSettings.axisStrokeWidth = 1
        chartSettings.spacingBetweenAxesX = 15
        chartSettings.spacingBetweenAxesY = 15
        chartSettings.labelsSpacing = 0
        return chartSettings
    }
    
    fileprivate static var iPhoneChartSettings: ChartSettings {
        var chartSettings = ChartSettings()
        chartSettings.leading = 10
        chartSettings.top = 10
        chartSettings.trailing = 10
        chartSettings.bottom = 10
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 8
        chartSettings.labelsSpacing = 0
        return chartSettings
    }
    
    fileprivate static var iPadChartSettingsWithPanZoom: ChartSettings {
        var chartSettings = iPadChartSettings
        chartSettings.zoomPan.panEnabled = true
        chartSettings.zoomPan.zoomEnabled = true
        return chartSettings
    }
    
    fileprivate static var iPhoneChartSettingsWithPanZoom: ChartSettings {
        var chartSettings = iPhoneChartSettings
        chartSettings.zoomPan.panEnabled = true
        chartSettings.zoomPan.zoomEnabled = true
        return chartSettings
    }
    
    static func chartFrame(_ containerBounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 30, width: containerBounds.size.width-30, height: containerBounds.size.height - 10)
    }
    
    static var labelSettings: ChartLabelSettings {
        return ChartLabelSettings(font: ChartDefaults.labelFont)
    }
    
    static var labelFont: UIFont {
        return ChartDefaults.fontWithSize(Devices.iPad ? 14 : 11)
    }
    
    static var labelFontSmall: UIFont {
        return ChartDefaults.fontWithSize(Devices.iPad ? 12 : 10)
    }
    
    static func fontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static var guidelinesWidth: CGFloat {
        return Devices.iPad ? 0.5 : 0.1
    }
    
    static var minBarSpacing: CGFloat {
        return Devices.iPad ? 10 : 5
    }
}
