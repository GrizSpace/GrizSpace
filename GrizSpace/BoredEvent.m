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

-(id) initWithTitle:(NSString *)atitle andDescription:(NSString *)adescription atLocation:(NSString *)alocation
{
    self = [super init];
    
    self.title = atitle;
    self.description = adescription;
    self.location = alocation;
    
    return self;
}

@end
