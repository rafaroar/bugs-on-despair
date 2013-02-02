//
//  CongratsLayer2.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 24/01/13.
//
//

#import "kobold2d.h"

@interface CongratsLayer2 : CCLayer
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
-(void) gotolevel3: (CCMenuItem  *) menuItem;
@end
