class InventoryLocation < ActiveRecord::Base
  include TSort

  has_many :containers

  validate :acyclic

  private

  def acyclic
    tsort
  rescue TSort::Cyclic
    errors.add(:base, 'Creates cyclic container relationship')
  end

  def tsort_each_node(&block)
    containers.each(&block)
  end

  def tsort_each_child(container, &block)
    container.child_containers.each(&block)
  end
end
