# encoding: UTF-8

require 'pry-nav'
require 'rake'
require 'rspec'
require 'txgh'

module StandardTxghSetup
  extend RSpec::SharedContext

  let(:github_api) { double(:github_api) }
  let(:transifex_api) { double(:transifex_api) }

  let(:project_name) { 'my_awesome_project' }
  let(:resource_slug) { 'my_resource' }
  let(:repo_name) { 'my_org/my_repo' }
  let(:branch) { 'master' }
  let(:language) { 'ko_KR' }
  let(:translations) { 'translation file contents' }

  let(:project_config) do
    {
      'api_username' => 'transifex_api_username',
      'api_password' => 'transifex_api_password',
      'push_translations_to' => repo_name,
      'name' => project_name
    }
  end

  let(:repo_config) do
    {
      'api_username' => 'github_api_username',
      'api_token' => 'github_api_token',
      'push_source_to' => project_name,
      'branch' => branch,
      'name' => repo_name
    }
  end

  let(:tx_config) do
    TxConfig.load(
      """
      [main]
      host = https://www.transifex.com
      lang_map =

      [#{project_name}.#{resource_slug}]
      file_filter = translations/<lang>/sample.po
      source_file = sample.po
      source_lang = en
      type = PO
      """
    )
  end

  let(:transifex_project) do
    TransifexProject.new(project_config, tx_config, transifex_api)
  end

  let(:github_repo) do
    GitHubRepo.new(repo_config, github_api)
  end
end

RSpec.configure do |config|
end
