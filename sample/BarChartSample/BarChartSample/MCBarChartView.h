//
//  MCBarChartView.h
//  MCBarChart
//
//  Created by Vinícius Rodrigues on 2/12/2013.
//  Copyright (c) 2013 MyAppControls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MCCore.h"
#import "MCNewCustomLayeredView+MCCustomLayeredViewSubclass.h"

@class MCBarChartView;

@protocol MCBarChartViewDataSource <NSObject>

/*
 Asks the data source to return the number of bars in the bar chart.
 */
- (NSInteger)numberOfBarsInBarChartView:(MCBarChartView*)barChartView;

/*
 Asks the data source the value of each bar in the bar chart.
 */
- (CGFloat)barCharView:(MCBarChartView*)barChartView valueForBarAtIndex:(NSInteger)index;

@optional

/*
 Asks the data source the threshold of each bar in the bar chart. If the value of the bar
 is smaller than the threshold, than the backbar is not shown.
 */
- (CGFloat)barCharView:(MCBarChartView*)barChartView thresholdForBarAtIndex:(NSInteger)index;

/*
 Asks the data source for the color of each bar. If this method is not implemented,
 the value stored in the property barColor is used as the color instead. If this property
 is also not set, the default value is used.
 */
- (UIColor*)barCharView:(MCBarChartView*)barChartView colorForBarAtIndex:(NSInteger)index;

/*
 Asks the data source for the color of each back bar. If this method is not implemented,
 the value stored in the property backBarColor is used as the color instead. If this property
 is also not set, the default value is used.
 */
- (UIColor*)barCharView:(MCBarChartView*)barChartView colorForBackBarAtIndex:(NSInteger)index;

/*
 Asks the data source for the image of each back bar. If this method is not implemented,
 the value stored in the property barImage is used as the image instead. If this property
 is also not set, no image is shown.
 */
- (UIImage*)barCharView:(MCBarChartView*)barChartView imageForBarAtIndex:(NSInteger)index;

/*
 Asks the data source for the color of the text on the x axis on each bar.
 */
- (UIColor*)barCharView:(MCBarChartView*)barChartView colorForXAxisTextAtIndex:(NSInteger)index;

/*
 Asks the data source for the color of the text on the y axis on each bar.
 */
- (UIColor*)barCharView:(MCBarChartView*)barChartView colorForYAxisTextAtIndex:(NSInteger)index;

/*
 Asks the data source for the text on the x axis on each bar. If this method is not implemented
 the position of the bar is used as the default text (1 for the first bar, 2 for the second, ...).
 You can hide the x axis text by setting the property showXAxisLabels to NO.
 */
- (NSString*)barCharView:(MCBarChartView*)barChartView textForYAxisAtIndex:(NSInteger)index;

/*
 Asks the data source for the text on the y axis on each bar. If this method is not implemented
 the default text depends on the property textStyle. 
    if textStyle = MCBarChartBarTextRealValue, the value of the bar is used as the text
    if textStyle = MCBarChartBarTextPercentage, the percentual value of the bar is used as the text
 You can hide the y axis text by setting the property showYAxisLabels to NO.
 */
- (NSString*)barCharView:(MCBarChartView*)barChartView textForXAxisAtIndex:(NSInteger)index;

@end

@protocol MCBarChartViewDelegate <NSObject>

@optional
/*
 Tells the delegate that the user touched the specified bar
 */
- (void)barChartView:(MCBarChartView*)barChartView didSelectBarAtIndex:(NSInteger)index;

@end

typedef enum {
    MCBarChartBarTextRealValue,
    MCBarChartBarTextPercentage
} MCBarChartBarTextStyle;

@interface MCBarChartView : MCNewCustomLayeredView

/*
 Defines how the text on the y axis is displayed, if not set by the data source.
 if textStyle = MCBarChartBarTextRealValue, the value of the bar is used as the text
 if textStyle = MCBarChartBarTextPercentage, the percentual value of the bar is used as the text
 */
@property (nonatomic) MCBarChartBarTextStyle textStyle;

/*
 Bar chart data source
 */
@property (nonatomic, assign) id<MCBarChartViewDataSource> dataSource;

/*
 Bar chart delegate
 */
@property (nonatomic, assign) id<MCBarChartViewDelegate> delegate;

/*
 Defines the color of the bars globally. If the data source implements the method
 (barCharView: colorForBarAtIndex:), then the value stored in this property is ignored
 */
@property (strong, nonatomic) UIColor *barColor;

/*
 Defines the color of the back bars globally. If the data source implements the method
 (barCharView: colorForBackBarAtIndex:), then the value stored in this property is ignored
 */
@property (strong, nonatomic) UIColor *backBarColor;

/*
 Defines the bar image globally. If the data source implements the method
 (barCharView: imageForBarAtIndex:), then the value stored in this property is ignored
 */
@property (strong, nonatomic) UIImage *barImage;

/*
 Defines the x axis text color globally. If the data source implements the method
 (barCharView: colorForXAxisTextAtIndex:), then the value stored in this property is ignored
 */
@property (strong, nonatomic) UIColor *xAxisTextColor;

/*
 Defines the y axis text color globally. If the data source implements the method
 (barCharView: colorForYAxisTextAtIndex:), then the value stored in this property is ignored
 */
@property (strong, nonatomic) UIColor *yAxisTextColor;

/*
 Defines the font of the x axis labels. Setting the color of the font has no effect, 
 use xAxisTextColor instead.
 */
@property (strong, nonatomic) UIFont *xAxisLabelFont;

/*
 Defines the font of the y axis labels. Setting the color of the font has no effect,
 use xAxisTextColor instead.
 */
@property (strong, nonatomic) UIFont *yAxisLabelFont;


/*
 Defines the corner of the bars. It must be assigned to values from 0 to 1.
 cornerRadiusPercentage = 1 -> most rounded corner possible (cornerRadius = barWidth/2)
 cornerRadiusPercentage = 0 -> less rounded corner possible (cornerRadius = 0)
 */
@property (nonatomic) CGFloat cornerRadiusPercentage;

/*
 Defines if the bar chart should show back bars
 */
@property (nonatomic) BOOL showBackBar;

/*
 Defines if the bar chart should show x axis labels
 */
@property (nonatomic) BOOL showXAxisLabels;

/*
 Defines if the bar chart should show the decoration element (circle) on the x axis
 */
@property (nonatomic) BOOL showXAxisDecorationElement;

/*
 Defines if the bar chart should show y axis labels
 */
@property (nonatomic) BOOL showYAxisLabels;

/*
 Defines the height for the y Axis labels on the bar in relation to the bar's height.
 The default value is 0.07, or 7%. The maximum value is 0.5 (50%) and the
 minimum is 0.05 (5%).
 Changing this property doesn't interfere on the label's font height, only on the 
 space that the label will occupy. The label's font height is automatically calculated
 based on the available width.
 */
@property (nonatomic) CGFloat yAxisLabelHeightPercentage;

/*
 Defines the distance between bars in pixels. If the value is too big, it is
 adjusted to ensure that the chart fits inside it's bounds. Setting this property
 makes the bar chart recalculate the bars width.
 */
@property (nonatomic) CGFloat interBarSpace;

@end
