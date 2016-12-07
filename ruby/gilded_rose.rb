class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|

      case item.name
      when "Aged Brie"
        BrieUpdater.new(item).update
      when "Sulfuras, Hand of Ragnaros"
        item
      when "Backstage passes to a TAFKAL80ETC concert"
        BackstagePassUpdater.new(item).update
      when "Conjured"
        ConjuredUpdater.new(item).update
      else
        StandardUpdater.new(item).update
      end
    end
  end

end

class ItemUpdater
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update
  end
end

class StandardUpdater < ItemUpdater
  def update
    item.sell_in -= 1
    return item.quality if item.quality <= 0

    item.sell_in < 0 ? item.quality -= 2 : item.quality -= 1
  end
end

class BrieUpdater < ItemUpdater
  def update
    item.sell_in -= 1
    return item.quality if item.quality >= 50

    item.sell_in < 0 ? item.quality += 2 : item.quality += 1
  end
end

class BackstagePassUpdater < ItemUpdater
  def update
    item.sell_in -= 1
    return item.quality = 0 if item.sell_in < 0
    return item.quality if item.quality >= 50

    item.quality += 1
    item.quality += 1 if item.sell_in < 10
    item.quality += 1 if item.sell_in < 5
  end
end

class ConjuredUpdater < ItemUpdater
  def update
    item.sell_in -= 1
    return item.quality if item.quality <= 0

    item.sell_in < 0 ? item.quality -= 4 : item.quality -= 2
  end
end


class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end