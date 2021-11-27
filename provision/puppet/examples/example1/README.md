## Test installing the webserver

### Puppet-master
```
puppet config print | grep -i manifests
cd /etc/puppetlabs/code/environments/production
cp -r /vagrant/modules/* modules/
cp /vagrant/manifests/site.pp manifests/
cd manifests/
puppet parser validate site.pp
```

### puppet-agent-centos
```
puppet agent -tv --noop
puppet agent -tv
```

### puppet-agent-ubuntu
```
/opt/puppetlabs/bin/puppet agent -tv --noop
/opt/puppetlabs/bin/puppet agent -tv
```