{-# LANGUAGE OverloadedStrings #-}

-- From https://github.com/palf/haskell-sdl2-examples
module Lesson01Palf (main) where

import qualified SDL
import qualified Common as C


main :: IO ()
main = C.withSDL $ C.withWindow "Lesson 01" (640, 480) $
  \w -> do

    screen <- SDL.getWindowSurface w
    -- pixelFormat <- SDL.surfaceFormat `applyToPointer` screen
    -- color <- SDL.mapRGB pixelFormat 0xFF 0xFF 0xFF
    SDL.surfaceFillRect screen Nothing (SDL.V4 maxBound maxBound maxBound maxBound)
    SDL.updateWindowSurface w

    SDL.delay 10000

    SDL.freeSurface screen