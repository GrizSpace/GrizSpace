//
//  BuildingModel.h
//  DBConnectionPractice
//
//  Created by Jaylene Naylor on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BuildingModel : NSObject{
    //create properties for each column in the building table
    NSString *idBuilding;
    NSString *name;
    NSInteger fk_idGPS;
    

}
-(NSString*)getName;
-(NSString*)getID;

@property (nonatomic, retain)NSString *idBuilding;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, assign)NSInteger fk_idGPS;



@end


