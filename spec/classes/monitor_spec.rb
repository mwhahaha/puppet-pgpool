require 'spec_helper'
describe 'pgpool::monitor' do
  context 'on RedHat' do
    let :facts do
    {
    }
    end

    context 'with defaults for all parameters' do
      it {
        should contain_class('pgpool::monitor')
        should contain_package('pgpool_monitor').with_ensure('latest')
        should contain_file('/etc/pgpool_monitor.cfg').with(
          'ensure' => 'file',
          'owner'  => 'zabbix',
          'group'  => 'zabbix')
        should contain_ini_setting('db_host').with(
          'ensure'  => 'present',
          'section' => 'db',
          'setting' => 'host',
          'value'   => 'localhost')
        should contain_ini_setting('db_port').with(
          'ensure'  => 'present',
          'section' => 'db',
          'setting' => 'port',
          'value'   => '9999')
        should contain_ini_setting('db_database').with(
          'ensure'  => 'present',
          'section' => 'db',
          'setting' => 'database',
          'value'   => 'postgres')
        should contain_ini_setting('db_user').with(
          'ensure'  => 'present',
          'section' => 'db',
          'setting' => 'user',
          'value'   => 'zabbix')
        should contain_ini_setting('db_password').with(
          'ensure'  => 'present',
          'section' => 'db',
          'setting' => 'password',
          'value'   => '')
        should contain_ini_setting('pcp_timeout').with(
          'ensure'  => 'present',
          'section' => 'pcp',
          'setting' => 'timeout',
          'value'   => '10')
        should contain_ini_setting('pcp_host').with(
          'ensure'  => 'present',
          'section' => 'pcp',
          'setting' => 'host',
          'value'   => 'localhost')
        should contain_ini_setting('pcp_port').with(
          'ensure'  => 'present',
          'section' => 'pcp',
          'setting' => 'port',
          'value'   => '9898')
        should contain_ini_setting('pcp_user').with(
          'ensure'  => 'present',
          'section' => 'pcp',
          'setting' => 'user',
          'value'   => 'zabbix')
        should contain_ini_setting('pcp_password').with(
          'ensure'  => 'present',
          'section' => 'pcp',
          'setting' => 'password',
          'value'   => 'zabbix')
      }
    end

    context 'with ensure set to absent' do
      let(:params) { {
          :ensure => 'absent'
      } }
      it {
        should contain_class('pgpool::monitor')
        should contain_package('pgpool_monitor').with_ensure('absent')
        should contain_file('/etc/pgpool_monitor.cfg').with(
          'ensure' => 'absent',
          'owner'  => 'zabbix',
          'group'  => 'zabbix')
        should_not contain_ini_setting('db_host').with(
          'ensure'  => 'absent',
          'section' => 'db',
          'setting' => 'host',
          'value'   => 'localhost')
      }
    end
  end
end
