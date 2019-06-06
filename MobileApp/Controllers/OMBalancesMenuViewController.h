//
//  OMBalancesMenuViewController.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/30/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMChannelGuideViewController.h"
#import "OMChannelGuideViewController.h"
@interface OMBalancesMenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tvMenu;
@property (weak, nonatomic) IBOutlet UILabel *lblClientName;
@property (weak, nonatomic) IBOutlet UILabel *lblLastSession;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentIP;

- (IBAction)btnSaveExit:(UIButton *)sender;

@end
