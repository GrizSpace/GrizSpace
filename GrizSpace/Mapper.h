//
//  Mapper.h -- Base class for Data Mapper classes
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "FMDatabase.h"

@interface Mapper : NSObject
{
    FMDatabase* db;
}

- (id)init;

+ (NSString*)getDatabasePath;

@end
