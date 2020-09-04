require 'spec_helper'

describe 'pgpool' do

   shared_examples_for 'a Linux OS' do
     context 'with defaults' do
       it {
         should contain_class('pgpool')
         should contain_class('pgpool::package')
         should contain_package('pgpool').
           with_name("#{platform_params[:pkg_name]}").
           with_ensure('present')
         should contain_class('pgpool::config')
         should contain_file("#{platform_params[:config_path]}/pgpool.conf").
           with_ensure('file').
           with_owner('postgres').
           with_group('postgres')
         should contain_file("#{platform_params[:defaults_path]}/#{platform_params[:pkg_name]}").
           with_ensure('file').
           with_owner('postgres').
           with_group('postgres')
         should contain_class('pgpool::service')
         should contain_service('pgpool').
           with_ensure('running')
         should contain_exec('pgpool_reload')
       }
    end
  end


  shared_examples_for 'a RedHat OS' do
    context 'with package and paths' do
      let(:defaults_path) { '/etc/sysconfig' }
      let(:params) { {
        :config_dir   => '/etc/pgpool-II',
        :package_name => 'pgpool-II-pg93',
        :service_name => 'pgpool'
      } }
      it {
        should contain_class('pgpool')
        should contain_class('pgpool::package')
        should contain_package('pgpool').
          with_name(params[:package_name]).
          with_ensure('present')
        should contain_class('pgpool::config')
        should contain_file("#{params[:config_dir]}/pgpool.conf").
          with_ensure('file').
          with_owner('postgres').
          with_group('postgres')
        should contain_file("#{defaults_path}/#{params[:service_name]}").
          with_ensure('file').
          with_owner('postgres').
          with_group('postgres')
        should contain_class('pgpool::service')
        should contain_service('pgpool').
          with_ensure('running')
        should contain_exec('pgpool_reload')
      }
    end
  end

  shared_examples_for 'a Debian OS' do
  end

  on_supported_os({
    :supported_os => [
      { 'operatingsystem'        => 'CentOS',
        'operatingsystemrelease' => [ '5', '6', '7', '8' ] },
      { 'operatingsystem'        => 'Ubuntu',
        'operatingsystemrelease' => [ '16.04', '18.04', '20.04' ] }
    ]
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) {
        facts.merge!({
        :concat_basedir  => '/tmp'
        })
      }

      let(:platform_params) do
        case facts[:osfamily]
        when 'RedHat'
          {
            :config_path   => '/etc/pgpool-II-93',
            :defaults_path => '/etc/sysconfig',
            :pkg_name      => 'pgpool-II-93'
          }
        when 'Debian'
          {
            :config_path   => '/etc/pgpool2',
            :defaults_path => '/etc/default',
            :pkg_name      => 'pgpool2'
          }
        end
      end

      it_behaves_like 'a Linux OS'
      it_behaves_like "a #{facts[:osfamily]} OS"
    end
  end
end
