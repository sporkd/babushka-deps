dep 'meld' do
  requires 'meld.managed'
end

dep 'meld.managed' do
  # Meld doesn't normally require python, but
  # there's a PYTHONPATH issue if we don't
  requires 'python'
end
