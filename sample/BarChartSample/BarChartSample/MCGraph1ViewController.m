//
//  MCViewController.m
//  BarChartSample
//
//  Created by Vinícius Rodrigues on 1/04/2014.
//  Copyright (c) 2014 MyAppControls. All rights reserved.
//

#import "MCGraph1ViewController.h"
#import "MCUtil.h"

#define SEGUE_IDENTIFIER @"segue-table-view-controller"

#define ADD_ONE_TAG 0
#define REMOVE_ONE_TAG 1

@interface MCGraph1ViewController () {
    NSMutableArray *chartValues;
    NSInteger selectedIndex;
    UIColor *mainColor;
}

@end

@implementation MCGraph1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set the interface main color
    mainColor = [UIColor redColor];
    
    // starts with the first column selected
    selectedIndex = 0;
    
    // populate char values array
    chartValues = [[NSMutableArray alloc] init];
    
    [chartValues addObject:[NSNumber numberWithFloat:10]];
    [chartValues addObject:[NSNumber numberWithFloat:-50]];
    [chartValues addObject:[NSNumber numberWithFloat:-45]];
    [chartValues addObject:[NSNumber numberWithFloat:90]];
    [chartValues addObject:[NSNumber numberWithFloat:100]];
    
    // set data source and delegate
    self.barChart.dataSource = self;
    self.barChart.delegate = self;
    
    // customization properties
    self.barChart.cornerRadiusPercentage = 0.5;
    self.barChart.showXAxisLabels = YES;
    self.barChart.backBarColor = [[UIColor redColor] colorWithAlphaComponent:0.03];
    self.barChart.interBarSpace = 5; // in pixels.
//    self.barChart.showXAxisDecorationElement = NO;
    
    
    // This property will be ignored, since the data source is
    // implementing the method barCharView: colorForBarAtIndex:
    // The yellow color will apply if the data source doesn't
    // implement the color method.
    self.barChart.barColor = [UIColor yellowColor];
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
    if (index == selectedIndex) {
        return mainColor;
    }
    return [mainColor colorWithAlphaComponent:0.1];
}

#pragma mark - Bar Chart View delegate

- (void)barChartView:(MCBarChartView *)barChartView didSelectBarAtIndex:(NSInteger)index
{
    selectedIndex = index;
    
    // Asks for the bar chart to reload it's data
    // The bar chart will redraw itself, asking
    // for the data source for it's colors again
    [barChartView reloadData];
}

#pragma mark - Customization

- (IBAction)addRandomColumn:(id)sender
{
    [chartValues addObject:[NSNumber numberWithFloat:rand()%200 - 100]];
    [self.barChart reloadData];
}

- (IBAction)removeRandomColumn:(id)sender
{
    [chartValues removeLastObject];
    [self.barChart reloadData];
}

- (IBAction)cornerRadiusSliderDidChange:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    self.barChart.cornerRadiusPercentage = slider.value;
    self.cornerRadiusLabel.text = [NSString stringWithFormat:@"%.2f", slider.value];
    [self.barChart reloadData];
}

- (IBAction)colorSwitchDidChange:(id)sender
{
    UISwitch *uiswitch =(UISwitch*)sender;
    
    if (uiswitch.isOn) {
        mainColor = [MCUtil iOS7DefaultBlueColor];
    }
    else {
        mainColor = [UIColor redColor];
    }
    
    uiswitch.thumbTintColor = mainColor;
    self.barChart.backBarColor = [mainColor colorWithAlphaComponent:0.03];
    [self.barChart reloadData];
}

- (IBAction)showYLabelsSwitchDidChange:(id)sender
{
    UISwitch *switchControl = (UISwitch*)sender;
    self.barChart.showYAxisLabels = switchControl.isOn;
    [self.barChart reloadData];
}

- (IBAction)percentageSwitchDidChange:(id)sender
{
    UISwitch *switchControl = (UISwitch*)sender;
    
    if (switchControl.isOn) {
        self.barChart.textStyle = MCBarChartBarTextPercentage;
    }
    else {
        self.barChart.textStyle = MCBarChartBarTextRealValue;
    }
    
    [self.barChart reloadData];
}
@end
