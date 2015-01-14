require 'spec_helper'
describe 'pgpool' do

 shared_examples 'a Linux OS with defaults' do
    it {
      should contain_class('pgpool')
      should contain_class('pgpool::package')
      should contain_package('pgpool').
        with_ensure('present')
      should contain_class('pgpool::config')
      should contain_file('/etc/pgpool/pgpool.conf').
        with_ensure('file').
        with_owner('postgres').
        with_group('postgres')
      should contain_file('/etc/sysconfig/pgpool').
        with_ensure('file').
        with_owner('postgres').
        with_group('postgres')
      should contain_class('pgpool::service')
      should contain_service('pgpool').
        with_ensure('running')
      should contain_exec('pgpool_reload')
    }
  end

  context 'on RedHat' do
    let (:facts) { {
      :kernel          => 'Linux',
      :osfamily        => 'RedHat',
      :operatingsystem => 'CentoOS',
      :concat_basedir  => '/tmp'
    } }
    it_behaves_like 'a Linux OS with defaults' do
    end
  end

  context 'on Debian' do
    let (:facts) { {
      :kernel          => 'Linux',
      :osfamily        => 'Debian',
      :operatingsystem => 'Debian',
      :concat_basedir  => '/tmp'
    } }
    it_behaves_like 'a Linux OS with defaults' do
    end
  end
end
