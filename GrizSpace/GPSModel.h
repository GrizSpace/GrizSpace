//
//  GPSModel.h
//  DBConnectionPractice
//
//  Created by Jaylene Naylor on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPSModel : NSObject{
    
    NSInteger idGPS;
    NSDecimal *Latitude;
    NSDecimal *Longitude;
    NSInteger Radius; 
}

@property (nonatomic, assign)NSInteger idGPS;
@property (nonatomic, assign)NSDecimal *Latitude;
@property (nonatomic, assign)NSDecimal *Longitude;
@property (nonatomic, assign)NSInteger Radius;

@end
