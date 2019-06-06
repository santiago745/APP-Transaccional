//
//  OMTransactionsHistoryViewController.h
//  MobileApp
//
//  Created by Rober on 24/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMTransactionsHistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblContractNumber;
@property (weak, nonatomic) IBOutlet UITableView *tblTransactionsHistory;

@end
