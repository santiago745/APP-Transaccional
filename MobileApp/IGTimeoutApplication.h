//
//  IGTimeoutApplication.h
//  MobileApp
//
//  Created by Armando Restrepo on 3/3/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <UIKit/UIKit.h>

// # of minutes before application times out
#define kApplicationTimeoutInMinutes 5

// Notification that gets sent when the timeout occurs
#define kApplicationDidTimeoutNotification @"ApplicationDidTimeout"

@interface IGTimeoutApplication : UIApplication{
    NSTimer *_idleTimer;
}

/**
 * Resets the idle timer to its initial state. This method gets called
 * every time there is a touch on the screen.  It should also be called
 * when the user correctly enters their pin to access the application.
 */
- (void)resetIdleTimer;
- (void)invalidateTimer;

@end
