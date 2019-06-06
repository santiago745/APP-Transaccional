//
//  IGTestSecurityRepository.h
//  salesforce
//
//  Created by Armando Restrepo on 12/26/14.
//  Copyright (c) 2014 Leonisa. All rights reserved.
//

#import "IGISecurityRepository.h"

@interface IGTestSecurityRepository : NSObject<IGISecurityRepository>

+(id) sharedInstance;

@end

