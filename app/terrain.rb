class Terrain
  def armor_bonus
    0
  end

  def evade_bonus
    0
  end

  def available_to_place_units?
    false
  end

  def tile
    identifier
  end

  def actions
    {}
  end

  def act!(unit)
  end
end

class Plains < Terrain
  def identifier
    :plains
  end

  def available_to_place_units?
    true
  end

  def standard_movement_cost
    1
  end
end

class Mountain < Terrain
  def identifier
    :mountain
  end

  def standard_movement_cost
    5
  end

  def armor_bonus
    2
  end

  def evade_bonus
    30
  end
end

class Forest < Terrain
  def identifier
    :forest
  end

  def available_to_place_units?
    true
  end

  def standard_movement_cost
    2
  end

  def armor_bonus
    1
  end

  def evade_bonus
    20
  end
end

class Wall < Terrain
  def identifier
    :wall
  end
  def standard_movement_cost
    99999
  end
end

class Fort < Terrain
  def identifier
    :fort
  end

  def available_to_place_units?
    true
  end

  def standard_movement_cost
    2
  end

  def armor_bonus
    2
  end

  def evade_bonus
    20
  end

  def act!(unit)
    amt = unit.max_hp/10
    amt = [unit.max_hp - unit.hp, amt].min
    if amt > 0
      unit.heal(amt)
      unit.animation_queue << "+#{amt} hp"
    end
  end
end

class Shop < Terrain
  attr_reader :items

  def initialize
    @items = starting_inventory
  end

  def config
    self.class.config
  end

  def self.config
    @config ||= JSON.load(File.read('./config/shops.json'))
  end

  def starting_inventory
    _,hsh = config.to_a.shuffle.pop
    standard_items = hsh['normal']
    rare_items = hsh['special']
    number_of_rare_items = 1#[rand(5)-3,0].max

    (standard_items + rare_items.shuffle.first(number_of_rare_items)).map do |item_name|
      Item.create(item_name)
    end
  end

  def identifier
    :shop
  end

  def tile
    return :shop if @items.any?
    :closed_shop
  end

  def available_to_place_units?
    false
  end

  def actions
    if @items.any?
      {
        :shop => ShopAction
      }
    else
      {}
    end
  end

  def standard_movement_cost
    2
  end
end
