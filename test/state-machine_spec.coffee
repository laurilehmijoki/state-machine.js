sinon = require 'sinon'
chai = require 'chai'
chai.should()

StateMachine = (require '../src/state-machine.coffee').StateMachine

describe 'CyclicStateMachine', ->
  beforeEach ->
    @state1Entry = sinon.spy()
    @state1Exit = sinon.spy()
    @state2Entry = sinon.spy()
    @state2Exit = sinon.spy()
    @state1 = new StateMachine.State @state1Entry, @state1Exit
    @state2 = new StateMachine.State @state2Entry, @state2Exit

  context '#start', ->
    it 'should call the entry action of the first state', ->
      new StateMachine.CyclicStateMachine([@state1, @state2]).start()
      @state1Entry.calledOnce.should.equal true

    it 'should not call the entry action of other than the first state', ->
      new StateMachine.CyclicStateMachine([@state1, @state2]).start()
      @state2Entry.called.should.equal false

    it 'should not call the exit actions of any state', ->
      new StateMachine.CyclicStateMachine([@state1, @state2]).start()
      @state1Exit.called.should.equal false
      @state2Exit.called.should.equal false

    it 'should pass the transition argument to the entry action of the first state', ->
      new StateMachine.CyclicStateMachine([@state1, @state2])
        .start(1)
      @state1Entry.calledWith(1).should.equal true

    it 'it should pass undefined to as the default transition argument', ->
      new StateMachine.CyclicStateMachine([@state1, @state2])
        .start()
      @state1Entry.calledWith(undefined).should.equal true

  context '#transition', ->
    it 'should fail if the user forgot to invoke #start', ->
      try
        new StateMachine.CyclicStateMachine([@state1, @state2]).transition()
      catch error
        error.should.equal 'State machine not started. Invoke #start first.'

    it 'should call the exit action of the first state', ->
      new StateMachine.CyclicStateMachine([@state1, @state2]).start().transition()
      @state1Exit.calledOnce.should.equal true

    it 'should call the entry action of the second state', ->
      new StateMachine.CyclicStateMachine([@state1, @state2]).start().transition()
      @state2Entry.calledOnce.should.equal true

    it 'should transition to the first state after the last state', ->
      new StateMachine.CyclicStateMachine([@state1, @state2])
        .start().transition().transition()
      @state1Entry.calledTwice.should.equal true

    it 'should pass the transition argument to the entry action of the second state', ->
      new StateMachine.CyclicStateMachine([@state1, @state2])
        .start().transition(1)
      @state2Entry.calledWith(1).should.equal true

    it 'should pass the transition argument to the exit action of the first state', ->
      new StateMachine.CyclicStateMachine([@state1, @state2])
        .start().transition(1)
      @state1Exit.calledWith(1).should.equal true
