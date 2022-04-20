class GildedRose
  BRIE = "Aged Brie"
  PASS = "Backstage passes to a TAFKAL80ETC concert"

  attr_reader :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  # NAME
  #   BRIE
  #   PASS
  #   Other
  #
  # Quality
  #   > 0
  #   <= 0

  def tick
    if @name != BRIE and @name != PASS
      if @quality > 0
        if @name != "Sulfuras, Hand of Ragnaros"
          @quality = @quality - 1
        end
      end
    else
      if @quality < 50
        @quality = @quality + 1
        if @name == "Backstage passes to a TAFKAL80ETC concert"
          if @days_remaining < 11
            if @quality < 50
              @quality = @quality + 1
            end
          end
          if @days_remaining < 6
            if @quality < 50
              @quality = @quality + 1
            end
          end
        end
      end
    end
    if @name != "Sulfuras, Hand of Ragnaros"
      @days_remaining = @days_remaining - 1
    end
    if @days_remaining < 0
      if @name != "Aged Brie"
        if @name !="Backstage passes to a TAFKAL80ETC concert"
          if @quality > 0
            if @name != "Sulfuras, Hand of Ragnaros"
              @quality = @quality - 1
            end
          end
        else
          @quality = @quality - @quality
        end
      else
        if @quality < 50
          @quality = @quality + 1
        end
      end
    end
  end
end

RSpec.describe GildedRose do
  subject!(:rose) { GildedRose.new(name: name, days_remaining: days_remaining, quality: quality) }

  # before(:each) do
  # end

  before do
    rose.tick
  end

  describe '#tick' do
    context 'when name is "Aged Brie"' do
      let(:name) { 'Aged Brie' }

      context 'when quality is more than 0' do
        let(:quality) { 1 }

        context 'when days_remaining is 0' do
          let(:days_remaining) { 0 }

          specify do
            expect(rose.quality).to eq(3)
            expect(rose.days_remaining).to eq(-1)
          end
        end

        context 'when days_remaining is more than 0' do
          let(:days_remaining) { 1 }

          specify do
            expect(rose.quality).to eq(2)
            expect(rose.days_remaining).to eq(0)
          end
        end
      end

      context 'when quality is 0' do
        let(:quality) { 0 }

        context 'when days_remaining is more than 0' do
          let(:days_remaining) { 1 }

          specify do
            expect(rose.quality).to eq(1)
            expect(rose.days_remaining).to eq(0)
          end
        end

        context 'when days_remaining is 0' do
          let(:days_remaining) { 0 }

          specify do
            expect(rose.quality).to eq(2)
            expect(rose.days_remaining).to eq(-1)
          end
        end
      end
    end

    context 'when name is "Backstage passes to a TAFKAL80ETC concert"' do
      let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }

      context 'when quality is more than 0' do
        let(:quality) { 1 }

        context 'when days_remaining is 0' do
          let(:days_remaining) { 0 }

          specify do
            expect(rose.quality).to eq(0)
            expect(rose.days_remaining).to eq(-1)
          end
        end

        context 'when days_remaining is more than 0' do
          let(:days_remaining) { 1 }

          specify do
            expect(rose.quality).to eq(4)
            expect(rose.days_remaining).to eq(0)
          end
        end
      end

      context 'when quality is 0' do
        let(:quality) { 0 }

        context 'when days_remaining is more than 0' do
          let(:days_remaining) { 1 }

          specify do
            expect(rose.quality).to eq(3)
            expect(rose.days_remaining).to eq(0)
          end
        end

        context 'when days_remaining is 0' do
          let(:days_remaining) { 0 }

          specify do
            expect(rose.quality).to eq(0)
            expect(rose.days_remaining).to eq(-1)
          end
        end
      end
    end

    context 'when name is other thing' do
    end
  end
end

# Describe
#   For classes and methods -> What we are testing
#
# Context
#   One specific context under test -> Variable values and such
#
# Specify/It - Examples
#   The actual test - run the code and call the expectations


# Let
#   Memoizes a certain value on a variable - block only called once
#   Called just when needed, not before
#   Called before if you use let!

# Before
#   Calls code before each test (usually)

# Subject
#   Special kinda let, provides shorter syntax for that particular object's
#   assertions
