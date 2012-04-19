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
@synthesize when;
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

+(void) flagEvent: (BoredEvent*) event
{
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    PFObject *PFEvent = [query getObjectWithId:event.parseObjectID];
    NSLog(@"ParseObjKey: %@", event.parseObjectID);
    
    [PFEvent incrementKey:@"flags"];
    [PFEvent save];
    
}

+(NSMutableArray*) getBoredEvents
{
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
    PFObject* tmpPFObject = [[PFObject alloc] init];
    NSMutableArray* tmpArray = [[NSMutableArray alloc] init];
    
    
    NSArray* PFObjectCourseArray = [query findObjects];
    
    
    for (int i=0; i<[PFObjectCourseArray count]; i++)
    {
        tmpPFObject = [PFObjectCourseArray objectAtIndex:i];
        
        NSString* tmpTitle = [tmpPFObject objectForKey:@"title"];
        
        NSString* tmpDesc = [tmpPFObject objectForKey:@"desc"];
        NSString* tmpLoc = [tmpPFObject objectForKey:@"location"];
        NSString* tmpWhen = [tmpPFObject objectForKey:@"when"];
        
        NSString* tmpObjId = tmpPFObject.objectId;
        
        BoredEvent* tmpBoredEvent = [[BoredEvent alloc] initWithTitle:tmpTitle andDescription:tmpDesc atLocation:tmpLoc withParseObjID:tmpObjId];
        [tmpBoredEvent setWhen:tmpWhen];
        // [events addObject:tmpString];
        
        
        
        //NSLog(@"tmpString: %@", tmpString);
        
        if ([[tmpPFObject objectForKey:@"flags"] intValue] < 3)
        {
            [tmpArray addObject:tmpBoredEvent];
        }
        
    }
    
    return tmpArray;
}

+(void) addBoredEvent:(BoredEvent *)event
{
    PFObject* newEvent = [PFObject objectWithClassName:@"Event"];
    [newEvent setObject:event.title forKey:@"title"];
    [newEvent setObject:event.description forKey:@"desc"];
    [newEvent setObject:event.location forKey:@"location"];
    [newEvent setObject:event.when forKey:@"when"];
    [newEvent save];
}


@end
