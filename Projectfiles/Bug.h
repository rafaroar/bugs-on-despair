//
//  Bug.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 03/02/13.
//
//

#import "kobold2d.h"

@interface Bug : CCSprite
@property float ranx;
@property float rany;
@property float speedd;
-(void) setBugSpeed: (float) bugspeed;
-(void) moveBug: (int)counte;
@end