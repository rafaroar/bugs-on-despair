//
//  Missile.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
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

-(id) initWithMissileAnimation;
@end