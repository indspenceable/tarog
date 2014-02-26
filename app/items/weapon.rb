class Weapon
  ATTRS = [:name, :type, :range, :power, :to_hit, :to_crit, :weight, :targets]
  attr_reader *ATTRS
  attr_reader :config

  def self.config
    @config ||= YAML.load(File.read('./weapons.yml'))
  end

  def self.build(name)
    raise "No weapon named: #{name}" unless Weapon.config[name]
    Weapon.new(Weapon.config[name])
  end

  def initialize configuration, identifier=nil
    @config = configuration
    @identifier=identifier
    ATTRS.map(&:to_s).each do |stat|
      raise "Weapon #{@identifier} doens't have stat #{stat}!" unless config[stat]
      instance_variable_set("@#{stat}", config[stat])
    end
    @range = (@range..@range) if @range.is_a?(Numeric)
  end

  def in_range?(x)
    range.include?(x)
  end

  def self.exists?(name)
    config.key?(name)
  end

  # override if different from their triangle weapon type
  # examples: axekiller is wieldable by lances, but in other cases is a sword.
  def wield_type
    type
  end

  # equip!
  def trigger!(unit)
    if unit.can_wield?(self)
      unit.equip!(self)
    end
    false
  end

  def color_for(unit)
    if unit.can_wield?(self)
      GREEN
    else
      YELLOW
    end
  end

  def used_up?
    #TODO weapon durabilities
    false
  end

  def targets
    @targets || []
  end

  def magic?
    [:anima, :light, :dark].include?(type)
  end
end

