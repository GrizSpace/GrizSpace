//
//  AppDelegate.h
//  GrizSpace
//
//  Created by Jon-Michael Deldin on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
// comment

#import <UIKit/UIKit.h>
#import "AppDelegateProtocol.h"

@class GrizSpaceDataObjects;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    //data objects referenced in the app for storing data.
    GrizSpaceDataObjects* theAppDataObject;
}
@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, retain) GrizSpaceDataObjects* theAppDataObject;
@end
