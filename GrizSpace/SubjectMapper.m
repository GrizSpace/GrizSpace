//
//  SubjectMapper.m
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubjectMapper.h"

@implementation SubjectMapper

-(id)init
{
    self = [super init];
    if (!self)
        return nil;
    
    return self;
}

-(NSMutableArray*)findById:(int)subjectId
{
    return [self query:^{
        NSMutableArray* results = [[NSMutableArray alloc] init];
        NSString* sql = @"SELECT abbr, title FROM Subject WHERE id = ?";
        FMResultSet* rs = [db executeQuery:sql, [NSNumber numberWithInt:subjectId]];
        
        while ([rs next]) {
            NSString* abbr = [rs stringForColumn:@"abbr"];
            NSString* title = [rs stringForColumn:@"title"];
            SubjectModel* subject = [[SubjectModel alloc] initWithId:subjectId
                                                             andAbbr:abbr
                                                            andTitle:title];
            [results addObject:subject];
        }
        return results;
    }];
}

@end
