//
//  Fly.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "kobold2d.h"

@interface Fly : CCSprite
{
    CCAction *move;
    CCAnimation *moving;
    NSMutableArray *flies;
}

-(id) initWithFlyAnimation;
-(float) moveFlyX: (int)counte high: (float)ranx;
-(float) moveFlyY: (int)counte high: (float)rany;
@end