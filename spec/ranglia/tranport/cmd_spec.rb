require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ranglia::Transport::Cmd do

  it "should default bin to /usr/bin/gmetric" do
    subject.bin.should eq '/usr/bin/gmetric'
  end

  it "should default config to /etc/ganglia/gmond.conf" do
    subject.config.should eq '/etc/ganglia/gmond.conf'
  end

  it "should default groups to false" do
    subject.group.should eq false
  end

  it "should print the command in debug mode" do
    STDOUT.should_receive(:puts).with('/usr/bin/gmetric -c /etc/ganglia/gmond.conf --name=group_test --type=int32 --units= --slope=both --dmax=60 --value=123')
    subject.debug = true
    subject.push({:group => 'group', :name => 'test', :type => 'int32', :slope => 'both', :unit => 'count', :dmax => 60}, 123)
  end

  it "should execute the command" do
    Kernel.should_receive(:system).with('/usr/bin/gmetric -c /etc/ganglia/gmond.conf --name=group_test --type=int32 --units= --slope=both --dmax=60 --value=123')
    subject.push({:group => 'group', :name => 'test', :type => 'int32', :slope => 'both', :unit => 'count', :dmax => 60}, 123)
  end

  context "group is true" do
    it "should build a gmetric 3.2 string with --group" do
      Kernel.should_receive(:system).with('/usr/bin/gmetric -c /etc/ganglia/gmond.conf --group=group --name=test --type=int32 --units= --slope=both --dmax=60 --value=123')
      subject.group = true
      subject.push({:group => 'group', :name => 'test', :type => 'int32', :slope => 'both', :unit => 'count', :dmax => 60}, 123)
    end
  end

end