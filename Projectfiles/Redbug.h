//
//  Redbug.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "kobold2d.h"
#import "Bug.h"

@interface Redbug : Bug
{
    CCAction *move;
    CCAnimation *moving;
    NSMutableArray *redbugs;
}
@property float speed;
-(id) initWithRedbugAnimation;
@end
