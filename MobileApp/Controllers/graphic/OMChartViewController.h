//
//  OMGraphicViewController.h
//  MobileApp
//
//  Created by Rober on 21/05/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChartDelegate.h"
#import "PNChart.h"

@interface OMChartViewController : UIViewController <PNChartDelegate>

@property(nonatomic, weak) id delegate;
@property (nonatomic) PNPieChart *pieChart;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

- (IBAction)closeButton:(id)sender;

@end
