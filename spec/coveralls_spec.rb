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
        <a href='https://example.io/builds/987654321'>
          gihub-user/repo-name
        </a>
        coverage increased (3.5) to
        <span class='label label-info'>99.35%</span>
        on branch-name after commit:
        commit message by Committer Name <user@example.com>
      </p>
      HTML

      its([:format]) { should eq(:html) }
    end

    context 'decreased' do
      let(:fixture) { 'decreased' }

      its([:source]) { should eq(<<-HTML.strip_heredoc) }
      <p>
        <a href='https://example.io/builds/987654321'>
          gihub-user/repo-name
        </a>
        coverage decreased (-0.8) to
        <span class='label label-info'>88.19%</span>
        on branch-name after commit:
        commit message by Committer Name <user@example.com>
      </p>
      HTML

      its([:format]) { should eq(:html) }
    end

    context 'same' do
      let(:fixture) { 'same' }

      its([:source]) { should eq(<<-HTML.strip_heredoc) }
      <p>
        <a href='https://example.io/builds/987654321'>
          gihub-user/repo-name
        </a>
        coverage remained the same at
        <span class='label label-info'>100.00%</span>
        on branch-name after commit:
        commit message by Committer Name <user@example.com>
      </p>
      HTML

      its([:format]) { should eq(:html) }
    end

    context 'ambiguous' do
      let(:fixture) { 'ambiguous' }

      its([:source]) { should eq(<<-HTML.strip_heredoc) }
      <p>
        <a href='https://example.io/builds/987654321'>
          gihub-user/repo-name
        </a>
        coverage remained the same at
        <span class='label label-info'>0.00%</span>
        on branch-name after commit:
        commit message by Committer Name <user@example.com>
      </p>
      HTML

      its([:format]) { should eq(:html) }
    end
  end
end
