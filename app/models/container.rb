module ValidateAcyclicInventoryLocation
  def with_location_validation
    transaction do
      yield
      owner = proxy_association.owner
      location = owner.inventory_location.reload
      return true if location.valid?

      location.errors.full_messages_for(:base).each do |error|
        owner.errors.add(:base, error)
      end
    end
  end

  def <<(value)
    with_location_validation { super(value) }
  end
end

class Container < ActiveRecord::Base
  belongs_to :inventory_location

  belongs_to(
    :parent_container,
    class_name: 'Container',
    foreign_key: :container_id
  )

  has_many(
    :child_containers,
    (-> { extending ValidateAcyclicInventoryLocation }),
    class_name: 'Container',
    foreign_key: :container_id
  )
end
