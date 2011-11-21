require 'spec_helper'

describe User do
 it_behaves_like 'has_many association', 'user', 'trips'
end
