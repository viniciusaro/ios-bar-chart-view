# iOS Bar Chart View
The iOS Bar Chart is a great tool to represent data in an elegant and simple way. The default appearance conforms to the beautiful design, It has built in animation features for presenting, inserting, deleting and updating actions and it is fully customisable, being able to change colors, label text, font, all through properties attributes and delegate methods. The content is managed by a data source object following the built in Apple controls standards. 

Demo video: https://www.youtube.com/watch?v=eWJi99ZGcgs

More info at: http://myappcontrols.binpress.com/product/ios-bar-chart-view/1836

![alt tag](http://myappcontrols.binpress.com/images/stores/store30934/bar-chart-view-5184.png)

## Installation

Add all files from the src folder to your project
Import as usual: #import "MCBarChartView.h"
Add QuartzCore.framework to your project

## Setup

MCBarChartView can be added to your view either from the Interface Builder or through code.

#### Interface Builder (Xcode 5):

* Open the Storyboard or Xib file you want to add the bar chart to.
* Drag a new UIView from the Object Library into your view controller.
* Resize and position your new UIView as you wish (the bar chart will be drawn on the center of the new UIView).
* Make sure the new UIView is selected and choose the Identity Inspector tab on Xcode's the Utilities view (on the right).
* Change the class from UIView to MCBarChartView.
* On the view controller's header file create an IBOutlet property of the type MCBarChartView and link it to the object you created on the Interface Builder.

#### Through Code:
```
CGRect frame = CGRectMake(x, y, width, height);
MCBarChartView *barChart = [[MCBarChartView alloc] initWithFrame:frame];
[self.view addSubview:barChart];
```

## Credits
Brought to you by [MyAppControls](http://www.binpress.com/profile/myappcontrols/30934) team.

## Similar Projects

[iOS Circular Progress Bar](https://github.com/vinicius-a-ro/ios-circular-progress-bar)

[iOS Simple Color Picker](https://github.com/vinicius-a-ro/ios-color-picker)

[iOS Pie Chart](https://github.com/vinicius-a-ro/ios-pie-chart-view)
