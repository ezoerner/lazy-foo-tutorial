{-# LANGUAGE OverloadedStrings #-}

module Lesson03
  ( main
    )
where

import qualified Common as C
import Control.Monad.Extra (whileM)
import Paths_lazy_foo (getDataFileName)
import qualified SDL

main :: IO ()
main = C.withSDL $ C.withWindow "Lesson 03" (640, 480)
  $ \w -> do
    screen <- SDL.getWindowSurface w
    image <- getDataFileName "x.bmp" >>= SDL.loadBMP
    let doRender = C.renderSurfaceToWindow w screen image
    whileM
      $ C.isContinue
      <$> SDL.pollEvent
      >>= C.conditionallyRun doRender
    SDL.freeSurface image
