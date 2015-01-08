module Main (main) where

import System.Environment
import System.Exit
import Control.Monad
import qualified GPIO.Pin as Pin

motors :: ([Int], [Int])
motors = (
        [4, 17],
        [18, 23]
    )

-- TOTO(jonas): Isn't this mapTuple2M_ ?
mapTuple4M_ :: Monad m => (a -> m b) -> (a, a) -> m ()
mapTuple4M_ f (a3, a4) = mapM_ f [a3, a4]

drive "forward" = do
    Pin.writePinHigh (head $ snd motors)
    Pin.writePinLow (last $ snd motors)

drive "back" = do
    Pin.writePinLow (head $ snd motors)
    Pin.writePinHigh (last $ snd motors)

drive "left" = do
    Pin.writePinLow (head $ fst motors)
    Pin.writePinHigh (last $ fst motors)

drive "right" = do
    Pin.writePinHigh (head $ fst motors)
    Pin.writePinLow (last $ fst motors)


drive "forwardstop" = do
    Pin.writePinLow (head $ snd motors)
    Pin.writePinLow (last $ snd motors)

drive "backstop" = do
    Pin.writePinLow (head $ snd motors)
    Pin.writePinLow (last $ snd motors)

drive "leftstop" = do
    Pin.writePinLow (head $ fst motors)
    Pin.writePinLow (last $ fst motors)

drive "rightstop" = do
    Pin.writePinLow (head $ fst motors)
    Pin.writePinLow (last $ fst motors)

main = do
    args <- getArgs

    case args of
        [option, parameter] -> case option of
            "drive" -> drive parameter
        [option] -> case option of
            "init" -> do
                mapTuple4M_ (\motor -> mapM_ (\led -> Pin.writeDirection led "out") motor) motors
                exitSuccess
            "export" -> do
                mapTuple4M_ (\motor -> mapM_ (\led -> Pin.export led) motor) motors
                exitSuccess
            "unexport" -> do
                mapTuple4M_ (\motor -> mapM_ (\led -> Pin.unexport led) motor) motors
                exitSuccess
            "stop" -> do
                mapTuple4M_ Pin.writePinListLow motors
                exitSuccess
            _ -> do
                putStrLn "Usage: picar export|init|unexport|stop|drive [forward|back|left|right|forwardstop|backstop|leftstop|rightstop]"
                exitSuccess
        _ -> do
            putStrLn "Usage: picar export|init|unexport|stop|drive [forward|back|left|right|forwardstop|backstop|leftstop|rightstop]"
            exitSuccess
