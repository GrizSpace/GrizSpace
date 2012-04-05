//
//  BoredEvent.m
//  GrizSpace
//
//  Created by William Lyon on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BoredEvent.h"

@implementation BoredEvent
@synthesize title;
@synthesize description;
@synthesize location;
@synthesize parseObjectID;

-(id) initWithTitle:(NSString *)atitle andDescription:(NSString *)adescription atLocation:(NSString *)alocation withParseObjID:(NSString *)aobjectID
{
    self = [super init];
    
    self.title = atitle;
    self.description = adescription;
    self.location = alocation;
    self.parseObjectID = aobjectID;
    return self;
}

@end
