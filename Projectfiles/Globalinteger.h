//
//  StartLayer.h
//  thelifegame1
//
//  Created by Andrea Rodríguez Arguedas on 23/01/13.
//
//

#import "kobold2d.h"
int global = 0;

@interface StartLayer : CCLayer
-(void) draw;
-(id) init;
-(void) startg: (CCMenuItem  *) menuItem;
@end
