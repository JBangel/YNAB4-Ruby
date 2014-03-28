require 'ynab'

describe Ynab do
  describe '#open' do
    let(:ynab) { Ynab.open('./spec/fixtures/Test~E8570C74.ynab4') }

    it 'accepts a file'
    
    it 'returns an object with transactions' do
      transaction = ynab.transactions.first
      pending "Figure out transactions first"
      expect(transaction.date).to eq Date.new(2014, 2, 17)
      #expect(transaction.account.name).to eq "Savings"

    end
  end

  describe Ynab::Transaction do
    describe '#new' do
      let(:account)  { 'Savings' }
      let(:category) { 'Spending Money' }
      let(:payee)    { 'Target' }

      it 'stores values for a debit transaction' do
        t = Ynab::Transaction.new(account,
                                  Date.new(2014, 3, 26), 
                                  payee,
                                  category,
                                  "This is a memo",
                                  -100.00)

        expect(t.date).to eq Date.new(2014, 3, 26)
        expect(t.payee).to eq 'Target'
        expect(t.outflow).to eq -100.00
        expect(t.inflow).to eq nil
      end

      it 'stores values for a credit transaction' do
        t = Ynab::Transaction.new(account,
                                  Date.new(2014, 2, 28),
                                  payee,
                                  category,
                                  "Another memo",
                                  200.00)
        expect(t.date).to eq Date.new(2014, 2, 28)
        expect(t.payee).to eq 'Target'
        expect(t.inflow).to eq 200.00
        expect(t.outflow).to eq nil
      end
    end
  end
end