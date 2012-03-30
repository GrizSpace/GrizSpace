//
//  Mapper.m
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Mapper.h"

@implementation Mapper

- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    db = [FMDatabase databaseWithPath: [Mapper getDatabasePath]];

    return self;
}

- (int)close
{
    return [db close];
}

+ (NSString*)getDatabasePath
{
    // [mainBundle pathForResource] doesn't work in unit tests
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    return [bundle pathForResource:DB_NAME ofType:@"sqlite"];
}
@end
