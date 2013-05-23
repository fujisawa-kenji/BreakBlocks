//
//  BreakBlocksScene.cpp
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#include "BreakBlocksScene.h"

BreakBlocksScene::BreakBlocksScene()
{
    this->ballChangedHandler = new PropertyChangedEventHandler<BreakBlocksScene>();
    this->ballChangedHandler->setDelegate(this, &BreakBlocksScene::onBallPropertyChanged);
    
    this->barChangedHandler = new PropertyChangedEventHandler<BreakBlocksScene>();
    this->barChangedHandler->setDelegate(this, &BreakBlocksScene::onBarPropertyChanged);
    
    this->blockChangedHandler = new PropertyChangedEventHandler<BreakBlocksScene>();
    this->blockChangedHandler->setDelegate(this, &BreakBlocksScene::onBlockPropertyChanged);
}

BreakBlocksScene::~BreakBlocksScene()
{
    if (this->ballChangedHandler != NULL)
        delete this->ballChangedHandler;
    if (this->barChangedHandler != NULL)
        delete this->barChangedHandler;
    if (this->blockChangedHandler != NULL)
        delete this->blockChangedHandler;
}

CCScene* BreakBlocksScene::scene()
{
    CCScene *scene = CCScene::create();
    BreakBlocksScene *layer = BreakBlocksScene::create();
    scene->addChild(layer);
    return scene;
}

bool BreakBlocksScene::init()
{
    if (!CCLayer::init())
    {
        return false;
    }
    
    CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this, 0, true);
    
    auto size = CCDirector::sharedDirector()->getWinSize();
    auto center = ccp(size.width * 0.5f, size.height * 0.5f);
    
    this->presenter = new BreakBlocksPresenter();
    this->presenter->initialize(0.0f, 0.0f, size.width, size.height);
    
    auto ball = this->presenter->getBall();
    ball->addListener(this->ballChangedHandler);
    
    this->ball = CCSprite::create("ball.png");
    this->ball->setPosition(ball->getCenterX(), ball->getCenterY());
    this->addChild(this->ball);
    
    auto bar = this->presenter->getBar();
    bar->addListener(this->barChangedHandler);
    
    this->bar = CCSprite::create("bar.png");
    this->bar->setPosition(bar->getCenterX(), bar->getCenterY());
    this->addChild(this->bar);
    
    auto blockTexture = CCTextureCache::sharedTextureCache()->addImage("block.png");
    for (int i = 0; i < this->presenter->getBlockCount(); i++)
    {
        auto b = this->presenter->getBlock(i);
        b->addListener(this->blockChangedHandler);
        
        auto block = CCSprite::createWithTexture(blockTexture);
        block->setPositionX(b->getCenterX());
        block->setPositionY(b->getCenterY());
        block->setTag(b->getId());
        this->blocks.push_back(block);
        this->addChild(block);
    }
    
    this->label = CCLabelTTF::create("", "Thonburi", 50.0f);
    this->label->setPosition(center);
    this->addChild(this->label, 100);
    
    this->schedule(schedule_selector(BreakBlocksScene::update));
    
    return true;
}

void BreakBlocksScene::update(float tick)
{
    switch (this->presenter->getStatus())
    {
        case Ready:
        {
            this->label->setString("READY");
            break;
        }
        case Running:
        {
            this->presenter->updateStates();
            break;
        }
        case Clear:
        case GameOver:
        {
            this->unschedule(schedule_selector(BreakBlocksScene::update));
            
            this->ball->removeFromParentAndCleanup(true);
            
            auto msg = this->presenter->getStatus() == Clear ? "CLEAR" : "GAME OVER";
            this->label->setString(msg);
            
            break;
        }
    }
}

void BreakBlocksScene::onBallPropertyChanged(void *sender, PropertyChangedEventArgsBase *e)
{
    if (strcmp(e->getPropertyName(), "centerX") == 0)
    {
        auto arg = (PropertyChangedEventArgs<float>*)e;
        this->ball->setPositionX(arg->getNewValue());
    }
    if (strcmp(e->getPropertyName(), "centerY") == 0)
    {
        auto arg = (PropertyChangedEventArgs<float>*)e;
        this->ball->setPositionY(arg->getNewValue());
    }
}

void BreakBlocksScene::onBarPropertyChanged(void *sender, PropertyChangedEventArgsBase *e)
{
    if (strcmp(e->getPropertyName(), "centerX") == 0)
    {
        auto arg = (PropertyChangedEventArgs<float>*)e;
        this->bar->setPositionX(arg->getNewValue());
    }
    if (strcmp(e->getPropertyName(), "centerY") == 0)
    {
        auto arg = (PropertyChangedEventArgs<float>*)e;
        this->bar->setPositionY(arg->getNewValue());
    }
}

void BreakBlocksScene::onBlockPropertyChanged(void *sender, PropertyChangedEventArgsBase *e)
{
    if (strcmp(e->getPropertyName(), "durability") == 0)
    {
        auto arg = (PropertyChangedEventArgs<int>*)e;
        if (arg->getNewValue() == 0)
        {
            auto block = this->getChildByTag(((Block*)sender)->getId());
            block->removeFromParentAndCleanup(true);
        }
    }
}

bool BreakBlocksScene::ccTouchBegan(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    return true;
}

void BreakBlocksScene::ccTouchMoved(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    if (this->presenter->getStatus() == Running)
    {
        auto position = pTouch->getLocation();
        this->presenter->moveBar(position.x, position.y);
    }
}

void BreakBlocksScene::ccTouchEnded(cocos2d::CCTouch *pTouch, cocos2d::CCEvent *pEvent)
{
    switch (this->presenter->getStatus())
    {
        case Ready:
        {
            this->label->setString("");
            this->presenter->startGame();
            break;
        }
        case Clear:
        case GameOver:
        {
            auto scene = BreakBlocksScene::scene();
            CCDirector::sharedDirector()->replaceScene(scene);
            break;
        }
        default:
            break;
    }
}
