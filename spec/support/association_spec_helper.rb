# invoke like this: it_behaves_like 'has_many association', 'trip', 'places'

shared_examples_for 'has_many association' do |owner_name, target_name|

  it 'responds to places' do
    should respond_to(target_name)
  end
  it 'can create a place' do
    owner_instance = FactoryGirl.create(owner_name)
    expect {
      owner_instance.send(target_name).create(FactoryGirl.attributes_for(target_name.singularize))
    }.should change{owner_instance.send(target_name).count}.by(1)
  end
  it 'will remove dependents' do
    target_instance = FactoryGirl.create(target_name.singularize)
    target_instance.should be_persisted
    owner_instance = target_instance.send(owner_name)
    expect {
      owner_instance.destroy
    }.to change{target_name.classify.constantize.send(:count)}.by(-1)
  end

end


# invoke like this:   it_behaves_like 'belongs_to association', 'trip', 'user'

shared_examples_for 'belongs_to association' do |owner_name, target_name|

  it 'responds_to user' do
    should respond_to(target_name)
  end
  it 'can retrieve a user' do
    trip = FactoryGirl.create(owner_name)
    trip.send(target_name).should be_kind_of(target_name.classify.constantize)
  end

end
