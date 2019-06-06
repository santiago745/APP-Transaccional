//
//  OMBalancesContractsViewController.h
//  MobileApp
//
//  Created by steven muñoz on 7/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMBalancesContractsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableContracts;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalBalance;

@end
