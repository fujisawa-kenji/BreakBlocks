//
//  BreakBlocksScene.h
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#ifndef __BreakBlocks__BreakBlocksScene__
#define __BreakBlocks__BreakBlocksScene__

#include "cocos2d.h"
#include "BreakBlocksPresenter.h"
#include "PropertyChangedEventHandler.h"

using namespace cocos2d;

class BreakBlocksScene : public cocos2d::CCLayer
{
private:
    BreakBlocksPresenter* presenter;
    
    CCNode* ball;
    CCNode* bar;
    std::vector<CCSprite*> blocks;
    CCLabelTTF* label;
    
    void update(float tick);
    
    PropertyChangedEventHandler<BreakBlocksScene>* ballChangedHandler;
    PropertyChangedEventHandler<BreakBlocksScene>* barChangedHandler;
    PropertyChangedEventHandler<BreakBlocksScene>* blockChangedHandler;
    
    void onBallPropertyChanged(void* sender, PropertyChangedEventArgsBase* e);
    void onBarPropertyChanged(void* sender, PropertyChangedEventArgsBase* e);
    void onBlockPropertyChanged(void* sender, PropertyChangedEventArgsBase* e);
    
public:
    BreakBlocksScene();
    ~BreakBlocksScene();
    
    static cocos2d::CCScene* scene();
    virtual bool init();
    CREATE_FUNC(BreakBlocksScene);
    
    virtual bool ccTouchBegan(CCTouch* pTouch, CCEvent* pEvent);
    virtual void ccTouchMoved(CCTouch* pTouch, CCEvent* pEvent);
    virtual void ccTouchEnded(CCTouch* pTouch, CCEvent* pEvent);
};

#endif /* defined(__BreakBlocks__BreakBlocksScene__) */
