require './lib/player'

describe Player do
	subject(:inputs) { described_class.new }

	describe '#select_piece' do
		it 'accepts a two character input' do
			allow(inputs).to receive(:gets).and_return('b1')
			expect(inputs.transform_inputs).to eq([1,0])
		end
	end
end