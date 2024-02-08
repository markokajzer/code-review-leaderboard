require "config"

RSpec.describe Config do
  describe ".initialize!" do
    it "can initialize from arguments" do
      allow(ArgumentParser).to receive(:parse!).and_return(
        ArgumentParser.parse!(args: ["--access-token", "abc", "--repository", "rails/rails"])
      )

      described_class.initialize!

      expect(described_class.access_token).to eq("abc")
      expect(described_class.repositories).to contain_exactly("rails/rails")
    end

    it "can initialize from environment variables" do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("ACCESS_TOKEN").and_return("abc")
      allow(ENV).to receive(:[]).with("REPOSITORY").and_return("rails/rails")

      described_class.initialize!

      expect(described_class.access_token).to eq("abc")
      expect(described_class.repositories).to contain_exactly("rails/rails")
    end
  end
end
