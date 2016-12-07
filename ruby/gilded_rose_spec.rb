require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context "for standard item" do
      it "subtracts 1 from sell_in value" do
        items = [Item.new("Standard", 2, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 1
      end

      it "will not assign a negative quality" do
        items = [Item.new("Standard", 2, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      context "before sell by date" do
        it "lowers item quality by 1 each day" do
          items = [Item.new("Standard", 4, 4)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 3
        end
      end

      context "after sell by date" do
        it "lowers item quality by 2 each day" do
          items = [Item.new("Standard", 0, 4)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 2
        end
      end
    end

    context "for Aged Brie" do
      it "subtracts 1 from sell_in value" do
        items = [Item.new("Aged Brie", 1, 4)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
      end

      it "will not assign a quality greater than 50" do
        items = [Item.new("Aged Brie", 1, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      context "before sell by date" do
        it "increases item quality by 1 each day" do
          items = [Item.new("Aged Brie", 1, 4)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 5
        end
      end

      context "after sell by date" do
        it "increases item quality by 2 each day" do
          items = [Item.new("Aged Brie", -1, 4)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 6
        end
      end
    end

    context "for Sulfuras" do
      it "will not lower sell_in value" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 2, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 2
      end

      it "will maintain a quality of 80" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 2, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 80
      end
    end

    context "for backstage passes" do
      it "subtracts 1 from sell_in value" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 4)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 3
      end

      it "will not assign a quality greater than 50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end

      it "will not assign a negative quality" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it "increases in quality by 1 when sell_in greater than 10" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end

      it "increases in quality by 2 when sell_in value is 6 to 10" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 4
      end

      it "increases in quality by 3 when sell_in value is 1 to 5" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 5
      end

      it "sets quality to 0 when sell_in is 0 or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "for conjured items" do
      it "subtracts 1 from sell_in value" do
        items = [Item.new("Conjured", 4, 4)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 3
      end

      it "will not assign a negative quality" do
        items = [Item.new("Conjured", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      context "before sell by date" do
        it "lowers item quality by 2 each day" do
          items = [Item.new("Conjured", 2, 4)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 2
        end
      end

      context "after sell by date" do
        it "lowers item quality by 4 each day" do
          items = [Item.new("Conjured", 0, 4)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 0
        end
      end
    end
  end

end
