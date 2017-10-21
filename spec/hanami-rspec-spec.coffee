HanamiRspec = require '../lib/hanami-rspec'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe 'HanamiRspec', ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('hanami-rspec')

  describe 'pathToOpen', ->
    it 'returns the spec path for an apps source path', ->
      expect(HanamiRspec.pathToOpen('apps/web/controllers/models/index.rb'))
        .toBe 'spec/web/controllers/models/index_spec.rb'

    it 'returns the spec path for a lib source path', ->
      expect(HanamiRspec.pathToOpen('lib/app_web/repositories/model_repository.rb'))
        .toBe 'spec/app_web/repositories/model_repository_spec.rb'

    it 'returns the spec path for an apps source path', ->
      expect(HanamiRspec.pathToOpen('spec/web/controllers/models/index_spec.rb'))
        .toBe 'apps/web/controllers/models/index.rb'

    it 'returns the spec path for a lib source path', ->
      expect(HanamiRspec.pathToOpen('spec/app_web/repositories/model_repository_spec.rb'))
        .toBe 'lib/app_web/repositories/model_repository.rb'
