require 'spec_helper'

describe 'rocket::image', :type => :define do
  let(:title) { 'hello.aci' }
  let(:params) { { 'source' => '/input', 'output_dir' => '/output' } }
  it { should contain_exec('actool build /input /output/hello.aci').with_creates('/output/hello.aci') }
end
