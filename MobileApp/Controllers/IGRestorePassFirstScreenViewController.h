//
//  IGRestorePassFirstScreenViewController.h
//  MobileApp
//
//  Created by steven muñoz on 30/03/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGRestorePassViewController.h"

@interface IGRestorePassFirstScreenViewController : UIViewController <ForgotPasswordDelegate>

@property (nonatomic, weak) id<ForgotPasswordDelegate> delegate;

@end
