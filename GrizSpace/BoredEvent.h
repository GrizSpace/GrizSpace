//
//  BoredEvent.h
//  GrizSpace
//
//  Created by William Lyon on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface BoredEvent : NSObject

@property NSString* title;
@property NSString* description;
@property NSString* location;
@property NSString* parseObjectID;
-(id) initWithTitle:(NSString*) title andDescription:(NSString*) description atLocation:(NSString*) location withParseObjID:(NSString*) objectID;

+(void) flagEvent: (BoredEvent*) event;
+(NSMutableArray*) getBoredEvents;
+(void) addBoredEvent: (BoredEvent*) event;

@end
