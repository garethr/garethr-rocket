require 'spec_helper'

describe 'rocket::application', :type => :define do
  let(:title) { 'hello' }
  let(:params) { { 'image' => '/output/hello.aci' } }
  it { should contain_service('rocket-hello').with_ensure(true) }
  it { should contain_file('/etc/init/rocket-hello.conf').with_content(/hello\.aci/) }

  context 'with running set to false' do
    let(:params) { { 'image' => '/output/hello.aci', 'running' => false } }
    it { should contain_service('rocket-hello').with_ensure(false) }
  end
end
