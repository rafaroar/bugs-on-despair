//
//  CongratsLayer5.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 01/02/13.
//
//

@class Redbug;

@interface CongratsLayer5 : CCLayer
{
    CCSprite *congrats;
    CCSprite *playagain;
    Redbug *rbug;
    int counte;
    int ranx;
    int rany;
}
-(void) draw;
-(id) init;
-(void) gotolevel1: (CCMenuItem  *) menuItem;
-(void) gotolevel2: (CCMenuItem  *) menuItem;
-(void) gotolevel3: (CCMenuItem  *) menuItem;
-(void) gotolevel4: (CCMenuItem  *) menuItem;
-(void) gotolevel5: (CCMenuItem  *) menuItem;
@end
