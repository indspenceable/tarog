class PlayerArmy
  STARTING_MONEY = 5000
  STARTING_SIZE = 3

  attr_reader :inventory
  attr_accessor :money
  def name
    "Stash"
  end

  def initialize
    # build an army of size units, plus the lord.

    # lord = lord_klasses.shuffle.pop.new(PLAYER_TEAM, Names.generate, 1, true)
    lord = PlayerUnit.new(PlayerUnit.random_lord_class, Names.generate, 1, true)
    @army = [ lord ]
    if ARGV.include?('a')
      @army += PlayerUnit.basic_classes.map do |k|
        PlayerUnit.new(k, Names.generate, 1)
      end
    else
      @army += STARTING_SIZE.times.map do |x|
        PlayerUnit.new(PlayerUnit.basic_classes.shuffle.pop, Names.generate, 1)
      end
    end
    @army.each do |u|
      u.inventory << Vulnerary.new
    end
    @inventory = []
    @money = STARTING_MONEY
  end

  def next_level!(difficulty)
    purge_dead!
    heal_all_units!
    ready_all_units!
    @army.each{|u| u.current_level = nil}
    @army.each{|u| u.clear_buffs! }
  end

  def units
    @army
  end

  def purge_dead!
    @army.select!(&:alive?)
  end

  def heal_all_units!
    @army.each(&:heal)
  end

  def ready_all_units!
    @army.each{|u| u.action_available = true}
  end
end
