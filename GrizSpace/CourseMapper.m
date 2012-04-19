//
//  CourseMapper.m
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseMapper.h"

@implementation CourseMapper

- (id)init
{
    self = [super init];
    if (!self)
        return nil;
    
    return self;
}

-(NSMutableArray*)findBySubject:(SubjectModel*)subject
{
    return [self query:^{
        NSMutableArray* results = [[NSMutableArray alloc] init];
        NSString* sql = @"SELECT id, number, title, subject_id"
                         " FROM Course WHERE subject_id = ?";
        FMResultSet* rs = [db executeQuery:sql, [NSNumber numberWithInt:subject.idSubject]];
        
        while ([rs next]) {
            int _id = [rs intForColumn:@"id"];
            NSString* num = [rs stringForColumn:@"number"];
            NSString* title = [rs stringForColumn:@"title"];
            CourseModel* course = [[CourseModel alloc] initWithCourseId:_id
                                                              andNumber:num
                                                               andTitle:title
                                                           andSubject:subject];
            [results addObject:course];
        }
        return results;
    }];
}

@end
