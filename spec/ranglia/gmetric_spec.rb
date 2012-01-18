require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ranglia::GMetric do

  class TestGMetric < Ranglia::GMetric
    add_metric('test', 'name' => 'name')

    def collect
      {'test' => 38}
    end

  end

  subject do
    TestGMetric.new
  end

  it "should be able to add metric definition" do
    TestGMetric.metrics.should_not be_nil
  end

  it "should have sane defaults" do
    TestGMetric.metrics['test'].should eq({
                                                  :name  => 'name',
                                                  :group => 'no_group',
                                                  :type  => 'int32',
                                                  :units => 'count',
                                                  :slope => 'both',
                                                  :dmax  => 600
                                          })
  end

  it "should symbolize keys" do
    TestGMetric.metrics['test'].should_not have_key 'name'
    TestGMetric.metrics['test'][:name].should eq 'name'
  end

  it "should have Cmd as default transport" do
    subject.config.transport.should be Ranglia::Transport::Cmd
  end

  it "should have debug false" do
    subject.config.debug.should be false
  end

end