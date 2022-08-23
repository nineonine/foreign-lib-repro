{-# LANGUAGE CPP                      #-}
{-# LANGUAGE ForeignFunctionInterface #-}
module Lib where

foreign export ccall fromHaskell :: IO ()

fromHaskell :: IO ()
fromHaskell = putStrLn "Hello from haskell"
