//
//  Bee.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "kobold2d.h"

@interface Bee : CCSprite
-(id) initWithBeeAnimation;
-(float) moveBeeX: (int)counte high: (float)ranx;
-(float) moveBeeY: (int)counte high: (float)rany;
@end
