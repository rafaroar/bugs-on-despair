//
//  CongratsLayer.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 23/01/13.
//
//

#import "kobold2d.h"

@interface CongratsLayer : CCLayer
{
    CCSprite *congrats;
    CCSprite *playagain;
    CCSprite *fly;
    CCAction *move;
    NSMutableArray *flies;
    int counte;
    int ranx;
    int rany;
}

-(void) draw;
-(id) init;
-(void) gotolevel1: (CCMenuItem  *) menuItem;
-(void) gotolevel2: (CCMenuItem  *) menuItem;
@end
