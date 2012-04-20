//
//  MapAnnotationView.m
//  GrizSpace
//
//  Created by Kevin Scott on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotationView.h"

#define CalloutMapAnnotationViewBottomShadowBufferSize 6.0f
#define CalloutMapAnnotationViewContentHeightBuffer 8.0f
#define CalloutMapAnnotationViewHeightAboveParent 2.0f

@interface MapAnnotationView()

@property (nonatomic, readonly) CGFloat yShadowOffset;
@property (nonatomic) BOOL animateOnNextDrawRect;
@property (nonatomic) CGRect endFrame;

- (void)prepareContentFrame;
- (void)prepareFrameSize;
- (void)prepareOffset;
- (CGFloat)relativeParentXPosition;
- (void)adjustMapRegionIfNeeded;

@end

@implementation MapAnnotationView

@synthesize parentAnnotationView = _parentAnnotationView;
@synthesize mapView = _mapView;
@synthesize contentView = _contentView;
@synthesize animateOnNextDrawRect = _animateOnNextDrawRect;
@synthesize endFrame = _endFrame;
@synthesize yShadowOffset = _yShadowOffset;
@synthesize offsetFromParent = _offsetFromParent;
@synthesize contentHeight = _contentHeight;

- (id) initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
		self.contentHeight = 0.0;
		self.offsetFromParent = CGPointMake(8, -14); //this works for MKPinAnnotationView
		self.enabled = NO;
		self.backgroundColor = [UIColor clearColor];
        annotationsList = [[NSMutableArray alloc] init];
        buttonList = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) addAnnotationModel: (MapAnnotationCallout*) tmpAM
{
    
    for(MapAnnotation* tmpMA in tmpAM.annObjectArray)
    {
        [annotationsList addObject:tmpMA];
        
        int alCount = annotationsList.count;
        int yOffset = 2;
        int annHeight = 40;
        int annWidth = self.mapView.frame.size.width - 50;
        if(alCount > 1)
        {
            yOffset = yOffset + ((alCount - 1) * annHeight);
        }
        
        self.contentHeight = (annHeight * alCount);
        UIFont* font = [UIFont fontWithName:@"Arial" size:12];
        CGRect frame = CGRectMake(5, yOffset - 5, annWidth, annHeight - 18);
        
        UITextView* annText = [[UITextView alloc] initWithFrame: frame];
        
        annText.text = tmpMA.title;
        annText.backgroundColor = [UIColor clearColor];  
        annText.font = font;
        annText.textColor = [UIColor whiteColor];
        annText.editable = NO;                     // added to make annotation not editable
        
        NSLog(@"adding sub text: %@", tmpMA.subtitle);
        if(tmpMA.subtitle != nil)
        {
            if(tmpMA.subtitle != @"")
            {
                
                CGRect subframe = CGRectMake(5, yOffset + 11, annWidth, annHeight - 17);
                UITextView* subannText = [[UITextView alloc] initWithFrame:subframe];
                UIFont* subfont = [UIFont fontWithName:@"Arial" size:10];
                subannText.text = tmpMA.subtitle;
                subannText.backgroundColor = [UIColor clearColor];
                subannText.textColor = [UIColor whiteColor];
                subannText.font = subfont;
                subannText.editable = NO;
                [self.contentView addSubview:subannText];
            }
        }
        
        
        if(tmpMA.annotationType != @"Building")
        {
            UIButton* accessory = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            accessory.exclusiveTouch = YES;
            accessory.enabled = YES;
            [accessory addTarget: self 
                          action: @selector(calloutAccessoryTapped) 
                forControlEvents: UIControlEventTouchUpInside | UIControlEventTouchCancel];
            accessory.tag = tmpMA.keyVal;
            accessory.frame = CGRectMake(annWidth - 10, 
                                         (yOffset- 10), 
                                         55, 
                                         55);   
            [self.contentView addSubview: accessory];
            [buttonList addObject:accessory];
        }
        [self.contentView addSubview:annText];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	
    UIView *hitView = [super hitTest:point withEvent:event];
    int tmpIndex = 0;
	for (UIButton* tmpButton in buttonList)
    {
        if(hitView == tmpButton)
        {
            currAnn = [annotationsList objectAtIndex:tmpIndex];
            currButton = tmpButton;
            currButtonIndex = tmpIndex;
        }
        tmpIndex = tmpIndex + 1;
    }
    
    return hitView;
}

- (void) calloutAccessoryTapped {
	if ([self.mapView.delegate respondsToSelector:@selector(mapView:annotationView:calloutAccessoryControlTapped:)]) {
        
		[self.mapView.delegate mapView:self.mapView 
						annotationView:self 
		 calloutAccessoryControlTapped:currButton];
	}
}

- (void)clearAnnotations
{
    [annotationsList removeAllObjects];
    [buttonList removeAllObjects];
    for (UIView *subview in [self.contentView subviews]) {
            [subview removeFromSuperview];
        
    }
}

- (void)setAnnotation:(id <MKAnnotation>)annotation {
	[super setAnnotation:annotation];
	[self prepareFrameSize];
	[self prepareOffset];
	[self prepareContentFrame];
	[self setNeedsDisplay];
}

- (void)prepareFrameSize {
	CGRect frame = self.frame;
	CGFloat height =	self.contentHeight +
	CalloutMapAnnotationViewContentHeightBuffer +
	CalloutMapAnnotationViewBottomShadowBufferSize -
	self.offsetFromParent.y;
	
	frame.size = CGSizeMake(self.mapView.frame.size.width, height);
	self.frame = frame;
}

- (void)prepareContentFrame {
	CGRect contentFrame = CGRectMake(self.bounds.origin.x + 10, 
									 self.bounds.origin.y + 3, 
									 self.bounds.size.width - 20, 
									 self.contentHeight);
    
	self.contentView.frame = contentFrame;
}

- (void)prepareOffset {
	CGPoint parentOrigin = [self.mapView convertPoint:self.parentAnnotationView.frame.origin 
											 fromView:self.parentAnnotationView.superview];
	
	CGFloat xOffset =	(self.mapView.frame.size.width / 2) - 
    (parentOrigin.x + self.offsetFromParent.x);
	CGFloat yOffset = -(self.frame.size.height / 2 + 
						self.parentAnnotationView.frame.size.height / 2) + 
    self.offsetFromParent.y + 
    CalloutMapAnnotationViewBottomShadowBufferSize;
	
	self.centerOffset = CGPointMake(xOffset, yOffset);
}

//if the pin is too close to the edge of the map view we need to shift the map view so the callout will fit.
- (void)adjustMapRegionIfNeeded {
	//Longitude
	CGFloat xPixelShift = 0;
	if ([self relativeParentXPosition] < 38) {
		xPixelShift = 38 - [self relativeParentXPosition];
	} else if ([self relativeParentXPosition] > self.frame.size.width - 38) {
		xPixelShift = (self.frame.size.width - 38) - [self relativeParentXPosition];
	}
	
	
	//Latitude
	CGPoint mapViewOriginRelativeToParent = [self.mapView convertPoint:self.mapView.frame.origin toView:self.parentAnnotationView];
	CGFloat yPixelShift = 0;
	CGFloat pixelsFromTopOfMapView = -(mapViewOriginRelativeToParent.y + self.frame.size.height - CalloutMapAnnotationViewBottomShadowBufferSize);
	CGFloat pixelsFromBottomOfMapView = self.mapView.frame.size.height + mapViewOriginRelativeToParent.y - self.parentAnnotationView.frame.size.height;
	if (pixelsFromTopOfMapView < 7) {
		yPixelShift = 7 - pixelsFromTopOfMapView;
	} else if (pixelsFromBottomOfMapView < 10) {
		yPixelShift = -(10 - pixelsFromBottomOfMapView);
	}
	
	//Calculate new center point, if needed
	if (xPixelShift || yPixelShift) {
		CGFloat pixelsPerDegreeLongitude = self.mapView.frame.size.width / self.mapView.region.span.longitudeDelta;
		CGFloat pixelsPerDegreeLatitude = self.mapView.frame.size.height / self.mapView.region.span.latitudeDelta;
		
		CLLocationDegrees longitudinalShift = -(xPixelShift / pixelsPerDegreeLongitude);
		CLLocationDegrees latitudinalShift = yPixelShift / pixelsPerDegreeLatitude;
		
		CLLocationCoordinate2D newCenterCoordinate = {self.mapView.region.center.latitude + latitudinalShift, 
			self.mapView.region.center.longitude + longitudinalShift};
		
		[self.mapView setCenterCoordinate:newCenterCoordinate animated:YES];
		
		//fix for now
		self.frame = CGRectMake(self.frame.origin.x - xPixelShift,
								self.frame.origin.y - yPixelShift,
								self.frame.size.width, 
								self.frame.size.height);
		//fix for later (after zoom or other action that resets the frame)
		self.centerOffset = CGPointMake(self.centerOffset.x - xPixelShift, self.centerOffset.y);
	}
}

- (CGFloat)xTransformForScale:(CGFloat)scale {
	CGFloat xDistanceFromCenterToParent = self.endFrame.size.width / 2 - [self relativeParentXPosition];
	return (xDistanceFromCenterToParent * scale) - xDistanceFromCenterToParent;
}

- (CGFloat)yTransformForScale:(CGFloat)scale {
	CGFloat yDistanceFromCenterToParent = (((self.endFrame.size.height) / 2) + self.offsetFromParent.y + CalloutMapAnnotationViewBottomShadowBufferSize + CalloutMapAnnotationViewHeightAboveParent);
	return yDistanceFromCenterToParent - yDistanceFromCenterToParent * scale;
}

- (void)animateIn {
	self.endFrame = self.frame;
	CGFloat scale = 0.001f;
	self.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, [self xTransformForScale:scale], [self yTransformForScale:scale]);
	[UIView beginAnimations:@"animateIn" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.075];
	[UIView setAnimationDidStopSelector:@selector(animateInStepTwo)];
	[UIView setAnimationDelegate:self];
	scale = 1.1;
	self.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, [self xTransformForScale:scale], [self yTransformForScale:scale]);
	[UIView commitAnimations];
}

- (void)animateInStepTwo {
	[UIView beginAnimations:@"animateInStepTwo" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationDidStopSelector:@selector(animateInStepThree)];
	[UIView setAnimationDelegate:self];
	
	CGFloat scale = 0.95;
	self.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, [self xTransformForScale:scale], [self yTransformForScale:scale]);
	
	[UIView commitAnimations];
}

- (void)animateInStepThree {
	[UIView beginAnimations:@"animateInStepThree" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.075];
	
	CGFloat scale = 1.0;
	self.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, [self xTransformForScale:scale], [self yTransformForScale:scale]);
	
	[UIView commitAnimations];
}

- (void)didMoveToSuperview {
	[self adjustMapRegionIfNeeded];
	[self animateIn];
}

- (void)drawRect:(CGRect)rect {
	CGFloat stroke = 1.0;
	CGFloat radius = 7.0;
	CGMutablePathRef path = CGPathCreateMutable();
	UIColor *color;
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGFloat parentX = [self relativeParentXPosition];
	
	//Determine Size
	rect = self.bounds;
	rect.size.width -= stroke + 14;
	rect.size.height -= stroke + CalloutMapAnnotationViewHeightAboveParent - self.offsetFromParent.y + CalloutMapAnnotationViewBottomShadowBufferSize;
	rect.origin.x += stroke / 2.0 + 7;
	rect.origin.y += stroke / 2.0;
	
	//Create Path For Callout Bubble
	CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y + radius);
	CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height - radius);
	CGPathAddArc(path, NULL, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, 
				 radius, M_PI, M_PI / 2, 1);
	CGPathAddLineToPoint(path, NULL, parentX - 15, 
						 rect.origin.y + rect.size.height);
	CGPathAddLineToPoint(path, NULL, parentX, 
						 rect.origin.y + rect.size.height + 15);
	CGPathAddLineToPoint(path, NULL, parentX + 15, 
						 rect.origin.y + rect.size.height);
	CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width - radius, 
						 rect.origin.y + rect.size.height);
	CGPathAddArc(path, NULL, rect.origin.x + rect.size.width - radius, 
				 rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
	CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width, rect.origin.y + radius);
	CGPathAddArc(path, NULL, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, 
				 radius, 0.0f, -M_PI / 2, 1);
	CGPathAddLineToPoint(path, NULL, rect.origin.x + radius, rect.origin.y);
	CGPathAddArc(path, NULL, rect.origin.x + radius, rect.origin.y + radius, radius, 
				 -M_PI / 2, M_PI, 1);
	CGPathCloseSubpath(path);
	
	//Fill Callout Bubble & Add Shadow
	color = [[UIColor blackColor] colorWithAlphaComponent:.6];
	[color setFill];
	CGContextAddPath(context, path);
	CGContextSaveGState(context);
	CGContextSetShadowWithColor(context, CGSizeMake (0, self.yShadowOffset), 6, [UIColor colorWithWhite:0 alpha:.5].CGColor);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
	
	//Stroke Callout Bubble
	color = [[UIColor greenColor] colorWithAlphaComponent:.9];
	[color setStroke];
	CGContextSetLineWidth(context, stroke);
	CGContextSetLineCap(context, kCGLineCapSquare);
	CGContextAddPath(context, path);
	CGContextStrokePath(context);
	
	//Determine Size for Gloss
	CGRect glossRect = self.bounds;
	glossRect.size.width = rect.size.width - stroke;
	glossRect.size.height = (rect.size.height - stroke) / 2;
	glossRect.origin.x = rect.origin.x + stroke / 2;
	glossRect.origin.y += rect.origin.y + stroke / 2;
	
	CGFloat glossTopRadius = radius - stroke / 2;
	CGFloat glossBottomRadius = radius / 1.5;
	
	//Create Path For Gloss
	CGMutablePathRef glossPath = CGPathCreateMutable();
	CGPathMoveToPoint(glossPath, NULL, glossRect.origin.x, glossRect.origin.y + glossTopRadius);
	CGPathAddLineToPoint(glossPath, NULL, glossRect.origin.x, glossRect.origin.y + glossRect.size.height - glossBottomRadius);
	CGPathAddArc(glossPath, NULL, glossRect.origin.x + glossBottomRadius, glossRect.origin.y + glossRect.size.height - glossBottomRadius, 
				 glossBottomRadius, M_PI, M_PI / 2, 1);
	CGPathAddLineToPoint(glossPath, NULL, glossRect.origin.x + glossRect.size.width - glossBottomRadius, 
						 glossRect.origin.y + glossRect.size.height);
	CGPathAddArc(glossPath, NULL, glossRect.origin.x + glossRect.size.width - glossBottomRadius, 
				 glossRect.origin.y + glossRect.size.height - glossBottomRadius, glossBottomRadius, M_PI / 2, 0.0f, 1);
	CGPathAddLineToPoint(glossPath, NULL, glossRect.origin.x + glossRect.size.width, glossRect.origin.y + glossTopRadius);
	CGPathAddArc(glossPath, NULL, glossRect.origin.x + glossRect.size.width - glossTopRadius, glossRect.origin.y + glossTopRadius, 
				 glossTopRadius, 0.0f, -M_PI / 2, 1);
	CGPathAddLineToPoint(glossPath, NULL, glossRect.origin.x + glossTopRadius, glossRect.origin.y);
	CGPathAddArc(glossPath, NULL, glossRect.origin.x + glossTopRadius, glossRect.origin.y + glossTopRadius, glossTopRadius, 
				 -M_PI / 2, M_PI, 1);
	CGPathCloseSubpath(glossPath);
	
	//Fill Gloss Path	
	CGContextAddPath(context, glossPath);
	CGContextClip(context);
	CGFloat colors[] =
	{
		1, 1, 1, .3,
		1, 1, 1, .1,
	};
	CGFloat locations[] = { 0, 1.0 };
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, colors, locations, 2);
	CGPoint startPoint = glossRect.origin;
	CGPoint endPoint = CGPointMake(glossRect.origin.x, glossRect.origin.y + glossRect.size.height);
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	
	//Gradient Stroke Gloss Path	
	CGContextAddPath(context, glossPath);
	CGContextSetLineWidth(context, 2);
	CGContextReplacePathWithStrokedPath(context);
	CGContextClip(context);
	CGFloat colors2[] =
	{
		1, 1, 1, .3,
		1, 1, 1, .1,
		1, 1, 1, .0,
	};
	CGFloat locations2[] = { 0, .1, 1.0 };
	CGGradientRef gradient2 = CGGradientCreateWithColorComponents(space, colors2, locations2, 3);
	CGPoint startPoint2 = glossRect.origin;
	CGPoint endPoint2 = CGPointMake(glossRect.origin.x, glossRect.origin.y + glossRect.size.height);
	CGContextDrawLinearGradient(context, gradient2, startPoint2, endPoint2, 0);
	
	//Cleanup
	CGPathRelease(path);
	CGPathRelease(glossPath);
	CGColorSpaceRelease(space);
	CGGradientRelease(gradient);
	CGGradientRelease(gradient2);
}

- (CGFloat)yShadowOffset {
	if (!_yShadowOffset) {
		float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
		if (osVersion >= 3.2) {
			_yShadowOffset = 6;
		} else {
			_yShadowOffset = -6;
		}
		
	}
	return _yShadowOffset;
}

- (CGFloat)relativeParentXPosition {
	CGPoint parentOrigin = [self.mapView convertPoint:self.parentAnnotationView.frame.origin 
											 fromView:self.parentAnnotationView.superview];
	return parentOrigin.x + self.offsetFromParent.x;
}

- (UIView *)contentView {
	if (!_contentView) {
		_contentView = [[UIView alloc] init];
		self.contentView.backgroundColor = [UIColor clearColor];
		self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		[self addSubview:self.contentView];
	}
	return _contentView;
}

- (void)dealloc {
	self.parentAnnotationView = nil;
	self.mapView = nil;
	//[_contentView release];
    //[super dealloc];
}

@end
