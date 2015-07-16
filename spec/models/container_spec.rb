require 'rails_helper'

describe Container do
  it 'can add child containers' do
    location = InventoryLocation.create
    container_a = location.containers.create
    container_b = location.containers.create
    container_a.child_containers << container_b
    expect(container_a.reload.child_containers).to include(container_b)
  end

  it 'does not add a child container if a cycle would be formed' do
    location = InventoryLocation.create
    container_a = location.containers.create
    container_b = location.containers.create
    container_a.child_containers << container_b
    container_b.child_containers << container_a
    expect(container_b.errors[:base])
      .to include('Creates cyclic container relationship')
  end
end
