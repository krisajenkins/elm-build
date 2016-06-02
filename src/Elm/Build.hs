module Elm.Build (build) where

import           Development.Shake
import           Development.Shake.FilePath


build :: IO ()
build =
  shakeArgs shakeOptions {shakeThreads = 1
                         ,shakeVerbosity = Loud} $
  do staticRules
     priority 2 $ mconcat [lessRules,elmRules,testRules]
     action $
       do need (toDist <$> ["app.js","main.css"])
          need ["test"]
          needStatic

needStatic :: Action ()
needStatic =
  do files <-
       getDirectoryFiles "static"
                         ["//*"]
     need (toDist <$> files)

toDist :: FilePath -> FilePath
toDist = ("dist" </>)

staticRules :: Rules ()
staticRules =
  "dist//*" %>
  (\out ->
     copyFileChanged ("static" </> dropDirectory1 out)
                     out)

lessRules :: Rules ()
lessRules =
  "dist/main.css" %>
  (\out ->
     do files <-
          getDirectoryFiles ""
                            ["styles//*.less"]
        need files
        command [] "lessc" ["styles" </> dropDirectory1 out -<.> "less",out])

elmRules :: Rules ()
elmRules =
  "dist/app.js" %>
  \out ->
    do files <-
         getDirectoryFiles ""
                           ["src//*.elm","src//*.js"]
       need files
       elmMake "src/App.elm" out

elmMake :: FilePath -> FilePath -> Action ()
elmMake root out =
  command [] "elm-make" [root,"--yes","--warn","--output=" ++ out]

testRules :: Rules ()
testRules =
  phony "test" $
  withTempDir
    (\tmpDir ->
       do let tmp = tmpDir </> "test.js"
          elmMake "test/Test.elm" tmp
          command [] "node" [tmp])
