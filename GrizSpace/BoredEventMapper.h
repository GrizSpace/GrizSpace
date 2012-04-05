//
//  BoredEventMapper.h
//  GrizSpace
//
//  Created by William Lyon on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "BoredEvent.h"

@interface BoredEventMapper : NSObject

+(void) flagEvent: (BoredEvent*) event;
@end
