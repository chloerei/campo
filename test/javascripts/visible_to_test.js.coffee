module('visible-to')

test 'should remove element unless logined', ->
  $fixture = $('#qunit-fixture')
  $fixture.append("
  <div data-visible-to='user'></div>
  ")

  campo.currentUser = { id: 1 }
  campo.VisibleTo.check()
  ok($fixture.find('div').length)

  campo.currentUser = null
  campo.VisibleTo.check()
  ok(!$fixture.find('div').length)

test 'should remove element unless creator', ->
  $fixture = $('#qunit-fixture')
  $fixture.append("
  <div data-creator-id='1' data-visible-to='creator'></div>
  ")

  campo.currentUser = { id: 1 }
  campo.VisibleTo.check()
  ok($fixture.find('div').length)

  campo.currentUser = { id: 2 }
  campo.VisibleTo.check()
  ok(!$fixture.find('div').length)

test 'should remove element if creator', ->
  $fixture = $('#qunit-fixture')
  $fixture.append("
  <div data-creator-id='1' data-visible-to='no-creator'></div>
  ")

  campo.currentUser = { id: 2 }
  campo.VisibleTo.check()
  ok($fixture.find('div').length)

  campo.currentUser = { id: 1 }
  campo.VisibleTo.check()
  ok(!$fixture.find('div').length)
