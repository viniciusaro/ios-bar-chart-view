//
//  MCViewController.h
//  BarChartSample
//
//  Created by Vinícius Rodrigues on 1/04/2014.
//  Copyright (c) 2014 MyAppControls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBarChartView.h"

@interface MCGraph1ViewController : UIViewController <MCBarChartViewDataSource, MCBarChartViewDelegate>

@property (strong, nonatomic) IBOutlet MCBarChartView *barChart;
@property (strong, nonatomic) IBOutlet UILabel *cornerRadiusLabel;
@property (strong, nonatomic) IBOutlet UILabel *interBarSpaceLabel;

@end
