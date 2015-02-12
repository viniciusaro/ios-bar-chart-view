//
//  MCBarLayer.h
//  MCBarChart
//
//  Created by Vinícius Rodrigues on 2/12/2013.
//  Copyright (c) 2013 MyAppControls. All rights reserved.
//

#import "MCCore.h"

@interface MCBarLayer : MCNewCustomLayer

@property (strong, nonatomic) UIColor *barColor;
@property (strong, nonatomic) UIColor *xAxisTextColor;
@property (strong, nonatomic) UIColor *yAxisTextColor;
@property (strong, nonatomic) UIColor *backBarColor;
@property (strong, nonatomic) NSString *barText;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat maxValue;
@property (nonatomic) CGFloat minValue;
@property (nonatomic) BOOL showBackBar;
@property (nonatomic) BOOL showXAxisDecorationElement;
@property (nonatomic) BOOL showXAxisLabel;
@property (nonatomic) CGFloat yAxisLabelHeightPercentage;

@property (strong, nonatomic) UIFont *xAxisLabelFont;
@property (strong, nonatomic) UIFont *yAxisLabelFont;

// percentage of the biggest dimension (width/height)
// max value = 1 min value = 0
@property (nonatomic) CGFloat cornerRadiusPercentage;

@end
