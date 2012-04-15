

#import <Foundation/Foundation.h>

@interface ModalAlertDelegate : NSObject <UIAlertViewDelegate>
{
    UIAlertView *alertView;
    int index;
}
+ (id) delegateWithAlert: (UIAlertView *) anAlert;
- (int) show;
@end
