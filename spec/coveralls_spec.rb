describe Idobata::Hook::Coveralls, type: :hook do
  let(:payload) { fixture_payload("coveralls/#{fixture}.txt") }

  before do
    post payload, 'Content-Type' => 'application/x-www-form-urlencoded'
  end

  describe '#process_payload' do
    subject { hook.process_payload }

    context 'increased coverrage' do
      let(:fixture) { 'increased' }

      its([:source]) { should eq(<<-HTML.strip_heredoc) }
      <p>
        gihub-user/repo-name
         coverage increased (3.5) to
        <span class='label label-info'>99.35%</span>
        on branch-name after commit:
        commit message by Committer Name
      </p>
      HTML

      its([:format]) { should eq(:html) }
    end

    context 'decreased' do
      let(:fixture) { 'decreased' }

      its([:source]) { should eq(<<-HTML.strip_heredoc) }
      <p>
        gihub-user/repo-name
         coverage decreased (-0.8) to
        <span class='label label-info'>88.19%</span>
        on branch-name after commit:
        commit message by Committer Name
      </p>
      HTML

      its([:format]) { should eq(:html) }
    end

    context 'same' do
      let(:fixture) { 'same' }

      its([:source]) { should eq(<<-HTML.strip_heredoc) }
      <p>
        gihub-user/repo-name
         coverage remained the same at
        <span class='label label-info'>100.00%</span>
        on branch-name after commit:
        commit message by Committer Name
      </p>
      HTML

      its([:format]) { should eq(:html) }
    end

    context 'ambiguous' do
      let(:fixture) { 'ambiguous' }

      its([:source]) { should eq(<<-HTML.strip_heredoc) }
      <p>
        gihub-user/repo-name
         coverage remained the same at
        <span class='label label-info'>0.00%</span>
        on branch-name after commit:
        commit message by Committer Name
      </p>
      HTML

      its([:format]) { should eq(:html) }
    end
  end
end
