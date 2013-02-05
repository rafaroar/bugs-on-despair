//
//  Missile.h
//  flyvsplants1
//
//  Created by Rafael Rodríguez Arguedas on 31/01/13.
//
//

#import "kobold2d.h"

@interface Missile : CCSprite
{
    CCAction *move;
    CCAnimation *moving;
    NSMutableArray *missys;
}
@property float direcx;
@property float direcy;
@property float reorder;
-(id) initWithMissileAnimation;
-(id) initWithMissileAnimationLeft;
@end
