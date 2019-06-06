//
//  OMStatementsViewController.h
//  MobileApp
//
//  Created by steven muñoz on 16/04/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMStatementsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIDocumentInteractionControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIDocumentInteractionController* controller;

@end
