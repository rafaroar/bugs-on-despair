//
//  MissilePlant.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "MissilePlant.h"

@interface MissilePlant (PrivateMethods)

@end

@implementation MissilePlant
@synthesize grow;
@synthesize thrower;

-(id) initWithPlantImage
{
    plantex1 = [[CCTextureCache sharedTextureCache] addImage:@"thrower1.png"];
    plantex2 = [[CCTextureCache sharedTextureCache] addImage:@"thrower2.png"];
    plantex3 = [[CCTextureCache sharedTextureCache] addImage:@"thrower3.png"];
    plantex4 = [[CCTextureCache sharedTextureCache] addImage:@"thrower4.png"];
    plantex5 = [[CCTextureCache sharedTextureCache] addImage:@"thrower5.png"];
    plantex6 = [[CCTextureCache sharedTextureCache] addImage:@"thrower6.png"];
    plantex7 = [[CCTextureCache sharedTextureCache] addImage:@"thrower7.png"];
    plantex8 = [[CCTextureCache sharedTextureCache] addImage:@"thrower8.png"];
    plantex9 = [[CCTextureCache sharedTextureCache] addImage:@"thrower9.png"];
    plantex10 = [[CCTextureCache sharedTextureCache] addImage:@"thrower10.png"];
    shooting1 = [[CCTextureCache sharedTextureCache] addImage:@"throwright1.png"];
    shooting2 = [[CCTextureCache sharedTextureCache] addImage:@"throwright2.png"];
    
    if ((self = [super initWithTexture:plantex1]))
    {
        grow = 0;
        thrower = 0;
    }
    return self;
}

-(void) growMiss: (NSMutableArray*)throwers
{
    if (self.grow==0)
    {
        [self setTexture: plantex2];
        self.grow++;
    }
    else if (self.grow==1)
    {
        [self setTexture: plantex3];
        self.grow++;
    }
    else if (self.grow==2)
    {
        [self setTexture: plantex4];
        self.grow++;
    }
    else if (self.grow==3)
    {
        [self setTexture: plantex5];
        self.grow++;
    }
    else if (self.grow==4)
    {
        [self setTexture: plantex6];
        self.grow++;
    }
    else if (self.grow==5)
    {
        [self setTexture: plantex7];
        self.grow++;
    }
    else if (self.grow==6)
    {
        [self setTexture: plantex8];
        self.grow++;
        [throwers addObject:self];
    }
    else
    {
        if (self.thrower==1)
        {
            [self setTexture: plantex10];
        }
        else if (self.thrower==0)
        {
            [self setTexture: plantex9];
        }
    }
}

@end
