describe Idobata::Hook::Codeship, type: :hook do
  let(:payload) { fixture_payload("codeship/#{fixture}.json") }

  before do
    post payload, 'Content-Type' => 'application/x-www-form-urlencoded'
  end

  describe '#process_payload' do
    subject { hook.process_payload }
  end
end
