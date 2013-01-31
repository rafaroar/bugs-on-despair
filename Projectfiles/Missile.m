//
//  Missile.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "Missile.h"

@interface Missile (PrivateMethods)

@end

@implementation Missile
@synthesize direcx;
@synthesize direcy;

-(id) initWithMissileImage
{
    // This calls CCSprite's init. Basically this init method does everything CCSprite's init method does and then more
    if ((self = [super initWithFile:@"ship.png"]))
    {
        direcx = 0;
        direcy = 0;
        //properties work internally just like normal instance variables
    }
    return self;
}

@end
