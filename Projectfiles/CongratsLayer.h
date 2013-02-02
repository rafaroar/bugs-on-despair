//
//  CongratsLayer.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 23/01/13.
//
//

#import "kobold2d.h"

@class Bee;

@interface CongratsLayer : CCLayer
{
    CCSprite *congrats;
    CCSprite *playagain;
    Bee *bee;
    int counte;
    float beex;
    float beey;
}

-(void) draw;
-(id) init;
-(void) gotolevel1: (CCMenuItem  *) menuItem;
-(void) gotolevel2: (CCMenuItem  *) menuItem;
@end
