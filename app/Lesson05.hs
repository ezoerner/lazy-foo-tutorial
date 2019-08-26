{-# LANGUAGE OverloadedStrings #-}

module Lesson05 (main) where

import qualified SDL
import qualified Common as C

import Control.Monad.IO.Class (MonadIO)
import Control.Monad.Extra    (whileM)

import Paths_lazy_foo (getDataFileName)

main :: IO ()
main = C.withSDL $ C.withWindow "Lesson 05" (640, 480) $
  \w -> do

    screen <- SDL.getWindowSurface w
    pixelFormat <- SDL.surfaceFormat screen

    image <- getDataFileName "stretch.bmp" >>= SDL.loadBMP
    surface <- SDL.convertSurface image pixelFormat

    whileM $
      C.isContinue <$> SDL.pollEvent
      >>= C.conditionallyRun (draw w screen surface)

    mapM_ SDL.freeSurface [image, surface]


draw :: (MonadIO m) => SDL.Window -> SDL.Surface -> SDL.Surface -> m ()
draw w s t
  = SDL.surfaceBlitScaled t Nothing s Nothing
  >> SDL.updateWindowSurface w