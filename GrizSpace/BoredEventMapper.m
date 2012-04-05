//
//  BoredEventMapper.m
//  GrizSpace
//
//  Created by William Lyon on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BoredEventMapper.h"



@implementation BoredEventMapper

+(void) flagEvent: (BoredEvent*) event
{
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    PFObject *PFEvent = [query getObjectWithId:event.parseObjectID];
    NSLog(@"ParseObjKey: %@", event.parseObjectID);
    
    if ([[PFEvent objectForKey:@"flags"] intValue] > 2)
    {
        [PFEvent delete];
    }
    else
    {
        [PFEvent incrementKey:@"flags"];
        [PFEvent save];
    }
}

@end
