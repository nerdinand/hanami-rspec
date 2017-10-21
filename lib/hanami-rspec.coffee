{CompositeDisposable} = require 'atom'

module.exports = HanamiRspec =

  activate: (state) ->
    atom.commands.add 'atom-workspace', 'hanami-rspec:open-spec-file', => @openSpecFile()

  openSpecFile: ->
    relativeOpenPath = @relativeOpenPath()
    return if !relativeOpenPath

    pathToOpen = @pathToOpen(relativeOpenPath)

    return if !pathToOpen

    return if @isAlreadyOpen(pathToOpen)

    @openSplitPane(pathToOpen)

  pathToOpen: (path) ->
    if @isSpec(path)
      if @isWebSpec(path)
        @sourcePathForSpecPath(path)
      else
        @libPathForSpecPath(path)
    else
      @specPathForSourcePath(path)

  isAlreadyOpen: (path) ->
    path in @relativeOpenPaths()

  relativeOpenPaths: ->
    atom.project.getBuffers().map((buffer) ->
      buffer.getPath()).map((path) ->
        HanamiRspec.relativizePath(path))

  relativeOpenPath: ->
    sourceEditor = atom.workspace.getActiveTextEditor()
    return if !sourceEditor
    @relativizePath(sourceEditor.getPath())

  relativizePath: (path) ->
    atom.project.relativizePath(path)[1]

  openSplitPane: (openFilePath) ->
    atom.workspace.open(openFilePath, split: 'right')

  isSpec: (path) ->
    path.indexOf('spec.rb') >= 0

  isWebSpec: (path) ->
    path.indexOf('/web/') >= 0

  specPathForSourcePath: (path) ->
    path.replace('apps', 'spec').replace('lib', 'spec')[0..-4] + '_spec.rb'

  libPathForSpecPath: (path) ->
    path.replace('_spec', '').replace('spec', 'lib')

  sourcePathForSpecPath: (path) ->
    path.replace('_spec', '').replace('spec', 'apps')
