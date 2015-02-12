//
//  MCGraph2ViewController.m
//  BarChartSample
//
//  Created by Vinícius Rodrigues on 11/07/2014.
//  Copyright (c) 2014 MyAppControls. All rights reserved.
//

#import "MCGraph2ViewController.h"

@interface MCGraph2ViewController () {
    NSMutableArray *chartValues;
}
@end

@implementation MCGraph2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // populate char values array
    chartValues = [[NSMutableArray alloc] init];
    
    [chartValues addObject:[NSNumber numberWithFloat:10]];
    [chartValues addObject:[NSNumber numberWithFloat:20]];
    [chartValues addObject:[NSNumber numberWithFloat:-30]];
    [chartValues addObject:[NSNumber numberWithFloat:-50]];
    [chartValues addObject:[NSNumber numberWithFloat:-45]];
    [chartValues addObject:[NSNumber numberWithFloat:90]];
    [chartValues addObject:[NSNumber numberWithFloat:100]];
    
    self.barChart.dataSource = self;
    self.barChart.cornerRadiusPercentage = 0.5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Bar Chart View data source

- (NSInteger)numberOfBarsInBarChartView:(MCBarChartView*)barChartView
{
    return chartValues.count;
}

- (CGFloat)barCharView:(MCBarChartView*)barChartView valueForBarAtIndex:(NSInteger)index
{
    return [[chartValues objectAtIndex:index] floatValue];
}

// optional data source methods:

- (UIColor*)barCharView:(MCBarChartView *)barChartView colorForBarAtIndex:(NSInteger)index
{
    return self.view.tintColor;
}

@end
