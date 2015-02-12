//
//  MCBarChartView.m
//  MCBarChart
//
//  Created by Vinícius Rodrigues on 2/12/2013.
//  Copyright (c) 2013 MyAppControls. All rights reserved.
//

#import "MCBarChartView.h"
#import "MCBarLayer.h"
#import "MCNewCustomLayeredView+MCCustomLayeredViewSubclass.h"

@interface MCBarChartView()

@property (nonatomic) CGFloat maxValue;
@property (nonatomic) CGFloat minValue;
@property (nonatomic) CGFloat barWidth;
@property (nonatomic) CGFloat sum;

@end

@implementation MCBarChartView

- (void)setDefaults {
    [super setDefaults];

    self.barColor                       = nil;
    self.barImage                       = nil;
    self.backBarColor                   = nil;
    self.xAxisLabelFont                 = nil;
    self.yAxisLabelFont                 = nil;
    self.cornerRadiusPercentage         = 0;
    self.decimalPlaces                  =  0;
    self.showBackBar                    = YES;
    self.showXAxisLabels                = YES;
    self.showYAxisLabels                = YES;
    self.yAxisTextColor                 = nil;
    self.xAxisTextColor                 = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
    self.backgroundColor                = [UIColor clearColor];
    self.interBarSpace                  = 3;
    self.yAxisLabelHeightPercentage     = 0.07;
    self.animatesBegining               = YES;
    self.showXAxisDecorationElement     = YES;
    self.textStyle                      = MCBarChartBarTextRealValue;
}

- (Class)classForSublayers {
    return [MCBarLayer class];
}

- (void)willDrawSublayers
{
    self.maxValue = MAXFLOAT*-1;
    self.minValue = MAXFLOAT;
    self.sum = 0;
    
    NSInteger numberOfBars = [self.dataSource numberOfBarsInBarChartView:self];
    
    for (int i = 0; i < numberOfBars; i++) {
        CGFloat floatValue = [self.dataSource barCharView:self valueForBarAtIndex:i];
        if (floatValue > self.maxValue) {
            self.maxValue = floatValue;
        }
        if (floatValue < self.minValue) {
            self.minValue = floatValue;
        }
        self.sum += fabs(floatValue);
    }
    
    self.barWidth = (self.bounds.size.width-(self.interBarSpace*numberOfBars))/numberOfBars;
}

- (MCNewCustomLayer*)itemForIndex:(NSInteger)index withReuseItem:(MCNewCustomLayer *)reuseItem
{
    static CGFloat x = 0;
    
    if (index == 0) {
        x = self.interBarSpace/2;
    }
    
    MCBarLayer *bar                     = (MCBarLayer*)[super itemForIndex:index withReuseItem:reuseItem];
    bar.width                           = self.barWidth;
    bar.maxValue                        = self.maxValue;
    bar.minValue                        = self.minValue;
    bar.cornerRadiusPercentage          = self.cornerRadiusPercentage;
    bar.showXAxisDecorationElement      = self.showXAxisDecorationElement;
    bar.showXAxisLabel                  = self.showXAxisLabels;
    bar.xAxisLabelFont                  = self.xAxisLabelFont;
    bar.yAxisLabelFont                  = self.yAxisLabelFont;
    bar.yAxisLabelHeightPercentage      = self.yAxisLabelHeightPercentage;
    bar.value                           = [self.dataSource barCharView:self valueForBarAtIndex:index];
    bar.backBarColor                    = [self backBarColorAtIndex:index];
    bar.barColor                        = [self barColorAtIndex:index];
    bar.mainPathImage                   = [self barImageAtIndex:index];
    bar.xAxisTextColor                  = [self colorForXAxisTextAtIndex:index];
    bar.yAxisTextColor                  = [self colorForYAxisTextAtIndex:index];
    bar.x                               = x;
    
    if ([self.dataSource respondsToSelector:@selector(barCharView:thresholdForBarAtIndex:)])
    {
        if (bar.value < [self.dataSource barCharView:self thresholdForBarAtIndex:index]) {
            bar.showBackBar = NO;
        }
        else {
            bar.showBackBar = YES;
        }
    }
    else {
        bar.showBackBar = self.showBackBar;
    }
    
    if (self.showXAxisLabels)
    {
        if ([self.dataSource respondsToSelector:@selector(barCharView:textForXAxisAtIndex:)]) {
            bar.textLabel.text = [self.dataSource barCharView:self textForXAxisAtIndex:index];
        }
        else {
            bar.textLabel.text = [NSString stringWithFormat:@"%d", (int)(index+1)];
        }
    }
    
    if (self.showYAxisLabels)
    {
        if ([self.dataSource respondsToSelector:@selector(barCharView:textForYAxisAtIndex:)]) {
            bar.barText = [self.dataSource barCharView:self textForYAxisAtIndex:index];
        }
        else {
            switch (self.textStyle)
            {
                case MCBarChartBarTextPercentage:
                    bar.barText = [NSString stringWithFormat:@"%.*f%%", (int)self.decimalPlaces, bar.value/self.sum*100];
                    break;
                case MCBarChartBarTextRealValue:
                    bar.barText = [NSString stringWithFormat:@"%.*f", (int)self.decimalPlaces, bar.value];
                    break;
            }
        }
    }
    else {
        bar.barText = nil;
    }
    
    x += (self.barWidth+self.interBarSpace);

    return bar;
}

- (UIImage*)barImageAtIndex:(NSUInteger)index
{
    if ([self.dataSource respondsToSelector:@selector(barCharView:imageForBarAtIndex:)]) {
        return [self.dataSource barCharView:self imageForBarAtIndex:index];
    }
    else if (self.barImage != nil) {
        return self.barImage;
    }
    else {
        return nil;
    }
}

- (UIColor*)barColorAtIndex:(NSUInteger)index
{
    if ([self.dataSource respondsToSelector:@selector(barCharView:colorForBarAtIndex:)]) {
        return [self.dataSource barCharView:self colorForBarAtIndex:index];
    }
    else if (self.barColor != nil) {
        return self.barColor;
    }
    else {
        return self.tintColor;
    }
}

- (UIColor*)colorForXAxisTextAtIndex:(NSUInteger)index
{
    if ([self.dataSource respondsToSelector:@selector(barCharView:colorForXAxisTextAtIndex:)]) {
        return [self.dataSource barCharView:self colorForXAxisTextAtIndex:index];
    }
    else if (self.xAxisTextColor != nil) {
        return self.xAxisTextColor;
    }
    else {
        return [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
    }
}

- (UIColor*)colorForYAxisTextAtIndex:(NSUInteger)index
{
    if ([self.dataSource respondsToSelector:@selector(barCharView:colorForYAxisTextAtIndex:)]) {
        return [self.dataSource barCharView:self colorForYAxisTextAtIndex:index];
    }
    else if (self.yAxisTextColor != nil) {
        return self.yAxisTextColor;
    }
    else {
        return [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
    }
}

- (UIColor*)backBarColorAtIndex:(NSUInteger)index
{
    if ([self.dataSource respondsToSelector:@selector(barCharView:colorForBackBarAtIndex:)]) {
        return [self.dataSource barCharView:self colorForBackBarAtIndex:index];
    }
    else if (self.backBarColor != nil) {
        return self.backBarColor;
    }
    else {
        return [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    }
}

#pragma mark Custom Setters

- (void)setInterBarSpace:(CGFloat)interBarSpace {
    if (interBarSpace < 0) {
        interBarSpace = 0;
    }
    
    _interBarSpace = interBarSpace;
}

#pragma mark Data Source/Delegate Methods

- (void)customLayeredView:(MCNewCustomLayeredView *)customLayeredView
  didTouchMainPathOnLayer:(MCNewCustomLayer *)layer {
  
    NSInteger index = [self.containerLayer.sublayers indexOfObject:layer];
    
    if ([self.delegate respondsToSelector:@selector(barChartView:didSelectBarAtIndex:)]) {
        [self.delegate barChartView:self didSelectBarAtIndex:index];
    }
}

- (NSInteger)dataSourceNumberOfItemsInView:(MCNewCustomLayeredView *)view {
    return [self.dataSource numberOfBarsInBarChartView:self];
}

@end
