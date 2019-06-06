//
//  IGDownloadDocument.h
//  MobileApp
//
//  Created by Rober on 23/06/15.
//  Copyright (c) 2015 Old Mutual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGIDownloadDocumentRepository.h"

@interface IGDownloadDocumentRepository : NSObject<IGIDownloadDocumentRepository>
+(id) sharedInstance;
@end