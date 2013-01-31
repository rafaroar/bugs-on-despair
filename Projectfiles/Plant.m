//
//  Plant.m
//  thelifegame1
//
//  Created by Andrea Rodríguez Arguedas on 22/01/13.
//
//

#import "Plant.h"

@interface Plant (PrivateMethods)

@end

@implementation Plant
@synthesize grow;
@synthesize currentlife;

-(id) initWithPlantImage
{
    // This calls CCSprite's init. Basically this init method does everything CCSprite's init method does and then more
    if ((self = [super initWithFile:@"transparent.png"]))
    {
        grow = 0;
        currentlife = 0;
        //properties work internally just like normal instance variables
    }
    return self;
}
@end



