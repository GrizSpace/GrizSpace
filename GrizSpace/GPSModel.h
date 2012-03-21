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
    //NSDecimal *Latitude;
    //NSDecimal *Longitude;
    NSInteger Radius;
}

@property (nonatomic, assign)NSInteger idGPS;
@property (nonatomic, assign)double Latitude;
@property (nonatomic, assign)double Longitude;
@property (nonatomic, assign)NSInteger Radius;


+ (GPSModel*) FindGPSModelFromList: (NSMutableArray*) tmpGPSModelList idGPS: (NSInteger) searchIdGPS;
@end
