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
@synthesize shoot;
@synthesize side;

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
    shootingleft1 = [[CCTextureCache sharedTextureCache] addImage:@"throwleft1.png"];
    shootingleft2 = [[CCTextureCache sharedTextureCache] addImage:@"throwleft2.png"];
    
    if ((self = [super initWithTexture:plantex1]))
    {
        grow = 0;
        thrower = 0;
        shoot = 0;
        side = 0;
    }
    if(!self)
        return nil;
    return self;
}

-(void) growMiss: (NSMutableArray*)throwers
{
    if (self.grow < 7)
    {
        if (self.grow==0)
        {
            [self setTexture: plantex2];
        }
        else if (self.grow==1)
        {
            [self setTexture: plantex3];
        }
        else if (self.grow==2)
        {
            [self setTexture: plantex4];
        }
        else if (self.grow==3)
        {
            [self setTexture: plantex5];
        }
        else if (self.grow==4)
        {
            [self setTexture: plantex6];
        }
        else if (self.grow==5)
        {
            [self setTexture: plantex7];
        }
        else if (self.grow==6)
        {
            [self setTexture: plantex8];
            [throwers addObject:self];
        }
        self.grow++;
    }
    if (self.thrower > 0)
    {
        if (self.thrower==1)
        {
            [self setTexture: plantex9];
            self.thrower--;
        }
        else if (self.thrower==2)
        {
            [self setTexture: plantex10];
            self.thrower--;
        }
        else if (self.thrower==3)
        {
            if (self.side == 0)
            {
                [self setTexture: shooting1];
            }
            else
            {
                [self setTexture: shootingleft1];
            }
        }
        else if (self.thrower==7)
        {
            if (self.side == 0)
            {
                [self setTexture: shooting1];
            }
            else
            {
                [self setTexture: shootingleft1];
            }
        }
        else if (self.thrower==11)
        {
            if (self.side == 0)
            {
                [self setTexture: shooting1];
            }
            else
            {
                [self setTexture: shootingleft1];
            }
        }
        else if (self.thrower==15)
        {
            [self setTexture: plantex10];
        }
        else if (self.thrower==19)
        {
            [self setTexture: plantex9];
        }
        else if (self.thrower==23)
        {
            [self setTexture: plantex8];
            self.thrower=-1;
            self.shoot=0;
        }
        self.thrower++;
    }
}

@end
