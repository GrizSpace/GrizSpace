//
//  BuildingModel.h
//  DBConnectionPractice
//
//  Created by Jaylene Naylor on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BuildingModel : NSObject

@property (nonatomic, retain)NSString *idBuilding;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, assign)double Latitude;
@property (nonatomic, assign)double Longitude;
@property (nonatomic, assign)NSInteger Radius;

@end


