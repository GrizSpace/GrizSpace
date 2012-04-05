//
//  BoredEvent.h
//  GrizSpace
//
//  Created by William Lyon on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoredEvent : NSObject

@property NSString* title;
@property NSString* description;
@property NSString* location;
-(id) initWithTitle:(NSString*) title andDescription:(NSString*) description atLocation:(NSString*) location;

@end
