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
@synthesize hunger;

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
    plantex9 = [[CCTextureCache sharedTextureCache] addImage:@"carniv9.png"];
    plantex11 = [[CCTextureCache sharedTextureCache] addImage:@"carniv11.png"];
    plantex12 = [[CCTextureCache sharedTextureCache] addImage:@"carniv12.png"];
    plantex13 = [[CCTextureCache sharedTextureCache] addImage:@"carniv13.png"];
    
    if ((self = [super initWithTexture:plantex1]))
    {
        grow = 0;
        hunger = 0;
    }
    if(!self)
        return nil;
    return self;
}

-(void) growPlant: (NSMutableArray*)carnivores
{
    if (self.grow < 8)
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
        }
        else if (self.grow==7)
        {
            [self setTexture: plantex9];
            [carnivores addObject:self];
        }
        self.grow++;
    }
    if (self.hunger > 0)
    {
        if (self.hunger == 2)
        {
            [self setTexture: plantex11];
        }
        else if (self.hunger == 3)
        {
            [self setTexture: plantex12];
        }
        else if (self.hunger == 4)
        {
            [self setTexture: plantex13];
        }
        else if (self.hunger == 50)
        {
            [self setTexture: plantex12];
        }
        else if (self.hunger == 55)
        {
            [self setTexture: plantex11];
        }
        else if (self.hunger == 60)
        {
            [self setTexture: plantex9];
            [carnivores addObject:self];
            self.hunger = -1;
        }
        self.hunger++;
    }
}

@end
