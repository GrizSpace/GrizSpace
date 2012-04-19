//
//  SubjectModel.m
//  GrizSpace
//
//  Created by Jaylene Naylor on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubjectModel.h"

@implementation SubjectModel

@synthesize idSubject;
@synthesize abbr;
@synthesize title;

-(id)initWithId:(int)subjectId
        andAbbr:(NSString*)aAbbr
       andTitle:(NSString*)aTitle
{
    self = [super init];

    if (!self)
        return nil;

    self.idSubject = subjectId;
    self.abbr      = aAbbr;
    self.title     = aTitle;

    return self;
}

-(NSString*) getAbbr
{
    return abbr;
}
@end
