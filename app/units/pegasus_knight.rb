PegasusKnight = create_class('g', 'Pegasus Knight', 7, 5, {
  :max_hp => [40, 80],
  :power  => [30, 45],
  :skill  => [40, 65],
  :speed  => [50, 70],
  :armor  => [10, 20],
  :resistance => [20, 50],
}, {
  :max_hp => 14,
  :power  => 2,
  :skill  => 4,
  :speed  => 4,
  :armor  => 1,
  :resistance    => 3,
}, [:lances], {:mountain => 1, :forest => 1, :fort => 1}, [:flying])