//
//  OGBalancesViewController.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/25/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"

@interface OMBalancesViewController : UIViewController<UIGestureRecognizerDelegate, UIAlertViewDelegate, SKSTableViewDelegate>

@property (weak, nonatomic) IBOutlet SKSTableView *tableView;

@end
