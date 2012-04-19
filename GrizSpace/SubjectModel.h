//
//  SubjectModel.h
//  GrizSpace
//
//  Created by Jaylene Naylor on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectModel : NSObject

@property (nonatomic, assign)NSInteger idSubject;
@property (nonatomic, retain)NSString *abbr;
@property (nonatomic, retain)NSString *title;

-(id)initWithId:(int)subjectId andAbbr:(NSString*)aAbbr andTitle:(NSString*)aTitle;
-(NSString*) getAbbr;

@end
