require 'spec_helper'

describe Coinmux::BitcoinCrypto do
  let(:message) { "this is a message" }
  let(:address) { "mh9nRF1ZSqLJB3hbUjPLmfDHdnGUURdYdK" }
  let(:private_key_hex) { "585C660C887913E5F40B8E34D99C62766443F9D043B1DE1DFDCC94E386BC6DF6" }
  let(:private_key_wif) { "92FqDytA43K8unrrZgpzMddhmEbMMRNhBJAU59a3MkYfsUgH8st" }
  let(:private_key_wif_compressed) { "cQYTrJ4nxRD3v1R3mGnpA4gzvEzcq8akLSknVJpqQbCnZeD6WfNC" }
  let(:public_key_hex) { "04FD30E98AF97627082F169B524E4646D31F900C9CAB13743140567C0CAE4B3F303AE48426DD157AEA58DCC239BB8FB19193FB856C312592D8296B02C0EA54E03C" }
  let(:signature_base_64) { "HIZQbBLAGJLhSZ310FCQMAo9l1X2ysxyt0kXkf6KcBN3znl2iClC6V9wz9Nkn6mMDUaq4kRlgYQDUUlsm29Bl0o=" }

  describe "#verify_message!" do
    subject { bitcoin_crypto_facade.verify_message!(message, signature_base_64, address) }

    it "returns true" do
      expect(subject).to be_true
    end
  end

  describe "#sign_message!" do
    subject { bitcoin_crypto_facade.sign_message!(message, private_key_hex) }

    it "verifies" do
      expect(bitcoin_crypto_facade.verify_message!(message, subject, address)).to be_true
    end
  end

  describe "#address_for_public_key!" do
    subject { bitcoin_crypto_facade.address_for_public_key!(public_key_hex) }

    it "returns the bitcoin address" do
      expect(subject).to eq(address)
    end
  end

  describe "#public_key_for_private_key!" do
    subject { bitcoin_crypto_facade.public_key_for_private_key!(private_key_hex) }

    it "returns the public key" do
      expect(subject).to eq(public_key_hex)
    end
  end

  describe "#address_for_private_key!" do
    subject { bitcoin_crypto_facade.address_for_private_key!(private_key_hex) }

    it "returns the address" do
      expect(subject).to eq(address)
    end
  end

  describe "#verify_address!" do
    subject { bitcoin_crypto_facade.verify_address!(address) }

    it "returns true" do
      expect(subject).to be_true
    end
  end

  describe "private_key_to_hex!" do
    subject { bitcoin_crypto_facade.private_key_to_hex!(private_key) }

    context "with private_key_hex" do
      let(:private_key) { private_key_hex }

      it "returns private key hex" do
        expect(subject).to eq(private_key_hex)
      end
    end

    context "with private_key_wif" do
      let(:private_key) { private_key_wif }

      it "returns private key hex" do
        expect(subject).to eq(private_key_hex)
      end
    end

    context "with private_key_wif_compressed" do
      let(:private_key) { private_key_wif_compressed }

      it "returns private key hex" do
        expect(subject).to eq(private_key_hex)
      end
    end

    context "with invalid key" do
      let(:private_key) { private_key_hex[0..10] }

      it "returns private key hex" do
        expect { subject }.to raise_exception(Coinmux::Error, "Private Key not valid")
      end
    end
  end
end