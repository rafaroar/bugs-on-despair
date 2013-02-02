//
//  Redbug.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "kobold2d.h"

@interface Redbug : CCSprite
{
    CCAction *move;
    CCAnimation *moving;
    NSMutableArray *redbugs;
}
-(id) initWithRedbugAnimation;
-(float) moveRedbugX: (int)counte high: (float)ranx;
-(float) moveRedbugY: (int)counte high: (float)rany;
@end
