//
//  IGSecurityRepository.h
//  salesforce
//
//  Created by Armando Restrepo on 12/26/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGISecurityRepository.h"

@interface IGSecurityRepository : NSObject<IGISecurityRepository>
+(id) sharedInstance;
@end
