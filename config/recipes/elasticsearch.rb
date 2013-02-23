namespace :elasticsearch do
  desc "Install latest stable release of nginx"
  task :install, roles: :app do
    run "#{sudo} apt-get install openjdk-7-jre-headless -y"
    run "wget https://github.com/elasticsearch/elasticsearch/archive/v0.20.1.tar.gz -O elasticsearch.tar.gz"
    run "tar -xf elasticsearch.tar.gz"
    run "rm elasticsearch.tar.gz"


    run "sudo mv elasticsearch-* elasticsearch"
    run "sudo mv elasticsearch /usr/local/share"

    run "curl -L http://github.com/elasticsearch/elasticsearch-servicewrapper/tarball/master | tar -xz"
    run "#{sudo} mv *servicewrapper*/service /usr/local/share/elasticsearch/bin/"
    run "rm -Rf *servicewrapper*"
    run "#{sudo} /usr/local/share/elasticsearch/bin/service/elasticsearch install"
    run "#{sudo} ln -s `readlink -f /usr/local/share/elasticsearch/bin/service/elasticsearch` /usr/local/bin/rcelasticsearch"

    run "#{sudo} service elasticsearch start"
  end
  after "deploy:install", "elasticsearch:install"
end
