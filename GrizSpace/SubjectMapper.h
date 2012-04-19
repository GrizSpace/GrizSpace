//
//  SubjectMapper.h
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Mapper.h"
#import "SubjectModel.h"

@interface SubjectMapper : Mapper

-(id)init;
-(NSMutableArray*)findById:(int)subjectId;

@end
