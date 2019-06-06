//
//  IGNotification.h
//  salesforce
//
//  Created by Armando Restrepo on 2/13/15.
//  Copyright (c) 2015 Leonisa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TSMessage.h"

@interface IGNotification : NSObject

+(void) showNotification:(NSError *)error
                   title:(NSString *)title
                subtitle:(NSString *)subtitle
                 andType:(TSMessageNotificationType)type;

@end
