require 'ballistics'
require 'ballistics/projectile'
require 'ballistics/cartridge'
require 'ballistics/gun'
require 'ballistics/atmosphere'

class Ballistics::Problem
  DEFAULTS = {
    shooting_angle: 0, # degrees; downhill 0 to -90, uphill 0 to +90
    wind_speed:     0, # mph
    wind_angle:    90, # degrees; 0-360 clockwise; 90 right, 270 left
    interval:      50, # yards
    max_range:    500, # yards
    y_intercept:    0, # inches; -2 means POI 2 inches below POA @ zero range
  }

  def self.simple(gun_id:, cart_id:, gun_family: nil)
    gun = Ballistics::Gun.find(file: gun_family, id: gun_id)
    cart = gun.cartridges.fetch(cart_id)
    self.new(projectile: cart.projectile,
             cartridge: cart,
             gun: gun)
  end

  attr_accessor :projectile, :cartridge, :gun, :atmosphere

  def initialize(projectile: nil,
                 cartridge: nil,
                 gun: nil,
                 atmosphere: nil)
    @projectile = projectile
    @cartridge = cartridge
    @gun = gun
    @atmosphere = atmosphere
  end

  # Given a hash of specified options / params
  # Return a hash of params enriched by DEFAULTS as well as any inferred
  #   parameters from @projectile, @cartridge, @gun, and @atmosphere
  #
  def enrich(opts = {})
    mine = {}
    mine.merge!(@projectile.params) if @projectile
    mine.merge!(@gun.params) if @gun
    mine[:velocity] = @cartridge.mv(@gun.barrel_length) if @cartridge and @gun

    # Set up the return hash
    # opts overrides mine overrides DEFAULT
    ret = DEFAULTS.merge(mine.merge(opts))

    # validate drag function and replace with the numeral
    if ret[:drag_function] and !ret[:drag_number]
      ret[:drag_number] =
        Ballistics::Projectile.drag_number(ret[:drag_function])
    end

    # apply atmospheric correction to ballistic coefficient
    if ret[:ballistic_coefficient] and @atmosphere
      ret[:ballistic_coefficient] =
        @atmosphere.translate(ret[:ballistic_coefficient])
    end

    ret
  end

  # Return a multiline string showing each component of the problem
  #
  def report
    lines = []
    lines << @gun.multiline if @gun
    lines << @cartridge.multiline if @cartridge
    lines << @projectile.multiline if @projectile
    lines << @atmosphere.multiline if @atmosphere
    lines.join("\n\n")
  end

  # Given a zero range and basic ballistics parameters
  # Return the angle between sight axis and bore axis necessary to achieve zero
  #
  def zero_angle(opts = {})
    Ballistics.zero_angle self.enrich opts
  end

  # Return a data structure with trajectory data at every interval for the
  #   specified range
  #
  def trajectory(opts = {})
    Ballistics.trajectory self.enrich opts
  end

  # Return a multiline string based on trajectory data
  #
  def table(trajectory: nil, fields: nil, opts: {})
    Ballistics.table(trajectory: trajectory,
                     fields: fields,
                     opts: self.enrich(opts))
  end
end
