//
//  CourseMapper.h
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Mapper.h"
#import "CourseModel.h"
#import "SubjectModel.h"

@interface CourseMapper : Mapper

-(id)init;
-(NSMutableArray*)findBySubject:(SubjectModel*)subject;

@end
