module Main where

import           Data.Monoid
import           Elm.Build
import           Elm.Build.NewProject
import           System.Console.GetOpt
import           System.Environment

data Flag =
  NewProject FilePath
  deriving ((Show))

options :: [OptDescr Flag]
options =
  [Option "n"
          ["new"]
          (ReqArg NewProject "directory")
          "Create a new project."]

runCommand :: ([Flag],[String],[String]) -> IO ()
runCommand ([],[],[]) = build
runCommand ([NewProject rootDir],[],[]) = newProject rootDir
runCommand (_,_,errors) =
  ioError (userError (concat errors <> usageInfo "USAGE: " options))


main :: IO ()
main =
  do args <- getArgs
     runCommand (getOpt Permute options args)
