WyvernRider = create_class('w', 'Wyvern Rider', 7, 5, {
  :max_hp => [50, 90],
  :power  => [40, 65],
  :skill  => [20, 55],
  :speed  => [30, 60],
  :armor  => [30, 60],
  # :res    => [25, 35],
}, {
  :max_hp => 14,
  :power  => 4,
  :skill  => 2,
  :speed  => 2,
  :armor  => 3,
  :res    => 0,
}, [:lances], {'^' => 1, 'T' => 1}, [:flying])
