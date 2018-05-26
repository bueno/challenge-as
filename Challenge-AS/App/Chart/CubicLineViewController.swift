//
//  CubicLineViewController.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/25/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit
import SwiftCharts

class CubicLinesViewController: ChartBaseViewController {
    
    fileprivate var chart: Chart?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelSettings = ChartLabelSettings(font: ChartDefaults.labelFont)
        
        let chartPoints: [ChartPoint] = chartItems.enumerated().map {index, item in
            let xLabelSettings = ChartLabelSettings(font: ChartDefaults.labelFont, rotation: 45, rotationKeep: .top)
            let x = ChartAxisValueString(item.name, order: index, labelSettings: xLabelSettings)
            let y = ChartAxisValueString(item.value.text, order: item.value.number, labelSettings: labelSettings)
            return ChartPoint(x: x, y: y)
        }
        
        let xValues = [ChartAxisValueString("", order: -1)] + chartPoints.map{$0.x} + [ChartAxisValueString("", order: 5)]
        
        func toYValue(_ value: ChartValue) -> ChartAxisValue {
            return ChartAxisValueString(value.text, order: value.number, labelSettings: labelSettings)
        }
    
        var yValues: [ChartAxisValue] = []
        for item in chartItemsSorted {
            yValues.append(toYValue(item.value))
        }

        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "", settings: labelSettings.defaultVertical()))
        
        let cFrame = ChartDefaults.chartFrame(chartFrame)
        let chartSettings = ChartDefaults.chartSettingsWithPanZoom
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: cFrame, xModel: xModel, yModel: yModel)
        
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.lightGray, lineWidth: 2, animDuration: 1, animDelay: 0)
        
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel])
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ChartDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLineLayer
            ]
        )
        
        view.addSubview(chart.view)
        self.chart = chart
    }
}
