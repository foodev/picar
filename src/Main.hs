module Main (main) where

import System.Environment
import System.Cmd(system)
import System.Console.GetOpt
import System.Exit
import Control.Monad
import qualified GPIO.Pin as Pin

data Options = Options
    { optExport    :: Bool
    , optUnexport  :: Bool
    , optInit      :: Bool
    , optHttp      :: Bool
    , optPort      :: String
    , optStart     :: Bool
    , optStop      :: Bool
    , optDirection :: String
    }

defaultOptions :: Options
defaultOptions = Options
    { optExport    = False
    , optUnexport  = False
    , optInit      = False
    , optHttp      = False
    , optPort      = "8080"
    , optStart     = False
    , optStop      = False
    , optDirection = ""
    }

motors :: ([Int], [Int])
motors = (
        [4, 17],
        [18, 23]
    )

mapTuple2M_ :: Monad m => (a -> m b) -> (a, a) -> m ()
mapTuple2M_ f (a3, a4) = mapM_ f [a3, a4]

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

drive _ = error "You must sepcify one of these directions: forward, back, left, right"

options :: [OptDescr (Options -> IO Options)]
options = [
        Option "" ["export"]
            (NoArg (\opt -> return opt { optExport = True }))
            "export all pins",

        Option "" ["unexport"]
            (NoArg (\opt -> return opt { optUnexport = True }))
            "unexport all pins",

        Option "" ["init"]
            (NoArg (\opt -> return opt { optInit = True }))
            "init all pins",

        Option "" ["http"]
            (NoArg (\opt -> return opt { optHttp = True }))
            "start webserver",

        Option "" ["port"]
            (ReqArg (\arg opt -> return opt { optPort = arg }) "port")
            "use port number PORT for webserver",

        Option "" ["start"]
            (NoArg (\opt -> return opt { optStart = True }))
            "start driving",

        Option "" ["stop"]
            (NoArg (\opt -> return opt { optStop = True }))
            "stop driving",

        Option "" ["direction"]
            (ReqArg (\arg opt -> return opt { optDirection = arg }) "direction")
            "the DIRECTION to start or stop driving to",

        Option "h" ["help"]
            (NoArg (\_ -> do
                putStrLn (usageInfo "Usage: picar [OPTION...]" options)
                exitSuccess))
            "show this help and exit"
    ]

main = do
    args <- getArgs

    -- parse command line options
    let (actions, nonOptions, errors) = getOpt Permute options args

    -- merge options with default options
    opts <- foldl (>>=) (return defaultOptions) actions
    let Options { optExport = optExport
                , optUnexport = optUnexport
                , optInit = optInit
                , optHttp = optHttp
                , optPort = optPort
                , optStart = optStart
                , optStop = optStop
                , optDirection = optDirection
                } = opts

    -- export all pins
    when optExport $ mapTuple2M_ (\motor -> mapM_ (\led -> Pin.export led) motor) motors

    -- unexport all pins
    when optUnexport $ mapTuple2M_ (\motor -> mapM_ (\led -> Pin.unexport led) motor) motors

    -- init all pins
    when optInit $ mapTuple2M_ (\motor -> mapM_ (\led -> Pin.writeDirection led "out") motor) motors

    -- start the webserver and exit
    when optHttp $ do
        system ("nodejs $HOME/picar/web/server.js " ++ optPort)
        exitSuccess

    -- start or stop driving to the specified direction
    when optStart $ drive optDirection
    when optStop $ drive (optDirection ++ "stop")

    exitSuccess
