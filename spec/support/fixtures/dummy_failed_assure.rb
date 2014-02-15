class DummyFailedAssure < Anvil::Assure
  def assured?; false; end
end
