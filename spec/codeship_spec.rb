describe Idobata::Hook::Codeship, type: :hook do
  let(:payload) { fixture_payload("codeship/payload.json") }

  before do
    post payload, 'Content-Type' => 'application/json'
  end

  describe '#process_payload' do
    subject { hook.process_payload }

    it do
      subject
    end
  end
end
