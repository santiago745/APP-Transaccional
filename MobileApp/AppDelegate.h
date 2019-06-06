//
//  AppDelegate.h
//  MobileApp
//
//  Created by Armando Restrepo on 2/23/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"
@import Firebase;
@class TAGManager;
@class TAGContainer;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) id<GAITracker> tracker;
@property (nonatomic, strong) TAGManager *tagManager;
@property (nonatomic, strong) TAGContainer *container;


@end

