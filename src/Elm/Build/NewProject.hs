{-# LANGUAGE OverloadedStrings #-}
module Elm.Build.NewProject (newProject) where

import           Development.Shake.FilePath
import           Formatting
import           Paths_elm_build
import           System.Directory
import           System.Directory.Extra

copyTemplate :: FilePath -> IO ()
copyTemplate fileName =
  do sourceFile <- getDataFileName $ "templates" </> "default" </> fileName
     createDirectoryIfMissing True
                              (takeDirectory fileName)
     copyFile sourceFile fileName

newProject :: FilePath -> IO ()
newProject rootDir =
  do fprint ("Creating project in " % string % "\n") rootDir
     createDirectory rootDir
     withCurrentDirectory rootDir $ mapM_ copyTemplate templateFiles

templateFiles :: [FilePath]
templateFiles =
  mconcat [[".dir-locals.el",".gitignore","elm-package.json"]
          ,(("src" </>) <$> ["App.elm","State.elm","Types.elm","View.elm"])
          ,(("static" </>) <$> ["index.html","interop.js"])
          ,(("styles" </>) <$> ["main.less"])
          ,(("test" </>) <$> ["Main.elm","StateTest.elm"])]
