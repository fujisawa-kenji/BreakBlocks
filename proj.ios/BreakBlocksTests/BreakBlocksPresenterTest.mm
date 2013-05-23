//
//  BreakBlocksPresenterTest.m
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/06.
//
//

#import "BreakBlocksPresenterTest.h"
#import "BreakBlocksPresenter.h"
#import <typeinfo>

@implementation BreakBlocksPresenterTest

- (void)testInitializer
{
    BlockInitializerMock initializer;
    BreakBlocksPresenter presenter;
    
    presenter.setInitializer(&initializer);
    STAssertTrue(presenter.getInitializer() == &initializer, @"initializer expected %s, but was %s", typeid(presenter.getInitializer()).name(), typeid(initializer).name());
}

- (void)testInitialize
{
    Ball ball;
    Bar bar;
    Block block;
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = &bar;
    initializer.block = &block;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(1.1f, 2.2f, 3.3f, 4.4f);
    
    STAssertTrue(presenter.getBall() == &ball, @"ball expected %s, but was %s", typeid(ball).name(), typeid(presenter.getBall()).name());
    
    STAssertTrue(presenter.getBar() == &bar, @"bar expected %s, but was %s", typeid(bar).name(), typeid(presenter.getBar()).name());
    
    auto field = presenter.getGameField();
    STAssertEquals(1.1f, field->getX(), @"field.x expected %f, but was %f", 1.1f, field->getX());
    STAssertEquals(2.2f, field->getY(), @"field.y expected %f, but was %f", 2.2f, field->getY());
    STAssertEquals(3.3f, field->getWidth(), @"field.width expected %f, but was %f", 3.3f, field->getWidth());
    STAssertEquals(4.4f, field->getHeight(), @"field.height expected %f, but was %f", 4.4f, field->getHeight());
    
    STAssertEquals(initializer.getInitialBlockCount(), presenter.getBlockCount(), @"block count expected %d, but was %d", initializer.getInitialBlockCount(), presenter.getBlockCount());
    STAssertTrue(presenter.getBlock(-1) == NULL, @"block(-1) expected NULL, but was not NULL");
    STAssertTrue(presenter.getBlock(0) == &block, @"block(0) expected %s, but was %s", typeid(block).name(), typeid(presenter.getBlock(0)).name());
    STAssertTrue(presenter.getBlock(1) == NULL, @"block(1) expected NULL, but was not NULL");
    
    STAssertEquals(Ready, presenter.getStatus(), @"status expected %d, but was %d", Ready, presenter.getStatus());
}

- (void)testStartGame
{
    Ball ball;
    ball.setCenterX(1.0f);
    ball.setCenterY(2.0f);
    ball.setDX(1.0f);
    ball.setDY(2.0f);
    
    Block block;
    block.setDurability(1);
    
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = NULL;
    initializer.block = &block;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    
    STAssertEquals(Ready, presenter.getStatus(), @"status expected %d, but was %d", Ready, presenter.getStatus());
    STAssertEquals(1.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 1.0f, ball.getCenterX());
    STAssertEquals(2.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 2.0f, ball.getCenterY());
    
    presenter.updateStates();
    
    STAssertEquals(Ready, presenter.getStatus(), @"status expected %d, but was %d", Ready, presenter.getStatus());
    STAssertEquals(1.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 1.0f, ball.getCenterX());
    STAssertEquals(2.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 2.0f, ball.getCenterY());
    
    presenter.startGame();
    
    STAssertEquals(Running, presenter.getStatus(), @"status expected %d, but was %d", Running, presenter.getStatus());
    STAssertEquals(1.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 1.0f, ball.getCenterX());
    STAssertEquals(2.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 2.0f, ball.getCenterY());
    
    presenter.updateStates();
    
    STAssertEquals(Running, presenter.getStatus(), @"status expected %d, but was %d", Running, presenter.getStatus());
    STAssertEquals(2.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 2.0f, ball.getCenterX());
    STAssertEquals(4.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 4.0f, ball.getCenterY());
    
    presenter.updateStates();
    
    STAssertEquals(Running, presenter.getStatus(), @"status expected %d, but was %d", Running, presenter.getStatus());
    STAssertEquals(3.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 3.0f, ball.getCenterX());
    STAssertEquals(6.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 6.0f, ball.getCenterY());
}

- (void)testIntersectsWithBlocks
{
    Block block;
    block.setCenterX(150.0f);
    block.setCenterY(150.0f);
    block.setWidth(50.0f);
    block.setHeight(50.0f);
    block.setDurability(1);
    
    BlockInitializerMock initializer;
    initializer.ball = NULL;
    initializer.bar = NULL;
    initializer.block = &block;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    
    Block b1;
    b1.setCenterX(50.0f);
    b1.setCenterY(50.0f);
    b1.setWidth(50.0f);
    b1.setHeight(50.0f);
    STAssertFalse(presenter.intersectsWithBlocks(&b1), @"intersectsWithBlocks(b1) expected false, but was true");
    
    Block b2;
    b2.setCenterX(100.0f);
    b2.setCenterY(100.0f);
    b2.setWidth(100.0f);
    b2.setHeight(100.0f);
    STAssertTrue(presenter.intersectsWithBlocks(&b2), @"intersectsWithBlocks(b2) expected true, but was false");
    
    STAssertFalse(presenter.intersectsWithBlocks(&block), @"intersectsWithBlocks(block) expected false, but was true");
}

- (void)testUpdateBallPosition
{
    Ball ball;
    ball.setCenterX(1.0f);
    ball.setCenterY(2.0f);
    ball.setDX(1.0f);
    ball.setDY(2.0f);
    
    Block block;
    block.setDurability(1);
    
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = NULL;
    initializer.block = &block;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    presenter.startGame();
    
    STAssertEquals(1.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 1.0f, ball.getCenterX());
    STAssertEquals(2.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 2.0f, ball.getCenterY());
    
    presenter.updateStates();
    
    STAssertEquals(2.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 2.0f, ball.getCenterX());
    STAssertEquals(4.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 4.0f, ball.getCenterY());
    
    presenter.updateStates();
    
    STAssertEquals(3.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 3.0f, ball.getCenterX());
    STAssertEquals(6.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 6.0f, ball.getCenterY());
}

- (void)testUpdateBoundsX
{
    Ball ball;
    ball.setCenterX(3.0f);
    ball.setCenterY(10.0f);
    ball.setWidth(3.0f);
    ball.setHeight(3.0f);
    ball.setDX(-2.0f);
    ball.setDY(2.0f);
    
    Block block;
    block.setDurability(1);
    
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = NULL;
    initializer.block = &block;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    presenter.startGame();
    
    STAssertEquals(3.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 3.0f, ball.getCenterX());
    STAssertEquals(10.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 10.0f, ball.getCenterY());
    STAssertEquals(-2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", -2.0f, ball.getDX());
    STAssertEquals(2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", 2.0f, ball.getDY());
    
    presenter.updateStates();
    
    STAssertEquals(1.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 1.0f, ball.getCenterX());
    STAssertEquals(12.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 12.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", 2.0f, ball.getDY());
    
    presenter.updateStates();
    
    STAssertEquals(3.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 3.0f, ball.getCenterX());
    STAssertEquals(14.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 14.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", 2.0f, ball.getDY());
}

- (void)testUpdateBoundsY
{
    Ball ball;
    ball.setCenterX(10.0f);
    ball.setCenterY(297.0f);
    ball.setWidth(3.0f);
    ball.setHeight(3.0f);
    ball.setDX(2.0f);
    ball.setDY(2.0f);
    
    Block block;
    block.setDurability(1);
    
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = NULL;
    initializer.block = &block;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    presenter.startGame();
    
    STAssertEquals(10.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 10.0f, ball.getCenterX());
    STAssertEquals(297.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 297.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", 2.0f, ball.getDY());
    
    presenter.updateStates();
    
    STAssertEquals(12.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 12.0f, ball.getCenterX());
    STAssertEquals(299.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 299.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(-2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", -2.0f, ball.getDY());
    
    presenter.updateStates();
    
    STAssertEquals(14.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 14.0f, ball.getCenterX());
    STAssertEquals(297.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 297.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(-2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", -2.0f, ball.getDY());
}

- (void)testUpdateStatesGameOver
{
    Ball ball;
    ball.setCenterX(10.0f);
    ball.setCenterY(3.0f);
    ball.setWidth(3.0f);
    ball.setHeight(3.0f);
    ball.setDX(2.0f);
    ball.setDY(-2.0f);
    
    Block block;
    block.setDurability(1);
    
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = NULL;
    initializer.block = &block;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    presenter.startGame();
    
    STAssertEquals(10.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 10.0f, ball.getCenterX());
    STAssertEquals(3.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 3.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(-2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", -2.0f, ball.getDY());
    STAssertEquals(Running, presenter.getStatus(), @"status expected %d, but was %d", Running, presenter.getStatus());
    
    presenter.updateStates();
    
    STAssertEquals(12.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 12.0f, ball.getCenterX());
    STAssertEquals(1.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 1.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(-2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", -2.0f, ball.getDY());
    STAssertEquals(Running, presenter.getStatus(), @"status expected %d, but was %d", Running, presenter.getStatus());
    
    presenter.updateStates();
    
    STAssertEquals(14.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 14.0f, ball.getCenterX());
    STAssertEquals(-1.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", -1.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(-2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", -2.0f, ball.getDY());
    STAssertEquals(GameOver, presenter.getStatus(), @"status expected %d, but was %d", GameOver, presenter.getStatus());
}

- (void)testUpdateStatsClear
{
    Ball ball;
    ball.setCenterX(50.0f);
    ball.setCenterY(50.0f);
    
    Block block;
    block.setDurability(0);
    
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = NULL;
    initializer.block = &block;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    presenter.startGame();
    
    STAssertEquals(Running, presenter.getStatus(), @"status expected %d, but was %d", Running, presenter.getStatus());
    
    presenter.updateStates();
    
    STAssertEquals(Clear, presenter.getStatus(), @"status expected %d, but was %d", Clear, presenter.getStatus());
}

- (void)testUpdateBoundsBlockX
{
    Ball ball;
    ball.setCenterX(87.0f);
    ball.setCenterY(87.0f);
    ball.setWidth(3.0f);
    ball.setHeight(3.0f);
    ball.setDX(2.0f);
    ball.setDY(2.0f);
    
    Block block;
    block.setCenterX(100.0f);
    block.setCenterY(100.0f);
    block.setWidth(20.0f);
    block.setHeight(40.0f);
    block.setDurability(1);
    
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = NULL;
    initializer.block = &block;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    presenter.startGame();
    
    STAssertEquals(87.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 87.0f, ball.getCenterX());
    STAssertEquals(87.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 87.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", 2.0f, ball.getDY());
    STAssertEquals(1, block.getDurability(), @"block.durability expected %d, but was %d", 1, block.getDurability());
    
    presenter.updateStates();
    
    STAssertEquals(89.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 89.0f, ball.getCenterX());
    STAssertEquals(89.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 89.0f, ball.getCenterY());
    STAssertEquals(-2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", -2.0f, ball.getDX());
    STAssertEquals(2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", 2.0f, ball.getDY());
    STAssertEquals(0, block.getDurability(), @"block.durability expected %d, but was %d", 0, block.getDurability());
}

- (void)testUpdateBoundsBlockY
{
    Ball ball;
    ball.setCenterX(87.0f);
    ball.setCenterY(87.0f);
    ball.setWidth(3.0f);
    ball.setHeight(3.0f);
    ball.setDX(2.0f);
    ball.setDY(2.0f);
    
    Block block;
    block.setCenterX(100.0f);
    block.setCenterY(100.0f);
    block.setWidth(40.0f);
    block.setHeight(20.0f);
    block.setDurability(1);
    
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = NULL;
    initializer.block = &block;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    presenter.startGame();
    
    STAssertEquals(87.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 87.0f, ball.getCenterX());
    STAssertEquals(87.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 87.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", 2.0f, ball.getDY());
    STAssertEquals(1, block.getDurability(), @"block.durability expected %d, but was %d", 1, block.getDurability());
    
    presenter.updateStates();
    
    STAssertEquals(89.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 89.0f, ball.getCenterX());
    STAssertEquals(89.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 89.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(-2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", -2.0f, ball.getDY());
    STAssertEquals(0, block.getDurability(), @"block.durability expected %d, but was %d", 0, block.getDurability());
}

- (void)testUpdateBoundsBlockXY
{
    Ball ball;
    ball.setCenterX(87.0f);
    ball.setCenterY(87.0f);
    ball.setWidth(3.0f);
    ball.setHeight(3.0f);
    ball.setDX(2.0f);
    ball.setDY(2.0f);
    
    Block block;
    block.setCenterX(100.0f);
    block.setCenterY(100.0f);
    block.setWidth(20.0f);
    block.setHeight(20.0f);
    block.setDurability(1);
    
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = NULL;
    initializer.block = &block;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    presenter.startGame();
    
    STAssertEquals(87.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 87.0f, ball.getCenterX());
    STAssertEquals(87.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 87.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", 2.0f, ball.getDY());
    STAssertEquals(1, block.getDurability(), @"block.durability expected %d, but was %d", 1, block.getDurability());
    
    presenter.updateStates();
    
    STAssertEquals(89.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 89.0f, ball.getCenterX());
    STAssertEquals(89.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 89.0f, ball.getCenterY());
    STAssertEquals(-2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", -2.0f, ball.getDX());
    STAssertEquals(-2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", -2.0f, ball.getDY());
    STAssertEquals(0, block.getDurability(), @"block.durability expected %d, but was %d", 0, block.getDurability());
}

- (void)testUpdateBoundsBarX
{
    Ball ball;
    ball.setCenterX(87.0f);
    ball.setCenterY(87.0f);
    ball.setWidth(3.0f);
    ball.setHeight(3.0f);
    ball.setDX(2.0f);
    ball.setDY(2.0f);
    
    Bar bar;
    bar.setCenterX(100.0f);
    bar.setCenterY(100.0f);
    bar.setWidth(20.0f);
    bar.setHeight(40.0f);
    
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = &bar;
    initializer.block = NULL;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    presenter.startGame();
    
    STAssertEquals(87.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 87.0f, ball.getCenterX());
    STAssertEquals(87.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 87.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", 2.0f, ball.getDY());
    
    presenter.updateStates();
    
    STAssertEquals(89.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 89.0f, ball.getCenterX());
    STAssertEquals(89.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 89.0f, ball.getCenterY());
    STAssertEquals(-2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", -2.0f, ball.getDX());
    STAssertEquals(2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", 2.0f, ball.getDY());
}

- (void)testUpdateBoundsBarY
{
    Ball ball;
    ball.setCenterX(87.0f);
    ball.setCenterY(87.0f);
    ball.setWidth(3.0f);
    ball.setHeight(3.0f);
    ball.setDX(2.0f);
    ball.setDY(2.0f);
    
    Bar bar;
    bar.setCenterX(100.0f);
    bar.setCenterY(100.0f);
    bar.setWidth(40.0f);
    bar.setHeight(20.0f);
    
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = &bar;
    initializer.block = NULL;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    presenter.startGame();
    
    STAssertEquals(87.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 87.0f, ball.getCenterX());
    STAssertEquals(87.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 87.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", 2.0f, ball.getDY());
    
    presenter.updateStates();
    
    STAssertEquals(89.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 89.0f, ball.getCenterX());
    STAssertEquals(89.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 89.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(-2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", -2.0f, ball.getDY());
}

- (void)testUpdateBoundsBarXY
{
    Ball ball;
    ball.setCenterX(87.0f);
    ball.setCenterY(87.0f);
    ball.setWidth(3.0f);
    ball.setHeight(3.0f);
    ball.setDX(2.0f);
    ball.setDY(2.0f);
    
    Bar bar;
    bar.setCenterX(100.0f);
    bar.setCenterY(100.0f);
    bar.setWidth(20.0f);
    bar.setHeight(20.0f);
    
    BlockInitializerMock initializer;
    initializer.ball = &ball;
    initializer.bar = &bar;
    initializer.block = NULL;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    presenter.startGame();
    
    STAssertEquals(87.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 87.0f, ball.getCenterX());
    STAssertEquals(87.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 87.0f, ball.getCenterY());
    STAssertEquals(2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", 2.0f, ball.getDX());
    STAssertEquals(2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", 2.0f, ball.getDY());
    
    presenter.updateStates();
    
    STAssertEquals(89.0f, ball.getCenterX(), @"ball.centerX expected %f, but was %f", 89.0f, ball.getCenterX());
    STAssertEquals(89.0f, ball.getCenterY(), @"ball.centerY expected %f, but was %f", 89.0f, ball.getCenterY());
    STAssertEquals(-2.0f, ball.getDX(), @"ball.DX expected %f, but was %f", -2.0f, ball.getDX());
    STAssertEquals(-2.0f, ball.getDY(), @"ball.DY expected %f, but was %f", -2.0f, ball.getDY());
}

- (void)testMoveBar
{
    Bar bar;
    bar.setCenterX(1.0f);
    bar.setCenterY(2.0f);
    bar.setWidth(20.0f);
    
    BlockInitializerMock initializer;
    initializer.ball = NULL;
    initializer.bar = &bar;
    initializer.block = NULL;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    
    STAssertEquals(1.0f, bar.getCenterX(), @"bar.centerX expected %f, but was %f", 1.0f, bar.getCenterX());
    STAssertEquals(2.0f, bar.getCenterY(), @"bar.centerY expected %f, but was %f", 2.0f, bar.getCenterY());
    
    presenter.moveBar(50.0f, 100.0f);
    
    STAssertEquals(50.0f, bar.getCenterX(), @"bar.centerX expected %f, but was %f", 50.0f, bar.getCenterX());
    STAssertEquals(2.0f, bar.getCenterY(), @"bar.centerY expected %f, but was %f", 2.0f, bar.getCenterY());
}

- (void)testMoveBarOver
{
    Bar bar;
    bar.setCenterX(1.0f);
    bar.setCenterY(2.0f);
    bar.setWidth(20.0f);
    
    BlockInitializerMock initializer;
    initializer.ball = NULL;
    initializer.bar = &bar;
    initializer.block = NULL;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    
    STAssertEquals(1.0f, bar.getCenterX(), @"bar.centerX expected %f, but was %f", 1.0f, bar.getCenterX());
    STAssertEquals(2.0f, bar.getCenterY(), @"bar.centerY expected %f, but was %f", 2.0f, bar.getCenterY());
    
    presenter.moveBar(400.0f, 100.0f);
    
    STAssertEquals(290.0f, bar.getCenterX(), @"bar.centerX expected %f, but was %f", 290.0f, bar.getCenterX());
    STAssertEquals(2.0f, bar.getCenterY(), @"bar.centerY expected %f, but was %f", 2.0f, bar.getCenterY());
}

- (void)testMoveBarUnder
{
    Bar bar;
    bar.setCenterX(1.0f);
    bar.setCenterY(2.0f);
    bar.setWidth(20.0f);
    
    BlockInitializerMock initializer;
    initializer.ball = NULL;
    initializer.bar = &bar;
    initializer.block = NULL;
    
    BreakBlocksPresenter presenter;
    presenter.setInitializer(&initializer);
    presenter.initialize(0.0f, 0.0f, 300.0f, 300.0f);
    
    STAssertEquals(1.0f, bar.getCenterX(), @"bar.centerX expected %f, but was %f", 1.0f, bar.getCenterX());
    STAssertEquals(2.0f, bar.getCenterY(), @"bar.centerY expected %f, but was %f", 2.0f, bar.getCenterY());
    
    presenter.moveBar(0.0f, 100.0f);
    
    STAssertEquals(10.0f, bar.getCenterX(), @"bar.centerX expected %f, but was %f", 10.0f, bar.getCenterX());
    STAssertEquals(2.0f, bar.getCenterY(), @"bar.centerY expected %f, but was %f", 2.0f, bar.getCenterY());
}

@end

Ball* BlockInitializerMock::createBall()
{
    return this->ball;
}

Bar* BlockInitializerMock::createBar()
{
    return this->bar;
}

int BlockInitializerMock::getInitialBlockCount()
{
    return 1;
}

Block* BlockInitializerMock::createBlock()
{
    return this->block;
}
