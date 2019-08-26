{-# LANGUAGE OverloadedStrings #-}

module Lesson07 (main) where

import qualified SDL
import qualified SDL.Image
import qualified Common as C

import Control.Monad.IO.Class (MonadIO)
import Control.Monad.Extra (whileM)
import Paths_lazy_foo (getDataFileName)

main :: IO ()
main = C.withSDL $ do
  C.setHintQuality
  C.withWindow "Lesson 07" (640, 480) $ \w ->
    C.withRenderer w $ \r -> do

      t <- getDataFileName "texture.png" >>= SDL.Image.loadTexture r

      whileM $
        C.isContinue <$> SDL.pollEvent
        >>= C.conditionallyRun (draw r t)

      SDL.destroyTexture t


draw :: (MonadIO m) => SDL.Renderer -> SDL.Texture -> m ()
draw r t = do
  SDL.clear r
  SDL.copy r t Nothing Nothing
  SDL.present r