//
//  Global.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 02/02/13.
//
//

#import "kobold2d.h"

#define Y_OFF_SET 80
#define WIDTH_WINDOW 320
#define HEIGHT_WINDOW 480
#define WIDTH_GAME WIDTH_WINDOW
#define HEIGHT_GAME (HEIGHT_WINDOW - 80)

@interface Global : NSObject
{
    int level;
    int levelunlocked;
    int statu;
}
@property int level;
@property int levelunlocked;
@property int statu;
+ (id)sharedManager;
@end
