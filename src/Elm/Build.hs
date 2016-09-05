module Elm.Build (build) where

import           ClassyPrelude
import           Control.Monad
import           Data.Foldable
import           Development.Shake
import           Development.Shake.FilePath


build :: IO ()
build =
  shakeArgs shakeOptions {shakeThreads = 1
                         ,shakeVerbosity = Loud} $
  do staticRules
     priority 2 $ mconcat [styleRules,elmRules,purescriptRules,testRules]
     action $
       do whenFiles getElmFiles $ need [toDist "app.js"]
          whenFiles getPurescriptFiles $ need [toDist "support.js"]
          whenFiles getStyleFiles $ need [toDist "main.css"]
          need ["test"]
          needStatic

whenFiles :: (Monad m, Foldable t) => m (t a) -> m () -> m ()
whenFiles fileLookup fileAction =
  do files <- fileLookup
     unless (Data.Foldable.null files) fileAction

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

getStyleFiles :: Action [FilePath]
getStyleFiles =
          getDirectoryFiles ""
                            ["styles//*.less","styles//*.css"]

styleRules :: Rules ()
styleRules =
  "dist/main.css" %>
  (\out ->
     do getStyleFiles >>= need
        command [] "lessc" ["styles" </> dropDirectory1 out -<.> "less",out])

getPurescriptFiles :: Action [FilePath]
getPurescriptFiles =
  getDirectoryFiles ""
                    ["src//*.purs"]


purescriptRules :: Rules ()
purescriptRules =
  "dist/support.js" %>
  (\out ->
     do getPurescriptFiles >>= need
        command [] "pulp" ["browserify","--standalone","support","-t",out])

getElmFiles :: Action [FilePath]
getElmFiles =
  getDirectoryFiles ""
                    ["src//*.elm"]

elmRules :: Rules ()
elmRules =
  "dist/app.js" %>
  \out ->
    do getElmFiles >>= need
       elmMake "src/App.elm" out

elmMake :: FilePath -> FilePath -> Action ()
elmMake root out =
  command_ []
           "elm-make"
           [root,"--yes","--warn","--output=" ++ out]

testRules :: Rules ()
testRules =
  phony "test" $
  withTempDir
    (\tmpDir ->
       do let tmp = tmpDir </> "test.js"
          elmMake "test/Test.elm" tmp
          command_ [] "sed" ["-i","''","1s/^/window = {};/",tmp]
          command_ [] "sed" ["-i","''","1s/^/document = {};/",tmp]
          command_ [] "node" [tmp])
