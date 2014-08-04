import System.Environment

motorFront = (4, 17)
motorBack = (18, 23)

writeToGPIO :: Int -> String -> String -> IO ()
writeToGPIO pin command value = writeFile filename value
    where
        filename = "/sys/class/gpio/gpio" ++ show pin ++ "/" ++ command

exportGPIO :: Int -> IO ()
exportGPIO pin = writeFile "/sys/class/gpio/export" (show pin)

unexportGPIO :: Int -> IO ()
unexportGPIO pin = writeFile "/sys/class/gpio/unexport" (show pin)

setGPIOValue :: Int -> String -> IO ()
setGPIOValue pin value = writeToGPIO pin "value" value

setGPIODirection :: Int -> String -> IO ()
setGPIODirection pin value = writeToGPIO pin "direction" value

driveForward :: String -> IO ()
driveForward action
    -- drive forward
    | action == "start" = do
        setGPIOValue (fst motorBack) "1"
        setGPIOValue (snd motorBack) "0"
    -- stop driving forward
    | action == "stop" = do
        setGPIOValue (fst motorBack) "0"
        setGPIOValue (snd motorBack) "0"
    | otherwise = printHelp

driveBack :: String -> IO ()
driveBack action
    -- drive back
    | action == "start" = do
        setGPIOValue (fst motorBack) "0"
        setGPIOValue (snd motorBack) "1"
    -- stop driving back
    | action == "stop" = do
        setGPIOValue (fst motorBack) "0"
        setGPIOValue (snd motorBack) "0"
    | otherwise = printHelp

driveLeft :: String -> IO ()
driveLeft action
    -- drive left
    | action == "start" = do
        setGPIOValue (fst motorFront) "0"
        setGPIOValue (snd motorFront) "1"
    -- stop driving left
    | action == "stop" = do
        setGPIOValue (fst motorFront) "0"
        setGPIOValue (snd motorFront) "0"
    | otherwise = printHelp

driveRight :: String -> IO ()
driveRight action
    -- drive right
    | action == "start" = do
        setGPIOValue (fst motorFront) "1"
        setGPIOValue (snd motorFront) "0"
    -- stop driving right
    | action == "stop" = do
        setGPIOValue (fst motorFront) "0"
        setGPIOValue (snd motorFront) "0"
    | otherwise = printHelp

printHelp :: IO ()
printHelp = putStrLn "Usage: picar [[export|unexport] | [f|b|l|r] [start|stop]]"

main :: IO ()
main = do
    args <- getArgs

    case args of
        [direction, action] -> do
            -- setup the pins as output
            setGPIODirection (fst motorFront) "out"
            setGPIODirection (snd motorFront) "out"
            setGPIODirection (fst motorBack) "out"
            setGPIODirection (snd motorBack) "out"

            -- toggle drive for each direction
            case direction of
                "f" -> driveForward action
                "b" -> driveBack action
                "l" -> driveLeft action
                "r" -> driveRight action
                _ -> printHelp
        [action] -> do
            -- export / unexport pins
            case action of
                "export" -> do
                    exportGPIO (fst motorFront)
                    exportGPIO (snd motorFront)
                    exportGPIO (fst motorBack)
                    exportGPIO (snd motorBack)
                "unexport" -> do
                    unexportGPIO (fst motorFront)
                    unexportGPIO (snd motorFront)
                    unexportGPIO (fst motorBack)
                    unexportGPIO (snd motorBack)
                _ -> printHelp
        -- print the help info and exit
        _ -> printHelp
