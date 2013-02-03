//
//  Bug.m
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 03/02/13.
//
//

#import "Bug.h"

@interface Bug (PrivateMethods)
@end

@implementation Bug
@synthesize ranx;
@synthesize rany;
@synthesize speedd;

-(void) setBugSpeed: (float) bugspeed
{
        ranx = 0;
        rany = 0;
        speedd = bugspeed;
}

-(void) moveBug: (int)counte
{
    int ran = counte % 10;
    ranx = ranx + 10 - arc4random()%21;
    if (ran==1)
    {
        ranx = ranx + 50 - arc4random()%101;
    }
    ranx = ranx - (self.position.x - 160)/50.0f;
    if ((self.position.x > 140) && (self.position.x < 180))
    {
        ranx = ranx + (self.position.x - 160)/5.0f;
    }
    if ((self.position.x > 20) && (self.position.x < 300))
    {
        self.position = ccp( self.position.x + ranx*speedd, self.position.y);
    }
    if (self.position.x >= 300)
    {
        self.position = ccp( 299, self.position.y );
        ranx = -20;
    }
    if (self.position.x <= 20)
    {
        self.position = ccp( 21, self.position.y );
        ranx = 20;
    }
    
    rany = rany + 10 - arc4random()%21;
    if (ran==1)
    {
        rany = rany + 50 - arc4random()%101;
    }
    rany = rany - (self.position.y - 280)/50.0f;
    if ((self.position.y > 260) && (self.position.y < 300))
    {
        rany = rany + (self.position.y - 280)/5.0f;
    }
    if ((self.position.y > 100) && (self.position.y < 460))
    {
        self.position = ccp( self.position.x, self.position.y + rany*speedd);
    }
    if (self.position.y <= 100)
    {
        self.position = ccp( self.position.x, 101 );
        rany = 20;
    }
    if (self.position.y >= 460)
    {
        self.position = ccp( self.position.x, 459 );
        rany = -20;
    }
}

@end
