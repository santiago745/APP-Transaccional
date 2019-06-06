//
//  IGTimeoutApplication.m
//  MobileApp
//
//  Created by Armando Restrepo on 3/3/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import "IGTimeoutApplication.h"
#import "IGMobileApp.h"

@implementation IGTimeoutApplication

-(id)init{
    
    if(!_idleTimer) {
        //[self resetIdleTimer];
    }
    
    return [super init];
}

- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
    
    // Fire up the timer upon first event
    if(!_idleTimer) {
        //[self resetIdleTimer];
    }
    
    // Check to see if there was a touch event
    NSSet *allTouches = [event allTouches];
    if ([allTouches count] > 0) {
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan && [[IGMobileApp sharedInstance] isAuthenticated] ) {
            [self resetIdleTimer];
        }
    }
}

- (void)resetIdleTimer
{
    [self invalidateTimer];
    // Schedule a timer to fire in kApplicationTimeoutInMinutes * 60
    int timeout = kApplicationTimeoutInMinutes * 60;
    _idleTimer = [NSTimer scheduledTimerWithTimeInterval:timeout
                                                  target:self
                                                selector:@selector(idleTimerExceeded)
                                                userInfo:nil
                                                 repeats:NO];
    
}

-(void)invalidateTimer{
    [_idleTimer invalidate];
    _idleTimer = nil;
}

- (void)idleTimerExceeded {
    /* Post a notification so anyone who subscribes to it can be notified when
     * the application times out */
    [self invalidateTimer];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kApplicationDidTimeoutNotification object:nil];
}

@end
