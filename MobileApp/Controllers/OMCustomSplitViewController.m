//
//  OMCustomSplitViewController.m
//  MobileApp
//
//  Created by Armando Restrepo on 4/7/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "OMCustomSplitViewController.h"

@interface OMCustomSplitViewController ()

@end

@implementation OMCustomSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [[self navigationController] setNavigationBarHidden:NO animated:NO];
    if ([self respondsToSelector:@selector(setPreferredDisplayMode:)]) {
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
