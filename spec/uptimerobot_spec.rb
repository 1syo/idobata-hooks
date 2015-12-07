describe Idobata::Hook::Uptimerobot, type: :hook do
  before { get params }

  describe '#process_payload' do
    subject { hook.process_payload }

    context 'Down' do
      let(:params) do
        {
          monitorID: 777274719,
          monitorURL: 'https://example.com',
          monitorFriendlyName: 'example.com(tls)',
          alertType: 1,
          alertTypeFriendlyName: 'Down'
        }
      end

      its([:source]) { should eq(<<-HTML.strip_heredoc) }
        <p>
          <a href='https://example.com'>example.com(tls)</a>
          is Down
          (<a href='https://uptimerobot.com/dashboard#777274719'>detail</a>)
        </p>
      HTML

      its([:format]) { should eq(:html) }
    end

    context 'Up' do
      let(:params) do
        {
          monitorID: 777274719,
          monitorURL: 'https://example.com',
          monitorFriendlyName: 'example.com(tls)',
          alertType: 2,
          alertTypeFriendlyName: 'Up'
        }
      end

      its([:source]) { should eq(<<-HTML.strip_heredoc) }
        <p>
          <a href='https://example.com'>example.com(tls)</a>
          is Up
          (<a href='https://uptimerobot.com/dashboard#777274719'>detail</a>)
        </p>
      HTML

      its([:format]) { should eq(:html) }
    end
  end
end
