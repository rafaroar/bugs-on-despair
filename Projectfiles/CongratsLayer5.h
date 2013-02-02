//
//  CongratsLayer5.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 01/02/13.
//
//

#import "kobold2d.h"

@interface CongratsLayer5 : CCLayer
{
    CCSprite *congrats;
    CCSprite *playagain;
    CCSprite *fly;
    CCSprite *bee;
    CCAction *move;
    CCAction *move2;
    NSMutableArray *flies;
    NSMutableArray *bees;
    int counte;
    int ranx;
    int rany;
    int beex;
    int beey;
}
-(void) draw;
-(id) init;
-(void) gotolevel1: (CCMenuItem  *) menuItem;
-(void) gotolevel2: (CCMenuItem  *) menuItem;
-(void) gotolevel3: (CCMenuItem  *) menuItem;
-(void) gotolevel4: (CCMenuItem  *) menuItem;
-(void) gotolevel5: (CCMenuItem  *) menuItem;
@end
