module GPIO.Pin (
    read,
    write,
    export,
    unexport,
    readValue,
    writeValue,
    writeDirection,
    writePinHigh,
    writePinLow,
    writePinListHigh,
    writePinListLow
) where

import Prelude hiding (read)

read :: Int -> String -> IO String
read pin command = readFile $ "/sys/class/gpio/gpio" ++ show pin ++ "/" ++ command

write :: Int -> String -> String -> IO ()
write pin command value = writeFile ("/sys/class/gpio/gpio" ++ show pin ++ "/" ++ command) value

export :: Int -> IO ()
export pin = writeFile "/sys/class/gpio/export" (show pin)

unexport :: Int -> IO ()
unexport pin = writeFile "/sys/class/gpio/unexport" (show pin)

readValue :: Int -> IO String
readValue pin = read pin "value"

writeValue :: Int -> String -> IO ()
writeValue pin value = write pin "value" value

writeDirection :: Int -> String -> IO ()
writeDirection pin value = write pin "direction" value

writePinHigh :: Int -> IO ()
writePinHigh pin = writeValue pin "1"

writePinLow :: Int -> IO ()
writePinLow pin = writeValue pin "0"

writePinListHigh :: [Int] -> IO ()
writePinListHigh pins = mapM_ writePinHigh pins

writePinListLow :: [Int] -> IO ()
writePinListLow pins = mapM_ writePinLow pins
