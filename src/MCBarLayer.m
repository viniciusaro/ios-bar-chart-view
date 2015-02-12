//
//  MCBarLayer.m
//  MCBarChart
//
//  Created by Vinícius Rodrigues on 2/12/2013.
//  Copyright (c) 2013 MyAppControls. All rights reserved.
//

#import "MCBarLayer.h"

@interface MCBarLayer()

@property (strong, nonatomic) UILabel *yLabel;

@end

@implementation MCBarLayer

@synthesize cornerRadius = _cornerRadius;

- (void)setDefaults
{
    [super setDefaults];
    
    self.cornerRadiusPercentage = 0;
    self.animationDuration = 1;
}

- (void)setUp
{
    self.yLabel = [[UILabel alloc] init];
    self.yLabel.adjustsFontSizeToFitWidth = NO;
    self.yLabel.textAlignment = NSTextAlignmentCenter;
    self.yLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [self addSublayer:self.yLabel.layer];
    
    self.textLabel.adjustsFontSizeToFitWidth = NO;
}

- (BOOL)allNegative {
    if (self.minValue <= 0 && self.maxValue <= 0) {
        return YES;
    }
    return NO;
}

- (BOOL)allPositive {
    if (self.minValue >= 0 && self.maxValue >= 0) {
        return YES;
    }
    return NO;
}

+ (NSArray*)animatableKeys {
    return [[NSArray alloc] initWithObjects:@"value", nil];
}

- (id)initWithLayer:(id)layer
{
    self = [super initWithLayer:layer];
    
    if (self) {
        MCBarLayer *other                   = (MCBarLayer*)layer;
        self.x                              = other.x;
        self.maxValue                       = other.maxValue;
        self.minValue                       = other.minValue;
        self.showBackBar                    = other.showBackBar;
        self.textLabel                      = other.textLabel;
        self.xAxisLabelFont                 = other.xAxisLabelFont;
        self.yAxisLabelFont                 = other.yAxisLabelFont;
        self.yLabel                         = other.yLabel;
        self.cornerRadiusPercentage         = other.cornerRadiusPercentage;
        self.barText                        = other.barText;
        self.backBarColor                   = other.backBarColor;
        self.barColor                       = other.barColor;
        self.width                          = other.width;
        self.xAxisTextColor                 = other.xAxisTextColor;
        self.yAxisTextColor                 = other.yAxisTextColor;
        self.yAxisLabelHeightPercentage     = other.yAxisLabelHeightPercentage;
        self.showXAxisDecorationElement     = other.showXAxisDecorationElement;
        self.showXAxisLabel                 = other.showXAxisLabel;
    }
    
    return self;
}

- (void)customDrawInContext:(CGContextRef)context
{
    [super customDrawInContext:context];
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGMutablePathRef backPath   = CGPathCreateMutable();
    CGMutablePathRef circlePath   = CGPathCreateMutable();
    
    if (self.minValue > 0) {
        self.minValue = 0;
    }
    if (self.maxValue < 0) {
        self.maxValue = 0;
    }
    
    if (self.xAxisLabelFont) {
        self.textLabel.font = self.xAxisLabelFont;
    }
    else {
        self.textLabel.font = [UIFont systemFontOfSize:self.width*0.25];
    }
    if (self.yAxisLabelFont) {
        self.yLabel.font = self.yAxisLabelFont;
    }
    else {
        self.yLabel.font = [UIFont systemFontOfSize:self.width*0.25];
    }
    
    _cornerRadius = self.width/2*self.cornerRadiusPercentage;
    
    // bar width
    CGFloat width = self.width;
    
    // height to draw the ylabel layers
    CGFloat yLabelHeight = self.frame.size.height*self.yAxisLabelHeightPercentage;
    if (self.barText == nil) {
        yLabelHeight = 0;
    }
    
    CGFloat xLabelAndCircleHeightPercentage = 0;
    
    if (self.showXAxisLabel) {
        xLabelAndCircleHeightPercentage += 0.1;
    }
    if (self.showXAxisDecorationElement) {
        xLabelAndCircleHeightPercentage += 0.05;
    }
    
    // height to draw the circle and xlabel layers
    CGFloat xLabelAndCircleHeight = self.frame.size.height*xLabelAndCircleHeightPercentage;
    
    // percentage sum = 1 ---------------------------------------
    // height for the lable layer
    CGFloat labelHeight = xLabelAndCircleHeight*0.5;
    CGFloat labelDistanceFromCircle = xLabelAndCircleHeight*0.1;
    
    // height for the circle layer
    CGFloat circleHeight = xLabelAndCircleHeight*0.3;
    CGFloat circleDistanceFromBar = xLabelAndCircleHeight*0.1;
    
    if (!self.showXAxisLabel) {
        labelHeight = 0;
        labelDistanceFromCircle = 0;
        circleHeight = xLabelAndCircleHeight*0.8;
        circleDistanceFromBar = xLabelAndCircleHeight*0.2;
    }
    
    if (!self.showXAxisDecorationElement) {
        labelHeight = xLabelAndCircleHeight*0.8;
        labelDistanceFromCircle = xLabelAndCircleHeight*0.2;
        circleHeight = 0;
        circleDistanceFromBar = 0;
    }
    
    if (circleHeight > width/2) {
        circleHeight = width/2;
    }
    // end percentage sum = 1 ---------------------------------------
    
    // bar height, already discounted the height that xlabel, ylabel and circle will occupy
    CGFloat availableHeight = self.frame.size.height-xLabelAndCircleHeight-yLabelHeight;
    
    // if are there positive and negative values, there is the need
    // to discount the height for the yLabels on both negative and positive sides
    // of the x axis
    if (![self allPositive] && ![self allNegative]) {
        availableHeight -= yLabelHeight;
    }
    
    // height normalized with the bar's value
    CGFloat normalizedHeight = (self.value/(fabs(self.maxValue)+fabs(self.minValue)))*(availableHeight);
    
    // calculates where does the xAxis should be
    CGFloat xAxisHeight = fabs(self.minValue)/(fabs(self.maxValue)+fabs(self.minValue))*(availableHeight);
    
    xAxisHeight += xLabelAndCircleHeight;
    if ([self allNegative] || (![self allNegative] && ![self allPositive])) {
        xAxisHeight += yLabelHeight;
    }
    
    // back bar
    if (self.showBackBar) {
        CGFloat backBarHeight = availableHeight;
        if (![self allPositive] && ![self allNegative]) {
            backBarHeight += yLabelHeight*2;
        }
        else if ([self allPositive] || [self allNegative]) {
            backBarHeight += yLabelHeight;
        }
        
        CGPathAddRoundedRect(backPath,
                             &transform,
                             CGRectMake(self.x, self.frame.size.height-xLabelAndCircleHeight, width, -backBarHeight),
                             MIN(2*fabs(self.cornerRadius), fabs(width))/2,
                             MIN(2*fabs(self.cornerRadius), fabs(availableHeight))/2);
        
        CGContextAddPath(context, backPath);
        CGContextSetFillColorWithColor(context, self.backBarColor.CGColor);
        CGContextFillPath(context);
    }
    
    // main bar
    CGPathAddRoundedRect(self.mainPath,
                         &transform,
                         CGRectMake(self.x, self.frame.size.height-xAxisHeight, width, -normalizedHeight),
                         MIN(2*fabs(self.cornerRadius), fabs(width))/2,
                         MIN(2*fabs(self.cornerRadius), fabs(normalizedHeight))/2);
    
    CGContextAddPath(context, self.mainPath);
    CGContextSetFillColorWithColor(context, self.barColor.CGColor);
    CGContextFillPath(context);

    // circle
    CGFloat circleWidth = circleHeight;
    CGFloat circle_x = (width/2) - (circleWidth/2) + self.x;
    CGFloat circle_y = xLabelAndCircleHeight-circleDistanceFromBar-circleHeight;
    
    if (self.showXAxisDecorationElement)
    {
        CGPathAddRoundedRect(circlePath,
                             &transform,
                             CGRectMake(circle_x, self.frame.size.height-circle_y, circleWidth, -circleHeight),
                             MIN(2*fabs(self.cornerRadius), fabs(circleWidth))/2,
                             MIN(2*fabs(self.cornerRadius), fabs(circleHeight)/2));
        
        CGContextAddPath(context, circlePath);
        CGContextSetFillColorWithColor(context, self.barColor.CGColor);
        CGContextFillPath(context);
    }
    
    if (self.showXAxisLabel) {
        // xlabel
        CGFloat xLabel_y = circle_y - labelDistanceFromCircle - labelHeight;
        
        self.textLabel.frame = CGRectMake(self.x, self.frame.size.height-xLabel_y, width, -labelHeight);
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = self.xAxisTextColor;
    }
    
    if (self.barText != nil) {
        // ylabel
        CGFloat yLabel_y;
        
        if (self.value >= 0) {
            yLabel_y = normalizedHeight+xAxisHeight;
        }
        else {
            yLabel_y = xAxisHeight+normalizedHeight-yLabelHeight;
        }
        
        self.yLabel.frame = CGRectMake(self.x, self.frame.size.height-yLabel_y, width, -yLabelHeight);
        self.yLabel.backgroundColor = [UIColor clearColor];
        self.yLabel.textColor = self.yAxisTextColor;
    }
    
    self.yLabel.text = self.barText;
    
    CGPathRelease(backPath);
    CGPathRelease(circlePath);
}

#pragma mark Custom Setters

- (void)setCornerRadiusPercentage:(CGFloat)cornerRadiusPercentage
{
    cornerRadiusPercentage = [MCUtil verifyPercentageBoundsForValue:cornerRadiusPercentage];
    _cornerRadiusPercentage = cornerRadiusPercentage;
}

- (void)setYAxisLabelHeightPercentage:(CGFloat)yAxisLabelHeightPercentage
{
    yAxisLabelHeightPercentage = [MCUtil verifyBoundsForValue:yAxisLabelHeightPercentage
                                                   lowerBound:0.05
                                                   upperBound:0.5];
    
    _yAxisLabelHeightPercentage = yAxisLabelHeightPercentage;
}

@end
