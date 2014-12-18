require 'spec_helper'

describe 'rocket' do
  it { should contain_class('rocket::params') }
  it { should contain_class('rocket') }

  it { should contain_package('curl') }

  it { should contain_archive('appc-spec-v0.1.1').with_ensure('present') }
  it { should contain_archive('rocket-v0.1.1').with_ensure('present') }

  it { should contain_file('/usr/local/bin/actool')
    .with_target('/usr/local/src/appc-spec-v0.1.1/actool')
    .with_ensure('link')
  }
  it { should contain_file('/usr/local/bin/rkt')
  .with_target('/usr/local/src/rocket-v0.1.1/rkt')
  .with_ensure('link')
  }

  context 'with a custom version' do
    let(:params) { { 'version' => '1.0.0', } }
    it { should contain_archive('appc-spec-v1.0.0') }
    it { should contain_archive('rocket-v1.0.0') }
  end

  context 'with ensure absent' do
    let(:params) { { 'ensure' => 'absent', } }
    it { should contain_file('/usr/local/bin/actool').with_ensure('absent') }
    it { should contain_file('/usr/local/bin/rkt').with_ensure('absent') }
    it { should contain_archive('appc-spec-v0.1.1').with_ensure('absent') }
    it { should contain_archive('rocket-v0.1.1').with_ensure('absent') }
  end
end
