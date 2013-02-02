/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "kobold2d.h"

@class Bee, Plant;

@interface Level1 : CCLayer
{
    Bee *fly;
    CCSprite *scissors;
    CCSprite *selscissors;
    CCSprite *redselscissors;
    CCSprite *announcement;
    CCSprite *connt;
    Plant *newplant;
    CCTexture2D* redclosedscissors;
    CCTexture2D* blueclosedscissors;
    CCProgressTimer* powerBar;
    CCMenu *pausemenu;
    
    NSMutableArray *carnivores;
    NSMutableArray *allplants;
    NSMutableArray *carnplants;
    NSMutableArray *catchingplants;
    
    int counte;
    float ranx;
    float rany;
    int weapon;
    int nplant;
}
-(id) init;
-(void) draw;

@end
