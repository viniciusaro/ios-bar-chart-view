//
//  MCGraph2ViewController.h
//  BarChartSample
//
//  Created by Vinícius Rodrigues on 11/07/2014.
//  Copyright (c) 2014 MyAppControls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBarChartView.h"

@interface MCGraph3ViewController : UIViewController <MCBarChartViewDataSource, MCBarChartViewDelegate>

@property (strong, nonatomic) IBOutlet MCBarChartView *barChart;

@end
