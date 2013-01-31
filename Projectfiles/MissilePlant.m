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

CCTexture2D* plantex1;
CCTexture2D* plantex2;
CCTexture2D* plantex3;
CCTexture2D* plantex4;
CCTexture2D* plantex5;
CCTexture2D* plantex6;
CCTexture2D* plantex7;
CCTexture2D* plantex8;
CCTexture2D* plantex9;

-(id) initWithPlantImage
{
    plantex1 = [[CCTextureCache sharedTextureCache] addImage:@"carniv1.png"];
    plantex2 = [[CCTextureCache sharedTextureCache] addImage:@"carniv2.png"];
    plantex3 = [[CCTextureCache sharedTextureCache] addImage:@"carniv3.png"];
    plantex4 = [[CCTextureCache sharedTextureCache] addImage:@"carniv4.png"];
    plantex5 = [[CCTextureCache sharedTextureCache] addImage:@"carniv5.png"];
    plantex6 = [[CCTextureCache sharedTextureCache] addImage:@"carniv6.png"];
    plantex7 = [[CCTextureCache sharedTextureCache] addImage:@"carniv7.png"];
    plantex8 = [[CCTextureCache sharedTextureCache] addImage:@"carniv8.png"];
    plantex9 = [[CCTextureCache sharedTextureCache] addImage:@"redbug1.png"];
    
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
    }
    else if (self.grow==7)
    {
        [self setTexture: plantex9];
        self.grow++;
        [throwers addObject:self];
    }
}

@end
